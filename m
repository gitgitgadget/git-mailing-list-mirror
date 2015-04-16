From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log -L: improve error message on malformed argument
Date: Thu, 16 Apr 2015 14:45:01 -0700
Message-ID: <xmqqpp73hhnm.fsf@gitster.dls.corp.google.com>
References: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 16 23:45:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yirax-0005yu-PM
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbDPVpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 17:45:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbbDPVpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 17:45:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E5924A72B;
	Thu, 16 Apr 2015 17:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nDX7MvX5MbbQFx1GQw9AuZoGugk=; b=DpTwXq
	w97V+JAIfDWOxCe4c3l0Fg9u8XwD2HM+4+5BJqhF2vMeRWYkSrvkAn+NWlAS7yfp
	pnyItKWPX4Kw3TXPLTl4E5J44gWu+vVOftG+/wa7iaXWC22/i1ghsPK2/yAB4XiU
	UEbQbMFP043g5EYe0XVNuxSGTlzoGGoeLdCr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Loh/I7S4HXlKhyBO/YEFvu15XCH/wOnV
	2P4sxH6CijKXOaHK93iUe9OsEfrdlO/5U0/Ktn4DvJMzJn/GYBuwiUS8/Mbfmyhj
	W3D1q3r646Xw/s5ToUGeyHq/FUerTlq7wY5VyyQ4ILqO2cBAcU5/QeHBvssgWujj
	CXt2uyUdAzc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4728C4A72A;
	Thu, 16 Apr 2015 17:45:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABD0C4A727;
	Thu, 16 Apr 2015 17:45:02 -0400 (EDT)
In-Reply-To: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 16 Apr 2015 16:43:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D66A7C46-E481-11E4-B5F2-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267336>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The old message did not mention the :regex:file form.
>
> To avoid overly long lines, split the message into two lines (in case
> item->string is long, it will be the only part truncated in a narrow
> terminal).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  line-log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/line-log.c b/line-log.c
> index a490efe..e725248 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -575,7 +575,8 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
>  
>  		name_part = skip_range_arg(item->string);
>  		if (!name_part || *name_part != ':' || !name_part[1])
> -			die("-L argument '%s' not of the form start,end:file",
> +			die("invalid -L argument '%s'.\n"
> +			    "It should be of the form start,end:file or :regex:file.",
>  			    item->string);
>  		range_part = xstrndup(item->string, name_part - item->string);
>  		name_part++;

You forgot to update tests to match their expectations?  4211.20
wants to see 'argument.*not of the form', it seems.
