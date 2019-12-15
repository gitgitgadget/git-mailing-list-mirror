Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCAC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B5206E0
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 10:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f9FL6zRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfLOK34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 05:29:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:60969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfLOK34 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576405789;
        bh=u1GZJvfLLIShcUOew9e1s4vNSti9fH1OWZrE2ewyvhg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f9FL6zRDCE/20Z0FZwdRt093I62vDbQyLnoMivLL2Nl7QjfEtYSlZA5UlB9hs0Ca3
         zgFzFsZtDqu+PZuqETDEuED3h+MOwkYit4maJgsC73dvB69pBkuNx7gZ9mjidKCn2m
         TQTEDLniojBAJAOwHJ6aWCpu8AOvgN6VPpqkE1RM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1iQ0ET0UWK-00L1JK; Sun, 15
 Dec 2019 11:29:49 +0100
Date:   Sun, 15 Dec 2019 11:29:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
In-Reply-To: <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WTM4RmORqUavHP5/b0SWnssR+rWpViG9VQGg9yVp9NvypQmduQp
 RTpjyzelWs/aa5zOgi8vJpXug4KJv3d8oZTcq3JHCMA5LCZ0KkdleN28sP88NPSdHTEaFfm
 dxfTqHLQjBu63Si3dVf1Kdgxq+PxdoEbnQSIg9awrKTigurDy+whx6DNvt+vcnKlpyxwWXp
 HmSfstDD/FXMoY3DULXxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZm86Pwis4I=:xUx1+EQp/YZ/m/7RxJYyjS
 SdfWP0rYkvx8spE0oMpZCqYpqq/QyiQwmfNJqVDXiJ1pRMA/WI3XxPixA83lMfzPNvEK3OcDX
 0gGf6ayQfOOXLodzGrSutdOEKyTzugPt7g7X6PzKwr5/vp5+I54b0O+Ci4+SBc0CpOwvHOrgG
 HiKOzchq8Tz/BuoM0yKz4t1iws6vlJCKQjOYbAXKj3lzortIZKo71fHlal0HhXjYLXX5YMGz+
 JVsKq5+7jfCf0O66mfVlLVL91Xs63ypV/2i3zsPHX/CwUYIjCAto2CPTqz62SX8G+c4Rf820X
 4bgqWwvB+O9w+hTuEaLYb6G0/pSnLlCMsgs4S0m7lqnRIzAYWcaTD15Wxuk2RXlJk9VFM9tzt
 viRjtG2w2A81Y2o/NLgBiNV/cKHjDa2S2nzCZwicjY0jNpJes5LD7ocFJeMaf91jk7dpgWnAU
 Ef8btryCpwGw0G0cBAMhMe8KPK0SBLfEqGtS9Oevk5MFVqDJCWmoS1IlVJDT+l55BG+RzCuwV
 xqedul9sRG8jcaBLqgTfS07Z13CIiXM0f+paZo3cjbmtRL+AiA3klWhzawMMkDHQHyvFeHcWu
 9o8UYzGsw4MsApstFael5MOKKaX3bGrJjvb+fF0SQbjHeVHoEln+jUe8jypMtpyEnt8l/0mbK
 KSl0QbyBfgGTT1yT8m7GBO7hxL7nFryk1E+Dct1ujAV4fIkJtZvwcXOS90SYd9q7vd0YzZ+dV
 LKZ6CDoOdYpGM346ja2SQIKhsbxpBnJYy5wA9MmWTNu17KuIexLWhIvykTpyaaC3UZNwE6eya
 MwqBc9SkvHTxazJuxjOvU89E1tEDVyArsL+x0rCLFHD5vMEUlFE8OKatAVQ480y/H79AbUv8n
 ucIbMMoFDdARLC/b8rhOn/QTCLas85tkRODeP8/GBUxc2nZ139yoNvV7VvEKN/bQ3lpXxwohW
 LCmB1PMjsnRnAhNVZI0aaGrtD1eXl1w6ZGhlqXoDon8I4hXA94rV382PGVippyFfPcyNoGIjm
 sgI4GsPePuVCLDd26ZrYK+RFfqM7rskzSnYPQBSXQbKpuIBUKQI5i44GUNmdPGuPRK3p4A0s3
 rAV00Ruq8aALPR19Ql7LVeZ43/dizf0TOEVgPbiUp3ZHlgSNNvsKSVqoeNTFFor+otI64Aa30
 ahyI/p1mJWUUbw78HdXWK2kaMmItz8L2DDJyExQIZ3YlWgUzjUjw8YCWeh3whRn4udRQnre/i
 cDIReDfYWErCIRIwhkiwnrpSrBZsEcHEtrGTidPHoyQ2jtePgvYOgVWkQVjU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I have not had time to dive deeply into this, but I know that it _does_
