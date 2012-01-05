From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix incorrect ref namespace check
Date: Thu, 05 Jan 2012 08:23:39 -0800
Message-ID: <7v39bunmno.fsf@alter.siamese.dyndns.org>
References: <1325766924-14943-1-git-send-email-pclouds@gmail.com>
 <1325767180-15083-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 17:23:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Riq6W-0001Ht-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 17:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795Ab2AEQXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 11:23:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932792Ab2AEQXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 11:23:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 359005C49;
	Thu,  5 Jan 2012 11:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cV+95QXP5bcW
	jJPa5I3ItQprycQ=; b=tk3CLYa2DCFq88zS0TYs7QafBJdbKBIo+KQVqct94xGo
	5rLyk5SObJlbH2YRIiuuL7/InMG/SUPKFz+1uaz94Xd4Su8KroOeAqXOayM6VSoH
	gPcLGPAaEN081q/dnDN4PGlKFe6JPPXAtaD+kKqx8rCaf6H2s8QHlact/kPZtcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E1eTYb
	AD6p3Tz32gCIretSaXO0luQ7XGik3+sl8R1Os0ThqSzDCbWn6zZmDae7cYb6bSXJ
	Ofbd65sa8X9rDS9YepQrrunMx77CwSQI7zrC0uejSGnv7k2Rkk4t9xVfq2ujcE5p
	skyWRPP6GZ/Do5/bNiO65y5ct79+SavpBcNJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DC995C47;
	Thu,  5 Jan 2012 11:23:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B63DB5C45; Thu,  5 Jan 2012
 11:23:40 -0500 (EST)
In-Reply-To: <1325767180-15083-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 5 Jan
 2012 19:39:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1020970-37B9-11E1-82C9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187988>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The reason why the trailing slash is needed is obvious. refs/stash an=
d
> HEAD are not namespace, but complete refs. Do full string compare on =
them.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I missed prefixcmp(..., "HEAD") right below prefixcmp(..., "refs/sta=
sh")

As Michael has been actively showing interest in cleaning up the area, =
he
should have been CC'ed, I would think.

>
>  builtin/fetch.c  |    2 +-
>  builtin/remote.c |    2 +-
>  log-tree.c       |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 33ad3aa..daa68d2 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -573,7 +573,7 @@ static void find_non_local_tags(struct transport =
*transport,
> =20
>  	for_each_ref(add_existing, &existing_refs);
>  	for (ref =3D transport_get_remote_refs(transport); ref; ref =3D ref=
->next) {
> -		if (prefixcmp(ref->name, "refs/tags"))
> +		if (prefixcmp(ref->name, "refs/tags/"))
>  			continue;
> =20
>  		/*
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 583eec9..f54a89a 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -534,7 +534,7 @@ static int add_branch_for_removal(const char *ref=
name,
>  	}
> =20
>  	/* don't delete non-remote-tracking refs */
> -	if (prefixcmp(refname, "refs/remotes")) {
> +	if (prefixcmp(refname, "refs/remotes/")) {
>  		/* advise user how to delete local branches */
>  		if (!prefixcmp(refname, "refs/heads/"))
>  			string_list_append(branches->skipped,
> diff --git a/log-tree.c b/log-tree.c
> index 319bd31..535b905 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -119,9 +119,9 @@ static int add_ref_decoration(const char *refname=
, const unsigned char *sha1, in
>  		type =3D DECORATION_REF_REMOTE;
>  	else if (!prefixcmp(refname, "refs/tags/"))
>  		type =3D DECORATION_REF_TAG;
> -	else if (!prefixcmp(refname, "refs/stash"))
> +	else if (!strcmp(refname, "refs/stash"))
>  		type =3D DECORATION_REF_STASH;
> -	else if (!prefixcmp(refname, "HEAD"))
> +	else if (!strcmp(refname, "HEAD"))
>  		type =3D DECORATION_REF_HEAD;
> =20
>  	if (!cb_data || *(int *)cb_data =3D=3D DECORATE_SHORT_REFS)
