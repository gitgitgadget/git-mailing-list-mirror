Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E4C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2541A2078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naeOvySa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgFWWsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgFWWrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04EC0617BC
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so388037wmh.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cjnk3JYKiWJisRp2lMPx0FDjzVcE8A+Ebfdtmw2KG2k=;
        b=naeOvySaHkJ1OC8dPMb/A88r82KNAY2RhG22jvskKlFkU287UWS2qjtOpr7+NoGMuq
         3DPD0qT5jKjnHAd4Q4dGWMbHfqaDJCZbCflgh7JrSiZvWmUoYudeMUQMqzRcbY2/herY
         ZyGnY6GyBed/wCND2zTiRZZfvaN9f0HIBQn3QEZ6PRyOVQadytjA4p99HSFWRTdlIfYW
         piIkl2zyqdAvh+3BWMXtUc1kOx2FaU1VIGjoyZI0LiyQOz1UBNAJ1ZG7srd+OU67zE4F
         pXpi1Kf1j3dZoBCYuIDD6B4T3JTQjYs5t7pe6gt46xyrQMrYspXUyp1KSahsXbofpE+L
         /+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cjnk3JYKiWJisRp2lMPx0FDjzVcE8A+Ebfdtmw2KG2k=;
        b=s850wzmIE5IqUMmNtMYRZ9Z+Z89dCbSFMHXCbeEj2BtLxg0NKc+BMy/zS8x6hE7lTH
         OaycAU6PAZSHKoTffzBLc//s7EoKlf44YKVNlIS6oGsaTBgctLbDFxllFwfSlw6pzU2X
         JijfD5g/LFMBlTGa/eOOWzTOlUIhw3TztD80/Pqh3t2ru3mBwe+3ChuoG1Z8KU7QVh2E
         ighSFLP50j5w27U6Wi7WcGqE6qiPRcfMk9vxGDyyPyfuRfrC995iVYqVjF83gpufLb0c
         kbT0bn1dIRF44FT6zMD5m52HHdpIxbnZIlPX7jld0bFTUnnnAh8QfMcApu4111vTtxyB
         ay2A==
X-Gm-Message-State: AOAM530riHuVsvuXCEzrVmLleuupWKhjpybROkEiAzCCgwg3EqopBPEQ
        7GDp2I8I0wT+ayNMzTJBFzxVeTpY
X-Google-Smtp-Source: ABdhPJzCQnX4P1aykwOuDlUfc0fAKtFbQ4s5KFXR4WHRQOy5Mfwpu1edqTIQnnedjb5At+MxP8UeFQ==
X-Received: by 2002:a1c:64d5:: with SMTP id y204mr27618440wmb.131.1592951612816;
        Tue, 23 Jun 2020 15:33:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm23780003wrn.29.2020.06.23.15.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:32 -0700 (PDT)
Message-Id: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:22 +0000
Subject: [PATCH v3 0/8] Allow overriding the default name of the default branch
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
        <avarab@gmail.com>,
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

Johannes Schindelin (7):
  fmt-merge-msg: stop treating `master` specially
  send-pack/transport-helper: avoid mentioning a particular branch
  submodule: use a better fall-back for missing remote.<name>.branch
  init: allow specifying the initial branch name for the new repository
  clone: use configured default branch name when appropriate
  remote: use the configured default branch name when appropriate
  testsvn: respect `init.defaultBranch`

 Documentation/config/init.txt                 |  4 ++
 Documentation/git-init.txt                    |  7 ++
 Documentation/git-submodule.txt               |  4 +-
 builtin/clone.c                               | 13 ++--
 builtin/init-db.c                             | 34 +++++++--
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
 48 files changed, 287 insertions(+), 122 deletions(-)


base-commit: c9c318d6bf26bcecdca5b6f31683b9d5887a83ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-656%2Fdscho%2Fdefault-branch-name-option-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-656/dscho/default-branch-name-option-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/656

