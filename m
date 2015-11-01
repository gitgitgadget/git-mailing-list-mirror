From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] wt-status: don't skip a magical number of characters blindly
Date: Sun, 01 Nov 2015 09:51:54 -0800
Message-ID: <xmqq7fm1ip51.fsf@gitster.mtv.corp.google.com>
References: <5634FB59.1000506@web.de> <5634FC48.7070609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswnR-0007ut-Df
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbbKARv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 12:51:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752448AbbKARv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 12:51:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 696A526919;
	Sun,  1 Nov 2015 12:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zy3defgBNQXv
	gpjfahvca6WE/bs=; b=vl6Gu10pSHOLPxpJ8WgTmcVOYqLKK9/tzsQdv0gOHFat
	mooXrKfsORIgERp5mk4EMpyVjfpfOk71kbYwwXfshTcdedHa7UcNqrFBUJao/3IW
	Vni3bn6FqMnrkcTO/HTwz4714LcxYVb/105zY37nMrDWySaosz42OadMQWptReE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jHfUgB
	WfgdAi6losW3F4CeO3BwvwtgQgmyM07LmzpMYOZ+Tyx5H1sandhFbj70wvtOPOe9
	EdzLipr5/bnasNYILTEBbhIMJ4wyxww5r7GMvon/TPTrS4UT7lauNjqHlj3ZySli
	MVNlzD0vDikeSVJLvDK5oXRdixfFIQLpUGQ88=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 626C126918;
	Sun,  1 Nov 2015 12:51:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCB0F26917;
	Sun,  1 Nov 2015 12:51:55 -0500 (EST)
In-Reply-To: <5634FC48.7070609@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 31
	Oct 2015 18:37:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DD6E3AC-80C1-11E5-B068-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280640>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use the variable branch_name, which already has "refs/heads/" removed=
,
> instead of blindly advancing in the ->branch string by 11 bytes.  Thi=
s
> is safer and less magical.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index e206cc9..42ea15e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1656,7 +1656,7 @@ static void wt_shortstatus_print_tracking(struc=
t wt_status *s)
>  	if (starts_with(branch_name, "refs/heads/"))
>  		branch_name +=3D 11;
> =20
> -	branch =3D branch_get(s->branch + 11);
> +	branch =3D branch_get(branch_name);

Is this correct?  s->branch is the refname that is l10n independent;
branch_name is the localized variant for human consumption.

>  	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
