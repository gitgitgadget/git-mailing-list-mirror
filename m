From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCHv2 1/5] worktree: provide better prefix to go back to
 original cwd
Date: Sat, 16 Oct 2010 13:42:59 -0500
Message-ID: <20101016184259.GB30457@burratino>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
 <1287185204-843-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, pclouds@gmail.com,
	gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7BmC-0006S8-72
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0JPSqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 14:46:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44425 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0JPSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:46:33 -0400
Received: by ywi6 with SMTP id 6so836423ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zFYGVeykPEbUDEJ1PTvOzsBZSqSwwOYf87R+UI3IJNY=;
        b=MYHeD8TIsisElcBqnTFMUcw5p6GgOjZjXviAk93aiAmsMzDPc5DCL6WrCJiSHLAcBr
         hDU7N8MX8z2yCNYVsXozDk9sxDF85MS73rI+FOoby1tP2erA6orpPCG1CaML0d7Np2wZ
         CanKS/f0HBjoKWaKksPmQIEoD1o6zHRAzzQR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LEm55bKA6YOhun1CAOKRNbga9qRA5UcSv8o8L0w1CuPlCY/qPpHSzGWKwnVYjcHQW9
         Qq7kB9v+skOHO23lTJEXlz/Bq9WsxUeZYDphWfWBJa7hlO3dpM2ztZYH4kCZAUFNy97/
         RCPtRrunz6pWJRBvZgHWzn3NsoTLZEjkL3pS8=
Received: by 10.150.49.5 with SMTP id w5mr3763040ybw.401.1287254791382;
        Sat, 16 Oct 2010 11:46:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v39sm1207128yba.7.2010.10.16.11.46.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:46:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287185204-843-2-git-send-email-judge.packham@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159178>

Hi,

Chris Packham wrote:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>=20
> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside worktr=
ee,
> prefix (the one passed to every builtin commands) will be set to NULL=
,
> which means "user stays at worktree topdir".
>=20
> As a consequence, command line arguments are supposed to be relative
> to worktree topdir, not current working directory. Not very intuitive=
=2E

Thanks.  More detailed history for this patch:

 - v0: http://thread.gmane.org/gmane.comp.version-control.git/157599/fo=
cus=3D157601
 - v1: http://thread.gmane.org/gmane.comp.version-control.git/158287
 - v2: http://thread.gmane.org/gmane.comp.version-control.git/158369

Any thoughts about the previous questions?

> --- a/cache.h
> +++ b/cache.h
> @@ -1117,6 +1117,8 @@ const char *split_cmdline_strerror(int cmdline_=
errno);
>  /* git.c */
>  struct startup_info {
>  	int have_repository;
> +	char *cwd_to_worktree; /* chdir("this"); from cwd would return to w=
orktree */
> +	char *worktree_to_cwd; /* chdir("this"); from worktree would return=
 to cwd */

e.g. I still find these comments hard to understand.

> --- a/setup.c
> +++ b/setup.c
> @@ -313,10 +313,109 @@ const char *read_gitfile_gently(const char *pa=
th)
>  	return path;
>  }
> =20
> +/*
> + * Given "foo/bar" and "hey/hello/world", return "../../hey/hello/wo=
rld/"
> + * Either path1 or path2 can be NULL
> + */
> +static char *make_path_to_path(const char *path1, const char *path2)
> +{
> +	int nr_back =3D 0;
> +	int i, pathlen =3D path2 ? strlen(path2) : 0;
> +	char *buf, *p;
> +
> +	if (path1 && *path1) {
> +		nr_back =3D 1;
> +		while (*path1) {
> +			if (*path1 =3D=3D '/')
> +				nr_back++;

This still assumes Unix-style path separators.  Is that okay?  (The
answer could be yes; it just seems useful to document the assumptions..=
=2E)

> +/*
> + * Return a prefix if cwd inside worktree, or NULL otherwise.
> + * Also fill startup_info struct.
> + */
> +static const char *setup_prefix(const char *cwd)
> +{
> +	const char *worktree =3D get_git_work_tree();
> +	int len =3D 0, cwd_len =3D strlen(cwd), worktree_len =3D strlen(wor=
ktree);
> +
> +	while (worktree[len] && worktree[len] =3D=3D cwd[len])
> +		len++;
> +
> +	if (!worktree[len] && !cwd[len]) {
> +		if (startup_info) {
> +			startup_info->cwd_to_worktree =3D NULL;
> +			startup_info->worktree_to_cwd =3D NULL;
> +		}
> +		return NULL;
> +	}
> +	/* get /foo/, not /foo/baa if /foo/baa1 and /foo/baa2 are given */
> +	else if (worktree[len] && cwd[len]) {

Style: use cuddled braces.

	} else if (worktree[len] && cwd[len]) {
		/*
		 * The result should be /foo/, not /foo/baa, when
		 * worktree is /foo/baa1 and cwd is /foo/baa2.
		 */

> +		while (len && worktree[len] !=3D '/')
> +			len--;
> +		len++;
> +	}
> +	else {

Likewise.

> +		if (worktree[len]) {
> +			if (worktree[len] !=3D '/') {
> +				while (len && worktree[len] !=3D '/')
> +					len--;
> +			}
> +		}
> +		else {

Likewise.

> +			if (cwd[len] !=3D '/') {
> +				while (len && cwd[len] !=3D '/')
> +					len--;
> +			}

This is repetitive.  Why is the if necessary?

[...]
>  static const char *setup_explicit_git_dir(const char *gitdirenv,
>  				const char *work_tree_env, int *nongit_ok)
>  {
> -	static char buffer[1024 + 1];
> +	static char buffer[PATH_MAX];

Unexplained.

[...]
> --- /dev/null
> +++ b/t/t1510-worktree-prefix.sh
> @@ -0,0 +1,52 @@
[...]
> +test_expect_success 'at root' '
> +	(
> +	cd foo &&
> +	git rev-parse --cwd-to-worktree --worktree-to-cwd >result &&
> +	: >expected &&
> +	test_cmp expected result
> +	)
> +'

It is clearer where a subshell begins and ends if it is indented.  The
usual style in git shell scripts is to omit the ":" in

	>empty

commands.  So maybe:

	(
		cd foo &&
		git rev-parse --cwd-to-worktree --worktree-to-cwd >result
	) &&
	>expected &&
	test_cmp expected foo/result

Sorry, a bit grumpy today.  Still, hope that helps,
Jonathan
