Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE18FC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiL3CSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0952A1704D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so28867696edc.12
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbSaKIVZgb0vEpLM+EIequ/D6XUiKGLGk5QDdNeYJso=;
        b=jf0tl9QmahKwFXHTxxDJQ/STxUrgE+pKgY70wh/wr4+E739yP5g75VSQWrV+N8halt
         uCtmEN1cdnvztYe3f0jP+JLAbuOgYcRbWAB4sdgVf7xobgjjZwlOup5/yrTmgSbnh5IQ
         7kPqXmnu2SeShNRB9VwG2B6BTS4BjEABC6+f09kjB4qyRFWx7fyRGhN/mtAZp7c4aryH
         d5czp4wC9Mb7av+wF6YaiSbwvTYgQEbuu3N2jhwaSk13XrTGDDH/1vfvlpA2481OECKO
         eHFAF/Wi3dU848ZJnYFZQ3rG84FEg4lvnbaISV+4zsPaYq0sgBFAx1aZlkQoSbQrgZHG
         Pf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbSaKIVZgb0vEpLM+EIequ/D6XUiKGLGk5QDdNeYJso=;
        b=j+SrJf0kpFXqrbElu50LcGKN/4S4SlgIbzkLF3EtsyBbwluof8+tXprV5T7iAQVhf3
         CVHgjyC2DW4TP9dLwAoz3pHtrXE/h1i9Ne5OD8RGKhUf4bsIGXrMVitZ5z/gI+qgeVgu
         X47L29sCXreWNO5FmvLx6+sHNwhE0eW0f4ASCciHOTMLv2qcMHTFwciBAkwJNKOS/tmt
         v/AFEEdaDsuAmnoP+cPNH4JW8s1Dx7WRlUbMeLOwJagPuxLcdUU1ltCkxViCVSvlqRuv
         pljLdJPyf4fB3Y1GFruqIq8L6nc5U+OaKQ1aSkNYMDjv+7Lx5FTDHOkfaAcGtJcVrjPO
         w62A==
X-Gm-Message-State: AFqh2kpFiWgf28bt7d+PKhKDFUJZ3DaP51U+NTwSi2IsdSw7N9iMfI3Q
        aLYTO3cR5kpabhpMG8OqSEmCI45UZq6p0A==
X-Google-Smtp-Source: AMrXdXtE+QD2XJn7GgyIRvdBLsrnsVaWhKro9TZfQ93IOJOvDaiV2hndZc1z2SLtS6WaZOV5henqDw==
X-Received: by 2002:a05:6402:88d:b0:46c:b385:83d2 with SMTP id e13-20020a056402088d00b0046cb38583d2mr34632867edy.0.1672366719788;
        Thu, 29 Dec 2022 18:18:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/20] leak fixes: various simple leak fixes
Date:   Fri, 30 Dec 2022 03:18:15 +0100
Message-Id: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the ab/various-leak-fixes topic merged in
9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14). Like
that topic this is mixed collection of various leak fixes, all of
which should be simple to review & reason about.

Changes since v1:

 * v1 added 32 more tests to the linux-leaks job, this adds 51. In the
   v1 11 test files were made to pass by this series itself (the 1/20
   adds already existing tests with TEST_PASSES_SANITIZE_LEAK=true),
   we now have 30 newly passing tests.

   This is because I added a couple of more leak fixes to this v2, see below.

* Squash the previous [1-2]/20 into one.
* Squash all of the "pathspec" leak fixes into one patch
* Add a "name-rev" leak fix. Instad of UNLEAK() we can (mostly) skip
  allocation altogether (just need a string_list container)
* Fix the "dir" leak in http-backend.c as suggested, and also a
  "cmd_arg" leak in the same function.
