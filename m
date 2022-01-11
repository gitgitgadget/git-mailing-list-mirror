Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940FC433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbiAKSLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbiAKSLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:11:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0EC061748
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:11:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso2044472ybt.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/gZQNeovGZL5+ZpDl7rUchVq3anE0AAXTM69LtoN5JU=;
        b=Eb1V9x9VYhli7ECnGhcaY5r3FD17xOVABh50YE5AgjjZjEafnPfJwiw36avdsJT2VY
         plkjyC55JeFXHeYt6yUkGOZiT8UugLAPiKQQ2umw8c1itdkml9TLfnxVwZjcpo3EGWWk
         Gmvs6TTB7fk9ETif+J/I/qLZccMciU2+Oz4fLrtKmLWBoROWnbEUfyA2rChp9tlC6CoC
         fu6Vnv9kKSTvEJChaSY4UdIkAl9jxRsHWpnd9PU7f9817zBAwxCMnHGWXKfFDDIjdA5y
         d1Dotgw8w0X6mI+gwzxlLW2GHvW4bdeC2eA8X+HM9qUregzDMFhdBuWDz9SpuJRQCPLH
         EhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/gZQNeovGZL5+ZpDl7rUchVq3anE0AAXTM69LtoN5JU=;
        b=McHIoPIY0rA6NpWxUnnvws5Y/2QqowanhJxgPxXYjzN+7+OeCbRhNGQZFF2c5eGWg5
         0G7SzCwh/SWXnzhlWDDQKIbZa99yf+ql1IUGF7g+Oem8Ba4h15hbU14and5qAMNAJzMz
         7SUlip9KjTzYweZ/6Qzz1KMiLM7Vc4PMSg0MHUvhQoPo8Ry7GLmzrn76hgHrGwlKK07w
         1TQI0M30bERigsdRhSQ9oSc9PFdJbm4Y14/DdP3ahegRIEmGjJcu5ayq4EXsAaBZvF0Q
         6SCO/UGnwXeEvwFundtSjaEHWFh9vM1gaPFC6dhpZeZXpfDsShoa1qQiVxU7Lzfk4uz/
         w11w==
X-Gm-Message-State: AOAM531qIfzg+Z3SeXXUXNdMM5GJ1WjcuKa+gS/woV0zeYc7kAsK+JIc
        UxDUR1dUI110qRi86dAiVCa1D2cfOzgRZA==
X-Google-Smtp-Source: ABdhPJw/VUgd7k+ZCEhfNShCOdVAdSX4ZWEGG55GcfGkP6bsEXyBAAT3MoH0pszsNPicQKbpD2lL8WUKDYHcTQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a5b:dcd:: with SMTP id
 t13mr7732317ybr.46.1641924670460; Tue, 11 Jan 2022 10:11:10 -0800 (PST)
Date:   Tue, 11 Jan 2022 10:11:08 -0800
In-Reply-To: <20220111032842.1247928-1-jonathantanmy@google.com>
Message-Id: <kl6l4k6akurn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211220233459.45739-6-chooglen@google.com> <20220111032842.1247928-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 5/5] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I am not very familiar with branch tracking, so I'll review everything
> except that part.
>
> Glen Choo <chooglen@google.com> writes:
>> Although this commit does not introduce breaking changes, it is
>> incompatible with existing --recurse-submodules semantics e.g. `git
>> checkout` does not recursively checkout the expected branches created by
>> `git branch` yet. 
>
> Probably worth explaining that it will not recursively checkout the
> expected branches *if* any of them are subsequently updated. Maybe say:
>
>   If a user were to create branches in this way, create a commit on the
>   branch in a submodule, and run "git checkout --recurse-submodules" in
>   the superproject, the commits to be checked out (which are based on
>   the gitlink in the superproject, not on the ref store of the
>   submodule) probably wouldn't match the user's expectation.
>
>> To ensure that the correct set of semantics is used,
>> this commit introduces a new configuration value,
>> `submodule.propagateBranches`, which enables submodule branching when
>> true (defaults to false).
>
> And then this could be reworded to:
>
>   Because of this, this commit introduces a new configuration value
>   `submodule.propagateBranches`. The plan is for Git commands to
>   prioritize submodule ref store information over superproject gitlink
>   if this is true. Because "git branch --recurse-submodules" writes to
>   submodule ref stores, for the sake of clarity, it will not function
>   unless this configuration value is set.

Thanks! I'll use this wording - otherwise it might not be clear to
readers what the difference in 'semantics' refers to.

