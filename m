From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] branch: reject -D/-d without branch name
Date: Fri, 25 Jan 2013 11:04:14 -0800
Message-ID: <7vham53x01.fsf@alter.siamese.dyndns.org>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyoZq-0003ma-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838Ab3AYTES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 14:04:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756547Ab3AYTER convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 14:04:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C31FFC1B6;
	Fri, 25 Jan 2013 14:04:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XyMs1dVga1Ya
	io+nqxtMcp4FhoA=; b=I7LC7YxEfrrvYZ+RoJwzEmB/P+GX1V2oTFBg6bv9LkeI
	qZVuK2WqFJxwkEHsIiPINyqwU/YXGcwhmxkjrCRgOvd7DgPB/Sxar/1wNQJ44sT1
	hoyxmAjmOKHEhu3nvatXpXtUf8TzHYlHH6Wa5/HI37bJAPGB54dof2V2S3JbD7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KuA6vP
	CLONsm/naANfY92pyGlbHC5ggx+5XsEm1OHagfNN48xIquVvXlILAIQUSxcfvM2M
	+nz+ywhHu5Fs/3NLefsbgd4udchZdM1lGZsc8XmAmTalo8uPhGetWQbwVrajT8dN
	fY7De95oc4qMsVtYVOcxS0ryJTZg/bl6WF5eQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8515C1B5;
	Fri, 25 Jan 2013 14:04:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20D55C1B4; Fri, 25 Jan 2013
 14:04:16 -0500 (EST)
In-Reply-To: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 25 Jan
 2013 19:50:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0398B47E-6722-11E2-8256-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214569>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> ---
>  builtin/branch.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

=46orgot to sign-off?

Is this a real problem?

I do not see it particularly wrong to succeed after deleting 0 or
more given branch names.

>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 873f624..50fcacc 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -837,9 +837,11 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  		colopts =3D 0;
>  	}
> =20
> -	if (delete)
> +	if (delete) {
> +		if (!argc)
> +			die(_("branch name required"));
>  		return delete_branches(argc, argv, delete > 1, kinds, quiet);
> -	else if (list) {
> +	} else if (list) {
>  		int ret =3D print_ref_list(kinds, detached, verbose, abbrev,
>  					 with_commit, argv);
>  		print_columns(&output, colopts, NULL);
