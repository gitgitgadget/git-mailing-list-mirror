Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC9C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA567613BF
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhEZSm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhEZSm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:42:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C60BC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:40:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lg14so4009890ejb.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S4/4F/179Uz14ociRoAYSZCaC2awPy+DGodEcES+8uw=;
        b=QnvKEcaC1hemP3p1PocMElj2TPeCv52X0pOD96bcaQH3OF6Jr0L9VPV4IRSw1ahLor
         zH6xl1QCBkEPUkCZclxpSDI5B8uTWGh4Iov6a9AvBEWxLDO0apS0nVRCwyzXUjBM6Dqy
         +m4i+3qh1jWg+4eM+0Tx4H7VTFlP2vdUVt3Lbx8rlYu3c1ZlN70ELTvGKhkRZ9WX0EZi
         Z4BfR1ruAXsKFhN05S7ZXXNqSzuXcXrz7aLFWuDszObFJVyojdV1FwaDl8p+dAxzUat5
         gXA/HmWLx/818y4XCGyCCjJHdgtsWYeaNnv01rpDKJ1b8bsp/DTTGZlfwU5LPa/XOnLy
         0JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S4/4F/179Uz14ociRoAYSZCaC2awPy+DGodEcES+8uw=;
        b=cxu9bmFET71RFu7uJpb86gySlzr+MxkspLbz39ZsUflLoQAu2u+K68AJxUsGKhQWzb
         JqywHGkHa7N6Moep4XVRh1YbZRXu6tA6RPG2rfubNKR72B7GYS/YdNLvtp63TVHtIiRu
         7+zc+/QaDT0hBrVMkAgh4UYii30XGD0wZmVs05FqlTj+Na572KHJP4YFkXK0Ib1akhDT
         otZXrtIGocCiBe5cFt7a3kbkpMYDy7esvUDVugPA/LDIqlWd/QLH8r0ZR9JomS3nlrRH
         vl+C6oTjN8dHpTxLiGlUGfUBElEe7Nm1s3WFg8Bo38015j8rUIzrExL8KnomBkkrjrRI
         cxFw==
X-Gm-Message-State: AOAM530wCE1L7rNMqW5SEm4llhgv3DETrXqwmvGPCy4dIRTdl26lR9cG
        xuLS5jKbFVpRWLgT/0HPjr4=
X-Google-Smtp-Source: ABdhPJzjAfYToDVKCwYvufAcyn2VokTB7x3N5KTGdl4fdLfO7/uKV+M1Q8zVqUHO9lmVnF8eSQZ58w==
X-Received: by 2002:a17:907:161f:: with SMTP id hb31mr18508242ejc.278.1622054452815;
        Wed, 26 May 2021 11:40:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bx21sm1278647edb.64.2021.05.26.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:40:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com, stolee@gmail.com, tboegi@web.de
Subject: AIX failures on parallel checkout (new in v2.32.0-rc*)
Date:   Wed, 26 May 2021 20:36:43 +0200
References: <cover.1620145501.git.matheus.bernardino@usp.br>
 <667777053ab853ef2f94b7ba4ab39f7241d2b49c.1620145501.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <667777053ab853ef2f94b7ba4ab39f7241d2b49c.1620145501.git.matheus.bernardino@usp.br>
Message-ID: <87eedtmj7w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 04 2021, Matheus Tavares wrote:

