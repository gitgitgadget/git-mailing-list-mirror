Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D318BC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 03:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiAKD2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 22:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346761AbiAKD2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 22:28:45 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC54C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 19:28:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id d92-20020a17090a6f6500b001b35ac5f393so11187118pjk.7
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=07axpAovuKekOcyfxK4CAnb1s4fgh+N0oB3ZDW08uOc=;
        b=J4pknALhmLGHhjTCr7hYlkSCDNUSzJ+XGUT5izTQDN4vijC0MZrZLGa4hpuke2Th4E
         uohYYlkcmcr1nKKGB1rHtcTsHG9WOk0lcerAi9e80EHlq68Bmgj8lT+act3M8Epsnkps
         77ryVNgWOdEA/3G9Zpj3oeIu2iGvFaB5OFNHZVZdNVxH/DMgCz6VnUm6+lEnc/x66p7Q
         quj6FqlTwGobs5q1tTVJS33EMpOkLbqsLbCBnxWdA6FRQAeo1hD4YY8CclQp0xnxsNG6
         VDz1hsWECnktSXfcT5XudShF91ksof1T9kiOE92WYDuAMAFRE5WEB1iE2OEmQ7Vo96C4
         53tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=07axpAovuKekOcyfxK4CAnb1s4fgh+N0oB3ZDW08uOc=;
        b=zoIOkg+AO1rTlSBZztIM4ihbm+5TBR5/5FziRZRomraskEGiUM4IFxbvozWhptZflz
         +vn0SgMMBMNhCx1amNBsY2EJAtnLF8IsRe8mI/kGSPKK9wxSyClKRHywa86IE7kVVxFN
         TNGaIDhkc0baRVzs/q8qh0B8jAV3X7cTC0vrI0I8uA5ApsnvQku7xgYa40FI55RZnola
         Jz4j3HvVymxh9Z5J2csBYtAJNZbJ7JSVi54knGeWwj9JeTcLH5sub590xLn4qYFOt2nG
         7GWtrNqiWguJJe912TD7c1PAlpNe3K8ZoKhL67I2JOj1vKIlMsfb4T8qDsF8MnPP0HDx
         Qkhg==
X-Gm-Message-State: AOAM530c412+cfILRcDO1vj3SbQcEchF+bMyGCvZ6MpLLw1NAyZB4Otd
        YxH7N5PToOk8N896x+HEdBYuhd0ukn1Wu05tdB4m
X-Google-Smtp-Source: ABdhPJw9PGo1DNNbybdVNzS1n0aGQxQ3stOzfUyyVGF4r3aiq5zX75zzppE/pKGjjcCb4A/y/xnv8PYTY+YEkzrNDc6l
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:938d:0:b0:4ba:c445:8761 with
 SMTP id t13-20020aa7938d000000b004bac4458761mr2719944pfe.12.1641871724965;
 Mon, 10 Jan 2022 19:28:44 -0800 (PST)
Date:   Mon, 10 Jan 2022 19:28:42 -0800
In-Reply-To: <20211220233459.45739-6-chooglen@google.com>
Message-Id: <20220111032842.1247928-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-6-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v6 5/5] branch: add --recurse-submodules option for branch creation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am not very familiar with branch tracking, so I'll review everything
except that part.

Glen Choo <chooglen@google.com> writes:
> Although this commit does not introduce breaking changes, it is
> incompatible with existing --recurse-submodules semantics e.g. `git
> checkout` does not recursively checkout the expected branches created by
> `git branch` yet. 

Probably worth explaining that it will not recursively checkout the
expected branches *if* any of them are subsequently updated. Maybe say:

  If a user were to create branches in this way, create a commit on the
  branch in a submodule, and run "git checkout --recurse-submodules" in
  the superproject, the commits to be checked out (which are based on
  the gitlink in the superproject, not on the ref store of the
  submodule) probably wouldn't match the user's expectation.

> To ensure that the correct set of semantics is used,
> this commit introduces a new configuration value,
> `submodule.propagateBranches`, which enables submodule branching when
> true (defaults to false).

And then this could be reworded to:

  Because of this, this commit introduces a new configuration value
  `submodule.propagateBranches`. The plan is for Git commands to
  prioritize submodule ref store information over superproject gitlink
  if this is true. Because "git branch --recurse-submodules" writes to
  submodule ref stores, for the sake of clarity, it will not function
  unless this configuration value is set.