>
>> @@ -71,6 +68,23 @@ submodule.recurse::
>>  	`git fetch` but does not have a `--no-recurse-submodules` option.
>>  	For these commands a workaround is to temporarily change the
>>  	configuration value by using `git -c submodule.recurse=0`.
>> +	+
>> +	The following list shows the commands that accept
>> +	`--recurse-submodules` and whether they are supported by this
>> +	setting.
>> +	* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
>> +	`reset`, `restore` and `switch` are always supported.
>> +	* `clone` and `ls-files` are not supported.
>> +	* `branch` is supported only if `submodule.propagateBranches` is
>> +	enabled
>
> One oddity is that paragraphs after the "+" cannot be indented - see
> other documentation files for examples.

Ah, thanks for the catch. Interestingly, it still rendered as expected
when I ran `make` - perhaps a deviation from the asciidoc spec.

>> diff --git a/branch.c b/branch.c
>> index 55c7ba4a25..6d0d9a8e1b 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -8,6 +8,8 @@
>>  #include "sequencer.h"
>>  #include "commit.h"
>>  #include "worktree.h"
>> +#include "submodule-config.h"
>> +#include "run-command.h"
>>  
>>  struct tracking {
>>  	struct refspec_item spec;
>> @@ -478,6 +480,134 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
>>  	setup_tracking(new_ref, real_orig_ref, track, quiet);
>>  }
>>  
>> +/**
>> + * Creates a branch in a submodule by calling
>> + * create_branches_recursively() in a child process. The child process
>> + * is necessary because install_branch_config() (and its variants) do
>> + * not support writing configs to submodules.
>> + */
>
> Makes sense that we need a child process, but could the child process be
> "branch" instead of "submodule--helper"? If not, also mention why.

I'll mention why it has to be "submodule--helper"; I can see why a
reader might wonder this.

> As for the reason, probably better to explicitly mention
> install_branch_config_multiple_remotes() and say "(which is called by
> setup_tracking())".

Sounds good.

>> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
>> new file mode 100755
>> index 0000000000..a2dfb5ad7f
>> --- /dev/null
>> +++ b/t/t3207-branch-submodule.sh
>> @@ -0,0 +1,291 @@
>> +#!/bin/sh
>> +
>> +test_description='git branch submodule tests'
>> +
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>> +. ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +test_expect_success 'setup superproject and submodule' '
>> +	git init super &&
>> +	test_commit foo &&
>> +	git init sub-sub-upstream &&
>> +	test_commit -C sub-sub-upstream foo &&
>> +	git init sub-upstream &&
>> +	# Submodule in a submodule
>> +	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream" sub-sub &&
>> +	git -C sub-upstream commit -m "add submodule" &&
>> +	# Regular submodule
>> +	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
>> +	# Submodule in a subdirectory
>> +	git -C super submodule add "$TRASH_DIRECTORY/sub-sub-upstream" second/sub &&
>> +	git -C super commit -m "add submodule" &&
>> +	git -C super config submodule.propagateBranches true &&
>> +	git -C super/sub submodule update --init
>> +'
>> +
>> +CLEANUP_SCRIPT_PATH="$TRASH_DIRECTORY/cleanup_branches.sh"
>> +
>> +cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
>> +	#!/bin/sh
>> +
>> +	super_dir="$1"
>> +	shift
>> +	(
>> +		cd "$super_dir" &&
>> +		git checkout main &&
>> +		for branch_name in "$@"; do
>> +			git branch -D "$branch_name"
>> +			git submodule foreach "$TRASH_DIRECTORY/cleanup_branches.sh . $branch_name || true"
>> +		done
>> +	)
>> +EOF
>> +chmod +x "$CLEANUP_SCRIPT_PATH"
>> +
>> +cleanup_branches() {
>> +	TRASH_DIRECTORY="\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
>> +} >/dev/null 2>/dev/null
>
> I don't think that the cleanup is saving much in process invocation
> anymore - could we just delete the whole thing and start anew in each
> test?
>
> The rest of the tests are assuming that the cleanup works as expected -
> I didn't take a close look.

Hm, you're right - deleting the branches is already quite slow, starting
anew would be easier and might not be much slower. I'll test the
'starting anew' approach to make sure it's not too slow.

> Also, you should probably use "$(pwd)" instead of $TRASH_DIRECTORY.

Thanks!

>> +test_expect_success '--recurse-submodules should fail when not creating branches' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	(
>> +		cd super &&
>> +		git branch --recurse-submodules branch-a &&
>> +		test_must_fail git branch --recurse-submodules -D branch-a &&
>> +		# Assert that the branches were not deleted
>> +		git rev-parse --abbrev-ref branch-a &&
>> +		git -C sub rev-parse --abbrev-ref branch-a
>> +	)
>> +'
>
> If we're just checking that the ref exists, no need for "--abbrev-ref".
> Same comment throughout the file.