Range-diff vs v2:

  1:  ebd10f73cd <  -:  ---------- fast-export: do anonymize the primary branch name
  -:  ---------- >  1:  fffdb9944f fmt-merge-msg: stop treating `master` specially
  3:  bd8af3755a !  2:  a29943d7bb send-pack/transport-helper: respect `core.mainBranch`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    send-pack/transport-helper: respect `core.mainBranch`
     +    send-pack/transport-helper: avoid mentioning a particular branch
      
     -    When mentioning the main branch name in an error message, we want to go
     -    with the preference specified by the user, only falling back to Git's
     -    own, hard-coded default when none was configured explicitly.
     +    When trying to push all matching branches, but none match, we offer a
     +    message suggesting to push the `master` branch.
     +
     +    However, we want to step away from making that branch any more special
     +    than any other branch, so let's reword that message to mention no branch
     +    in particular.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## send-pack.c ##
      @@ send-pack.c: int send_pack(struct send_pack_args *args,
     - 	}
       
       	if (!remote_refs) {
     -+		char *branch_name = git_main_branch_name();
     -+
       		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
      -			"Perhaps you should specify a branch such as 'master'.\n");
     -+			"Perhaps you should specify a branch such as '%s'.\n",
     -+			branch_name);
     -+		free(branch_name);
     ++			"Perhaps you should specify a specific branch.\n");
       		return 0;
       	}
       	if (args->atomic && !atomic_supported)
     @@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch with upstr
       
      +test_expect_success '"matching" fails if none match' '
      +	git init --bare empty &&
     -+	test_must_fail git -c core.mainBranch=unmatch push empty : 2>actual &&
     -+	needle="Perhaps you should specify a branch such as '\''unmatch'\''" &&
     -+	test_i18ngrep "$needle" actual
     ++	test_must_fail git push empty : 2>actual &&
     ++	test_i18ngrep "Perhaps you should specify a specific branch" actual
      +'
      +
       test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
     @@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch with upstr
      
       ## transport-helper.c ##
      @@ transport-helper.c: static int push_refs(struct transport *transport,
     - 	}
     - 
       	if (!remote_refs) {
     -+		char *branch_name = git_main_branch_name();
     -+
       		fprintf(stderr,
       			_("No refs in common and none specified; doing nothing.\n"
      -			  "Perhaps you should specify a branch such as 'master'.\n"));
     -+			  "Perhaps you should specify a branch such as '%s'.\n"),
     -+			branch_name);
     -+		free(branch_name);
     ++			  "Perhaps you should specify a specific branch.\n"));
       		return 0;
       	}
       
 11:  59d6267f09 !  3:  6bda69541b submodule: use the correct default for the main branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    submodule: use the correct default for the main branch name
     +    submodule: use a better fall-back for missing remote.<name>.branch
      
     -    To allow for overriding the default branch name, we have introduced a
     -    config setting. With this patch, the `git submodule` command learns
     -    about this, too.
     +    When `remote.<name>.branch` is not configured, `git submodule update`
     +    currently falls back to using the branch name `master`. A much better
     +    idea, however, is to use `HEAD`: on all Git servers running reasonably
     +    recent Git versions, the symref `HEAD` points to the main branch.
     +
     +    Note: t7419 demonstrates that there _might_ be use cases out there that
     +    _expect_ `git submodule update --remote` to update submodules to the
     +    remote `master` branch even if the remote `HEAD` points to another
     +    branch. Arguably, this patch makes the behavior more intuitive, but
     +    there is a slight possibility that this might cause regressions in
     +    obscure setups.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## Documentation/git-submodule.txt ##
     +@@ Documentation/git-submodule.txt: OPTIONS
     + 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
     + 	indicate that the name of the branch in the submodule should be the
     + 	same name as the current branch in the current repository.  If the
     +-	option is not specified, it defaults to 'master'.
     ++	option is not specified, it defaults to 'HEAD'.
     + 
     + -f::
     + --force::
     +@@ Documentation/git-submodule.txt: OPTIONS
     + 	the superproject's recorded SHA-1 to update the submodule, use the
     + 	status of the submodule's remote-tracking branch.  The remote used
     + 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
     +-	The remote branch used defaults to `master`, but the branch name may
     ++	The remote branch used defaults to `HEAD`, but the branch name may
     + 	be overridden by setting the `submodule.<name>.branch` option in
     + 	either `.gitmodules` or `.git/config` (with `.git/config` taking
     + 	precedence).
     +
       ## builtin/submodule--helper.c ##
      @@ builtin/submodule--helper.c: static const char *remote_submodule_branch(const char *path)
     - 		branch = sub->branch;
       	free(key);
       
     --	if (!branch)
     + 	if (!branch)
      -		return "master";
     -+	if (!branch) {
     -+		static char *fall_back;
     -+
     -+		if (!fall_back)
     -+			fall_back = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
     -+
     -+		return fall_back;
     -+	}
     ++		return "HEAD";
       
       	if (!strcmp(branch, ".")) {
       		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
     @@ t/t7406-submodule-update.sh: test_expect_success 'setup a submodule tree' '
       	)
       '
       
     -+test_expect_success 'update --remote uses configured default main branch' '
     -+	git clone super main-branch &&
     -+	test_must_fail git -C main-branch -c init.defaultBranch=hello \
     -+		submodule update --init --remote submodule 2>err &&
     -+	test_i18ngrep origin/hello err
     ++test_expect_success 'update --remote falls back to using HEAD' '
     ++	test_create_repo main-branch-submodule &&
     ++	test_commit -C main-branch-submodule initial &&
     ++
     ++	test_create_repo main-branch &&
     ++	git -C main-branch submodule add ../main-branch-submodule &&
     ++	git -C main-branch commit -m add-submodule &&
     ++
     ++	git -C main-branch-submodule switch -c hello &&
     ++	test_commit -C main-branch-submodule world &&
     ++
     ++	git clone --recursive main-branch main-branch-clone &&
     ++	git -C main-branch-clone submodule update --remote main-branch-submodule &&
     ++	test_path_exists main-branch-clone/main-branch-submodule/world.t
      +'
      +
       test_expect_success 'submodule update detaching the HEAD ' '
       	(cd super/submodule &&
       	 git reset --hard HEAD~1
     +
     + ## t/t7419-submodule-set-branch.sh ##
     +@@ t/t7419-submodule-set-branch.sh: test_expect_success 'test submodule set-branch --branch' '
     + '
     + 
     + test_expect_success 'test submodule set-branch --default' '
     ++	test_commit -C submodule c &&
     + 	(cd super &&
     + 		git submodule set-branch --default submodule &&
     + 		! grep branch .gitmodules &&
     + 		git submodule update --remote &&
     + 		cat <<-\EOF >expect &&
     +-		a
     ++		c
     + 		EOF
     + 		git -C submodule show -s --pretty=%s >actual &&
     + 		test_cmp expect actual
     +@@ t/t7419-submodule-set-branch.sh: test_expect_success 'test submodule set-branch --default' '
     + '
     + 
     + test_expect_success 'test submodule set-branch -b' '
     ++	test_commit -C submodule b &&
     + 	(cd super &&
     + 		git submodule set-branch -b topic submodule &&
     + 		grep "branch = topic" .gitmodules &&
     +@@ t/t7419-submodule-set-branch.sh: test_expect_success 'test submodule set-branch -b' '
     + '
     + 
     + test_expect_success 'test submodule set-branch -d' '
     ++	test_commit -C submodule d &&
     + 	(cd super &&
     + 		git submodule set-branch -d submodule &&
     + 		! grep branch .gitmodules &&
     + 		git submodule update --remote &&
     + 		cat <<-\EOF >expect &&
     +-		a
     ++		d
     + 		EOF
     + 		git -C submodule show -s --pretty=%s >actual &&
     + 		test_cmp expect actual
  7:  0ec04b2086 !  4:  e8a6587c1a init: allow specifying the main branch name for the new repository
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    init: allow specifying the main branch name for the new repository
     +    init: allow specifying the initial branch name for the new repository
      
     -    There is a growing number of projects trying to avoid the non-inclusive
     -    name `master` in their repositories: The `master`/`slave` terminology is
     -    insensitive and perpetuates injustice. This `master`/`slave` idea is
     -    actually where Git's naming comes from, as it was inherited from
     -    BitKeeper which uses the term in exactly this way, see
     -    https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
     +    There is a growing number of projects and companies desiring to change
     +    the main branch name of their repositories (see e.g.
     +    https://twitter.com/mislav/status/1270388510684598272 for background on
     +    this).
      
          To change that branch name for new repositories, currently the only way
          to do that automatically is by copying all of Git's template directory,
     @@ Commit message
          template files.
      
          To make this process much less cumbersome, let's introduce a new option:
     -    `--main-branch=<branch-name>`.
     -
     -    This will not only initialize the repository with the specified initial
     -    branch; It will also record that branch name in `core.mainBranch`.
     +    `--initial-branch=<branch-name>`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ Documentation/git-init.txt: SYNOPSIS
       [verse]
       'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
       	  [--separate-git-dir <git dir>] [--object-format=<format]
     -+	  [-b <branch-name> | --main-branch=<branch-name>]
     ++	  [-b <branch-name> | --initial-branch=<branch-name>]
       	  [--shared[=<permissions>]] [directory]
       
       
     @@ Documentation/git-init.txt: repository.
       If this is reinitialization, the repository will be moved to the specified path.
       
      +-b <branch-name::
     -+--main-branch=<branch-name>::
     ++--initial-branch=<branch-name>::
      +
     -+Use the specified name for the main (or: initial) branch in the newly created
     -+repository. If not specified, fall back to the default name: `master`.
     ++Use the specified name for the initial branch in the newly created repository.
     ++If not specified, fall back to the default name: `master`.
      +
       --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
       
     @@ builtin/init-db.c: void initialize_repository_version(int hash_algo)
       
       static int create_default_files(const char *template_path,
       				const char *original_git_dir,
     -+				const char *main_branch,
     ++				const char *initial_branch,
       				const struct repository_format *fmt)
       {
       	struct stat st1;
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      -		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
      +		char *ref;
      +
     -+		if (!main_branch)
     -+			main_branch = "master";
     ++		if (!initial_branch)
     ++			initial_branch = "master";
      +
     -+		ref = xstrfmt("refs/heads/%s", main_branch);
     ++		ref = xstrfmt("refs/heads/%s", initial_branch);
      +		if (check_refname_format(ref, 0) < 0)
     -+			die(_("invalid main branch name: '%s'"), main_branch);
     ++			die(_("invalid initial branch name: '%s'"),
     ++			    initial_branch);
      +
      +		if (create_symref("HEAD", ref, NULL) < 0)
       			exit(1);
      -	}
      +		free(ref);
     -+
     -+		git_config_set("core.mainbranch", main_branch);
     -+	} else if (main_branch)
     -+		warning(_("re-init: ignoring --main-branch=%s"), main_branch);
     ++	} else if (initial_branch)
     ++		warning(_("re-init: ignoring --initial-branch=%s"),
     ++			initial_branch);
       
       	initialize_repository_version(fmt->hash_algo);
       
     @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format
       
       int init_db(const char *git_dir, const char *real_git_dir,
      -	    const char *template_dir, int hash, unsigned int flags)
     -+	    const char *template_dir, int hash, const char *main_branch,
     ++	    const char *template_dir, int hash, const char *initial_branch,
      +	    unsigned int flags)
       {
       	int reinit;
     @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
       
      -	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
      +	reinit = create_default_files(template_dir, original_git_dir,
     -+				      main_branch, &repo_fmt);
     ++				      initial_branch, &repo_fmt);
       
       	create_object_directory();
       
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       	const char *template_dir = NULL;
       	unsigned int flags = 0;
       	const char *object_format = NULL;
     -+	const char *main_branch = NULL;
     ++	const char *initial_branch = NULL;
       	int hash_algo = GIT_HASH_UNKNOWN;
       	const struct option init_db_options[] = {
       		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
       		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
       			   N_("separate git dir from working tree")),
     -+		OPT_STRING('b', "main-branch", &main_branch, N_("name"),
     -+			   N_("override the name of the main branch")),
     ++		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
     ++			   N_("override the name of the initial branch")),
       		OPT_STRING(0, "object-format", &object_format, N_("hash"),
       			   N_("specify the hash algorithm to use")),
       		OPT_END()
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       	flags |= INIT_DB_EXIST_OK;
      -	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
      +	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
     -+		       main_branch, flags);
     ++		       initial_branch, flags);
       }
      
       ## cache.h ##
     @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
       int init_db(const char *git_dir, const char *real_git_dir,
       	    const char *template_dir, int hash_algo,
      -	    unsigned int flags);
     -+	    const char *main_branch, unsigned int flags);
     ++	    const char *initial_branch, unsigned int flags);
       void initialize_repository_version(int hash_algo);
       
       void sanitize_stdfds(void);
     @@ t/t0001-init.sh: test_expect_success MINGW 'redirect std handles' '
       	grep "Needed a single revision" output.txt
       '
       
     -+test_expect_success '--main-branch' '
     -+	git init --main-branch=hello main-branch-option &&
     -+	git -C main-branch-option symbolic-ref HEAD >actual &&
     ++test_expect_success '--initial-branch' '
     ++	git init --initial-branch=hello initial-branch-option &&
     ++	git -C initial-branch-option symbolic-ref HEAD >actual &&
      +	echo refs/heads/hello >expect &&
      +	test_cmp expect actual &&
      +
     -+	: re-initializing should not change the main branch name &&
     -+	git init --main-branch=ignore main-branch-option 2>err &&
     -+	test_i18ngrep "ignoring --main-branch" err &&
     -+	git -C main-branch-option symbolic-ref HEAD >actual &&
     -+	grep hello actual &&
     -+	git -C main-branch-option config core.mainBranch >actual &&
     ++	: re-initializing should not change the branch name &&
     ++	git init --initial-branch=ignore initial-branch-option 2>err &&
     ++	test_i18ngrep "ignoring --initial-branch" err &&
     ++	git -C initial-branch-option symbolic-ref HEAD >actual &&
      +	grep hello actual
      +'
      +
  2:  f4d5473915 !  5:  a500e0f214 fmt-merge-msg: introduce a way to override the main branch name
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +Author: Don Goodman-Wilson <don@goodman-wilson.com>
      
       ## Commit message ##
     -    fmt-merge-msg: introduce a way to override the main branch name
     +    init: allow setting the default for the initial branch name via the config
      
     -    There is a growing number of projects and companies desiring to change
     -    the main branch name of their repositories (see e.g.
     -    https://twitter.com/mislav/status/1270388510684598272 for background on
     -    this).
     +    We just introduced the command-line option
     +    `--initial-branch=<branch-name>` to allow initializing a new repository
     +    with a different initial branch than the hard-coded one.
      
     -    However, there are a couple of hard-coded spots in Git's source code
     -    that make this endeavor harder than necessary. For example, when
     -    formatting the commit message for merge commits, Git appends "into
     -    <branch-name>" unless the current branch is the `master` branch.
     +    To allow users to override the initial branch name more permanently
     +    (i.e. without having to specify the name manually for each and every
     +    `git init` invocation), let's introduce the `init.defaultBranch` config
     +    setting.
      
     -    Clearly, this is not what one wants when already having gone through all
     -    the steps to manually rename the main branch (and taking care of all the
     -    fall-out such as re-targeting existing Pull Requests).
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Helped-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
      
     -    Let's introduce a way to override Git's hard-coded default:
     -    `core.mainBranch`.
     -
     -    We will start supporting this config option in the `git fmt-merge-msg`
     -    command and successively adjust all other places where the main branch
     -    name is hard-coded.
     -
     -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -
     - ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.abbrev::
     - 	in your repository, which hopefully is enough for
     - 	abbreviated object names to stay unique for some time.
     - 	The minimum length is 4.
     + ## Documentation/config/init.txt ##
     +@@
     + init.templateDir::
     + 	Specify the directory from which templates will be copied.
     + 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
      +
     -+core.mainBranch::
     -+	The name of the main (or: primary) branch in the current repository.
     -+	For historical reasons, `master` is used as the fall-back for this
     -+	setting.
     ++init.defaultBranch::
     ++	Allows overriding the default branch name when initializing
     ++	a new repository.
      
     - ## fmt-merge-msg.c ##
     -@@ fmt-merge-msg.c: static void fmt_merge_msg_title(struct strbuf *out,
     - 				const char *current_branch)
     - {
     - 	int i = 0;
     --	char *sep = "";
     -+	char *sep = "", *main_branch;
     + ## builtin/init-db.c ##
     +@@ builtin/init-db.c: static int create_default_files(const char *template_path,
     + 		char *ref;
       
     - 	strbuf_addstr(out, "Merge ");
     - 	for (i = 0; i < srcs.nr; i++) {
     -@@ fmt-merge-msg.c: static void fmt_merge_msg_title(struct strbuf *out,
     - 			strbuf_addf(out, " of %s", srcs.items[i].string);
     - 	}
     + 		if (!initial_branch)
     +-			initial_branch = "master";
     ++			initial_branch = git_default_branch_name();
       
     --	if (!strcmp("master", current_branch))
     -+	main_branch = git_main_branch_name();
     -+	if (!strcmp(main_branch, current_branch))
     - 		strbuf_addch(out, '\n');
     - 	else
     - 		strbuf_addf(out, " into %s\n", current_branch);
     -+	free(main_branch);
     - }
     - 
     - static void fmt_tag_signature(struct strbuf *tagbuf,
     + 		ref = xstrfmt("refs/heads/%s", initial_branch);
     + 		if (check_refname_format(ref, 0) < 0)
      
       ## refs.c ##
      @@ refs.c: void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
       		argv_array_pushf(prefixes, *p, len, prefix);
       }
       
     -+char *repo_main_branch_name(struct repository *r)
     ++char *repo_default_branch_name(struct repository *r)
      +{
     -+	const char *config_key = "core.mainbranch";
     -+	const char *config_display_key = "core.mainBranch";
     -+	const char *fall_back = "master";
     -+	char *name = NULL, *ret;
     ++	const char *config_key = "init.defaultbranch";
     ++	const char *config_display_key = "init.defaultBranch";
     ++	char *ret = NULL, *full_ref;
      +
     -+	if (repo_config_get_string(r, config_key, &name) < 0)
     ++	if (repo_config_get_string(r, config_key, &ret) < 0)
      +		die(_("could not retrieve `%s`"), config_display_key);
      +
     -+	ret = name ? name : xstrdup(fall_back);
     -+
     -+	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
     -+		die(_("invalid branch name: %s = %s"),
     -+		    config_display_key, name);
     ++	if (!ret)
     ++		ret = xstrdup("master");
      +
     -+	if (name != ret)
     -+		free(name);
     ++	full_ref = xstrfmt("refs/heads/%s", ret);
     ++	if (check_refname_format(full_ref, 0))
     ++		die(_("invalid branch name: %s = %s"), config_display_key, ret);
     ++	free(full_ref);
      +
      +	return ret;
      +}
      +
     -+char *git_main_branch_name(void)
     ++const char *git_default_branch_name(void)
      +{
     -+	return repo_main_branch_name(the_repository);
     ++	static char *ret;
     ++
     ++	if (!ret)
     ++		ret = repo_default_branch_name(the_repository);
     ++
     ++	return ret;
      +}
      +
       /*
     @@ refs.h: int repo_dwim_log(struct repository *r, const char *str, int len, struct
       int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
       
      +/*
     -+ * Retrieves the name of the main (or: primary) branch of the given
     -+ * repository.
     ++ * Retrieves the default branch name for newly-initialized repositories.
     ++ *
     ++ * The return value of `repo_default_branch_name()` is an allocated string. The
     ++ * return value of `git_default_branch_name()` is a singleton.
      + */
     -+char *git_main_branch_name(void);
     -+char *repo_main_branch_name(struct repository *r);
     ++const char *git_default_branch_name(void);
     ++char *repo_default_branch_name(struct repository *r);
      +
       /*
        * A ref_transaction represents a collection of reference updates that
        * should succeed or fail together.
      
     - ## t/t6200-fmt-merge-msg.sh ##
     -@@ t/t6200-fmt-merge-msg.sh: test_expect_success 'setup FETCH_HEAD' '
     - 	git fetch . left
     + ## t/t0001-init.sh ##
     +@@ t/t0001-init.sh: test_expect_success '--initial-branch' '
     + 	grep hello actual
       '
       
     -+test_expect_success 'with overridden default branch name' '
     -+	test_when_finished "git switch master" &&
     -+	git switch -c default &&
     -+	git -c core.mainBranch=default fmt-merge-msg <.git/FETCH_HEAD >actual &&
     -+	! grep "into default" actual
     ++test_expect_success 'overridden default initial branch name (config)' '
     ++	test_config_global init.defaultBranch nmb &&
     ++	git init initial-branch-config &&
     ++	git -C initial-branch-config symbolic-ref HEAD >actual &&
     ++	grep nmb actual
     ++'
     ++
     ++test_expect_success 'invalid default branch name' '
     ++	test_config_global init.defaultBranch "with space" &&
     ++	test_must_fail git init initial-branch-invalid 2>err &&
     ++	test_i18ngrep "invalid branch name" err
      +'
      +
     - test_expect_success 'merge.log=3 limits shortlog length' '
     - 	cat >expected <<-EOF &&
     - 	Merge branch ${apos}left${apos}
     + test_done
  4:  ca1c63c3e0 <  -:  ---------- git_main_branch_name(): optionally report the full ref name
  5:  a3be4f39aa <  -:  ---------- fast-export: handle overridden main branch names correctly
  6:  933e314813 <  -:  ---------- branch -m: adjust `core.mainBranch` if necessary
  8:  c711eba7e7 <  -:  ---------- init: allow overriding the default main branch name via the config
  9:  0e59b61816 !  6:  c0d74cedd1 clone: handle overridden main branch names
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    clone: handle overridden main branch names
     +    clone: use configured default branch name when appropriate
      
          When cloning a repository without any branches, Git chooses a default
          branch name for the as-yet unborn branch.
      
     -    As part of the implicit initialization of the local repository, Git
     -    just learned to respect `init.defaultBranch` to choose a different main
     +    As part of the implicit initialization of the local repository, Git just
     +    learned to respect `init.defaultBranch` to choose a different initial
          branch name. We now really want that branch name to be used as a
          fall-back.
      
     -    At the same time, we also want to make sure that `core.mainBranch` is
     -    set correctly, reflecting the name of the main branch. In case we detect
     -    a main branch, we do have to do that explicitly, otherwise `init_db()`
     -    will already have done that for us.
     -
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/config/init.txt ##
     @@ Documentation/config/init.txt: init.templateDir::
      +	a new repository or when cloning an empty repository.
      
       ## builtin/clone.c ##
     -@@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref *remote,
     - 		/* Local default branch link */
     - 		if (create_symref("HEAD", our->name, NULL) < 0)
     - 			die(_("unable to update HEAD"));
     -+		git_config_set("core.mainbranch", head);
     - 		if (!option_bare) {
     - 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
     - 				   UPDATE_REFS_DIE_ON_ERR);
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		remote_head_points_at = NULL;
       		remote_head = NULL;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      -			install_branch_config(0, "master", option_origin,
      -					      "refs/heads/master");
      +		if (!option_bare) {
     -+			char *main_branch =
     -+				git_main_branch_name(MAIN_BRANCH_FULL_NAME);
     -+			const char *nick;
     ++			const char *branch = git_default_branch_name();
     ++			char *ref = xstrfmt("refs/heads/%s", branch);
      +
     -+			if (!skip_prefix(main_branch, "refs/heads/", &nick))
     -+				BUG("unexpected default branch '%s'",
     -+				    main_branch);
     -+			install_branch_config(0, nick, option_origin,
     -+					      main_branch);
     -+			free(main_branch);
     ++			install_branch_config(0, branch, option_origin, ref);
     ++			free(ref);
      +		}
       	}
       
     @@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show pro
       
       '
       
     -+test_expect_success 'chooses correct default main branch name' '
     ++test_expect_success 'chooses correct default initial branch name' '
      +	git init --bare empty &&
      +	git -c init.defaultBranch=up clone empty whats-up &&
      +	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
     -+	test up = $(git -C whats-up config core.mainBranch) &&
      +	test refs/heads/up = $(git -C whats-up config branch.up.merge)
      +'
      +
     -+test_expect_success 'guesses main branch name correctly' '
     -+	git init --main-branch=guess main-branch &&
     -+	test_commit -C main-branch no-spoilers &&
     -+	git -C main-branch branch abc guess &&
     -+	git clone main-branch is-it &&
     -+	test guess = $(git -C is-it config core.mainBranch) &&
     ++test_expect_success 'guesses initial branch name correctly' '
     ++	git init --initial-branch=guess initial-branch &&
     ++	test_commit -C initial-branch no-spoilers &&
     ++	git -C initial-branch branch abc guess &&
     ++	git clone initial-branch is-it &&
      +	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
      +'
      +
 10:  59b8f4cfbb !  7:  00a1b281e5 remote: learn about the possibly-overridden default main branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    remote: learn about the possibly-overridden default main branch name
     +    remote: use the configured default branch name when appropriate
      
          When guessing the default branch name of a remote, and there are no refs
          to guess from, we want to go with the preference specified by the user
     -    for the fall-back, i.e. the default name to be used for the main branch
     -    of new repositories (because as far as the user is concerned, a remote
     -    that has no branches yet is a new repository).
     +    for the fall-back, i.e. the default name to be used for the initial
     +    branch of new repositories (because as far as the user is concerned, a
     +    remote that has no branches yet is a new repository).
     +
     +    At the same time, when talking to an older Git server that does not
     +    report a symref for `HEAD` (but instead reports a commit hash), let's
     +    try to guess the configured default branch name first. If it does not
     +    match the reported commit hash, let's fall back to `master` as before.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## remote.c ##
     -@@ remote.c: static void read_remotes_file(struct remote *remote)
     - 
     - static void read_branches_file(struct remote *remote)
     - {
     --	char *frag;
     -+	char *frag, *main_branch = NULL;
     - 	struct strbuf buf = STRBUF_INIT;
     - 	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
     - 
      @@ remote.c: static void read_branches_file(struct remote *remote)
       
       	/*
     @@ remote.c: static void read_branches_file(struct remote *remote)
       		*(frag++) = '\0';
       	else
      -		frag = "master";
     -+		frag = main_branch = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
     ++		frag = (char *)git_default_branch_name();
       
       	add_url_alias(remote, strbuf_detach(&buf, NULL));
       	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
     -@@ remote.c: static void read_branches_file(struct remote *remote)
     - 	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
     - 	refspec_append(&remote->push, buf.buf);
     - 	remote->fetch_tags = 1; /* always auto-follow */
     -+	free(main_branch);
     - 	strbuf_release(&buf);
     - }
     - 
      @@ remote.c: struct ref *guess_remote_head(const struct ref *head,
       	if (head->symref)
       		return copy_ref(find_ref_by_name(refs, head->symref));
       
      -	/* If refs/heads/master could be right, it is. */
     -+	/* If a remote branch exists with the main branch name, let's use it. */
     ++	/* If a remote branch exists with the default branch name, let's use it. */
       	if (!all) {
     --		r = find_ref_by_name(refs, "refs/heads/master");
     -+		char *name = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
     -+						  MAIN_BRANCH_FOR_INIT);
     ++		char *ref = xstrfmt("refs/heads/%s", git_default_branch_name());
     ++
     ++		r = find_ref_by_name(refs, ref);
     ++		free(ref);
     ++		if (r && oideq(&r->old_oid, &head->old_oid))
     ++			return copy_ref(r);
      +
     -+		r = find_ref_by_name(refs, name);
     -+		free(name);
     ++		/* Fall back to the hard-coded historical default */
     + 		r = find_ref_by_name(refs, "refs/heads/master");
       		if (r && oideq(&r->old_oid, &head->old_oid))
       			return copy_ref(r);
     - 	}
      
       ## t/t5606-clone-options.sh ##
     -@@ t/t5606-clone-options.sh: test_expect_success 'guesses main branch name correctly' '
     - 	git -C main-branch branch abc guess &&
     - 	git clone main-branch is-it &&
     - 	test guess = $(git -C is-it config core.mainBranch) &&
     +@@ t/t5606-clone-options.sh: test_expect_success 'guesses initial branch name correctly' '
     + 	test_commit -C initial-branch no-spoilers &&
     + 	git -C initial-branch branch abc guess &&
     + 	git clone initial-branch is-it &&
      -	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
      +	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD) &&
      +
      +	git -c init.defaultBranch=none init --bare no-head &&
     -+	git -C main-branch push ../no-head guess abc &&
     ++	git -C initial-branch push ../no-head guess abc &&
      +	git clone no-head is-it2 &&
      +	test_must_fail git -C is-it2 symbolic-ref refs/remotes/origin/HEAD &&
      +	git -C no-head update-ref --no-deref HEAD refs/heads/guess &&
 12:  e09f857f06 !  8:  1aa0e63785 testsvn: respect `init.defaultBranch`
     @@ Metadata
       ## Commit message ##
          testsvn: respect `init.defaultBranch`
      
     -    The default name of the main branch in new repositories can now be
     +    The default name of the initial branch in new repositories can now be
          configured. The `testsvn` remote helper translates the remote Subversion
          repository's branch name `trunk` to the hard-coded name `master`.
     -    Clearly, the intention was to make the name align with Git's detaults.
     +    Clearly, the intention was to make the name align with Git's defaults.
      
          So while we are not talking about a newly-created repository in the
     -    `testsvn` context, it _still_ makes sense to use the overridden default
     -    name for the main branch whenever users configured it.
     +    `testsvn` context, it is a newly-created _Git_ repository, si it _still_
     +    makes sense to use the overridden default name for the initial branch
     +    whenever users configured it.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ remote-testsvn.c: int cmd_main(int argc, const char **argv)
       		return 1;
       	}
       
     -+	remote_ref = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
     -+					  MAIN_BRANCH_FOR_INIT);
     -+	if (!skip_prefix(remote_ref, "refs/heads/", &remote_ref_short))
     -+		BUG("unexpected remote_ref '%s'", remote_ref);
     ++	remote_ref_short = git_default_branch_name();
     ++	remote_ref = xstrfmt("refs/heads/%s", remote_ref_short);
      +
       	remote = remote_get(argv[1]);
       	url_in = (argc == 3) ? argv[2] : remote->url[0];
     @@ t/t9020-remote-svn.sh: test_expect_success REMOTE_SVN 'incremental imports must
       	test_cmp master.good .git/refs/remotes/svnsim/master
       '
       
     -+test_expect_success REMOTE_SVN 'respects configured default main branch' '
     ++test_expect_success REMOTE_SVN 'respects configured default initial branch' '
      +	git -c init.defaultBranch=trunk remote add -f trunk \
      +		"testsvn::file://$TEST_DIRECTORY/t9154/svn.dump" &&
      +	git rev-parse --verify refs/remotes/trunk/trunk

-- 
gitgitgadget