* Rewrote the "builtin/merge.c" fix for "msg" as René suggested
* Use release_tag_memory() in the check_tag() fix. I also missed that
  I'd submitted that leak fix in another series. I re-rolled it
  (https://lore.kernel.org/git/cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com/)
  to avoid fixing the leak, and went for René's suggestion of using
  release_tag_memory() in this v2.
* Squashed/rewrote the grep.c refactoring & leak fix, hopfully this
  state is easier to grok/follow.
* Add two new leak fixes to the end of this series, each one is
  trivial, but they make 6 and 12 new tests pass in their entirety.
* Hopefully addressed all other comments, e.g. a typo fix, commit
  message clarifications etc.

Branch & CI for this at
https://github.com/avar/git/tree/avar/leak-fixes-more-misc-trivial-2
(the "win build" failure is unrelated, some generic CI issue that also
happens if I re-push Junio's "master").

Ævar Arnfjörð Bjarmason (20):
  tests: mark tests as passing with SANITIZE=leak
  bundle.c: don't leak the "args" in the "struct child_process"
  commit-graph: use free() instead of UNLEAK()
  clone: use free() instead of UNLEAK()
  various: add missing clear_pathspec(), fix leaks
  name-rev: don't xstrdup() an already dup'd string
  repack: fix leaks on error with "goto cleanup"
  worktree: fix a trivial leak in prune_worktrees()
  http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
  http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
  commit-graph: fix a parse_options_concat() leak
  show-branch: free() allocated "head" before return
  builtin/merge.c: always free "struct strbuf msg"
  builtin/merge.c: free "&buf" on "Your local changes..." error
  connected.c: free(new_pack) in check_connected()
  object-file.c: release the "tag" in check_tag()
  grep.c: refactor free_grep_patterns()
  grep API: plug memory leaks by freeing "header_list"
  receive-pack: free() the "ref_name" in "struct command"
  push: free_refs() the "local_refs" in set_refspecs()

 archive.c                                  |  1 +
 builtin/clean.c                            |  1 +
 builtin/clone.c                            |  5 +++--
 builtin/commit-graph.c                     | 10 ++++++----
 builtin/merge.c                            | 14 ++++++-------
 builtin/name-rev.c                         | 23 ++++++++++------------
 builtin/push.c                             |  1 +
 builtin/receive-pack.c                     | 10 ++++++++++
 builtin/repack.c                           | 13 ++++++------
 builtin/reset.c                            | 11 ++++++++---
 builtin/show-branch.c                      |  1 +
 builtin/stash.c                            |  7 +++++--
 builtin/worktree.c                         |  6 +++---
 bundle.c                                   |  6 ++++--
 connected.c                                | 13 ++++++------
 grep.c                                     | 15 +++++++++-----
 http-backend.c                             |  9 +++++++--
 object-file.c                              |  1 +
 t/t0023-crlf-am.sh                         |  1 +
 t/t1301-shared-repo.sh                     |  1 +
 t/t1302-repo-version.sh                    |  1 +
 t/t1304-default-acl.sh                     |  1 +
 t/t1408-packed-refs.sh                     |  1 +
 t/t1410-reflog.sh                          |  1 +
 t/t1416-ref-transaction-hooks.sh           |  1 +
 t/t2401-worktree-prune.sh                  |  1 +
 t/t2406-worktree-repair.sh                 |  1 +
 t/t3210-pack-refs.sh                       |  1 +
 t/t3800-mktag.sh                           |  1 +
 t/t4152-am-subjects.sh                     |  2 ++
 t/t4254-am-corrupt.sh                      |  2 ++
 t/t4256-am-format-flowed.sh                |  1 +
 t/t4257-am-interactive.sh                  |  2 ++
 t/t5001-archive-attr.sh                    |  1 +
 t/t5004-archive-corner-cases.sh            |  2 ++
 t/t5302-pack-index.sh                      |  2 ++
 t/t5317-pack-objects-filter-objects.sh     |  1 +
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  1 +
 t/t5403-post-checkout-hook.sh              |  1 +
 t/t5405-send-pack-rewind.sh                |  1 +
 t/t5406-remote-rejects.sh                  |  1 +
 t/t5502-quickfetch.sh                      |  1 +
 t/t5504-fetch-receive-strict.sh            |  1 +
 t/t5507-remote-environment.sh              |  2 ++
 t/t5522-pull-symlink.sh                    |  1 +
 t/t5523-push-upstream.sh                   |  1 +
 t/t5527-fetch-odd-refs.sh                  |  1 +
 t/t5529-push-errors.sh                     |  2 ++
 t/t5546-receive-limits.sh                  |  2 ++
 t/t5547-push-quarantine.sh                 |  2 ++
 t/t5604-clone-reference.sh                 |  1 +
 t/t5606-clone-options.sh                   |  1 +
 t/t5613-info-alternate.sh                  |  2 ++
 t/t5705-session-id-in-capabilities.sh      |  1 +
 t/t5810-proto-disable-local.sh             |  2 ++
 t/t5813-proto-disable-ssh.sh               |  2 ++
 t/t6011-rev-list-with-bad-commit.sh        |  1 +
 t/t6014-rev-list-all.sh                    |  1 +
 t/t6021-rev-list-exclude-hidden.sh         |  1 +
 t/t6439-merge-co-error-msgs.sh             |  1 +
 t/t7105-reset-patch.sh                     |  2 ++
 t/t7106-reset-unborn-branch.sh             |  2 ++
 t/t7107-reset-pathspec-file.sh             |  1 +
 t/t7301-clean-interactive.sh               |  1 +
 t/t7403-submodule-sync.sh                  |  1 +
 t/t7409-submodule-detached-work-tree.sh    |  1 +
 t/t7416-submodule-dash-url.sh              |  2 ++
 t/t7450-bad-git-dotfiles.sh                |  2 ++
 t/t7701-repack-unpack-unreachable.sh       |  1 +
 69 files changed, 158 insertions(+), 56 deletions(-)

Range-diff against v1:
 1:  84393ca3139 <  -:  ----------- t6021: mark as passing with SANITIZE=leak
 2:  2ad81be0d7a !  1:  3de29c6d75f tests: mark tests as passing with SANITIZE=leak
    @@ Metadata
      ## Commit message ##
         tests: mark tests as passing with SANITIZE=leak
     
    -    When the "ab/various-leak-fixes" topic was merged in [1] only
    -    t6021 (which was fixed in the preceding commit) would fail if the
    -    tests were run in the "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode,
    -    i.e. to check whether we marked all leak-free tests with
    -    "TEST_PASSES_SANITIZE_LEAK=true".
    +    When the "ab/various-leak-fixes" topic was merged in [1] only t6021
    +    would fail if the tests were run in the
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode, i.e. to check whether we
    +    marked all leak-free tests with "TEST_PASSES_SANITIZE_LEAK=true".
     
         Since then we've had various tests starting to pass under
         SANITIZE=leak. Let's mark those as passing, this is when they started
    @@ t/t6014-rev-list-all.sh
      
      
     
    + ## t/t6021-rev-list-exclude-hidden.sh ##
    +@@
    + 
    + test_description='git rev-list --exclude-hidden test'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t7403-submodule-sync.sh ##
     @@ t/t7403-submodule-sync.sh: These tests exercise the "git submodule sync" subcommand.
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 3:  a8b373ddef9 =  2:  5036712391d bundle.c: don't leak the "args" in the "struct child_process"
 4:  5be87f9720c !  3:  a840a1cb330 commit-graph: use free() instead of UNLEAK()
    @@ Commit message
         commit-graph: use free() instead of UNLEAK()
     
         In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
    -    this was made to UNLEAK(), but we can just as easily free() the memory
    -    instead.
    +    this was made to UNLEAK(), but we can just as easily invoke the
    +    free_commit_graph() function added in c3756d5b7fc (commit-graph: add
    +    free_commit_graph, 2018-07-11) instead.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, con
     -	UNLEAK(graph);
     -	return verify_commit_graph(the_repository, graph, flags);
     +	ret = verify_commit_graph(the_repository, graph, flags);
    -+	free(graph);
    ++	free_commit_graph(graph);
     +	return ret;
      }
      
 5:  49e6714939d =  4:  c05620cef49 clone: use free() instead of UNLEAK()
 8:  21670099c84 !  5:  62af6557760 reset: fix cmd_reset() leaks with a clear_pathspec() call
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    reset: fix cmd_reset() leaks with a clear_pathspec() call
    +    various: add missing clear_pathspec(), fix leaks
     
    -    Add clear_pathspec() calls to cmd_reset(), including to the codepaths
    -    where we'd return early.
    +    Fix memory leaks resulting from a missing clear_pathspec().
    +
    +    - archive.c: Plug a leak in the "struct archiver_args", and
    +      clear_pathspec() the "pathspec" member that the "parse_pathspec_arg()"
    +      call in this function populates.
    +
    +    - builtin/clean.c: Fix a memory leak that's been with us since
    +      893d839970c (clean: convert to use parse_pathspec, 2013-07-14).
    +
    +    - builtin/reset.c: Add clear_pathspec() calls to cmd_reset(),
    +      including to the codepaths where we'd return early.
    +
    +    - builtin/stash.c: Call clear_pathspec() on the pathspec initialized
    +      in push_stash().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## archive.c ##
    +@@ archive.c: int write_archive(int argc, const char **argv, const char *prefix,
    + 
    + 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
    + 	free(args.refname);
    ++	clear_pathspec(&args.pathspec);
    + 
    + 	return rc;
    + }
    +
    + ## builtin/clean.c ##
    +@@ builtin/clean.c: int cmd_clean(int argc, const char **argv, const char *prefix)
    + 	strbuf_release(&buf);
    + 	string_list_clear(&del_list, 0);
    + 	string_list_clear(&exclude_list, 0);
    ++	clear_pathspec(&pathspec);
    + 	return (errors != 0);
    + }
    +
      ## builtin/reset.c ##
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      		if (reset_type != NONE)
    @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      	return update_ref_status;
      }
     
    + ## builtin/stash.c ##
    +@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
    + 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
    + 		OPT_END()
    + 	};
    ++	int ret;
    + 
    + 	if (argc) {
    + 		force_assume = !strcmp(argv[0], "-p");
    +@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
    + 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
    + 	}
    + 
    +-	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
    +-			     include_untracked, only_staged);
    ++	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
    ++			    include_untracked, only_staged);
    ++	clear_pathspec(&ps);
    ++	return ret;
    + }
    + 
    + static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
    +
    + ## t/t5001-archive-attr.sh ##
    +@@
    + test_description='git archive attribute tests'
    + 
    + TEST_CREATE_REPO_NO_TEMPLATE=1
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + SUBSTFORMAT='%H (%h)%n'
    +
    + ## t/t5004-archive-corner-cases.sh ##
    +@@
    + #!/bin/sh
    + 
    + test_description='test corner cases of git-archive'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # the 10knuls.tar file is used to test for an empty git generated tar
    +
      ## t/t7105-reset-patch.sh ##
     @@
      #!/bin/sh
    @@ t/t7107-reset-pathspec-file.sh
      . ./test-lib.sh
      
      test_tick
    +
    + ## t/t7301-clean-interactive.sh ##
    +@@
    + 
    + test_description='git clean -i basic tests'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-terminal.sh
    + 
 9:  77fcdeb9284 !  6:  7cea3da9fae name-rev: don't xstrdup() an already dup'd string
    @@ Commit message
         we'd then xstrdup() again, leaking memory. See [1] and [2] for how
         this leak came about.
     
    +    We could xstrdup() only if "shorten_unambiguous" wasn't true, but
    +    let's instead inline this code, so that information on whether we need
    +    to xstrdup() is contained within add_to_tip_table().
    +
         1. 98c5c4ad015 (name-rev: allow to specify a subpath for --refs
            option, 2013-06-18)
         2. b23e0b9353e (name-rev: allow converting the exact object name at
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/name-rev.c ##
    +@@ builtin/name-rev.c: static int subpath_matches(const char *path, const char *filter)
    + 	return -1;
    + }
    + 
    +-static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
    +-{
    +-	if (shorten_unambiguous)
    +-		refname = shorten_unambiguous_ref(refname, 0);
    +-	else if (skip_prefix(refname, "refs/heads/", &refname))
    +-		; /* refname already advanced */
    +-	else
    +-		skip_prefix(refname, "refs/", &refname);
    +-	return refname;
    +-}
    +-
    + struct name_ref_data {
    + 	int tags_only;
    + 	int name_only;
     @@ builtin/name-rev.c: static void add_to_tip_table(const struct object_id *oid, const char *refname,
    + 			     int shorten_unambiguous, struct commit *commit,
    + 			     timestamp_t taggerdate, int from_tag, int deref)
    + {
    +-	refname = name_ref_abbrev(refname, shorten_unambiguous);
    ++	char *short_refname = NULL;
    ++
    ++	if (shorten_unambiguous)
    ++		short_refname = shorten_unambiguous_ref(refname, 0);
    ++	else if (skip_prefix(refname, "refs/heads/", &refname))
    ++		; /* refname already advanced */
    ++	else
    ++		skip_prefix(refname, "refs/", &refname);
      
      	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
      	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
     -	tip_table.table[tip_table.nr].refname = xstrdup(refname);
    -+	tip_table.table[tip_table.nr].refname = shorten_unambiguous ? refname :
    -+		xstrdup(refname);
    ++	tip_table.table[tip_table.nr].refname = short_refname ?
    ++		short_refname : xstrdup(refname);
      	tip_table.table[tip_table.nr].commit = commit;
      	tip_table.table[tip_table.nr].taggerdate = taggerdate;
      	tip_table.table[tip_table.nr].from_tag = from_tag;
10:  81555cce790 =  7:  b5978d75c6a repack: fix leaks on error with "goto cleanup"
11:  ee05254eb6a =  8:  468615570f4 worktree: fix a trivial leak in prune_worktrees()
 7:  e5a0134d1bb !  9:  8c5c964d872 stash: fix a "struct pathspec" leak
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    stash: fix a "struct pathspec" leak
    +    http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
     
    -    Call clear_pathspec() on the pathspec initialized in
    -    push_stash(). Initializing that structure in this way is already done
    -    by a few other callers, and now we have:
    +    Free the "dir" variable after we're done with it. Before
    +    917adc03608 (http-backend: add GIT_PROJECT_ROOT environment var,
    +    2009-10-30) there was no leak here, as we'd get it via getenv(), but
    +    since 917adc03608 we've xstrdup()'d it (or the equivalent), so we need
    +    to free() it.
     
    -            $ git grep -e 'struct pathspec.* = { 0 }' -e memset.pathspec
    -            add-interactive.c:              struct pathspec ps_selected = { 0 };
    -            builtin/sparse-checkout.c:              struct pathspec p = { 0 };
    -            builtin/stash.c:        struct pathspec ps = { 0 };
    -            pathspec.c:     memset(pathspec, 0, sizeof(*pathspec));
    -            wt-status.c:                    struct pathspec ps = { 0 };
    +    We also need to free the "cmd_arg" variable, which has been leaked
    +    ever since it was added in 2f4038ab337 (Git-aware CGI to provide dumb
    +    HTTP transport, 2009-10-30).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/stash.c ##
    -@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
    - 	int pathspec_file_nul = 0;
    - 	const char *stash_msg = NULL;
    - 	const char *pathspec_from_file = NULL;
    --	struct pathspec ps;
    -+	struct pathspec ps = { 0 };
    - 	struct option options[] = {
    - 		OPT_BOOL('k', "keep-index", &keep_index,
    - 			 N_("keep index")),
    -@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
    - 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
    - 		OPT_END()
    - 	};
    -+	int ret;
    + ## http-backend.c ##
    +@@ http-backend.c: int cmd_main(int argc, const char **argv)
    + 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
    + 	    access("git-daemon-export-ok", F_OK) )
    + 		not_found(&hdr, "Repository not exported: '%s'", dir);
    ++	free(dir);
      
    - 	if (argc) {
    - 		force_assume = !strcmp(argv[0], "-p");
    -@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
    - 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
    - 	}
    + 	http_config();
    + 	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
    +@@ http-backend.c: int cmd_main(int argc, const char **argv)
    + 		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 0);
      
    --	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
    --			     include_untracked, only_staged);
    -+	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
    -+			    include_untracked, only_staged);
    -+	clear_pathspec(&ps);
    -+	return ret;
    + 	cmd->imp(&hdr, cmd_arg);
    ++	free(cmd_arg);
    + 	return 0;
      }
    - 
    - static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
