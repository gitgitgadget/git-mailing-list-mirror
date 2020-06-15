Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C205CC433E2
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BA22074D
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9rWeA8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFOMu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgFOMuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A58C05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so14694459wmh.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iQZpIZ3SrjkOBCfZmP7XQLIMli2dECaz1sxKjnzqkog=;
        b=M9rWeA8JQF2TeI1n1vPZ6pEFrj4mLsqIM22TOopBA+oWqOiumd0KLtxh41jEs2vtyu
         oePKBIgPmxxS1dXa9OC3HkxT5MQKGW9eXWpHAqJD0Irl8yqm72YL8aCyx3tAj199waAK
         w5JiV+pX0hohPdM9HgYjlNyHatZGuwG3xT7qyeYCDJY5WYdg4tKxB2IOJ3kjGUqXOb61
         4o0dbXLVdutxo04WPEQ1vt6hQGqhAMyZBm3AvSDIoEN2R5tIzFwGtPhe2CTUDn2pHEWD
         zfykxXAgtqDtTQaLRJckcpOCL50z6qCSMghcFm+nn+D09r4wmduHgmQ8EA6Xmjuq9Vvz
         I7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iQZpIZ3SrjkOBCfZmP7XQLIMli2dECaz1sxKjnzqkog=;
        b=MqnX8Tdk64AT++pwXhsWABOpdDXFIjkfadZ3H1tevnZYFvNZ7CaHP9qMFaD+NzF/Xr
         6GPzdjK52H7zVnG5YVAWWTUwoRIqQya9hUd17LaHqJRU0jAONAcBcdTcsBrTNAGqPnAE
         9emMVqoO1b3JAPvIcdrQSXeZvf9FVFhZHDsUw2YRWxdr3i7v1JwvIKU33wXe53ImOt0y
         nwHoyR8ujRQVWiTEJgJ62NsnCsvkFzCVJEHD4vwFttDeNHLrRLF5yk3Z+u1sJuHLHBpL
         zKPVZwO5qThD1byxqa9uDVKp7DX993xfbAuv8oKio3Jtwz7va5hSR0jdnSi3+IbIBjDd
         IY7Q==
X-Gm-Message-State: AOAM532aOiQ5V7tikBk44OySkn66UPQ1U7IxqOqmZPEko4jG88YwrtxN
        nEAYQS/vH9n6f01teXM3FwQ5zBOX
X-Google-Smtp-Source: ABdhPJwkQYyAmAgZo3D5VJjQygR0jCnjCvZOUguXNX+d2SxwbQaH4Ve4Wt3l+Vsr/6RBhufzfX0o1Q==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr12479471wmg.76.1592225418398;
        Mon, 15 Jun 2020 05:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm29507116wra.85.2020.06.15.05.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:17 -0700 (PDT)
Message-Id: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:04 +0000
Subject: [PATCH v2 00/12] Allow overriding the default name of the default branch
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
repositories' main branch, as well as telling Git about a renamed main
branch in an already-existing repository. The former would be configured via 
init.defaultBranch and the latter via core.mainBranch (which is now
automatically configured in git init).

Shell scripts can find out what the current repository's main branch name is
called via

main_branch=$(git config core.mainBranch || echo master)

This is even future proof because all future git init invocations will
configure that setting.

The initial patch was started by newcomer Don Goodman-Wilson, as well as the
bigger change that morphed into #655, where we demonstrate how to change
Git's hard-coded default main branch name to main based on this here patch
series, verifying the approach. Thanks for the contribution!

This series DOES NOT change the default automatically, but only provides an
opt-in mechanism for interested users. The plan for that is to convert the
test scripts incrementally (by introducing GIT_TEST_DEFAULT_MAIN_BRANCH_NAME
, which overrides init.defaultBranch, and then converting the tricky test
scripts first, one by one, using that environment variable).

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
  init: allow overriding the default main branch name via the config

Johannes Schindelin (10):
  fmt-merge-msg: introduce a way to override the main branch name
  send-pack/transport-helper: respect `core.mainBranch`
  git_main_branch_name(): optionally report the full ref name
  fast-export: handle overridden main branch names correctly
  branch -m: adjust `core.mainBranch` if necessary
  init: allow specifying the main branch name for the new repository
  clone: handle overridden main branch names
  remote: learn about the possibly-overridden default main branch name
  submodule: use the correct default for the main branch name
  testsvn: respect `init.defaultBranch`

