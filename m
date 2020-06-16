Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF4C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417D0214DB
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8+0e/gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbgFPQB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgFPQB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:01:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E429DC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:01:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so3407708wmj.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k5b3Hgg/VIUF96TtioCeawhrggTqQ9peNF9C+ULTZoQ=;
        b=o8+0e/gDBw0WjCRp7BOpHED9lvH6nq3bap78V0/y5hqnQ/7edRzdP3OALtSE/Lz8mw
         YnJFZCa8oJs58pUukF35UHPduI6xUh7VG0gJbH/XciO7/MeM1GagAGkdJ7JIdkntOVUs
         ccpHiyrZafSrxPhmcLeoKsUiu3cyDSuzfSmy26NYw73EblaeRiiqrACMk9pCW9flwPze
         MHbm/SLzC3oEmmreWRt8Q9xlD/JRIYI6JTkUCx/E5h81PbRpwHoB8s0gT0eHxN3BWhHy
         ahuk9Y2dKXitasPtqeNm5tilK8XI9th/F43KKuuRldOzvT/QUTuwNIJxUdZ4k6u4ruN1
         zI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k5b3Hgg/VIUF96TtioCeawhrggTqQ9peNF9C+ULTZoQ=;
        b=ig8BHyq3CBte7Rn+VjymiKfcFX/3PMvNwN+fivd2v3wZrDf6noicJBKkC5yywJZDhi
         ipMByOwqj7+IAc/DX5hIgjm05eDjrUmnSr4CAxw2NDHa8s2Cl79jF+r3cd4K0GNWCnkk
         wCvS8lWfH5iqUvYHHsU2E9X4mOp9YkVHrLaQrnl4BzuGw84P2mZ5uH4lQ2vZSuU43TlP
         /mVb7RqRSDgxJOMbPITxCP4ve+MhKHyTBgZIdP5kcAioicDVUrTwQ1fSKJEQemz3tsgF
         qpBn6jxAwrRNtBN9tpGCizzIIbx2UX2fH54GTjDDaPwE/uSyE/ba420AqY6t/K6G9dLV
         nRFQ==
X-Gm-Message-State: AOAM533oNkUAgcdX37HyeX7dakY8cLfWgrI4Z/36Zxw1/PN/t19p8cd3
        Fg11Mo0OVVLvF+VHAEKKoQE=
X-Google-Smtp-Source: ABdhPJwDcNMm/l8UE3enyMt74ZCTF6VyBoba6ZDpEzZ9W5ifrNO9RNolvVps9PXMe14R1SbdYSpZRQ==
X-Received: by 2002:a1c:154:: with SMTP id 81mr3845149wmb.23.1592323315648;
        Tue, 16 Jun 2020 09:01:55 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id u7sm30348160wrm.23.2020.06.16.09.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:01:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] checkout: teach --worktree
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
 <2a434d328429907a304ad6aaad4c1d9261d27831.1592124367.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3c223d33-7f3f-7f4c-df91-3b72271308cd@gmail.com>
Date:   Tue, 16 Jun 2020 17:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2a434d328429907a304ad6aaad4c1d9261d27831.1592124367.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 14/06/2020 09:49, Denton Liu wrote:
> A complaint that has come up frequently in the past is that it is not
> possible to checkout files directly into a worktree without modifying
> the index. Even though this could be worked around by redirecting the
> output of `git show` to overwrite files, this was not feasible if one
> wanted to use patch mode.
> 
> Since `git restore` was implemented, this has since been possible using
> the `--worktree` option. However, some long-time users of Git still
> prefer to use `git checkout` over `git restore` and would like to see
> the functionality ported over.
> 
> Teach `git checkout --worktree`, allowing users to checkout files
> directly into the worktree without affecting the index.

I'm afraid I'm not sure that adding another option to `git checkout` is 
a good idea. The behavior of `git checkout` is already complicated 
enough which is why we ended up with switch and restore separating out 
branch switching from file updating.