12:  9be5b0c7836 = 10:  fd34c4817f4 http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
13:  78f12259ac5 = 11:  f7005f32cc0 commit-graph: fix a parse_options_concat() leak
14:  9df41b090b4 = 12:  bf0e9bc5fa6 show-branch: free() allocated "head" before return
15:  8deeee4278d ! 13:  b157092e8d0 builtin/merge.c: always free "struct strbuf msg"
    @@ Commit message
         builtin/merge.c: always free "struct strbuf msg"
     
         Follow-up 465028e0e25 (merge: add missing strbuf_release(),
    -    2021-10-07) and free "&msg" also when we'd "goto done" from the scope
    -    it's allocated in.
    +    2021-10-07) and address the "msg" memory leak in this block. We could
    +    free "&msg" before the "goto done" here, but even better is to avoid
    +    allocating it in the first place.
     
    +    By repeating the "Fast-forward" string here we can avoid using a
    +    "struct strbuf" altogether.
    +
    +    Suggested-by: René Scharfe <l.s.r@web.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    + 			!common->next &&
    + 			oideq(&common->item->object.oid, &head_commit->object.oid)) {
    + 		/* Again the most common case of merging one remote. */
    +-		struct strbuf msg = STRBUF_INIT;
    ++		const char *msg = have_message ?
    ++			"Fast-forward (no commit created; -m option ignored)" :
    ++			"Fast-forward";
    + 		struct commit *commit;
    + 
    + 		if (verbosity >= 0) {
    +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    + 			       find_unique_abbrev(&remoteheads->item->object.oid,
    + 						  DEFAULT_ABBREV));
    + 		}
    +-		strbuf_addstr(&msg, "Fast-forward");
    +-		if (have_message)
    +-			strbuf_addstr(&msg,
    +-				" (no commit created; -m option ignored)");
      		commit = remoteheads->item;
      		if (!commit) {
      			ret = 1;
    -+			strbuf_release(&msg);
    - 			goto done;
    - 		}
    - 
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    - 					  overwrite_ignore)) {
    - 			apply_autostash(git_path_merge_autostash(the_repository));
    - 			ret = 1;
    -+			strbuf_release(&msg);
      			goto done;
      		}
      
    +-		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
    ++		finish(head_commit, remoteheads, &commit->object.oid, msg);
    + 		remove_merge_branch_state(the_repository);
    +-		strbuf_release(&msg);
    + 		goto done;
    + 	} else if (!remoteheads->next && common->next)
    + 		;
    +
    + ## t/t6439-merge-co-error-msgs.sh ##
    +@@ t/t6439-merge-co-error-msgs.sh: test_description='unpack-trees error messages'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + 
