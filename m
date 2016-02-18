From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 15:20:42 -0800
Message-ID: <xmqqio1lehbp.fsf@gitster.mtv.corp.google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
	<xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
	<CAGZ79kZwgBJQ2bkvKSuT+ULiSPL9x5WTcwVJG0FATNv-D_-AhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:20:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXsP-0001N9-QO
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948605AbcBRXUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:20:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1947656AbcBRXUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:20:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62D98463C9;
	Thu, 18 Feb 2016 18:20:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=paUAaZ86aQLqiPmO3yCzKX9y7DU=; b=mkgPKs
	n9+I4NG0gH2gVRDb7jFTRphThMtOsGCw+uNTvN9VDoeDH+gJFKApZFFsX+TcQMnX
	327hL+i7iUAKfH4sUlt+TMp/udRW/c7qvirBasStP6ddrxMMA8a7fkiDuk2VeP6t
	ZuozGKKDI7ZCLizzg4pznsojKNNiQ7GSBgYFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQyC1AgkTGdvzwg5lJmUAXOH1dlg1ROj
	mYbleOnP0DC3hOPKMrt+NTp+brSC1X/OHDNTgMPHtSVkeRC8Gk6JjAJEgOdBviFS
	8oNfN71SlwN+4LEItfIJQo2irOPqhU1P5WZDRxjDwLP5FRBpoPRY8xAr6I+MfiYK
	2zp54aykbbA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5971B463C8;
	Thu, 18 Feb 2016 18:20:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C3A8B463C7;
	Thu, 18 Feb 2016 18:20:43 -0500 (EST)
In-Reply-To: <CAGZ79kZwgBJQ2bkvKSuT+ULiSPL9x5WTcwVJG0FATNv-D_-AhQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 18 Feb 2016 15:14:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B9B64CA-D696-11E5-9D68-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286641>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 18, 2016 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>> Unless you count "I want to write differently from what was
>>> suggested" is a desirable thing to do, I do not see a point in
>>> favouring the above that uses an extra variable and skip_prefix()
>>> over what I gave you as "how about" patch.  But whatever.
>>
>> The skip_prefix was there before, so it stuck there.

Sorry, but I thought this "parsing update strategy" was all new
code.

>> Also it seems a bit more high level to me hence easier to read,
>> (though I am biased). I'll use your suggestion.
>
> and it doesn't crash when passing in value == NULL.
> (We don't do that currently, just a side observation)

Hmph.  If you pass str==NULL with prefix="!" to what we have below,
I would think the first iteration would try to read from *str and do
a bizarre thing.

static inline int skip_prefix(const char *str, const char *prefix,
			      const char **out)
{
	do {
		if (!*prefix) {
			*out = str;
			return 1;
		}
	} while (*str++ == *prefix++);
	return 0;
}

Puzzled.