> Add tests to populate the working tree during clone and checkout using
> sequential and parallel mode, to confirm that they produce identical
> results. Also test basic checkout mechanics, such as checking for
> symlinks in the leading directories and the abidance to --force.
>
> Note: some helper functions are added to a common lib file which is only
> included by t2080 for now. But they will also be used by other
> parallel-checkout tests in the following patches.
>
> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/lib-parallel-checkout.sh          |  42 +++++
>  t/t2080-parallel-checkout-basics.sh | 229 ++++++++++++++++++++++++++++
>  2 files changed, 271 insertions(+)
>  create mode 100644 t/lib-parallel-checkout.sh
>  create mode 100755 t/t2080-parallel-checkout-basics.sh
>
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> new file mode 100644
> index 0000000000..f60b22ef34
> --- /dev/null
> +++ b/t/lib-parallel-checkout.sh
> @@ -0,0 +1,42 @@
> +# Helpers for tests invoking parallel-checkout
> +
> +set_checkout_config () {
> +	if test $# -ne 2
> +	then
> +		BUG "usage: set_checkout_config <workers> <threshold>"
> +	fi &&
> +
> +	test_config_global checkout.workers $1 &&
> +	test_config_global checkout.thresholdForParallelism $2
> +}
> +
> +# Run "${@:2}" and check that $1 checkout workers were used
> +test_checkout_workers () {
> +	if test $# -lt 2
> +	then
> +		BUG "too few arguments to test_checkout_workers"
> +	fi &&
> +
> +	local expected_workers=$1 &&
> +	shift &&
> +
> +	local trace_file=trace-test-checkout-workers &&
> +	rm -f "$trace_file" &&
> +	GIT_TRACE2="$(pwd)/$trace_file" "$@" &&
> +
> +	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
> +	test $workers -eq $expected_workers &&
> +	rm "$trace_file"
> +}
> +
> +# Verify that both the working tree and the index were created correctly
> +verify_checkout () {
> +	if test $# -ne 1
> +	then
> +		BUG "usage: verify_checkout <repository path>"
> +	fi &&
> +
> +	git -C "$1" diff-index --ignore-submodules=none --exit-code HEAD -- &&
> +	git -C "$1" status --porcelain >"$1".status &&
> +	test_must_be_empty "$1".status
> +}
> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
> new file mode 100755
> index 0000000000..7087818550
> --- /dev/null
> +++ b/t/t2080-parallel-checkout-basics.sh
> @@ -0,0 +1,229 @@
> +#!/bin/sh
> +
> +test_description='parallel-checkout basics
> +
> +Ensure that parallel-checkout basically works on clone and checkout, spawning
> +the required number of workers and correctly populating both the index and the
> +working tree.
> +'
> +
> +TEST_NO_CREATE_REPO=1
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
> +
> +# Test parallel-checkout with a branch switch containing a variety of file
> +# creations, deletions, and modifications, involving different entry types.
> +# The branches B1 and B2 have the following paths:
> +#
> +#      B1                 B2
> +#  a/a (file)         a   (file)
> +#  b   (file)         b/b (file)
> +#
> +#  c/c (file)         c   (symlink)
> +#  d   (symlink)      d/d (file)
> +#
> +#  e/e (file)         e   (submodule)
> +#  f   (submodule)    f/f (file)
> +#
> +#  g   (submodule)    g   (symlink)
> +#  h   (symlink)      h   (submodule)
> +#
> +# Additionally, the following paths are present on both branches, but with
> +# different contents:
> +#
> +#  i   (file)         i   (file)
> +#  j   (symlink)      j   (symlink)
> +#  k   (submodule)    k   (submodule)
> +#
> +# And the following paths are only present in one of the branches:
> +#
> +#  l/l (file)         -
> +#  -                  m/m (file)
> +#
> +test_expect_success 'setup repo for checkout with various types of changes' '
> +	git init sub &&
> +	(
> +		cd sub &&
> +		git checkout -b B2 &&
> +		echo B2 >file &&
> +		git add file &&
> +		git commit -m file &&
> +
> +		git checkout -b B1 &&
> +		echo B1 >file &&
> +		git add file &&
> +		git commit -m file
> +	) &&
> +
> +	git init various &&
> +	(
> +		cd various &&
> +
> +		git checkout -b B1 &&
> +		mkdir a c e &&
> +		echo a/a >a/a &&
> +		echo b >b &&
> +		echo c/c >c/c &&
> +		test_ln_s_add c d &&
> +		echo e/e >e/e &&
> +		git submodule add ../sub f &&
> +		git submodule add ../sub g &&
> +		test_ln_s_add c h &&
> +
> +		echo "B1 i" >i &&
> +		test_ln_s_add c j &&
> +		git submodule add -b B1 ../sub k &&
> +		mkdir l &&
> +		echo l/l >l/l &&
> +
> +		git add . &&
> +		git commit -m B1 &&
> +
> +		git checkout -b B2 &&
> +		git rm -rf :^.gitmodules :^k &&
> +		mkdir b d f &&
> +		echo a >a &&
> +		echo b/b >b/b &&
> +		test_ln_s_add b c &&
> +		echo d/d >d/d &&
> +		git submodule add ../sub e &&
> +		echo f/f >f/f &&
> +		test_ln_s_add b g &&
> +		git submodule add ../sub h &&
> +
> +		echo "B2 i" >i &&
> +		test_ln_s_add b j &&
> +		git -C k checkout B2 &&
> +		mkdir m &&
> +		echo m/m >m/m &&
> +
> +		git add . &&
> +		git commit -m B2 &&
> +
> +		git checkout --recurse-submodules B1
> +	)
> +'
> +
> +for mode in sequential parallel sequential-fallback
> +do
> +	case $mode in
> +	sequential)          workers=1 threshold=0 expected_workers=0 ;;
> +	parallel)            workers=2 threshold=0 expected_workers=2 ;;
> +	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
> +	esac
> +
> +	test_expect_success "$mode checkout" '
> +		repo=various_$mode &&
> +		cp -R various $repo &&
> +
> +		# The just copied files have more recent timestamps than their
> +		# associated index entries. So refresh the cached timestamps
> +		# to avoid an "entry not up-to-date" error from `git checkout`.
> +		# We only have to do this for the submodules as `git checkout`
> +		# will already refresh the superproject index before performing
> +		# the up-to-date check.
> +		#
> +		git -C $repo submodule foreach "git update-index --refresh" &&
> +
> +		set_checkout_config $workers $threshold &&
> +		test_checkout_workers $expected_workers \
> +			git -C $repo checkout --recurse-submodules B2 &&
> +		verify_checkout $repo
> +	'
> +done
> +
> +for mode in parallel sequential-fallback
> +do
> +	case $mode in
> +	parallel)            workers=2 threshold=0 expected_workers=2 ;;
> +	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
> +	esac
> +
> +	test_expect_success "$mode checkout on clone" '
> +		repo=various_${mode}_clone &&
> +		set_checkout_config $workers $threshold &&
> +		test_checkout_workers $expected_workers \
> +			git clone --recurse-submodules --branch B2 various $repo &&
> +		verify_checkout $repo
> +	'
> +done
> +
> +# Just to be paranoid, actually compare the working trees' contents directly.
> +test_expect_success 'compare the working trees' '
> +	rm -rf various_*/.git &&
> +	rm -rf various_*/*/.git &&
> +
> +	# We use `git diff` instead of `diff -r` because the latter would
> +	# follow symlinks, and not all `diff` implementations support the
> +	# `--no-dereference` option.
> +	#
> +	git diff --no-index various_sequential various_parallel &&
> +	git diff --no-index various_sequential various_parallel_clone &&
> +	git diff --no-index various_sequential various_sequential-fallback &&
> +	git diff --no-index various_sequential various_sequential-fallback_clone
> +'
> +
> +# Currently, each submodule is checked out in a separated child process, but
> +# these subprocesses must also be able to use parallel checkout workers to
> +# write the submodules' entries.
> +test_expect_success 'submodules can use parallel checkout' '
> +	set_checkout_config 2 0 &&
> +	git init super &&
> +	(
> +		cd super &&
> +		git init sub &&
> +		test_commit -C sub A &&
> +		test_commit -C sub B &&
> +		git submodule add ./sub &&
> +		git commit -m sub &&
> +		rm sub/* &&
> +		test_checkout_workers 2 git checkout --recurse-submodules .
> +	)
> +'
> +
> +test_expect_success 'parallel checkout respects --[no]-force' '
> +	set_checkout_config 2 0 &&
> +	git init dirty &&
> +	(
> +		cd dirty &&
> +		mkdir D &&
> +		test_commit D/F &&
> +		test_commit F &&
> +
> +		rm -rf D &&
> +		echo changed >D &&
> +		echo changed >F.t &&
> +
> +		# We expect 0 workers because there is nothing to be done
> +		test_checkout_workers 0 git checkout HEAD &&
> +		test_path_is_file D &&
> +		grep changed D &&
> +		grep changed F.t &&
> +
> +		test_checkout_workers 2 git checkout --force HEAD &&
> +		test_path_is_dir D &&
> +		grep D/F D/F.t &&
> +		grep F F.t
> +	)
> +'
> +
> +test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading dirs' '
> +	set_checkout_config 2 0 &&
> +	git init symlinks &&
> +	(
> +		cd symlinks &&
> +		mkdir D untracked &&
> +		# Commit 2 files to have enough work for 2 parallel workers
> +		test_commit D/A &&
> +		test_commit D/B &&
> +		rm -rf D &&
> +		ln -s untracked D &&
> +
> +		test_checkout_workers 2 git checkout --force HEAD &&
> +		! test -h D &&
> +		grep D/A D/A.t &&
> +		grep D/B D/B.t
> +	)
> +'
> +
> +test_done

I haven't dug into why but these tests fail on AIX (on the fairly easy
to get access to GCC farm boxes):

E.g. for ./t2080-parallel-checkout-basics.sh:
    
    [...]
    Branch 'B2' set up to track remote branch 'B2' from 'origin'.
    Switched to a new branch 'B2'
    + mkdir m
    + echo m/m
    + 1> m/m
    + git add .
    + git commit -m B2
    [B2 176cae8] B2
     Author: A U Thor <author@example.com>
     19 files changed, 17 insertions(+), 17 deletions(-)
     create mode 100644 a
     delete mode 100644 a/a
     delete mode 100644 b
     create mode 100644 b/b
     create mode 120000 c
     delete mode 100644 c/c
     delete mode 120000 d
     create mode 100644 d/d
     rename f => e (100%)
     delete mode 100644 e/e
     create mode 100644 f/f
     mode change 160000 => 120000 g
     mode change 120000 => 160000 h
     delete mode 100644 l/l
     create mode 100644 m/m
    + git checkout --recurse-submodules B1
    Switched to branch 'B1'
    ok 1 - setup repo for checkout with various types of changes
    
    expecting success of 2080.2 'sequential checkout':
                    repo=various_$mode &&
                    cp -R various $repo &&
    
                    # The just copied files have more recent timestamps than their
                    # associated index entries. So refresh the cached timestamps
                    # to avoid an "entry not up-to-date" error from `git checkout`.
                    # We only have to do this for the submodules as `git checkout`
                    # will already refresh the superproject index before performing
                    # the up-to-date check.
                    #
                    git -C $repo submodule foreach "git update-index --refresh" &&
    
                    set_checkout_config $workers $threshold &&
                    test_checkout_workers $expected_workers \
                            git -C $repo checkout --recurse-submodules B2 &&
                    verify_checkout $repo
    
    + repo=various_sequential
    + cp -R various various_sequential
    + git -C various_sequential submodule foreach git update-index --refresh
    Entering 'f'
    Entering 'g'
    Entering 'k'
    + set_checkout_config 1 0
    + test_checkout_workers 0 git -C various_sequential checkout --recurse-submodules B2
    error: Your local changes to the following files would be overwritten by checkout:
            d
            h
            j
    Please commit your changes or stash them before you switch branches.
    Aborting
    error: last command exited with $?=1
    not ok 2 - sequential checkout
    #
    #                       repo=various_$mode &&
    #                       cp -R various $repo &&
    #
    #                       # The just copied files have more recent timestamps than their
    #                       # associated index entries. So refresh the cached timestamps
    #                       # to avoid an "entry not up-to-date" error from `git checkout`.
    #                       # We only have to do this for the submodules as `git checkout`
    #                       # will already refresh the superproject index before performing
    #                       # the up-to-date check.
    #                       #
    #                       git -C $repo submodule foreach "git update-index --refresh" &&
    #
    #                       set_checkout_config $workers $threshold &&
    #                       test_checkout_workers $expected_workers \
    #                               git -C $repo checkout --recurse-submodules B2 &&
    #                       verify_checkout $repo
    #
    
The test suite has a lot of breakages on AIX that I haven't looked at,
but this particular one is new, so I thought I'd send a quick poke about
it...