Junio C Hamano (1):
  fast-export: do anonymize the primary branch name

 Documentation/config/core.txt    |  5 +++++
 Documentation/config/init.txt    |  4 ++++
 Documentation/git-init.txt       |  7 +++++++
 builtin/branch.c                 |  9 ++++++++
 builtin/clone.c                  | 19 +++++++++++++----
 builtin/fast-export.c            | 20 +++++++++++++-----
 builtin/init-db.c                | 36 +++++++++++++++++++++++++-------
 builtin/submodule--helper.c      | 10 +++++++--
 cache.h                          |  2 +-
 fmt-merge-msg.c                  |  6 ++++--
 refs.c                           | 34 ++++++++++++++++++++++++++++++
 refs.h                           | 15 +++++++++++++
 remote-testsvn.c                 | 12 ++++++++---
 remote.c                         | 15 ++++++++-----
 send-pack.c                      |  6 +++++-
 t/t0001-init.sh                  | 31 +++++++++++++++++++++++++++
 t/t3200-branch.sh                |  9 ++++++++
 t/t5528-push-default.sh          |  7 +++++++
 t/t5606-clone-options.sh         | 26 +++++++++++++++++++++++
 t/t6200-fmt-merge-msg.sh         |  7 +++++++
 t/t7406-submodule-update.sh      |  7 +++++++
 t/t9020-remote-svn.sh            |  6 ++++++
 t/t9351-fast-export-anonymize.sh | 15 +++++++++----
 transport-helper.c               |  6 +++++-
 24 files changed, 279 insertions(+), 35 deletions(-)


base-commit: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-656%2Fdscho%2Fdefault-branch-name-option-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-656/dscho/default-branch-name-option-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/656

