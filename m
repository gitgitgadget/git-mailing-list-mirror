Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121FEC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8A160EB0
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 13:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbhH0Nkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhH0Nkn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 09:40:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3FC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 06:39:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so6002447pgp.4
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=z+yfLiH+JzZKL0ejvJhth8j63+q/M2fdFRSpbG2o3Ro=;
        b=MMRviP3yaiwaXlxdY/dSglQwoou0Xmi9fpsNqGHUAKfvkQSDtGpmATvSkc42+PeBl8
         /AUO6jh1OLczVVWlq7HDgxRgd6LvTGWR4Rvw21UFdRgyYdd+B3chW8itKsHq+LwCWUju
         UhhfF3V65BDoAgjHHtfQFGjRNpZgxTfpdWfh8lgAFkTVZVUsgS3g2M/IdUrr4fprQgJ2
         /Tn74lst/yNCbzTfmB7m0POB2fMU+iaQrKAncxlG6MnDJGXEA50zjuNYH47ip3JscXeP
         l/AmTVwxL7dJ9mYlekY6P5CWpfA1M9i0T0b2VH3hvdQm6xuFNo9sFlLKnc7vAlxbr45g
         QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=z+yfLiH+JzZKL0ejvJhth8j63+q/M2fdFRSpbG2o3Ro=;
        b=pNBxcihszlEJxP8Ff7KcEWOn5TrDcDrK3SShgyzxoKoUoNVHU6YD2xrPuIvV3WNvwI
         WAKY0aMxd0zB6Cmw+GDyJerYmW7cHqEuvzQeBKVKlLD2ilC6fCoULQkb4eMVZRNU00SE
         Njn3WMzdkdC+umpH2gQYUTOAWF0YDSOL69a+YIfmpp3Pw1+BbPmDaXLYwVQcjOXKWK+G
         iAPEFoB3jwSlmL8dZvuq9PIRh8dGN48rmQMfO+1VY7eEgLnINBxfvLlYqBcyp+05x/m/
         2/Bv+tgbYUOOfqyvo498a7ZdLLV/G0CmABeiU56VSzAT66ropLgL3bTjKIZLI1XobQ24
         ec8A==
X-Gm-Message-State: AOAM533H+rALZtmp8eMa7Ff44bgJPxJfc52dNEnn9h8j3x7hubncZu0O
        aCGQB5qVRMX39lu6PHaIo2zQWEwt0fk=
X-Google-Smtp-Source: ABdhPJzVX3NobDzL5zbFDKZASnhQhj3iINr14SmNH2oCLEOGgalB60t3im5vEF4f5rhckz7UKSSk8A==
X-Received: by 2002:a65:6642:: with SMTP id z2mr7920675pgv.240.1630071593549;
        Fri, 27 Aug 2021 06:39:53 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id c12sm6024986pfl.56.2021.08.27.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 06:39:53 -0700 (PDT)
References: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
 <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, mugdha <mugdhapattnaik@gmail.com>
Subject: Re: [PATCH v2] submodule: absorb git dir instead of dying on deinit
Date:   Fri, 27 Aug 2021 18:50:23 +0530
In-reply-to: <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
Message-ID: <m28s0nc8gv.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mugdha <mugdhapattnaik@gmail.com>
>
> Currently, running 'git submodule deinit' on repos where the
> submodule's '.git' is a folder aborts with a message that is not
> exactly user friendly. Let's change this to instead warn the user
> to rerun the command with '--force'.

This makes sense, a lot of commands seem to follow this pattern of
requiring a user to '--force' when the behaviour might not be different
from what is normally expected.

> This internally calls 'absorb_git_dir_into_superproject()', which
> moves the '.git' folder into the superproject and replaces it with
> a '.git' file. The rest of the deinit function can operate as it
> already does with new-style submodules.

Nice. Just like what the NEEDSWORK comment suggested.

