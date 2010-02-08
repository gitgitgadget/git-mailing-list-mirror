From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Support working directory located at root
Date: Mon, 8 Feb 2010 22:29:41 +0100
Message-ID: <201002082229.43024.j6t@kdbg.org>
References: <1265640810-6361-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:31:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NebCN-0004Dx-MO
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 22:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924Ab0BHVbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 16:31:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59602 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750701Ab0BHVbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 16:31:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1A1AE2C4014;
	Mon,  8 Feb 2010 22:31:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 485B819F6B8;
	Mon,  8 Feb 2010 22:29:43 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1265640810-6361-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139321>

On Montag, 8. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy w=
rote:
> @@ -25,7 +25,7 @@ const char *prefix_path(const char *prefix, int len=
,
> const char *path) len =3D strlen(work_tree);
>  		total =3D strlen(sanitized) + 1;
>  		if (strncmp(sanitized, work_tree, len) ||
> -		    (sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')) {
> +		    (len > 1 && sanitized[len] !=3D '\0' && sanitized[len] !=3D '/=
')) {
>  		error_out:
>  			die("'%s' is outside repository", orig);
>  		}
> @@ -403,7 +403,7 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>  			if (!work_tree_env)
>  				inside_work_tree =3D 0;
>  			if (offset !=3D len) {
> -				cwd[offset] =3D '\0';
> +				cwd[offset ? offset : 1] =3D '\0';
>  				set_git_dir(cwd);
>  			} else
>  				set_git_dir(".");
> @@ -427,6 +427,8 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>  	inside_git_dir =3D 0;
>  	if (!work_tree_env)
>  		inside_work_tree =3D 1;
> +	if (offset =3D=3D 0) /* reached root, set worktree to '/' */
> +		offset =3D 1;
>  	git_work_tree_cfg =3D xstrndup(cwd, offset);
>  	if (check_repository_format_gently(nongit_ok))
>  		return NULL;

Does not work:

etc@master:1028> ~/Src/git/git/git add resolv.conf
fatal: pathspec 'tc/resolv.conf' did not match any files

I wonder how this works on Windows where we do not want to strip the sl=
ash=20
from C:/ either.

-- Hannes