Range-diff vs v1:

  -:  ----------- >  1:  ebd10f73cd7 fast-export: do anonymize the primary branch name
  7:  e849def4a8c !  2:  f4d54739153 fmt-merge-msg: learn about the possibly-configured default branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    fmt-merge-msg: learn about the possibly-configured default branch name
     +    fmt-merge-msg: introduce a way to override the main branch name
      
     -    When formatting the commit message for merge commits, Git appends "into
     -    <branch-name>" unless the current branch is the default branch.
     +    There is a growing number of projects and companies desiring to change
     +    the main branch name of their repositories (see e.g.
     +    https://twitter.com/mislav/status/1270388510684598272 for background on
     +    this).
      
     -    Now that we can configure what the default branch name should be, we
     -    will want to respect that setting in that scenario rather than using the
     -    compiled-in default branch name.
     +    However, there are a couple of hard-coded spots in Git's source code
     +    that make this endeavor harder than necessary. For example, when
     +    formatting the commit message for merge commits, Git appends "into
     +    <branch-name>" unless the current branch is the `master` branch.
     +
     +    Clearly, this is not what one wants when already having gone through all
     +    the steps to manually rename the main branch (and taking care of all the
     +    fall-out such as re-targeting existing Pull Requests).
     +
     +    Let's introduce a way to override Git's hard-coded default:
     +    `core.mainBranch`.
     +
     +    We will start supporting this config option in the `git fmt-merge-msg`
     +    command and successively adjust all other places where the main branch
     +    name is hard-coded.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## Documentation/config/core.txt ##
     +@@ Documentation/config/core.txt: core.abbrev::
     + 	in your repository, which hopefully is enough for
     + 	abbreviated object names to stay unique for some time.
     + 	The minimum length is 4.
     ++
     ++core.mainBranch::
     ++	The name of the main (or: primary) branch in the current repository.
     ++	For historical reasons, `master` is used as the fall-back for this
     ++	setting.
     +
       ## fmt-merge-msg.c ##
      @@ fmt-merge-msg.c: static void fmt_merge_msg_title(struct strbuf *out,
       				const char *current_branch)
       {
       	int i = 0;
      -	char *sep = "";
     -+	char *sep = "", *default_branch_name;
     ++	char *sep = "", *main_branch;
       
       	strbuf_addstr(out, "Merge ");
       	for (i = 0; i < srcs.nr; i++) {
     @@ fmt-merge-msg.c: static void fmt_merge_msg_title(struct strbuf *out,
       	}
       
      -	if (!strcmp("master", current_branch))
     -+	default_branch_name = git_default_branch_name(1);
     -+	if (!strcmp(default_branch_name, current_branch))
     ++	main_branch = git_main_branch_name();
     ++	if (!strcmp(main_branch, current_branch))
       		strbuf_addch(out, '\n');
       	else
       		strbuf_addf(out, " into %s\n", current_branch);
     -+	free(default_branch_name);
     ++	free(main_branch);
       }
       
       static void fmt_tag_signature(struct strbuf *tagbuf,
      
     + ## refs.c ##
     +@@ refs.c: void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
     + 		argv_array_pushf(prefixes, *p, len, prefix);
     + }
     + 
     ++char *repo_main_branch_name(struct repository *r)
     ++{
     ++	const char *config_key = "core.mainbranch";
     ++	const char *config_display_key = "core.mainBranch";
     ++	const char *fall_back = "master";
     ++	char *name = NULL, *ret;
     ++
     ++	if (repo_config_get_string(r, config_key, &name) < 0)
     ++		die(_("could not retrieve `%s`"), config_display_key);
     ++
     ++	ret = name ? name : xstrdup(fall_back);
     ++
     ++	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
     ++		die(_("invalid branch name: %s = %s"),
     ++		    config_display_key, name);
     ++
     ++	if (name != ret)
     ++		free(name);
     ++
     ++	return ret;
     ++}
     ++
     ++char *git_main_branch_name(void)
     ++{
     ++	return repo_main_branch_name(the_repository);
     ++}
     ++
     + /*
     +  * *string and *len will only be substituted, and *string returned (for
     +  * later free()ing) if the string passed in is a magic short-hand form
     +
     + ## refs.h ##
     +@@ refs.h: int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
     + int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
     + int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
     + 
     ++/*
     ++ * Retrieves the name of the main (or: primary) branch of the given
     ++ * repository.
     ++ */
     ++char *git_main_branch_name(void);
     ++char *repo_main_branch_name(struct repository *r);
     ++
     + /*
     +  * A ref_transaction represents a collection of reference updates that
     +  * should succeed or fail together.
     +
       ## t/t6200-fmt-merge-msg.sh ##
      @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'setup FETCH_HEAD' '
       	git fetch . left
       '
       
      +test_expect_success 'with overridden default branch name' '
     -+	test_config core.defaultBranchName default &&
      +	test_when_finished "git switch master" &&
      +	git switch -c default &&
     -+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
     ++	git -c core.mainBranch=default fmt-merge-msg <.git/FETCH_HEAD >actual &&
      +	! grep "into default" actual
      +'
      +
  3:  c9c9c81068e !  3:  bd8af3755ad send-pack/transport-helper: respect `core.defaultBranchName`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    send-pack/transport-helper: respect `core.defaultBranchName`
     +    send-pack/transport-helper: respect `core.mainBranch`
      
     -    When mentioning the default branch name in an error message, we want to
     -    go with the preference specified by the user.
     +    When mentioning the main branch name in an error message, we want to go
     +    with the preference specified by the user, only falling back to Git's
     +    own, hard-coded default when none was configured explicitly.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
       	}
       
       	if (!remote_refs) {
     -+		char *branch_name = git_default_branch_name(1);
     ++		char *branch_name = git_main_branch_name();
      +
       		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
      -			"Perhaps you should specify a branch such as 'master'.\n");
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
       	}
       	if (args->atomic && !atomic_supported)
      
     + ## t/t5528-push-default.sh ##
     +@@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch with upstream, matching and simple'
     + 	test_push_failure upstream
     + '
     + 
     ++test_expect_success '"matching" fails if none match' '
     ++	git init --bare empty &&
     ++	test_must_fail git -c core.mainBranch=unmatch push empty : 2>actual &&
     ++	needle="Perhaps you should specify a branch such as '\''unmatch'\''" &&
     ++	test_i18ngrep "$needle" actual
     ++'
     ++
     + test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
     + 	git checkout -b ambiguous &&
     + 	test_config branch.ambiguous.remote parent1 &&
     +
       ## transport-helper.c ##
      @@ transport-helper.c: static int push_refs(struct transport *transport,
       	}
       
       	if (!remote_refs) {
     -+		char *branch_name = git_default_branch_name(1);
     ++		char *branch_name = git_main_branch_name();
      +
       		fprintf(stderr,
       			_("No refs in common and none specified; doing nothing.\n"
  -:  ----------- >  4:  ca1c63c3e01 git_main_branch_name(): optionally report the full ref name
  8:  1efe848f2b0 !  5:  a3be4f39aa2 fast-export: respect the possibly-overridden default branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    fast-export: respect the possibly-overridden default branch name
     +    fast-export: handle overridden main branch names correctly
      
     -    When anonymizing commit history, we are careful to leave the branch name
     -    of the default branch alone.
     +    When anonymizing commit history, we are careful to translate the main
     +    branch name to `ref0`.
      
     -    When the default branch name is overridden via the config or via the
     -    environment variable, we will want `git fast-export` to use that
     -    overridden name instead.
     +    When the main branch name is overridden via the config, we will want
     +    `git fast-export` to use that overridden name instead.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ builtin/fast-export.c: static const char *anonymize_refname(const char *refname)
       	};
       	static struct hashmap refs;
       	static struct strbuf anon = STRBUF_INIT;
     -+	static char *default_branch_name;
     ++	static char *main_branch;
       	int i;
       
       	/*
     --	 * We also leave "master" as a special case, since it does not reveal
     --	 * anything interesting.
     -+	 * We also leave the default branch name as a special case, since it
     -+	 * does not reveal anything interesting.
     + 	 * In certain circumstances, it might be interesting to be able to
     + 	 * identify the main branch. For that reason, let's force its name to
     + 	 * be anonymized to `ref0`.
     ++	 *
     ++	 * While the main branch name might often be `main` for new
     ++	 * repositories (and `master` for aged ones), and such well-known names
     ++	 * may not necessarily need anonymizing, it could be configured to use
     ++	 * a secret word that the user may not want to reveal.
       	 */
      -	if (!strcmp(refname, "refs/heads/master"))
     -+	if (!default_branch_name)
     -+		default_branch_name = git_default_branch_name(0);
     ++	if (!main_branch)
     ++		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
      +
     -+	if (!strcmp(refname, default_branch_name))
     - 		return refname;
     ++	if (!strcmp(refname, main_branch))
     + 		return "refs/heads/ref0";
       
       	strbuf_reset(&anon);
     +
     + ## t/t9351-fast-export-anonymize.sh ##
     +@@ t/t9351-fast-export-anonymize.sh: test_expect_success 'stream translates master to ref0' '
     + 	! grep master stream
     + '
     + 
     ++test_expect_success 'respects configured main branch' '
     ++	git -c core.mainBranch=does-not-exist \
     ++		fast-export --anonymize --all >stream-without-ref0 &&
     ++	! grep ref0 stream-without-ref0
     ++'
     ++
     + test_expect_success 'stream omits other refnames' '
     + 	! grep other stream &&
     + 	! grep mytag stream
  -:  ----------- >  6:  933e314813d branch -m: adjust `core.mainBranch` if necessary
  1:  90912e32da1 !  7:  0ec04b2086e init: allow overriding the default branch name for new repositories
     @@
       ## Metadata ##
     -Author: Don Goodman-Wilson <don@goodman-wilson.com>
     +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    init: allow overriding the default branch name for new repositories
     +    init: allow specifying the main branch name for the new repository
      
          There is a growing number of projects trying to avoid the non-inclusive
     -    name `master` in their repositories. For existing repositories, this
     -    requires manual work. For new repositories, the only way to do that
     -    automatically is by copying all of Git's template directory, then
     -    hard-coding the desired default branch name into the `.git/HEAD` file,
     -    and then configuring `init.templateDir` to point to those copied
     +    name `master` in their repositories: The `master`/`slave` terminology is
     +    insensitive and perpetuates injustice. This `master`/`slave` idea is
     +    actually where Git's naming comes from, as it was inherited from
     +    BitKeeper which uses the term in exactly this way, see
     +    https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
     +
     +    To change that branch name for new repositories, currently the only way
     +    to do that automatically is by copying all of Git's template directory,
     +    then hard-coding the desired default branch name into the `.git/HEAD`
     +    file, and then configuring `init.templateDir` to point to those copied
          template files.
      
     -    To make this process much less cumbersome, let's introduce support for
     -    `core.defaultBranchName`. That way, users won't need to keep their
     -    copied template files up to date, and won't interfere with default hooks
     -    installed by their administrators.
     +    To make this process much less cumbersome, let's introduce a new option:
     +    `--main-branch=<branch-name>`.
      
     -    While at it, also let users set the default branch name via the
     -    environment variable `GIT_TEST_DEFAULT_BRANCH_NAME`, in preparation for
     -    adjusting Git's test suite to a more inclusive default branch name. As
     -    is common in Git, the `GIT_TEST_*` variable takes precedence over the
     -    config setting.
     +    This will not only initialize the repository with the specified initial
     +    branch; It will also record that branch name in `core.mainBranch`.
      
     -    Note: we use the prefix `core.` instead of `init.` because we want to
     -    adjust also `git clone`, `git fmt-merge-msg` and other commands over the
     -    course of the next commits to respect this setting.
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -    Helped-by: Derrick Stolee <dstolee@microsoft.com>
     -    Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
     + ## Documentation/git-init.txt ##
     +@@ Documentation/git-init.txt: SYNOPSIS
     + [verse]
     + 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
     + 	  [--separate-git-dir <git dir>] [--object-format=<format]
     ++	  [-b <branch-name> | --main-branch=<branch-name>]
     + 	  [--shared[=<permissions>]] [directory]
     + 
     + 
     +@@ Documentation/git-init.txt: repository.
     + +
     + If this is reinitialization, the repository will be moved to the specified path.
     + 
     ++-b <branch-name::
     ++--main-branch=<branch-name>::
     ++
     ++Use the specified name for the main (or: initial) branch in the newly created
     ++repository. If not specified, fall back to the default name: `master`.
     ++
     + --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
     + 
     + Specify that the Git repository is to be shared amongst several users.  This
     +
     + ## builtin/clone.c ##
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 		}
     + 	}
     + 
     +-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
     ++	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
     ++		INIT_DB_QUIET);
     + 
     + 	if (real_git_dir)
     + 		git_dir = real_git_dir;
      
       ## builtin/init-db.c ##
     +@@ builtin/init-db.c: void initialize_repository_version(int hash_algo)
     + 
     + static int create_default_files(const char *template_path,
     + 				const char *original_git_dir,
     ++				const char *main_branch,
     + 				const struct repository_format *fmt)
     + {
     + 	struct stat st1;
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       		die("failed to set up refs db: %s", err.buf);
       
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       		  || readlink(path, junk, sizeof(junk)-1) != -1);
       	if (!reinit) {
      -		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
     -+		char *default_ref = git_default_branch_name(0);
     -+		if (create_symref("HEAD", default_ref, NULL) < 0)
     ++		char *ref;
     ++
     ++		if (!main_branch)
     ++			main_branch = "master";
     ++
     ++		ref = xstrfmt("refs/heads/%s", main_branch);
     ++		if (check_refname_format(ref, 0) < 0)
     ++			die(_("invalid main branch name: '%s'"), main_branch);
     ++
     ++		if (create_symref("HEAD", ref, NULL) < 0)
       			exit(1);
     -+		free(default_ref);
     - 	}
     +-	}
     ++		free(ref);
     ++
     ++		git_config_set("core.mainbranch", main_branch);
     ++	} else if (main_branch)
     ++		warning(_("re-init: ignoring --main-branch=%s"), main_branch);
       
       	initialize_repository_version(fmt->hash_algo);
     -
     - ## refs.c ##
     -@@ refs.c: void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
     - 		argv_array_pushf(prefixes, *p, len, prefix);
     + 
     +@@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
       }
       
     -+char *git_default_branch_name(int short_name)
     -+{
     -+	const char *branch_name = getenv("GIT_TEST_DEFAULT_BRANCH_NAME");
     -+	char *from_config = NULL, *prefixed;
     -+
     -+	/*
     -+	 * If the default branch name was not specified via the environment
     -+	 * variable GIT_TEST_DEFAULT_BRANCH_NAME, retrieve it from the config
     -+	 * setting core.defaultBranchName. If neither are set, fall back to the
     -+	 * hard-coded default.
     -+	 */
     -+	if (!branch_name || !*branch_name) {
     -+		if (git_config_get_string("core.defaultbranchname",
     -+					  &from_config) < 0)
     -+			die(_("Could not retrieve `core.defaultBranchName`"));
     -+
     -+		if (from_config)
     -+			branch_name = from_config;
     -+		else
     -+			branch_name = "master";
     -+	}
     -+
     -+	if (short_name)
     -+		return from_config ? from_config : xstrdup(branch_name);
     -+
     -+	/* prepend "refs/heads/" to the branch name */
     -+	prefixed = xstrfmt("refs/heads/%s", branch_name);
     -+	if (check_refname_format(prefixed, 0))
     -+		die(_("invalid default branch name: '%s'"), branch_name);
     -+
     -+	free(from_config);
     -+	return prefixed;
     -+}
     -+
     - /*
     -  * *string and *len will only be substituted, and *string returned (for
     -  * later free()ing) if the string passed in is a magic short-hand form
     + int init_db(const char *git_dir, const char *real_git_dir,
     +-	    const char *template_dir, int hash, unsigned int flags)
     ++	    const char *template_dir, int hash, const char *main_branch,
     ++	    unsigned int flags)
     + {
     + 	int reinit;
     + 	int exist_ok = flags & INIT_DB_EXIST_OK;
     +@@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
     + 
     + 	validate_hash_algorithm(&repo_fmt, hash);
     + 
     +-	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
     ++	reinit = create_default_files(template_dir, original_git_dir,
     ++				      main_branch, &repo_fmt);
     + 
     + 	create_object_directory();
     + 
     +@@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     + 	const char *template_dir = NULL;
     + 	unsigned int flags = 0;
     + 	const char *object_format = NULL;
     ++	const char *main_branch = NULL;
     + 	int hash_algo = GIT_HASH_UNKNOWN;
     + 	const struct option init_db_options[] = {
     + 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
     +@@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     + 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
     + 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
     + 			   N_("separate git dir from working tree")),
     ++		OPT_STRING('b', "main-branch", &main_branch, N_("name"),
     ++			   N_("override the name of the main branch")),
     + 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
     + 			   N_("specify the hash algorithm to use")),
     + 		OPT_END()
     +@@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     + 	UNLEAK(work_tree);
     + 
     + 	flags |= INIT_DB_EXIST_OK;
     +-	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
     ++	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
     ++		       main_branch, flags);
     + }
      
     - ## refs.h ##
     -@@ refs.h: int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
     - int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
     - int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
     - 
     -+/*
     -+ * Retrieves the name of the default branch. If `short_name` is non-zero, the
     -+ * branch name will be prefixed with "refs/heads/".
     -+ */
     -+char *git_default_branch_name(int short_name);
     -+
     - /*
     -  * A ref_transaction represents a collection of reference updates that
     -  * should succeed or fail together.
     + ## cache.h ##
     +@@ cache.h: int path_inside_repo(const char *prefix, const char *path);
     + 
     + int init_db(const char *git_dir, const char *real_git_dir,
     + 	    const char *template_dir, int hash_algo,
     +-	    unsigned int flags);
     ++	    const char *main_branch, unsigned int flags);
     + void initialize_repository_version(int hash_algo);
     + 
     + void sanitize_stdfds(void);
      
       ## t/t0001-init.sh ##
      @@ t/t0001-init.sh: test_expect_success MINGW 'redirect std handles' '
       	grep "Needed a single revision" output.txt
       '
       
     -+test_expect_success 'custom default branch name from config' '
     -+	git config --global core.defaultbranchname nmb &&
     -+	GIT_TEST_DEFAULT_BRANCH_NAME= git init custom-config &&
     -+	git config --global --unset core.defaultbranchname &&
     -+	git -C custom-config symbolic-ref HEAD >actual &&
     -+	grep nmb actual
     -+'
     -+
     -+test_expect_success 'custom default branch name from env' '
     -+	GIT_TEST_DEFAULT_BRANCH_NAME=nmb git init custom-env &&
     -+	git -C custom-env symbolic-ref HEAD >actual &&
     -+	grep nmb actual
     -+'
     ++test_expect_success '--main-branch' '
     ++	git init --main-branch=hello main-branch-option &&
     ++	git -C main-branch-option symbolic-ref HEAD >actual &&
     ++	echo refs/heads/hello >expect &&
     ++	test_cmp expect actual &&
      +
     -+test_expect_success 'invalid custom default branch name' '
     -+	test_must_fail env GIT_TEST_DEFAULT_BRANCH_NAME="with space" \
     -+		git init custom-invalid 2>err &&
     -+	test_i18ngrep "invalid default branch name" err
     ++	: re-initializing should not change the main branch name &&
     ++	git init --main-branch=ignore main-branch-option 2>err &&
     ++	test_i18ngrep "ignoring --main-branch" err &&
     ++	git -C main-branch-option symbolic-ref HEAD >actual &&
     ++	grep hello actual &&
     ++	git -C main-branch-option config core.mainBranch >actual &&
     ++	grep hello actual
      +'
      +
       test_done
  -:  ----------- >  8:  c711eba7e76 init: allow overriding the default main branch name via the config
  6:  cce86c06bbf !  9:  0e59b618169 clone: learn about the possibly-configured default branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    clone: learn about the possibly-configured default branch name
     +    clone: handle overridden main branch names
      
          When cloning a repository without any branches, Git chooses a default
          branch name for the as-yet unborn branch.
      
     -    Now that we can configure what the default branch name should be, we
     -    will want `git clone` to respect that setting.
     +    As part of the implicit initialization of the local repository, Git
     +    just learned to respect `init.defaultBranch` to choose a different main
     +    branch name. We now really want that branch name to be used as a
     +    fall-back.
     +
     +    At the same time, we also want to make sure that `core.mainBranch` is
     +    set correctly, reflecting the name of the main branch. In case we detect
     +    a main branch, we do have to do that explicitly, otherwise `init_db()`
     +    will already have done that for us.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## Documentation/config/init.txt ##
     +@@ Documentation/config/init.txt: init.templateDir::
     + 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
     + 
     + init.defaultBranch::
     +-	Allows overriding the default branch name when initializing
     +-	a new repository.
     ++	Allows overriding the default branch name e.g. when initializing
     ++	a new repository or when cloning an empty repository.
     +
       ## builtin/clone.c ##
     +@@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref *remote,
     + 		/* Local default branch link */
     + 		if (create_symref("HEAD", our->name, NULL) < 0)
     + 			die(_("unable to update HEAD"));
     ++		git_config_set("core.mainbranch", head);
     + 		if (!option_bare) {
     + 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
     + 				   UPDATE_REFS_DIE_ON_ERR);
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		remote_head_points_at = NULL;
       		remote_head = NULL;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      -			install_branch_config(0, "master", option_origin,
      -					      "refs/heads/master");
      +		if (!option_bare) {
     -+			char *default_branch = git_default_branch_name(0);
     ++			char *main_branch =
     ++				git_main_branch_name(MAIN_BRANCH_FULL_NAME);
      +			const char *nick;
      +
     -+			if (!skip_prefix(default_branch, "refs/heads/", &nick))
     ++			if (!skip_prefix(main_branch, "refs/heads/", &nick))
      +				BUG("unexpected default branch '%s'",
     -+				    default_branch);
     ++				    main_branch);
      +			install_branch_config(0, nick, option_origin,
     -+					      default_branch);
     -+			free(default_branch);
     ++					      main_branch);
     ++			free(main_branch);
      +		}
       	}
       
       	write_refspec_config(src_ref_prefix, our_head_points_at,
      
     - ## t/t5609-clone-branch.sh ##
     -@@ t/t5609-clone-branch.sh: test_expect_success 'clone -b not allowed with empty repos' '
     - 	test_must_fail git clone -b branch empty clone-branch-empty
     + ## t/t5606-clone-options.sh ##
     +@@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show progress' '
     + 
       '
       
     -+test_expect_success 'chooses correct default branch name' '
     -+	GIT_TEST_DEFAULT_BRANCH_NAME= \
     -+		git -c core.defaultBranchName=up clone empty whats-up &&
     -+	test_write_lines refs/heads/up refs/heads/up >expect &&
     -+	git -C whats-up symbolic-ref HEAD >actual &&
     -+	git -C whats-up config branch.up.merge >>actual &&
     -+	test_cmp expect actual
     ++test_expect_success 'chooses correct default main branch name' '
     ++	git init --bare empty &&
     ++	git -c init.defaultBranch=up clone empty whats-up &&
     ++	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
     ++	test up = $(git -C whats-up config core.mainBranch) &&
     ++	test refs/heads/up = $(git -C whats-up config branch.up.merge)
     ++'
     ++
     ++test_expect_success 'guesses main branch name correctly' '
     ++	git init --main-branch=guess main-branch &&
     ++	test_commit -C main-branch no-spoilers &&
     ++	git -C main-branch branch abc guess &&
     ++	git clone main-branch is-it &&
     ++	test guess = $(git -C is-it config core.mainBranch) &&
     ++	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
      +'
      +
       test_done
  2:  06a2cea051c ! 10:  59b8f4cfbb2 remote: respect `core.defaultBranchName`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    remote: respect `core.defaultBranchName`
     +    remote: learn about the possibly-overridden default main branch name
      
          When guessing the default branch name of a remote, and there are no refs
          to guess from, we want to go with the preference specified by the user
     -    for the fall-back.
     +    for the fall-back, i.e. the default name to be used for the main branch
     +    of new repositories (because as far as the user is concerned, a remote
     +    that has no branches yet is a new repository).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ remote.c: static void read_remotes_file(struct remote *remote)
       static void read_branches_file(struct remote *remote)
       {
      -	char *frag;
     -+	char *frag, *default_branch_name = NULL;
     ++	char *frag, *main_branch = NULL;
       	struct strbuf buf = STRBUF_INIT;
       	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
       
     @@ remote.c: static void read_branches_file(struct remote *remote)
       	/*
       	 * The branches file would have URL and optionally
      -	 * #branch specified.  The "master" (or specified) branch is
     -+	 * #branch specified.  The default (or specified) branch is
     ++	 * #branch specified.  The main (or specified) branch is
       	 * fetched and stored in the local branch matching the
       	 * remote name.
       	 */
     @@ remote.c: static void read_branches_file(struct remote *remote)
       		*(frag++) = '\0';
       	else
      -		frag = "master";
     -+		frag = default_branch_name = git_default_branch_name(1);
     ++		frag = main_branch = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
       
       	add_url_alias(remote, strbuf_detach(&buf, NULL));
       	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
     @@ remote.c: static void read_branches_file(struct remote *remote)
       	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
       	refspec_append(&remote->push, buf.buf);
       	remote->fetch_tags = 1; /* always auto-follow */
     -+	free(default_branch_name);
     ++	free(main_branch);
       	strbuf_release(&buf);
       }
       
      @@ remote.c: struct ref *guess_remote_head(const struct ref *head,
     + 	if (head->symref)
     + 		return copy_ref(find_ref_by_name(refs, head->symref));
       
     - 	/* If refs/heads/master could be right, it is. */
     +-	/* If refs/heads/master could be right, it is. */
     ++	/* If a remote branch exists with the main branch name, let's use it. */
       	if (!all) {
      -		r = find_ref_by_name(refs, "refs/heads/master");
     -+		char *name = git_default_branch_name(0);
     ++		char *name = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
     ++						  MAIN_BRANCH_FOR_INIT);
      +
      +		r = find_ref_by_name(refs, name);
      +		free(name);
       		if (r && oideq(&r->old_oid, &head->old_oid))
       			return copy_ref(r);
       	}
     +
     + ## t/t5606-clone-options.sh ##
     +@@ t/t5606-clone-options.sh: test_expect_success 'guesses main branch name correctly' '
     + 	git -C main-branch branch abc guess &&
     + 	git clone main-branch is-it &&
     + 	test guess = $(git -C is-it config core.mainBranch) &&
     +-	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
     ++	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD) &&
     ++
     ++	git -c init.defaultBranch=none init --bare no-head &&
     ++	git -C main-branch push ../no-head guess abc &&
     ++	git clone no-head is-it2 &&
     ++	test_must_fail git -C is-it2 symbolic-ref refs/remotes/origin/HEAD &&
     ++	git -C no-head update-ref --no-deref HEAD refs/heads/guess &&
     ++	git -c init.defaultBranch=guess clone no-head is-it3 &&
     ++	test refs/remotes/origin/guess = \
     ++		$(git -C is-it3 symbolic-ref refs/remotes/origin/HEAD)
     + '
     + 
     + test_done
  5:  06ef42052d5 ! 11:  59d6267f099 submodule: use the (possibly overridden) default branch name
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    submodule: use the (possibly overridden) default branch name
     +    submodule: use the correct default for the main branch name
      
          To allow for overriding the default branch name, we have introduced a
          config setting. With this patch, the `git submodule` command learns
     @@ builtin/submodule--helper.c: static const char *remote_submodule_branch(const ch
      -	if (!branch)
      -		return "master";
      +	if (!branch) {
     -+		static char *default_branch;
     ++		static char *fall_back;
      +
     -+		if (!default_branch)
     -+			default_branch = git_default_branch_name(1);
     ++		if (!fall_back)
     ++			fall_back = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
      +
     -+		return default_branch;
     ++		return fall_back;
      +	}
       
       	if (!strcmp(branch, ".")) {
       		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
     +
     + ## t/t7406-submodule-update.sh ##
     +@@ t/t7406-submodule-update.sh: test_expect_success 'setup a submodule tree' '
     + 	)
     + '
     + 
     ++test_expect_success 'update --remote uses configured default main branch' '
     ++	git clone super main-branch &&
     ++	test_must_fail git -C main-branch -c init.defaultBranch=hello \
     ++		submodule update --init --remote submodule 2>err &&
     ++	test_i18ngrep origin/hello err
     ++'
     ++
     + test_expect_success 'submodule update detaching the HEAD ' '
     + 	(cd super/submodule &&
     + 	 git reset --hard HEAD~1
  4:  73cb567cd33 ! 12:  e09f857f068 testsvn: respect `core.defaultBranchName`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    testsvn: respect `core.defaultBranchName`
     +    testsvn: respect `init.defaultBranch`
      
     -    Since the default branch name can now be configured, the `testsvn`
     -    remote helper needs to be told about it.
     +    The default name of the main branch in new repositories can now be
     +    configured. The `testsvn` remote helper translates the remote Subversion
     +    repository's branch name `trunk` to the hard-coded name `master`.
     +    Clearly, the intention was to make the name align with Git's detaults.
     +
     +    So while we are not talking about a newly-created repository in the
     +    `testsvn` context, it _still_ makes sense to use the overridden default
     +    name for the main branch whenever users configured it.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ remote-testsvn.c: int cmd_main(int argc, const char **argv)
       			notes_ref_sb = STRBUF_INIT;
       	static struct remote *remote;
      -	const char *url_in;
     -+	const char *url_in, *default_branch;
     ++	const char *url_in, *remote_ref_short;
       
       	setup_git_directory();
       	if (argc < 2 || argc > 3) {
     @@ remote-testsvn.c: int cmd_main(int argc, const char **argv)
       		return 1;
       	}
       
     -+	remote_ref = git_default_branch_name(0);
     -+	if (!skip_prefix(remote_ref, "refs/heads/", &default_branch))
     ++	remote_ref = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
     ++					  MAIN_BRANCH_FOR_INIT);
     ++	if (!skip_prefix(remote_ref, "refs/heads/", &remote_ref_short))
      +		BUG("unexpected remote_ref '%s'", remote_ref);
      +
       	remote = remote_get(argv[1]);
     @@ remote-testsvn.c: int cmd_main(int argc, const char **argv)
       
      -	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
      +	strbuf_addf(&private_ref_sb, "refs/svn/%s/%s",
     -+		    remote->name, default_branch);
     ++		    remote->name, remote_ref_short);
       	private_ref = private_ref_sb.buf;
       
       	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
     +
     + ## t/t9020-remote-svn.sh ##
     +@@ t/t9020-remote-svn.sh: test_expect_success REMOTE_SVN 'incremental imports must lead to the same head'
     + 	test_cmp master.good .git/refs/remotes/svnsim/master
     + '
     + 
     ++test_expect_success REMOTE_SVN 'respects configured default main branch' '
     ++	git -c init.defaultBranch=trunk remote add -f trunk \
     ++		"testsvn::file://$TEST_DIRECTORY/t9154/svn.dump" &&
     ++	git rev-parse --verify refs/remotes/trunk/trunk
     ++'
     ++
     + test_debug 'git branch -a'
     + 
     + test_done
  9:  f680e66dd6d <  -:  ----------- Document how the default branch name can be overridden

-- 
gitgitgadget
