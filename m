Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD6C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 00:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLEAjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEAjs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 19:39:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5711441
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 16:39:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y4so9401510plb.2
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 16:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDOT/85YqmBY5zGAgY+TZow+AIY7GKl5HfjyEqBRi6M=;
        b=ikrdQc3LXlSGzW0slSef7H9vG7WT4ryWdYV+PTRJdAuwOnyj1bbSF3P/D2747gb4Or
         Q2Z2v3q6pEW3fTMWcZwn1UHs6KcForaRozXaKCEp78tFLz550SFi9nGYxzhlKFdGrWJf
         OlWImdlkk+31KrnhK0ZKd2vQimKn8hSS4DWM0uf5AMgH+tFmQvGsf8QXVLsr/CGNfvi6
         EQ/rJeuw2yGCp87RiPn95TQeZ/EcgewYZb4epuDuZhrIKREFvgBj+jsvVExlePcr5asb
         P1SV4zM9Dhsk4FmnMbf+nbRi6VOu1gVyHSFXs3+orAjeIDViVpJFEMNs/OBj0EWLd+is
         PGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDOT/85YqmBY5zGAgY+TZow+AIY7GKl5HfjyEqBRi6M=;
        b=MJXBhB+7zBG6RbJ7yj7jdRMQU40hreMF3Dj2+IcWUiuZfKW/3mlnJj22eKUetirHdh
         Q8/RgBa3duwCWNBrESGsjFGDqaYgLV/VOQ00rb28HsuaXhwaQFBeJvhS9UHLacUSBI7T
         oASfpm1lJ4iXotMsNsDcKs3/1xuGuRjfGmeAcsHogSXeskxbA1b3xxX9aRqaVTZ3B8/n
         sZfYyJDAz1xkxZdK28oSF+/vG2JblECeHLiD07oGXjXwo+VTgX9efS9cgHNKtus8uC6V
         +qkByXlJbCKRozLC3UxjC9OvxqRJcP0FEqZgBw9TJ/QVH/DvIwKP1CDI+bP2rhZk+IDZ
         ALEQ==
X-Gm-Message-State: ANoB5pls6/QoXD1KQ2E9M2GWPHAG5AxnkXvNKGPQ9w8AldxnPfVgqEJM
        To07DCEceiGPeMaAdofbCY4=
X-Google-Smtp-Source: AA0mqf5QRlpTrTm33rgmmKH2spf4qMyKwtcRkQa6GhoKDxkjeL5nJm2ICj1IBpCUH5uVskwPJfW6tQ==
X-Received: by 2002:a17:902:f394:b0:189:848d:675f with SMTP id f20-20020a170902f39400b00189848d675fmr37844685ple.141.1670200784871;
        Sun, 04 Dec 2022 16:39:44 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h13-20020a65468d000000b00477f5ae26bbsm7236108pgr.50.2022.12.04.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:39:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 5/8] tests: use "test_cmp" instead of "test" in
 sub-shells
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <patch-v3-5.8-58ac6fe5604-20221202T114733Z-avarab@gmail.com>
Date:   Mon, 05 Dec 2022 09:39:44 +0900
In-Reply-To: <patch-v3-5.8-58ac6fe5604-20221202T114733Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Dec
 2022 12:52:38
        +0100")
Message-ID: <xmqq7cz6u1in.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Convert a few cases where we were using "test" inside a sub-shell, and
> were losing the exit code of "git".

That makes it sound like

	(
		cd there &&
		a=$(git something expected to be silent) &&
		test -z "$a"
	) &&
	...

is bad, and it can be improved somehow by using "test_cmp" instead
of "test", but I do not think that is what you meant (in fact, the
command substitution used above is safe and we catch failing git).

After looking at a few samples from the patch s/sub-shell/command
substitution/ might be what you meant, i.e.

	test -z "$(git something) &&
	...

is bad and we want 

	git something >out &&
	! test -s out

to keep the exit code from "git".  IOW, fixing the lossage of exit
code has little to do with the use of test vs test_cmp.

Perhaps retitle to

    Subject: [PATCH] tests: avoid "test op $(git foo)" lose exit status of git

    Rewrite tests that ran "git" inside command substitution and
    lost exit status of "git" so that we notice failing "git".

or something like that.

> In the case of "t3200-branch.sh" some adjacent code outside of a
> sub-shell that was losing the exit code is also being converted, as
> it's within the same hunk.