16:  95d59b914d0 ! 14:  bdd2bc9a956 builtin/merge.c: free "&buf" on "Your local changes..." error
    @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      			}
      
      			/* See if it is really trivial. */
    -
    - ## t/t6439-merge-co-error-msgs.sh ##
    -@@ t/t6439-merge-co-error-msgs.sh: test_description='unpack-trees error messages'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - 
17:  ae2f4931315 = 15:  d5210017cab connected.c: free(new_pack) in check_connected()
18:  aa4df0e1b5c ! 16:  2016b4ddd0b object-file.c: free the "t.tag" in check_tag()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file.c: free the "t.tag" in check_tag()
    +    object-file.c: release the "tag" in check_tag()
     
         Fix a memory leak that's been with us ever since c879daa2372 (Make
         hash-object more robust against malformed objects, 2011-02-05). With
    @@ Commit message
         tags into a throwaway variable on the stack, but weren't freeing the
         "item->tag" we might malloc() when doing so.
     
    +    The clearing that release_tag_memory() does for us is redundant here,
    +    but let's use it as-is anyway. It only has one other existing caller,
    +    which does need the tag to be cleared.
    +
         Mark the tests that now pass in their entirety as passing under
         "SANITIZE=leak", which means we'll test them as part of the
         "linux-leaks" CI job.
    @@ object-file.c: static void check_tag(const void *buf, size_t size)
      	memset(&t, 0, sizeof(t));
      	if (parse_tag_buffer(the_repository, &t, buf, size))
      		die(_("corrupt tag"));
    -+	free(t.tag);
    ++	release_tag_memory(&t);
      }
      
      static int index_mem(struct index_state *istate,
20:  8ecc68c3e93 ! 17:  fa2e8a7d297 grep API: plug memory leaks by freeing "header_list"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep API: plug memory leaks by freeing "header_list"
    +    grep.c: refactor free_grep_patterns()
     
    -    When the "header_list" struct member was added in [1] it wasn't made
    -    to free the list using loop added for the adjacent "pattern_list"
    -    member, see [2] for when we started freeing it.
    +    Refactor the free_grep_patterns() function to split out the freeing of
    +    the "struct grep_pat" it contains, right now we're only freeing the
    +    "pattern_list", but we should be freeing another member of the same
    +    type, which we'll do in the subsequent commit.
     
    -    Let's start doing o by splitting up the loop in free_grep_patterns()
    -    into a utility function. This makes e.g. this command leak-free when
    -    run on git.git:
    +    Let's also replace the "return" if we don't have an
    +    "opt->pattern_expression" with a conditional call of
    +    free_pattern_expr().
     
    -            ./git -P log -1 --color=always --author=A origin/master
    +    Before db84376f981 (grep.c: remove "extended" in favor of
    +    "pattern_expression", fix segfault, 2022-10-11) the pattern here was:
     
    -    1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
    -       not union, 2010-01-17)
    -    2. b48fb5b6a95 (grep: free expressions and patterns when done.,
    -       2006-09-27)
    +            if (!x)
    +                    return;
    +            free(y);
    +
    +    But after the cleanup in db84376f981 (which was a narrow segfault fix,
    +    and thus avoided refactoring this) we ended up with:
    +
    +            if (!x)
    +                    return;
    +            free(x);
    +
    +    Let's instead do:
    +
    +            if (x)
    +                    free(x);
    +
    +    This doesn't matter for the subsequent change, but as we're
    +    refactoring this function let's make it easier to reason about, and to
    +    extend in the future, i.e. if we start to free free() members that
    +    come after "pattern_expression" in the "struct grep_opt".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ grep.c: void free_grep_patterns(struct grep_opt *opt)
      		free(p);
      	}
     +}
    -+
    + 
    +-	if (!opt->pattern_expression)
    +-		return;
    +-	free_pattern_expr(opt->pattern_expression);
     +void free_grep_patterns(struct grep_opt *opt)
     +{
     +	free_grep_pat(opt->pattern_list);
    -+	free_grep_pat(opt->header_list);
    ++
    ++	if (opt->pattern_expression)
    ++		free_pattern_expr(opt->pattern_expression);
    + }
      
    - 	if (opt->pattern_expression)
    - 		free_pattern_expr(opt->pattern_expression);
    + static const char *end_of_line(const char *cp, unsigned long *left)