> @@ -71,6 +68,23 @@ submodule.recurse::
>  	`git fetch` but does not have a `--no-recurse-submodules` option.
>  	For these commands a workaround is to temporarily change the
>  	configuration value by using `git -c submodule.recurse=0`.
> +	+
> +	The following list shows the commands that accept
> +	`--recurse-submodules` and whether they are supported by this
> +	setting.
> +	* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
> +	`reset`, `restore` and `switch` are always supported.
> +	* `clone` and `ls-files` are not supported.
> +	* `branch` is supported only if `submodule.propagateBranches` is
> +	enabled

One oddity is that paragraphs after the "+" cannot be indented - see
other documentation files for examples.

> diff --git a/branch.c b/branch.c
> index 55c7ba4a25..6d0d9a8e1b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -8,6 +8,8 @@
>  #include "sequencer.h"
>  #include "commit.h"
>  #include "worktree.h"
> +#include "submodule-config.h"
> +#include "run-command.h"
>  
>  struct tracking {
>  	struct refspec_item spec;
> @@ -478,6 +480,134 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
>  	setup_tracking(new_ref, real_orig_ref, track, quiet);
>  }
>  
> +/**
> + * Creates a branch in a submodule by calling
> + * create_branches_recursively() in a child process. The child process
> + * is necessary because install_branch_config() (and its variants) do
> + * not support writing configs to submodules.
> + */

Makes sense that we need a child process, but could the child process be
"branch" instead of "submodule--helper"? If not, also mention why.

As for the reason, probably better to explicitly mention
install_branch_config_multiple_remotes() and say "(which is called by
setup_tracking())".

> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
> new file mode 100755
> index 0000000000..a2dfb5ad7f
> --- /dev/null
> +++ b/t/t3207-branch-submodule.sh
> @@ -0,0 +1,291 @@
> +#!/bin/sh
> +
> +test_description='git branch submodule tests'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'setup superproject and submodule' '
> +	git init super &&
> +	test_commit foo &&
> +	git init sub-sub-upstream &&
> +	test_commit -C sub-sub-upstream foo &&
> +	git init sub-upstream &&
> +	# Submodule in a submodule
> +	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream" sub-sub &&
> +	git -C sub-upstream commit -m "add submodule" &&
> +	# Regular submodule
> +	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
> +	# Submodule in a subdirectory
> +	git -C super submodule add "$TRASH_DIRECTORY/sub-sub-upstream" second/sub &&
> +	git -C super commit -m "add submodule" &&
> +	git -C super config submodule.propagateBranches true &&
> +	git -C super/sub submodule update --init
> +'
> +
> +CLEANUP_SCRIPT_PATH="$TRASH_DIRECTORY/cleanup_branches.sh"
> +
> +cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
> +	#!/bin/sh
> +
> +	super_dir="$1"
> +	shift
> +	(
> +		cd "$super_dir" &&
> +		git checkout main &&
> +		for branch_name in "$@"; do
> +			git branch -D "$branch_name"
> +			git submodule foreach "$TRASH_DIRECTORY/cleanup_branches.sh . $branch_name || true"
> +		done
> +	)
> +EOF
> +chmod +x "$CLEANUP_SCRIPT_PATH"
> +
> +cleanup_branches() {
> +	TRASH_DIRECTORY="\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
> +} >/dev/null 2>/dev/null

I don't think that the cleanup is saving much in process invocation
anymore - could we just delete the whole thing and start anew in each
test?

The rest of the tests are assuming that the cleanup works as expected -
I didn't take a close look.

Also, you should probably use "$(pwd)" instead of $TRASH_DIRECTORY.

> +test_expect_success '--recurse-submodules should fail when not creating branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		test_must_fail git branch --recurse-submodules -D branch-a &&
> +		# Assert that the branches were not deleted
> +		git rev-parse --abbrev-ref branch-a &&
> +		git -C sub rev-parse --abbrev-ref branch-a
> +	)
> +'

If we're just checking that the ref exists, no need for "--abbrev-ref".
Same comment throughout the file.

