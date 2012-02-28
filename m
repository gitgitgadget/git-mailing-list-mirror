From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Tue, 28 Feb 2012 10:13:48 -0800
Message-ID: <7v4nua25cz.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2RYh-0004Sy-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab2B1SNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 13:13:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610Ab2B1SNu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 13:13:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 097C16FB5;
	Tue, 28 Feb 2012 13:13:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XTiO8BcPFQ/z
	tNEbs+D/bK6UWGM=; b=vfkowOusSzcfzuoFj3czr1/++mhIP/xQzeKeBqoWPSiV
	Iooa4hRmZSZ3+JHspdKjBIKSfiAilM2I9P5M3xnX3X73z1rmw1IBiUxiQfwx/5VV
	EYZEdnXXN+gIN0z40X+bCP5LqYbkqCvDw84N7ss2TZV/zhcTN+X3LpTXjuw7pNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v2Lunl
	oHJWPDKFj5zzJCTk+9MtLnyItyy7pjQ1YZ9NBjaG/1SjTtstUy1qKlcRTfOdPT3q
	IstPtPUAvo3EiMZsVYJVZPYlBYF+Rl/sHArDMfp9nS5nooQZeHhW4ddVWgXUb7wy
	spgeObQECW35Em4k2lSJK5ryiuD+9Aq/8lYaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 011506FB4;
	Tue, 28 Feb 2012 13:13:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 898256FB3; Tue, 28 Feb 2012
 13:13:49 -0500 (EST)
In-Reply-To: <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Feb
 2012 18:58:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F679E91A-6237-11E1-B185-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191754>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> git-column can be used as a pager for other git commands, something
> like this:
>
>     GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch
>
> The problem with this is that "git -p column" also has $GIT_PAGER
> set so the pager runs itself again as a pager, then again and again.
>
> Stop this.

A natural question that may come after reading only the above is if "gi=
t
column" is the only one that has this problem.  In other words, is the
undesirable behaviour you observed caused by a bug in setup_pager() tha=
t
needs to be fixed, or should it be fixed in "git column"?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  pager.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/pager.c b/pager.c
> index 05584de..4dcb08d 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -73,7 +73,7 @@ void setup_pager(void)
>  {
>  	const char *pager =3D git_pager(isatty(1));
> =20
> -	if (!pager)
> +	if (!pager || pager_in_use())
>  		return;
> =20
>  	/*