> We also edit a test case such that it matches the new behaviour of
> deinit.
>
> Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
> ---
>     submodule: absorb git dir instead of dying on deinit
>
>     We also edit a test case such that it matches the new behaviour of
>     deinit.
>
>     I have changed the 'cp -R ../.git/modules/example .git' to 'mv
>     ../.git/modules/example .git' since, at the time of testing, the test
>     would fail - deinit now would be moving the '.git' folder into the
>     superproject's '.git/modules/' folder, and since this same folder
>     already existed before, it was causing errors. So, before running
>     deinit, instead of copying the '.git' folder into the submodule, if we
>     move it there instead, this functionality can be appropriately tested.
>
>     Changes since v1:
>
>      * Removed extra indent within the if statements
>      * Moved absorb_git_dir_into_superproject() call outside the if
>        condition checking for --quiet flag
>
>     Thank you, Mugdha
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-107=
8%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/m=
ugdhapattnaik/submodule-deinit-absorbgitdirs-v2
> Pull-Request: https://github.com/git/git/pull/1078
>
> Range-diff vs v1:
>
>  1:  58814531d17 ! 1:  37c9b598fde submodule: absorb git dir instead of d=
ying on deinit
>      @@ builtin/submodule--helper.c: static void deinit_submodule(const c=
har *path, cons
>       -			    displaypath);
>       +		if (is_directory(sub_git_dir)) {
>       +			if (!(flags & OPT_FORCE))
>      -+					die(_("Submodule work tree '%s' contains a "
>      -+						  ".git directory (use --force if you want "
>      -+						  "to move its contents to superproject's "
>      -+						  "module folder and convert .git to a file "
>      -+						  "and then proceed with deinit)"),
>      ++				die(_("Submodule work tree '%s' contains a "
>      ++					  ".git directory.\nUse --force if you want "
>      ++					  "to move its contents to superproject's "
>      ++					  "module folder and convert .git to a file "
>      ++					  "and then proceed with deinit."),
>      ++					displaypath);
>      ++
>      ++			if (!(flags & OPT_QUIET))
>      ++				warning(_("Submodule work tree '%s' contains a .git "
>      ++						  "directory. This will be replaced with a "
>      ++						  ".git file by using absorbgitdirs."),
>       +						displaypath);
>       +
>      -+			if (!(flags & OPT_QUIET)) {
>      -+					warning(_("Submodule work tree '%s' contains a .git "
>      -+							  "directory (this will be replaced with a "
>      -+							  ".git file by using absorbgitdirs"),
>      -+							displaypath);
>      -+					absorb_git_dir_into_superproject(displaypath, flags);
>      -+			}
>      ++			absorb_git_dir_into_superproject(displaypath, flags);
>      ++
>       +		}
>
>        		if (!(flags & OPT_FORCE)) {
>
>
>  builtin/submodule--helper.c | 28 ++++++++++++++++++----------
>  t/t7400-submodule-basic.sh  | 10 +++++-----
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ef2776a9e45..4730dc141d4 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, co=
nst char *prefix,
>  		struct strbuf sb_rm =3D STRBUF_INIT;
>  		const char *format;
>
> -		/*
> -		 * protect submodules containing a .git directory
> -		 * NEEDSWORK: instead of dying, automatically call
> -		 * absorbgitdirs and (possibly) warn.
> -		 */
> -		if (is_directory(sub_git_dir))
> -			die(_("Submodule work tree '%s' contains a .git "
> -			      "directory (use 'rm -rf' if you really want "
> -			      "to remove it including all of its history)"),
> -			    displaypath);
> +		if (is_directory(sub_git_dir)) {
> +			if (!(flags & OPT_FORCE))
> +				die(_("Submodule work tree '%s' contains a "
> +					  ".git directory.\nUse --force if you want "
> +					  "to move its contents to superproject's "
> +					  "module folder and convert .git to a file "
> +					  "and then proceed with deinit."),
> +					displaypath);
> +
> +			if (!(flags & OPT_QUIET))
> +				warning(_("Submodule work tree '%s' contains a .git "
> +						  "directory. This will be replaced with a "
> +						  ".git file by using absorbgitdirs."),
> +						displaypath);
> +
> +			absorb_git_dir_into_superproject(displaypath, flags);
> +
> +		}

Looks okay to me. The quiet flag suppresses the warning, which is nice.

>  		if (!(flags & OPT_FORCE)) {
>  			struct child_process cp_rm =3D CHILD_PROCESS_INIT;
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index cb1b8e35dbf..3df71478d06 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1182,18 +1182,18 @@ test_expect_success 'submodule deinit is silent w=
hen used on an uninitialized su
>  	rmdir init example2
>  '
>
> -test_expect_success 'submodule deinit fails when submodule has a .git di=
rectory even when forced' '
> +test_expect_success 'submodule deinit fails when submodule has a .git di=
rectory unless forced' '
>  	git submodule update --init &&
>  	(
>  		cd init &&
>  		rm .git &&
> -		cp -R ../.git/modules/example .git &&
> +		mv ../.git/modules/example .git &&

The original test case was written with the expectation that the deinit
won't happen. But now that it will, I suppose an mv was necessary so
that absorbgitdirs can write the gitdir back to the original place
successfully.

>  		GIT_WORK_TREE=3D. git config --unset core.worktree
>  	) &&
>  	test_must_fail git submodule deinit init &&
> -	test_must_fail git submodule deinit -f init &&
> -	test -d init/.git &&
> -	test -n "$(git config --get-regexp "submodule\.example\.")"
> +	git submodule deinit -f init &&
> +	! test -d init/.git &&
> +	test -z "$(git config --get-regexp "submodule\.example\.")"
>  '

Likewise here. The test case has been flipped to reflect the new
behaviour.

>  test_expect_success 'submodule with UTF-8 name' '
>
> base-commit: c4203212e360b25a1c69467b5a8437d45a373cac

BTW, I see you linked downthread the documentation[1] which says:

  When [old-form submodules] deinitialized or deleted (see below), the
  submodule=E2=80=99s Git directory is automatically moved to
  $GIT_DIR/modules/<name>/ of the superproject.

This was not what Git was doing before this patch, it used to die() out
instead. So I think this actually is a bug fix (although I am not sure
why the test suite also did not agree with the documentation).

Either way, I think this is a welcome change. Thanks for the patch!

[1] https://git-scm.com/docs/gitsubmodules#_forms