Again s/sub-shell/command substitution?, I think.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/lib-httpd.sh              |  5 +++--
>  t/lib-submodule-update.sh   | 22 +++++++++-------------
>  t/t0060-path-utils.sh       |  4 +++-
>  t/t3200-branch.sh           | 13 +++++++------
>  t/t5605-clone-local.sh      | 15 ++++++++++-----
>  t/t7402-submodule-rebase.sh | 14 +++++++++++---
>  6 files changed, 43 insertions(+), 30 deletions(-)
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 608949ea80b..31e7fa3010c 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -217,8 +217,9 @@ test_http_push_nonff () {
>  		git commit -a -m path2 --amend &&
>  
>  		test_must_fail git push -v origin >output 2>&1 &&
> -		(cd "$REMOTE_REPO" &&
> -		 test $HEAD = $(git rev-parse --verify HEAD))
> +		echo "$HEAD" >expect &&
> +		git -C "$REMOTE_REPO" rev-parse --verify HEAD >actual &&
> +		test_cmp expect actual
>  	'
>  
>  	test_expect_success 'non-fast-forward push show ref status' '
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 2d31fcfda1f..d7c2b670b4a 100644
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -168,20 +168,16 @@ replace_gitfile_with_git_dir () {
>  # Note that this only supports submodules at the root level of the
>  # superproject, with the default name, i.e. same as its path.
>  test_git_directory_is_unchanged () {
> -	(
> -		cd ".git/modules/$1" &&
> -		# does core.worktree point at the right place?
> -		test "$(git config core.worktree)" = "../../../$1" &&
> -		# remove it temporarily before comparing, as
> -		# "$1/.git/config" lacks it...
> -		git config --unset core.worktree
> -	) &&
> +	# does core.worktree point at the right place?
> +	echo "../../../$1" >expect &&
> +	git -C ".git/modules/$1" config core.worktree >actual &&
> +	test_cmp expect actual &&
> +	# remove it temporarily before comparing, as
> +	# "$1/.git/config" lacks it...
> +	git -C ".git/modules/$1" config --unset core.worktree &&
>  	diff -r ".git/modules/$1" "$1/.git" &&
> -	(
> -		# ... and then restore.
> -		cd ".git/modules/$1" &&
> -		git config core.worktree "../../../$1"
> -	)
> +	# ... and then restore.
> +	git -C ".git/modules/$1" config core.worktree "../../../$1"
>  }
>  
>  test_git_directory_exists () {
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 68e29c904a6..53ec717cbca 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -255,7 +255,9 @@ test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
>  test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
>  	git init repo &&
>  	ln -s repo repolink &&
> -	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
> +	echo "a" >expect &&
> +	test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a" >actual &&
> +	test_cmp expect actual
>  '
>  
>  relative_path /foo/a/b/c/	/foo/a/b/	c/
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 5a169b68d6a..f5fbb84262b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -242,12 +242,13 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
>  test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
>  	git checkout -b baz &&
>  	git worktree add -f bazdir baz &&
> -	(
> -		cd bazdir &&
> -		git branch -M baz bam &&
> -		test $(git rev-parse --abbrev-ref HEAD) = bam
> -	) &&
> -	test $(git rev-parse --abbrev-ref HEAD) = bam &&
> +	git -C "$bazdir" branch -M baz bam &&
> +	echo "bam" >expect &&
> +	git -C "$bazdir" rev-parse --abbrev-ref HEAD >actual &&
> +	test_cmp expect actual &&
> +	echo "bam" >expect &&
> +	git rev-parse --abbrev-ref HEAD >actual &&
> +	test_cmp expect actual &&
>  	rm -r bazdir &&
>  	git worktree prune
>  '
> diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
> index 38b850c10ef..61a2342bc2c 100755
> --- a/t/t5605-clone-local.sh
> +++ b/t/t5605-clone-local.sh
> @@ -15,8 +15,12 @@ test_expect_success 'preparing origin repository' '
>  	: >file && git add . && git commit -m1 &&
>  	git clone --bare . a.git &&
>  	git clone --bare . x &&
> -	test "$(cd a.git && git config --bool core.bare)" = true &&
> -	test "$(cd x && git config --bool core.bare)" = true &&
> +	echo true >expect &&
> +	git -C a.git config --bool core.bare >actual &&
> +	test_cmp expect actual &&
> +	echo true >expect &&
> +	git -C x config --bool core.bare >actual &&
> +	test_cmp expect actual &&
>  	git bundle create b1.bundle --all &&
>  	git bundle create b2.bundle main &&
>  	mkdir dir &&
> @@ -28,9 +32,10 @@ test_expect_success 'preparing origin repository' '
>  
>  test_expect_success 'local clone without .git suffix' '
>  	git clone -l -s a b &&
> -	(cd b &&
> -	test "$(git config --bool core.bare)" = false &&
> -	git fetch)
> +	echo false >expect &&
> +	git -C b config --bool core.bare >actual &&
> +	test_cmp expect actual &&
> +	git -C b fetch
>  '
>  
>  test_expect_success 'local clone with .git suffix' '
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index ebeca12a711..1927a862839 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -82,11 +82,19 @@ test_expect_success 'stash with a dirty submodule' '
>  	CURRENT=$(cd submodule && git rev-parse HEAD) &&
>  	git stash &&
>  	test new != $(cat file) &&
> -	test submodule = $(git diff --name-only) &&
> -	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
> +	echo submodule >expect &&
> +	git diff --name-only >actual &&
> +	test_cmp expect actual &&
> +
> +	echo "$CURRENT" >expect &&
> +	git -C submodule rev-parse HEAD >actual &&
> +	test_cmp expect actual &&
> +
>  	git stash apply &&
>  	test new = $(cat file) &&
> -	test $CURRENT = $(cd submodule && git rev-parse HEAD)
> +	echo "$CURRENT" >expect &&
> +	git -C submodule rev-parse HEAD >actual &&
> +	test_cmp expect actual
>  
>  '
