From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sat, 28 Jul 2012 23:38:10 -0700
Message-ID: <7vipd7vzql.fsf@alter.siamese.dyndns.org>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolay Vladimirov <nikolay@vladimiroff.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 08:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvN9S-0000ll-IP
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 08:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2G2GiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 02:38:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab2G2GiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 02:38:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B5560ED;
	Sun, 29 Jul 2012 02:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kqy/VDpYi/hEVlQeMM+wzhkuONY=; b=cvUIkd
	g6gBTYcUYP0FskgBXHVZ8YzcKjT6WnlCPrcTYuwc0S8R4rgvqqEwCOMPaLU/Nkx3
	ziqluaeDPvhiU7Iu8+vrlRdxEWV98rL+VhHJgzZWBe5SKhMYC0nX0X0XZ0fvHoZG
	1uB5CoAqwOUsHiNFl31JfIoCa1CnFzudBHIZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAKOsOm7iUH8eHqFm7cQOr2sx6NdMeIs
	olLg5UBWaCkNtjCUIUxTKbED012+FQMUMgVPhxtkVE6Pp/+aiWo+XOmFAcLWv6Bi
	d61nWqaJ/ig+Wyrq6qaer2F1NdWi7nqsHrtVDQpH7BhQJkMPksL8dn5ee+S57G3N
	lCRxk4zYhew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DDE60EC;
	Sun, 29 Jul 2012 02:38:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD76760EA; Sun, 29 Jul 2012
 02:38:11 -0400 (EDT)
In-Reply-To: <20120728132923.GA31388@do> (Nguyen Thai Ngoc Duy's message of
 "Sat, 28 Jul 2012 20:29:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7909C68-D947-11E1-A642-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202472>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Jul 28, 2012 at 04:18:49PM +0300, Nikolay Vladimirov wrote:
>> But the behavior now seems kind of strange, or maybe I'm missing something:
>> # git config foobar; echo $?
>> error: key does not contain a section: foobar
>> 255
>> 
>> # git config foobar.info; echo $?
>> 1
>> 
>> git version 1.7.11.2
>> 
>> I would generally expect the both to behave the same way.
>
> Then the following patch may be better because it leaves other cases
> untouched (I'm not saying that we should or should not do it though)

I personally think that the documentation unnecessarily exposes the
useless value assignment of the exit codes (the use of different
exit codes was done merely to aid debugging the git-config command
itself) by describing the then-current set of conditions, and should
be reduced to say "0 for success, non-zero for any error".

But if we really want to follow that "documented" subset of possible
conditions, I agree that your version to return "1" in this case,
together with a change to initialize "ret" to "7" and document it as
"all other errors (ret=7), would make more sense.  Other conditions
that have been added since that partial enumeration of the exit code
was done are regexp errors, which I think will get -1 from the same
function.

>
> -- 8< --
> diff --git a/builtin/config.c b/builtin/config.c
> index 8cd08da..d048ebf 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -199,8 +199,10 @@ static int get_value(const char *key_, const char *regex_)
>  			goto free_strings;
>  		}
>  	} else {
> -		if (git_config_parse_key(key_, &key, NULL))
> +		if (git_config_parse_key(key_, &key, NULL)) {
> +			ret = 1;
>  			goto free_strings;
> +		}
>  	}
>  
>  	if (regex_) {
> -- 8< --