Ah yes, thanks.

>> +test_expect_success 'should not create any branches if branch is not valid for all repos' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	(
>> +		cd super &&
>> +		git -C sub branch branch-a &&
>> +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
>> +		test_must_fail git rev-parse branch-a &&
>> +
>> +		cat >expected <<-EOF &&
>> +		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} already exists.
>> +		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a${SQ}
>> +		EOF
>> +		test_cmp expected actual
>> +	)
>> +'
>
> The error message seems too specific - probably enough to grep for the
> information about the branch already existing.

Makes sense.

>
>> +test_expect_success 'should create branches if branch exists and --force is given' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	(
>> +		cd super &&
>> +		git -C sub rev-parse HEAD >expected &&
>> +		test_commit -C sub baz &&
>> +		git -C sub branch branch-a HEAD~1 &&
>> +		git branch --recurse-submodules --force branch-a &&
>> +		git rev-parse branch-a &&
>> +		# assert that sub:branch-a was moved
>> +		git -C sub rev-parse branch-a >actual &&
>> +		test_cmp expected actual
>> +	)
>> +'
>
> Should we create branch-a at HEAD instead of HEAD~1?

If we create branch-a at HEAD, we won't be testing that --force moves
the branch head. This means that the test might pass if we simply ignore
any existing branch-a - which is not the intended behavior of --force,
but this is behavior that we might want in the future (probably using
another option).

>> +test_expect_success 'should create branch when submodule is not in HEAD:.gitmodules' '
>> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
>> +	(
>> +		cd super &&
>> +		git branch branch-a &&
>> +		git checkout -b branch-b &&
>> +		git submodule add ../sub-upstream sub2 &&
>> +		git -C sub2 submodule update --init &&
>> +		# branch-b now has a committed submodule not in branch-a
>> +		git commit -m "add second submodule" &&
>> +		git checkout branch-a &&
>> +		git branch --recurse-submodules branch-c branch-b &&
>> +		git rev-parse branch-c &&
>> +		git -C sub rev-parse branch-c &&
>> +		git -C second/sub rev-parse branch-c &&
>> +		git checkout --recurse-submodules branch-c &&
>> +		git -C sub2 rev-parse branch-c &&
>> +		git -C sub2/sub-sub rev-parse branch-c
>> +	)
>> +'
>
> No need to check so many repos, I think - just sub2 will do.

Hm yes, there isn't a reason to think that the branch wouldn't be
created in the other repos.

>
> [skip tracking tests]
>
>> +test_expect_success 'should not create branches in inactive submodules' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	test_config -C super submodule.sub.active false &&
>> +	(
>> +		cd super &&
>> +		git branch --recurse-submodules branch-a &&
>> +		git rev-parse branch-a &&
>> +		test_must_fail git -C sub branch-a
>> +	)
>> +'
>
> Makes sense, but could all the tracking tests be together in the file?
> Or is this order for a reason?

No, you're right, the order doesn't make sense. I'll move this to before
the tracking tests.

>> +test_expect_success 'setup remote-tracking tests' '
>
> This setup is not just for remote-tracking tests.

Yes, this is misleading, thanks.

>
>> +	(
>> +		cd super &&
>> +		git branch branch-a &&
>> +		git checkout -b branch-b &&
>> +		git submodule add ../sub-upstream sub2 &&
>> +		# branch-b now has a committed submodule not in branch-a
>> +		git commit -m "add second submodule"
>> +	) &&
>> +	git clone --branch main --recurse-submodules super super-clone &&
>> +	git -C super-clone config submodule.propagateBranches true
>> +'
>> +
>> +test_expect_success 'should not create branch when submodule is not in .git/modules' '
>
> I understand that no branch is created, but the title is ambiguous, to
> me, whether it is a fatal error or not. Maybe the title should be "fatal
> error upon branch creation when submodule is not in .git/modules".

Ok, makes sense.

>
>> +	# The cleanup needs to delete sub2 separately because main does not have sub2
>> +	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
>> +		git -C super-clone/sub2/sub-sub branch -D branch-b && \
>> +		cleanup_branches super-clone branch-a branch-b" &&
>> +	(
>> +		cd super-clone &&
>> +		# This should succeed because super-clone has sub.
>
> "has sub in .git/modules", I think.
>
>> +		git branch --recurse-submodules branch-a origin/branch-a &&
>> +		# This should fail because super-clone does not have sub2.
>
> Likewise.

Ah, yes, it might be confusing otherwise.
