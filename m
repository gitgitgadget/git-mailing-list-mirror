Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06ADC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E54420702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8+lQw5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbgFXOql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgFXOqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72AC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so1312840wmf.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P461HKUew4YAchi6CF+wnPaYLIr5ZrgbHALZPliVPW0=;
        b=b8+lQw5qeKSsZUIxLVuYJDueCSAb/cYfWhjXmj7s5MbotedC4nqXRtFtsta5VI1UQB
         b9YZNTgoZEpnXI33YIfyprZ7z/KpuHKbj0MGx4KFQPXDrF+mVOyaWLtaVv6GbqfC/diK
         QaC44v86NPlJ7VzsSBlj332gzgCKahFzB8LilZJs9JbSaFb2VV1O62gOzAldhz5bEozT
         EkDqIAKd9VOJ71izDF71FwNUuQ9KYU3oRjZkOxMz/IRJf6zSqzcLGdT64G9eiHdqLOzr
         tkbte6et+PzbbreEAJyrmgl5IS9mzavcgzi1dkpDnrXHT4AOdwSooCYbs2Up79Qob30b
         0lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P461HKUew4YAchi6CF+wnPaYLIr5ZrgbHALZPliVPW0=;
        b=kDjNtAumbd9rToCgBGKVlbpFpeKZg/xkrQckw73GpBrRoLqQQD9ja5Nr2IOkbvZy7D
         PrUA4L+XL1sF17FFTP4VjvFBMGi8gO1z20HXUI2i6Du9xwvGTGebgAHJArUD5q8HmCVG
         mqneYpzVcPtEJeKZHfELNam26hIaC3SU1+74XtLM5A6aj25TsVJXHegj2yngJ6cNGyVK
         5n7cRKVrVY9xJh1hXCpdRdLSS+HUqhq6fI142gY01pYM1E30KixF7aK7Fpt9nVjaihSP
         4BNQfnu3gOsl6K7wNw02O6gvCG08YypgxtPCJ+wYCCi5Y8hst2xituvkhMNAMVyLCphR
         deAA==
X-Gm-Message-State: AOAM533cVQpQ028dBCCNZwyEdYwE6LtJvU7sb0qtjdyQpY9kCitPF1O6
        VHGdorxBNfhY8iR68tEqHWjvj6skchE=
X-Google-Smtp-Source: ABdhPJxEaKR9yqKHwKRvYqDqDyuIjr1UFPOxEBw7IABV3E9N4NzIZ1oL5z+gkos1c7TFS/4ABTZf1g==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr30422321wmh.150.1593009997865;
        Wed, 24 Jun 2020 07:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm7246095wmm.15.2020.06.24.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:37 -0700 (PDT)
Message-Id: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:27 +0000
Subject: [PATCH v4 0/9] Allow overriding the default name of the default branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A growing number of open source projects aims to avoid the branch name 
master due to its negative connotation. See [1] for an existing discussion
on this. The links [2], [3], and [4] describe community-driven ways for
users to rename their default branches or use template edits to set a new
default branch name.

[1] 
https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/

[2] https://twitter.com/mislav/status/1270388510684598272

[3] 
https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx

[4] https://github.com/ethomson/retarget_prs

By necessity, existing repositories require a lot of manual work to move
away from that branch name, but it should be much easier for new
repositories.

This patch series allows overriding the branch name being used for new
repositories' main branch. This can be configured via init.defaultBranch.

The initial patch was started by newcomer Don Goodman-Wilson, as well as the
bigger change that morphed into #655, where we demonstrate how to change
Git's hard-coded default branch name for new repositories to main based on
this here patch series, verifying the approach. Thanks for the contribution!

This series DOES NOT change the default automatically, but only provides an
opt-in mechanism for interested users. The plan for that is to convert the
test scripts incrementally (by introducing GIT_TEST_DEFAULT_MAIN_BRANCH_NAME
, which overrides init.defaultBranch, and then converting the tricky test
scripts first, one by one, using that environment variable).

Changes since v3:

 * We now avoid the phrasing "specify a specific" in the messages.
   
   
 * The git submodule patch has a better commit title now, and it also
   adjusts the documentation more completely now (thanks, Philippe!).
   
   
 * A code comment in builtin/init-db.c was updated to no longer talk about a 
   symlink when it comes to HEAD.
   
   
 * Made it the responsibility of the caller to warn about reinit &&
   initial_branch.
   
   