19:  7928470addb ! 18:  3fcf7054708 grep.c: make it easier to extend free_grep_patterns()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep.c: make it easier to extend free_grep_patterns()
    +    grep API: plug memory leaks by freeing "header_list"
     
    -    Before db84376f981 (grep.c: remove "extended" in favor of
    -    "pattern_expression", fix segfault, 2022-10-11) the pattern here was:
    +    When the "header_list" struct member was added in [1] it wasn't made
    +    to free the list using loop added for the adjacent "pattern_list"
    +    member, see [2] for when we started freeing it.
     
    -            if (!x)
    -                    return;
    -            free(y);
    +    This makes e.g. this command leak-free when run on git.git:
     
    -    But after the cleanup in db84376f981 (which was a narrow segfault fix,
    -    and thus avoided refactoring this) we ended up with:
    +            ./git -P log -1 --color=always --author=A origin/master
     
    -            if (!x)
    -                    return;
    -            free(x);
    -
    -    Let's instead do:
    -
    -            if (x)
    -                    free(x);
    -
    -    This doesn't matter for now, but makes the free_grep_patterns() easier
    -    to reason about, as we don't have to wonder why we're doing an early
    -    "return" if and when we add free()-ing of any members that come after
    -    "pattern_expression" in the "struct grep_opt".
    +    1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
    +       not union, 2010-01-17)
    +    2. b48fb5b6a95 (grep: free expressions and patterns when done.,
    +       2006-09-27)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## grep.c ##
    -@@ grep.c: void free_grep_patterns(struct grep_opt *opt)
    - 		free(p);
    - 	}
    - 
    --	if (!opt->pattern_expression)
    --		return;
    --	free_pattern_expr(opt->pattern_expression);
    -+	if (opt->pattern_expression)
    -+		free_pattern_expr(opt->pattern_expression);
    - }
    +@@ grep.c: static void free_grep_pat(struct grep_pat *pattern)
    + void free_grep_patterns(struct grep_opt *opt)
    + {
    + 	free_grep_pat(opt->pattern_list);
    ++	free_grep_pat(opt->header_list);
      
    - static const char *end_of_line(const char *cp, unsigned long *left)
    + 	if (opt->pattern_expression)
    + 		free_pattern_expr(opt->pattern_expression);
 6:  bc45aee530c ! 19:  fa5d657312f archive.c: call clear_pathspec() in write_archive()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    archive.c: call clear_pathspec() in write_archive()
    +    receive-pack: free() the "ref_name" in "struct command"
     
    -    Plug a leak in the "struct archiver_args", and clear_pathspec() the
    -    "pathspec" member that the "parse_pathspec_arg()" call in this
    -    function populates.
    +    Fix a memory leak that's been with us since this code was introduced
    +    in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29), see
    +    eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
    +    2005-06-29) for the later change that refactored the code to add the
    +    "ref_name" member.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## archive.c ##
    -@@ archive.c: int write_archive(int argc, const char **argv, const char *prefix,
    + ## builtin/receive-pack.c ##
    +@@ builtin/receive-pack.c: static struct command **queue_command(struct command **tail,
    + 	return &cmd->next;
    + }
      
    - 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
    - 	free(args.refname);
    -+	clear_pathspec(&args.pathspec);
    ++static void free_commands(struct command *commands)
    ++{
    ++	while (commands) {
    ++		struct command *next = commands->next;
    ++		free(commands);
    ++		commands = next;
    ++	}
    ++}
    ++
    + static void queue_commands_from_cert(struct command **tail,
    + 				     struct strbuf *push_cert)
    + {
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
    + 		run_receive_hook(commands, "post-receive", 1,
    + 				 &push_options);
    + 		run_update_post_hook(commands);
    ++		free_commands(commands);
    + 		string_list_clear(&push_options, 0);
    + 		if (auto_gc) {
    + 			struct child_process proc = CHILD_PROCESS_INIT;
    +
    + ## t/t5405-send-pack-rewind.sh ##
    +@@ t/t5405-send-pack-rewind.sh: test_description='forced push to replace commit we do not have'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    - 	return rc;
    - }
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success setup '
     
    - ## t/t5001-archive-attr.sh ##
    + ## t/t5406-remote-rejects.sh ##
     @@
    - test_description='git archive attribute tests'
      
    - TEST_CREATE_REPO_NO_TEMPLATE=1
    + test_description='remote push rejects are reported by client'
    + 
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - SUBSTFORMAT='%H (%h)%n'
    + test_expect_success 'setup' '
     
    - ## t/t5004-archive-corner-cases.sh ##
    + ## t/t5507-remote-environment.sh ##
     @@
      #!/bin/sh
      
    - test_description='test corner cases of git-archive'
    + test_description='check environment showed to remote side of transports'
     +
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - # the 10knuls.tar file is used to test for an empty git generated tar
    + test_expect_success 'set up "remote" push situation' '
    +
    + ## t/t5522-pull-symlink.sh ##
    +@@
    + 
    + test_description='pulling from symlinked subdir'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # The scenario we are building:
    +
    + ## t/t5527-fetch-odd-refs.sh ##
    +@@ t/t5527-fetch-odd-refs.sh: test_description='test fetching of oddly-named refs'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # afterwards we will have:
    +
    + ## t/t5705-session-id-in-capabilities.sh ##
    +@@
    + 
    + test_description='session ID in capabilities'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + REPO="$(pwd)/repo"
 -:  ----------- > 20:  e5af27134df push: free_refs() the "local_refs" in set_refspecs()
-- 
2.39.0.1153.g589e4efe9dc