cause a ton of segmentation faults in the `shears/pu` branch (where all of
Git for Windows' patches are rebased on top of `pu`):

On Tue, 10 Dec 2019, Elijah Newren via GitGitGadget wrote:

> diff --git a/dir.c b/dir.c
> index 645b44ea64..9c71a9ac21 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2102,37 +2102,69 @@ static int treat_leading_path(struct dir_struct =
*dir,
>  			      const struct pathspec *pathspec)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
> -	int baselen, rc =3D 0;
> +	int prevlen, baselen;
>  	const char *cp;
> +	struct cached_dir cdir;
> +	struct dirent de;
> +	enum path_treatment state =3D path_none;
> +
> +	/*
> +	 * For each directory component of path, we are going to check whether
> +	 * that path is relevant given the pathspec.  For example, if path is
> +	 *    foo/bar/baz/
> +	 * then we will ask treat_path() whether we should go into foo, then
> +	 * whether we should go into bar, then whether baz is relevant.
> +	 * Checking each is important because e.g. if path is
> +	 *    .git/info/
> +	 * then we need to check .git to know we shouldn't traverse it.
> +	 * If the return from treat_path() is:
> +	 *    * path_none, for any path, we return false.
> +	 *    * path_recurse, for all path components, we return true
> +	 *    * <anything else> for some intermediate component, we make sure
> +	 *        to add that path to the relevant list but return false
> +	 *        signifying that we shouldn't recurse into it.
> +	 */
>
>  	while (len && path[len - 1] =3D=3D '/')
>  		len--;
>  	if (!len)
>  		return 1;
> +
> +	memset(&cdir, 0, sizeof(cdir));
> +	memset(&de, 0, sizeof(de));
> +	cdir.de =3D &de;
> +	de.d_type =3D DT_DIR;

So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.

>  	baselen =3D 0;
> +	prevlen =3D 0;
>  	while (1) {
> -		cp =3D path + baselen + !!baselen;
> +		prevlen =3D baselen + !!baselen;
> +		cp =3D path + prevlen;
>  		cp =3D memchr(cp, '/', path + len - cp);
>  		if (!cp)
>  			baselen =3D len;
>  		else
>  			baselen =3D cp - path;
> -		strbuf_setlen(&sb, 0);
> +		strbuf_reset(&sb);
>  		strbuf_add(&sb, path, baselen);
>  		if (!is_directory(sb.buf))
>  			break;
> -		if (simplify_away(sb.buf, sb.len, pathspec))
> -			break;
> -		if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
> -				   DT_DIR, NULL) =3D=3D path_none)
> +		strbuf_reset(&sb);
> +		strbuf_add(&sb, path, prevlen);
> +		memcpy(de.d_name, path+prevlen, baselen-prevlen);

But here we try to copy a path into that `de.d_name`, which is still
`NULL`?

That can't be right, can it?

Thanks for your help,
Dscho

> +		de.d_name[baselen-prevlen] =3D '\0';
> +		state =3D treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
> +				    pathspec);
> +		if (state !=3D path_recurse)
>  			break; /* do not recurse into it */
> -		if (len <=3D baselen) {
> -			rc =3D 1;
> +		if (len <=3D baselen)
>  			break; /* finished checking */
> -		}
>  	}
> +	add_path_to_appropriate_result_list(dir, NULL, &cdir, istate,
> +					    &sb, baselen, pathspec,
> +					    state);
> +
>  	strbuf_release(&sb);
> -	return rc;
> +	return state =3D=3D path_recurse;
>  }
>
>  static const char *get_ident_string(void)
> diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t301=
1-common-prefixes-and-directory-traversal.sh
> index d6e161ddd8..098fddc75b 100755
> --- a/t/t3011-common-prefixes-and-directory-traversal.sh
> +++ b/t/t3011-common-prefixes-and-directory-traversal.sh
> @@ -74,7 +74,7 @@ test_expect_success 'git ls-files -o --directory untra=
cked_dir does not recurse'
>  	test_cmp expect actual
>  '
>
> -test_expect_failure 'git ls-files -o --directory untracked_dir/ does no=
t recurse' '
> +test_expect_success 'git ls-files -o --directory untracked_dir/ does no=
t recurse' '
>  	echo untracked_dir/ >expect &&
>  	git ls-files -o --directory untracked_dir/ >actual &&
>  	test_cmp expect actual
> @@ -86,7 +86,7 @@ test_expect_success 'git ls-files -o untracked_repo do=
es not recurse' '
>  	test_cmp expect actual
>  '
>
> -test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' =
'
> +test_expect_success 'git ls-files -o untracked_repo/ does not recurse' =
'
>  	echo untracked_repo/ >expect &&
>  	git ls-files -o untracked_repo/ >actual &&
>  	test_cmp expect actual
> @@ -133,7 +133,7 @@ test_expect_success 'git ls-files -o .git shows noth=
ing' '
>  	test_must_be_empty actual
>  '
>
> -test_expect_failure 'git ls-files -o .git/ shows nothing' '
> +test_expect_success 'git ls-files -o .git/ shows nothing' '
>  	git ls-files -o .git/ >actual &&
>  	test_must_be_empty actual
>  '
> --
> gitgitgadget
>
>
>
