From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: mark die_bad_number as NORETURN
Date: Wed, 16 Apr 2014 10:21:58 -0700
Message-ID: <xmqq7g6pi409.fsf@gitster.dls.corp.google.com>
References: <20140416141353.GA9676@camelia.ucw.cz>
	<20140416152920.GA4691@sigill.intra.peff.net>
	<534EB1FB.5040405@web.de>
	<20140416165146.GA16695@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, kasal@ucw.cz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTXV-0005uE-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbaDPRWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 13:22:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbaDPRWG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 13:22:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4AB57C887;
	Wed, 16 Apr 2014 13:22:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7mqimRh7kko8
	rrLxfyKANY3L2Cs=; b=O4DCDWq0zYdR/4GXA96CVvYWVDxlF8oRw8LhtTxkPMo3
	qtIPtNBNQ5738OFydF5ijgawSfHI8LZl/4/ksx/t2+5SkDQvbWtf3gJPGnXR6rlq
	roLztKQCYXnOBPfZYoopmrhSQeSDIvaWOHcryvXIRKUjwWe9PMN2XjzOTqL+JYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IHzyT7
	hcw9UdOGhp7UbBLNrRhhkVgneXt7TaRiZxYOY/9K9kY5ztWuvheqlZoN53s2wtha
	TI85Q8YqMGu5ilBwqUquscpGTs8COSL49NfBV+PBAIMjmC/+cSUI5G2c9gg2UkKN
	DznFBO5dZCvQjA3E+u2tkJFEy8pqu054ipLYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA447C886;
	Wed, 16 Apr 2014 13:22:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B62C7C87F;
	Wed, 16 Apr 2014 13:22:00 -0400 (EDT)
In-Reply-To: <20140416165146.GA16695@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Apr 2014 12:51:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EAB5C1E-C58B-11E3-AE20-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246352>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 16, 2014 at 06:38:19PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> > Does that also silence the warning?
>> >=20
>> This works under gcc 4.2.1 Mac OS: the warning is away.
>
> Thanks. I couldn't test myself, as I could not get gcc to generate th=
e
> warning in the first place, but I do not have anything as old as 4.2 =
on
> hand.
>
> Here it is with a commit message.
>
> -- >8 --
> Subject: config.c: mark die_bad_number as NORETURN
>
> This can help avoid -Wuninitialized false positives in
> git_config_int and git_config_ulong, as the compiler now
> knows that we do not return "ret" if we hit the error
> codepath.

Thanks for clearly solving the issue and describing the solution.
Will queue.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.c b/config.c
> index 6821cef..a30cb5c 100644
> --- a/config.c
> +++ b/config.c
> @@ -557,6 +557,7 @@ int git_parse_ulong(const char *value, unsigned l=
ong *ret)
>  	return 1;
>  }
> =20
> +NORETURN
>  static void die_bad_number(const char *name, const char *value)
>  {
>  	const char *reason =3D errno =3D=3D ERANGE ?
