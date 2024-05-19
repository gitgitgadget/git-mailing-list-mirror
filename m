Received: from mta-sndfb-e05.biglobe.ne.jp (mta-sndfb-e05.biglobe.ne.jp [27.86.113.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9617579
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102493; cv=none; b=kzj0gdGIlNa1j0hLNaVnKcRu563YIF8eVlSNWgqnVZJlKjvioxvVGwmExhCHituRxGfz0n7NjQ8iZJ7mX8eJMkeQcyLKKXBZF6tXITUbKdOJYu8uHocaOYlPHty+riptmWkkzO76wCo68XeIHDsMZn/mm9GlFjC7nfOHj/9COZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102493; c=relaxed/simple;
	bh=5rxeU+axIRPhaGUPJLlT2cMJPvsYAwjqNY3nFFZrIsY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eCQVeMi8mEZoYj0Asu0Ff1ivngJR6rqd/6/1WfwLJYttV/hEIdV0EQL65wjxW6l7yhEHlYlOSZevI4YTGc+qDSzxYGHDgnnMUXHZipf9+3aOCeq1A8rmf7+dbzovCy+Kw190WFw5LhTQzsW36Qdogpxy7dMYlbmZbf8bFuE46m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp; spf=pass smtp.mailfrom=kba.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b=nkimztek; arc=none smtp.client-ip=27.86.113.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b="nkimztek"
Received: from mail.biglobe.ne.jp by mta-snd-e11.biglobe.ne.jp with ESMTP
          id <20240519070305030.IAKE.51369.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Sun, 19 May 2024 16:03:05 +0900
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is
 NFD
From: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
In-Reply-To: <20240509161110.12121-1-tboegi@web.de>
Date: Sun, 19 May 2024 16:03:03 +0900
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <98AD4B35-ECE2-4349-AEA9-86F5CA52EA9B@kba.biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240509161110.12121-1-tboegi@web.de>
To: tboegi@web.de
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Biglobe-Sender: takimoto-j@kba.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kba.biglobe.ne.jp; s=default-1th84yt82rvi; t=1716102185;
 bh=mmrXFvBTkh+wWmlSyk4UJGjt+XdnZwD6VHOg/vSIsXk=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=nkimztekfNmQ8RPCexVDrMTJedG8nQoGKhe7P8f+7y9wGCI8ZKIsWFo/w80J3/svMPSmHek6
 lAD97K9B3sNoEEkeKEd136Il7kX2lq5VzTdF7rqdIaNu9aZAon0OCpPzHqct42EiKu7up9mVVD
 gwn32NsDsRuLyCQExa9x5oNeOUWrOiu6ks7KmKpXcPi/4PmcqiR1SX8fQQ/S/8Mv8fI6zQoh8u
 1cJJznZh60bM8siiWzVcE06wtpk2nqeOSC1KuhCPW+4UA9zwjeGSUGl+6tHLHodJlUWqPeZeXJ
 VN2SU/j5JyYN2ZtzBOjY0+0fUGlwVlDfawPcABKeE3LOVRTg==

Sorry for not responding quickly.

Thank you for the patch, but it seems the problem still remains.

Although
% git ls-files NFD
(apparently) works,
% git ls-files NFC
still gives the error
(if core.precomposeunicode is not set in global config).

The following is some info I got (hope it is correct and useful),
but I have no idea how to fix the problem.

precompose_string_if_needed() works only if:
  precomposed_unicode is already set to 1, or
  git_config_get_bool("core.precomposeunicode") sets it to 1.

But git_config_get_bool() reads the file .git/config only if:
  the_repository->commondir is already set to ".git".

Back trace when the strbuf_getcwd() is called for the
3rd time is (frame #4 is set_git_work_tree()):

  * frame #0: git`strbuf_getcwd(sb=3D0x00007ff7bfeff0a8) at =
strbuf.c:588:20
    frame #1: git`strbuf_realpath_1(resolved=3D0x00007ff7bfeff0a8, =
path=3D".", flags=3D2) at abspath.c:101:7
    frame #2: git`strbuf_realpath(resolved=3D0x00007ff7bfeff0a8, =
path=3D".", die_on_error=3D1) at abspath.c:219:9
    frame #3: git`real_pathdup(path=3D".", die_on_error=3D1) at =
abspath.c:240:6
    frame #4: git`repo_set_worktree(repo=3D0x000000010044eb98, path=3D".")=
 at repository.c:145:19
    frame #5: git`set_git_work_tree(new_work_tree=3D".") at =
environment.c:278:2
    frame #6: git`setup_discovered_git_dir(gitdir=3D".git", =
cwd=3D0x0000000100435238, offset=3D16, repo_fmt=3D0x00007ff7bfeff1d8, =
nongit_ok=3D0x0000000000000000) at setup.c:1119:2
    frame #7: =
git`setup_git_directory_gently(nongit_ok=3D0x0000000000000000) at =
setup.c:1606:12
    frame #8: git`setup_git_directory at setup.c:1815:9
    frame #9: git`run_builtin(p=3D0x0000000100424d58, argc=3D2, =
argv=3D0x00007ff7bfeff6d8) at git.c:448:12
    frame #10: git`handle_builtin(argc=3D2, argv=3D0x00007ff7bfeff6d8) =
at git.c:729:3       =20
    frame #11: git`run_argv(argcp=3D0x00007ff7bfeff54c, =
argv=3D0x00007ff7bfeff540) at git.c:793:4                                =
           =20
    frame #12: git`cmd_main(argc=3D2, argv=3D0x00007ff7bfeff6d8) at =
git.c:928:19                                  =20
    frame #13: git`main(argc=3D3, argv=3D0x00007ff7bfeff6d0) at =
common-main.c:62:11

At this point, precomposed_unicode is still -1 and
the_repository->commondir is still NULL.
This means strbuf_getcwd() retuns NFD, and                               =
       the_repository->worktree is set to NFD.
               =20
Moreover, precompose_string_if_needed() calls   =20
git_config_get_bool("core.precomposeunicode"), and
this function indirecly sets =20
the_repository->config->hash_initialized =3D 1

Later setup_git_directory_gently() (frame #7) calls
setup_git_env() --> repo_set_gitdir() --> repo_set_commondir()
and the_repository->commondir is now set to ".git".

Then run_builtin() (frame #10) calls precompose_argv_prefix()
 --> precompose_string_if_needed(). Here we have
  precomposed_unicode =3D -1
  the_repository->config->hash_initialized =3D 1
This means git_config_check_init() does not read
.git/config (does not call repo_read_config()) even if
the_repository->commondir is set to ".git",
and precomposed_unicode is not set to 1.
So the NFD in argv is not converted to NFC,
and
% git ls-files NFD
apparently works.