Changes since v2:

 * Dropped the fast-export patches, as they have been superseded by Peff's 
   jk/fast-export-anonym
   [https://github.com/gitgitgadget/git/commits/jk/fast-export-anonym].
   
   
 * Adjusted the fmt-merge-msg patch so as to not special-case master anymore
   (instead of special-casing a specific "main" branch).
   
   
 * Modified the git submodule patch so that it uses origin/HEAD instead of
   trying to look for a remote branch with the name indicated by 
   init.defaultBranch.
   
   

Changes since v1:

 * The modifications to respect GIT_TEST_DEFAULT_BRANCH_NAME have been
   backed out from this patch series, as they are only relevant once we
   start converting the test suite to accommodate for a new default main
   branch name.
   
   
 * An error message that started with an upper-case letter was downcased.
   
   
 * git_default_branch_name()'s logic was simplified by replacing an if ...
   else ... by a ternary assignment.
   
   
 * The git_default_branch_name() function was renamed to 
   git_main_branch_name() and a corresponding repo_main_branch_name() was
   introduced.
   
   
 * The "init" commit message's first paragraph now elaborates a little bit
   on the reasoning why projects want to move away from the current default
   branch name.
   
   
 * The "init" commit was split into two.
   
   
 * There are now two config settings: init.defaultBranch (defining the
   branch name to use when initializing new repositories) and 
   core.mainBranch (which is now configured by init_db(), declaring what the
   name of the main branch is in this repository).
   
   
 * The commits were re-ordered to introduce the concept of core.mainBranch 
   first because technically, this is something that we could do even
   without changing git init at all.
   
   
 * git fast-export --anonymize now always uses the ref name ref0 for the
   main branch, no matter whether it was overridden or whether the fall-back
   is in effect.
   
   
 * The code comment regarding anonymizing the main branch to ref0 in git
   fast-export --anonymize was enhanced.
   
   
 * A new patch was added to rename core.mainBranch if the main branch is
   renamed via git branch -m.
   
   
 * Added a patch that introduces support for git init
   --main-branch=<branch-name>.
   
   
 * Where possible, I added tests (although I did not try to extend test
   coverage to all changes: the send-pack.c/transport-helper.c patch only
   adds a test for the send-pack.c adjustment, for example).

Don Goodman-Wilson (1):
  init: allow setting the default for the initial branch name via the
    config

Johannes Schindelin (8):
  fmt-merge-msg: stop treating `master` specially
  send-pack/transport-helper: avoid mentioning a particular branch
  submodule: fall back to remote's HEAD for missing remote.<name>.branch
  docs: add missing diamond brackets
  init: allow specifying the initial branch name for the new repository
  clone: use configured default branch name when appropriate
  remote: use the configured default branch name when appropriate
  testsvn: respect `init.defaultBranch`

 Documentation/config/init.txt                 |  4 ++
 Documentation/git-branch.txt                  |  2 +-
 Documentation/git-clone.txt                   |  2 +-
 Documentation/git-init.txt                    |  9 ++-
 Documentation/git-submodule.txt               | 12 ++--
 Documentation/gitmodules.txt                  |  6 +-
 builtin/clone.c                               | 13 ++--
 builtin/init-db.c                             | 33 +++++++--
 builtin/submodule--helper.c                   |  2 +-
 cache.h                                       |  2 +-
 fmt-merge-msg.c                               |  5 +-
 refs.c                                        | 30 ++++++++
 refs.h                                        |  9 +++
 remote-testsvn.c                              | 10 ++-
 remote.c                                      | 14 +++-
 send-pack.c                                   |  2 +-
 t/t0001-init.sh                               | 26 +++++++
 t/t1507-rev-parse-upstream.sh                 |  2 +-
 t/t4013-diff-various.sh                       |  4 +-
 t/t4013/diff.log_--decorate=full_--all        |  2 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
 t/t4013/diff.log_--patch-with-stat_master     |  2 +-
 .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ..._--root_--patch-with-stat_--summary_master |  2 +-
 .../diff.log_--root_--patch-with-stat_master  |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4013/diff.log_--root_-p_master             |  2 +-
 t/t4013/diff.log_--root_master                |  2 +-
 t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
 t/t4013/diff.log_-m_-p_master                 |  4 +-
 t/t4013/diff.log_-p_--first-parent_master     |  2 +-
 t/t4013/diff.log_-p_master                    |  2 +-
 t/t4013/diff.log_master                       |  2 +-
 t/t4013/diff.show_--first-parent_master       |  2 +-
 t/t4013/diff.show_-c_master                   |  2 +-
 t/t4013/diff.show_-m_master                   |  4 +-
 t/t4013/diff.show_master                      |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4202-log.sh                                | 72 +++++++++----------
 t/t5528-push-default.sh                       |  6 ++
 t/t5606-clone-options.sh                      | 24 +++++++
 t/t6200-fmt-merge-msg.sh                      | 36 +++++-----
 t/t7406-submodule-update.sh                   | 16 +++++
 t/t7419-submodule-set-branch.sh               |  7 +-
 t/t7600-merge.sh                              | 14 ++--
 t/t7608-merge-messages.sh                     | 10 +--
 t/t9020-remote-svn.sh                         |  6 ++
 transport-helper.c                            |  2 +-
 51 files changed, 297 insertions(+), 131 deletions(-)


base-commit: c9c318d6bf26bcecdca5b6f31683b9d5887a83ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-656%2Fdscho%2Fdefault-branch-name-option-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-656/dscho/default-branch-name-option-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/656

Range-diff vs v3:

  1:  fffdb9944f =  1:  fffdb9944f fmt-merge-msg: stop treating `master` specially
  2:  a29943d7bb !  2:  1216de51ab send-pack/transport-helper: avoid mentioning a particular branch
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
       	if (!remote_refs) {
       		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
      -			"Perhaps you should specify a branch such as 'master'.\n");
     -+			"Perhaps you should specify a specific branch.\n");
     ++			"Perhaps you should specify a branch.\n");
       		return 0;
       	}
       	if (args->atomic && !atomic_supported)
     @@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch with upstr
      +test_expect_success '"matching" fails if none match' '
      +	git init --bare empty &&
      +	test_must_fail git push empty : 2>actual &&
     -+	test_i18ngrep "Perhaps you should specify a specific branch" actual
     ++	test_i18ngrep "Perhaps you should specify a branch" actual
      +'
      +
       test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
     @@ transport-helper.c: static int push_refs(struct transport *transport,
       		fprintf(stderr,
       			_("No refs in common and none specified; doing nothing.\n"
      -			  "Perhaps you should specify a branch such as 'master'.\n"));
     -+			  "Perhaps you should specify a specific branch.\n"));
     ++			  "Perhaps you should specify a branch.\n"));
       		return 0;
       	}
       
  3:  6bda69541b !  3:  54563642db submodule: use a better fall-back for missing remote.<name>.branch
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    submodule: use a better fall-back for missing remote.<name>.branch
     +    submodule: fall back to remote's HEAD for missing remote.<name>.branch
      
          When `remote.<name>.branch` is not configured, `git submodule update`
          currently falls back to using the branch name `master`. A much better
     -    idea, however, is to use `HEAD`: on all Git servers running reasonably
     -    recent Git versions, the symref `HEAD` points to the main branch.
     +    idea, however, is to use the remote `HEAD`: on all Git servers running
     +    reasonably recent Git versions, the symref `HEAD` points to the main
     +    branch.
      
          Note: t7419 demonstrates that there _might_ be use cases out there that
          _expect_ `git submodule update --remote` to update submodules to the
     @@ Commit message
          there is a slight possibility that this might cause regressions in
          obscure setups.
      
     +    Even so, it should be okay to fix this behavior without anything like a
     +    longer transition period:
     +
     +    - The `git submodule update --remote` command is not really common.
     +
     +    - Current Git's behavior when running this command is outright
     +      confusing, unless the remote repository's current branch _is_ `master`
     +      (in which case the proposed behavior matches the old behavior).
     +
     +    - If a user encounters a regression due to the changed behavior, the fix
     +      is actually trivial: setting `submodule.<name>.branch` to `master`
     +      will reinstate the old behavior.
     +
     +    Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/git-submodule.txt ##
     +@@ Documentation/git-submodule.txt: set-branch (-d|--default) [--] <path>::
     + 	Sets the default remote tracking branch for the submodule. The
     + 	`--branch` option allows the remote branch to be specified. The
     + 	`--default` option removes the submodule.<name>.branch configuration
     +-	key, which causes the tracking branch to default to 'master'.
     ++	key, which causes the tracking branch to default to the remote 'HEAD'.
     + 
     + set-url [--] <path> <newurl>::
     + 	Sets the URL of the specified submodule to <newurl>. Then, it will
      @@ Documentation/git-submodule.txt: OPTIONS
       	`.gitmodules` for `update --remote`.  A special value of `.` is used to
       	indicate that the name of the branch in the submodule should be the
       	same name as the current branch in the current repository.  If the
      -	option is not specified, it defaults to 'master'.
     -+	option is not specified, it defaults to 'HEAD'.
     ++	option is not specified, it defaults to the remote 'HEAD'.
       
       -f::
       --force::
     @@ Documentation/git-submodule.txt: OPTIONS
       	status of the submodule's remote-tracking branch.  The remote used
       	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
      -	The remote branch used defaults to `master`, but the branch name may
     -+	The remote branch used defaults to `HEAD`, but the branch name may
     - 	be overridden by setting the `submodule.<name>.branch` option in
     - 	either `.gitmodules` or `.git/config` (with `.git/config` taking
     - 	precedence).
     +-	be overridden by setting the `submodule.<name>.branch` option in
     +-	either `.gitmodules` or `.git/config` (with `.git/config` taking
     +-	precedence).
     ++	The remote branch used defaults to the remote `HEAD`, but the branch
     ++	name may be overridden by setting the `submodule.<name>.branch`
     ++	option in either `.gitmodules` or `.git/config` (with `.git/config`
     ++	taking precedence).
     + +
     + This works for any of the supported update procedures (`--checkout`,
     + `--rebase`, etc.).  The only change is the source of the target SHA-1.
     +
     + ## Documentation/gitmodules.txt ##
     +@@ Documentation/gitmodules.txt: submodule.<name>.update::
     + 
     + submodule.<name>.branch::
     + 	A remote branch name for tracking updates in the upstream submodule.
     +-	If the option is not specified, it defaults to 'master'.  A special
     +-	value of `.` is used to indicate that the name of the branch in the
     +-	submodule should be the same name as the current branch in the
     ++	If the option is not specified, it defaults to the remote 'HEAD'.
     ++	A special value of `.` is used to indicate that the name of the branch
     ++	in the submodule should be the same name as the current branch in the
     + 	current repository.  See the `--remote` documentation in
     + 	linkgit:git-submodule[1] for details.
     + 
      
       ## builtin/submodule--helper.c ##
      @@ builtin/submodule--helper.c: static const char *remote_submodule_branch(const char *path)
  -:  ---------- >  4:  1d723d35ed docs: add missing diamond brackets
  4:  e8a6587c1a !  5:  9edd4fd3b2 init: allow specifying the initial branch name for the new repository
     @@ Documentation/git-init.txt
      @@ Documentation/git-init.txt: SYNOPSIS
       [verse]
       'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
     - 	  [--separate-git-dir <git dir>] [--object-format=<format]
     + 	  [--separate-git-dir <git dir>] [--object-format=<format>]
      +	  [-b <branch-name> | --initial-branch=<branch-name>]
       	  [--shared[=<permissions>]] [directory]
       
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	/*
      -	 * Create the default symlink from ".git/HEAD" to the "master"
      -	 * branch, if it does not exist yet.
     -+	 * Create the default symlink from ".git/HEAD" to the default
     -+	 * branch name, if it does not exist yet.
     ++	 * Point the HEAD symref to the initial branch with if HEAD does
     ++	 * not yet exist.
       	 */
       	path = git_path_buf(&buf, "HEAD");
       	reinit = (!access(path, R_OK)
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      +
      +		if (create_symref("HEAD", ref, NULL) < 0)
       			exit(1);
     --	}
      +		free(ref);
     -+	} else if (initial_branch)
     -+		warning(_("re-init: ignoring --initial-branch=%s"),
     -+			initial_branch);
     + 	}
       
       	initialize_repository_version(fmt->hash_algo);
     - 
      @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
       }
       
     @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
      -	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
      +	reinit = create_default_files(template_dir, original_git_dir,
      +				      initial_branch, &repo_fmt);
     ++	if (reinit && initial_branch)
     ++		warning(_("re-init: ignored --initial-branch=%s"),
     ++			initial_branch);
       
       	create_object_directory();
       
     @@ t/t0001-init.sh: test_expect_success MINGW 'redirect std handles' '
      +
      +	: re-initializing should not change the branch name &&
      +	git init --initial-branch=ignore initial-branch-option 2>err &&
     -+	test_i18ngrep "ignoring --initial-branch" err &&
     ++	test_i18ngrep "ignored --initial-branch" err &&
      +	git -C initial-branch-option symbolic-ref HEAD >actual &&
      +	grep hello actual
      +'
  5:  a500e0f214 =  6:  7747eaa57d init: allow setting the default for the initial branch name via the config
  6:  c0d74cedd1 =  7:  1cff7705e4 clone: use configured default branch name when appropriate
  7:  00a1b281e5 !  8:  0a7c0bdfda remote: use the configured default branch name when appropriate
     @@ remote.c: static void read_branches_file(struct remote *remote)
       	/*
       	 * The branches file would have URL and optionally
      -	 * #branch specified.  The "master" (or specified) branch is
     -+	 * #branch specified.  The main (or specified) branch is
     ++	 * #branch specified.  The default (or specified) branch is
       	 * fetched and stored in the local branch matching the
       	 * remote name.
       	 */
  8:  1aa0e63785 =  9:  6c72abf677 testsvn: respect `init.defaultBranch`

-- 
gitgitgadget