> +test_expect_success 'should not create any branches if branch is not valid for all repos' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -C sub branch branch-a &&
> +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
> +		test_must_fail git rev-parse branch-a &&
> +
> +		cat >expected <<-EOF &&
> +		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} already exists.
> +		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a${SQ}
> +		EOF
> +		test_cmp expected actual
> +	)
> +'

The error message seems too specific - probably enough to grep for the
information about the branch already existing.

> +test_expect_success 'should create branches if branch exists and --force is given' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -C sub rev-parse HEAD >expected &&
> +		test_commit -C sub baz &&
> +		git -C sub branch branch-a HEAD~1 &&
> +		git branch --recurse-submodules --force branch-a &&
> +		git rev-parse branch-a &&
> +		# assert that sub:branch-a was moved
> +		git -C sub rev-parse branch-a >actual &&
> +		test_cmp expected actual
> +	)
> +'

Should we create branch-a at HEAD instead of HEAD~1?

> +test_expect_success 'should create branch when submodule is not in HEAD:.gitmodules' '
> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
> +	(
> +		cd super &&
> +		git branch branch-a &&
> +		git checkout -b branch-b &&
> +		git submodule add ../sub-upstream sub2 &&
> +		git -C sub2 submodule update --init &&
> +		# branch-b now has a committed submodule not in branch-a
> +		git commit -m "add second submodule" &&
> +		git checkout branch-a &&
> +		git branch --recurse-submodules branch-c branch-b &&
> +		git rev-parse branch-c &&
> +		git -C sub rev-parse branch-c &&
> +		git -C second/sub rev-parse branch-c &&
> +		git checkout --recurse-submodules branch-c &&
> +		git -C sub2 rev-parse branch-c &&
> +		git -C sub2/sub-sub rev-parse branch-c
> +	)
> +'

No need to check so many repos, I think - just sub2 will do.

[skip tracking tests]

> +test_expect_success 'should not create branches in inactive submodules' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	test_config -C super submodule.sub.active false &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		git rev-parse branch-a &&
> +		test_must_fail git -C sub branch-a
> +	)
> +'

Makes sense, but could all the tracking tests be together in the file?
Or is this order for a reason?

[skip tracking tests]

> +test_expect_success 'setup remote-tracking tests' '

This setup is not just for remote-tracking tests.

> +	(
> +		cd super &&
> +		git branch branch-a &&
> +		git checkout -b branch-b &&
> +		git submodule add ../sub-upstream sub2 &&
> +		# branch-b now has a committed submodule not in branch-a
> +		git commit -m "add second submodule"
> +	) &&
> +	git clone --branch main --recurse-submodules super super-clone &&
> +	git -C super-clone config submodule.propagateBranches true
> +'
> +
> +test_expect_success 'should not create branch when submodule is not in .git/modules' '

I understand that no branch is created, but the title is ambiguous, to
me, whether it is a fatal error or not. Maybe the title should be "fatal
error upon branch creation when submodule is not in .git/modules".

> +	# The cleanup needs to delete sub2 separately because main does not have sub2
> +	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
> +		git -C super-clone/sub2/sub-sub branch -D branch-b && \
> +		cleanup_branches super-clone branch-a branch-b" &&
> +	(
> +		cd super-clone &&
> +		# This should succeed because super-clone has sub.

"has sub in .git/modules", I think.

> +		git branch --recurse-submodules branch-a origin/branch-a &&
> +		# This should fail because super-clone does not have sub2.

Likewise.

> +		test_must_fail git branch --recurse-submodules branch-b origin/branch-b 2>actual &&
> +		cat >expected <<-EOF &&
> +		hint: You may try updating the submodules using ${SQ}git checkout origin/branch-b && git submodule update --init${SQ}
> +		fatal: submodule ${SQ}sub2${SQ}: unable to find submodule
> +		EOF
> +		test_cmp expected actual &&
> +		test_must_fail git rev-parse branch-b &&
> +		test_must_fail git -C sub rev-parse branch-b &&
> +		# User can fix themselves by initializing the submodule
> +		git checkout origin/branch-b &&
> +		git submodule update --init --recursive &&
> +		git branch --recurse-submodules branch-b origin/branch-b
> +	)
> +'

Apart from the branch tracking part (which I didn't review), overall,
this patch set looks good.