Given `git restore` provides a way to update the worktree without 
touching the index I'm not convinced we should be further complicating 
`git checkout` especially as it defaults to --overlay unless -p is given 
which is confusing in itself.

Best Wishes

Phillip

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> I realised that making `git checkout --worktree` without a pathspec to
> check out the current directory doesn't really make sense so I didn't
> make that change.
> 
> Range-diff against v1:
> 1:  d10cb03dd8 ! 1:  2a434d3284 checkout: teach --worktree
>      @@ Documentation/git-checkout.txt: When switching branches with `--merge`, staged c
>       +-W::
>       +--worktree::
>       +	When writing contents, only modify files in the worktree. Do not
>      -+	modify the index. This option is essentially a no-op when used
>      -+	without a `<tree-ish>`.
>      ++	modify the index.  This option does not make sense without a
>      ++	`<pathspec>`.
>       +
>        -p::
>        --patch::
>      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
>       +
>       +	opts->checkout_index = 0;
>       +	opts->checkout_worktree = 1;
>      ++	opts->empty_pathspec_ok = 0;
>       +
>       +	return 0;
>       +}
>      @@ builtin/checkout.c: int cmd_checkout(int argc, const char **argv, const char *pr
>        		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
>        			   N_("create/reset and checkout a branch")),
>       +		OPT_CALLBACK_F('W', "worktree", &opts, NULL,
>      -+			   N_("restore the working tree (default)"),
>      ++			   N_("restore the working tree"),
>       +			   PARSE_OPT_NOARG | PARSE_OPT_NONEG, handle_worktree_opt),
>        		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
>        		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
>      @@ t/t2028-checkout-worktree.sh (new)
>       +	test_cmp_rev HEAD tip
>       +'
>       +
>      ++test_expect_success 'checkout --worktree without pathspec fails' '
>      ++	test_must_fail git checkout --worktree
>      ++'
>      ++
>       +test_expect_success 'checkout --no-worktree fails' '
>       +	test_must_fail git checkout --no-worktree
>       +'
> 
>   Documentation/git-checkout.txt | 22 +++++++++-----
>   builtin/checkout.c             | 18 +++++++++++
>   t/t2028-checkout-worktree.sh   | 55 ++++++++++++++++++++++++++++++++++
>   t/t9902-completion.sh          |  1 +
>   4 files changed, 89 insertions(+), 7 deletions(-)
>   create mode 100755 t/t2028-checkout-worktree.sh
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 5b697eee1b..c303839920 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -12,9 +12,9 @@ SYNOPSIS
>   'git checkout' [-q] [-f] [-m] --detach [<branch>]
>   'git checkout' [-q] [-f] [-m] [--detach] <commit>
>   'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
> -'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
> -'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
> -'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
> +'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--worktree] [<tree-ish>] [--] <pathspec>...
> +'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--worktree] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
> +'git checkout' (-p|--patch) [--worktree] [<tree-ish>] [--] [<pathspec>...]
>   
>   DESCRIPTION
>   -----------
> @@ -79,14 +79,16 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
>   +
>   Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
>   
> -'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
> -'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
> +'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--worktree] [<tree-ish>] [--] <pathspec>...::
> +'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--worktree] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
>   
>   	Overwrite the contents of the files that match the pathspec.
>   	When the `<tree-ish>` (most often a commit) is not given,
>   	overwrite working tree with the contents in the index.
>   	When the `<tree-ish>` is given, overwrite both the index and
> -	the working tree with the contents at the `<tree-ish>`.
> +	the working tree with the contents at the `<tree-ish>` unless
> +	`--worktree` is given in which case _only_ the working tree is
> +	overwritten.
>   +
>   The index may contain unmerged entries because of a previous failed merge.
>   By default, if you try to check out such an entry from the index, the
> @@ -96,7 +98,7 @@ specific side of the merge can be checked out of the index by
>   using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
>   file can be discarded to re-create the original conflicted merge result.
>   
> -'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
> +'git checkout' (-p|--patch) [--worktree] [<tree-ish>] [--] [<pathspec>...]::
>   	This is similar to the previous mode, but lets you use the
>   	interactive interface to show the "diff" output and choose which
>   	hunks to use in the result.  See below for the description of
> @@ -264,6 +266,12 @@ When switching branches with `--merge`, staged changes may be lost.
>   	"merge" (default) and "diff3" (in addition to what is shown by
>   	"merge" style, shows the original contents).
>   
> +-W::
> +--worktree::
> +	When writing contents, only modify files in the worktree. Do not
> +	modify the index.  This option does not make sense without a
> +	`<pathspec>`.
> +
>   -p::
>   --patch::
>   	Interactively select hunks in the difference between the
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index af849c644f..8c533a305b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1741,6 +1741,21 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		return checkout_branch(opts, &new_branch_info);
>   }
>   
> +static int handle_worktree_opt(const struct option *opt, const char *arg, int unset)
> +{
> +	struct checkout_opts *opts = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	opts->checkout_index = 0;
> +	opts->checkout_worktree = 1;
> +	opts->empty_pathspec_ok = 0;
> +
> +	return 0;
> +}
> +
> +
>   int cmd_checkout(int argc, const char **argv, const char *prefix)
>   {
>   	struct checkout_opts opts;
> @@ -1750,6 +1765,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>   			   N_("create and checkout a new branch")),
>   		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
>   			   N_("create/reset and checkout a branch")),
> +		OPT_CALLBACK_F('W', "worktree", &opts, NULL,
> +			   N_("restore the working tree"),
> +			   PARSE_OPT_NOARG | PARSE_OPT_NONEG, handle_worktree_opt),
>   		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
>   		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
>   			 N_("second guess 'git checkout <no-such-branch>' (default)")),
> diff --git a/t/t2028-checkout-worktree.sh b/t/t2028-checkout-worktree.sh
> new file mode 100755
> index 0000000000..b5b5e287c1
> --- /dev/null
> +++ b/t/t2028-checkout-worktree.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +
> +test_description='checkout --worktree'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo first >file1 &&
> +	echo file2 >file2 &&
> +	git add file1 file2 &&
> +	git commit -m first &&
> +
> +	echo second >file1 &&
> +	git commit -am second &&
> +	git tag tip
> +'
> +
> +test_expect_success 'checkout --worktree on a commit' '
> +	test_when_finished "git reset --hard tip" &&
> +	git diff HEAD HEAD~ >expect &&
> +	git checkout --worktree HEAD~ file1 &&
> +	git diff >actual &&
> +	test_cmp expect actual &&
> +	git diff --cached --exit-code &&
> +	test_cmp_rev HEAD tip
> +'
> +
> +test_expect_success 'checkout --worktree with no commit' '
> +	test_when_finished "git reset --hard tip" &&
> +	echo worktree >file1 &&
> +	git checkout --worktree file1 &&
> +	git diff --exit-code &&
> +	test_cmp_rev HEAD tip
> +'
> +
> +test_expect_success 'checkout --worktree without pathspec fails' '
> +	test_must_fail git checkout --worktree
> +'
> +
> +test_expect_success 'checkout --no-worktree fails' '
> +	test_must_fail git checkout --no-worktree
> +'
> +
> +test_expect_success PERL 'git checkout -p --worktree' '
> +	test_when_finished "git reset --hard tip" &&
> +	echo changed >file2 &&
> +	git diff -R --src-prefix=b/ --dst-prefix=a/ >expect &&
> +	git commit -am file12 &&
> +	test_write_lines n y | git checkout --worktree -p HEAD~2 &&
> +	git diff >actual &&
> +	test_cmp expect actual &&
> +	git diff --cached --exit-code
> +'
> +
> +test_done
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 3c44af6940..1db0bb3a31 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1481,6 +1481,7 @@ test_expect_success 'double dash "git checkout"' '
>   	--quiet Z
>   	--detach Z
>   	--track Z
> +	--worktree Z
>   	--orphan=Z
>   	--ours Z
>   	--theirs Z
> 
