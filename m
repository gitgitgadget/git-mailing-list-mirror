Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB19C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLOJdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLOJdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1950D5A
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:32:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so50800878ejb.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ/j47ZrBp6/FLFI3gcSPQ/jJwbMgMVBvodeynwPqQ8=;
        b=o944lgDPL+dPrCH0zKfiL92DJu/fTyBwzA7V6fW0EUhhDeqc0pQ0h0TEQcDEUFNENx
         eEw4iBPFnShJrVzcrZ6W1qfRuXICYdOJI2VhaxPJudZjVecCHKzjip5Mv2vznamuH0QF
         qeQCIwp/0CeGl8zUjZJnfOMCWBrS9pZLBwvvR3+JfkDil2sDSB2rRD8BvChKomIl4zV3
         pysoJJUeNaJVInSw+Dj5pFhb8/1ldaRomMoJGJGf/EHvqfr2DMGuUG+sOotvJGaw8ZVg
         jyNndsYUauOR1H9GVjDopHkjAHNQJ1EnqbeQ/PNW45UF5yxygBjTFoOWfOszHQcws5pp
         mtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ/j47ZrBp6/FLFI3gcSPQ/jJwbMgMVBvodeynwPqQ8=;
        b=vRorxmKC/DjdDSj4tbG+wdKfXpO6pGUg/9E4j4jVf3eMmPp06w1UaICsL3nLRuwqUe
         byqWwkgsEiqYiitsmwr40zU3RFrPzI00rcagfdxjSOuxO3yqeqxWwypBJ9VRqv928eN/
         8BEbWg5cM/1OAdyY+FGyZIPjVyw3QLhzdqJJKaB887XLPlVBGF/JE6zhari96v7Uvsf+
         18flEMIqkWTL7MHnIcUDA6vLKxuleQO0n5KIlvJnDQnraDLdkkhYB6ZUhseek+7sBpsI
         vONavgr2GCqDFEWPv+4eGUvioJP2aHHYnBaWfB+VElufu4ObBHVTm8N9exHfOKxIj9se
         9K8w==
X-Gm-Message-State: ANoB5pkRzxkwdvbsbBf8YprE8JCTMHgzg9aRxbotpicMgeWx7PM6LpeI
        F9f1ZblKZN5zmz+LLmSn7iOzDJWfI1RSqA==
X-Google-Smtp-Source: AA0mqf68vjJbrmWd16IkgD+c6FAOV+TRa6KGiHve0vu0Ewhm/Szi2jtyyrIjwHnrYte9/5KQi2nRZA==
X-Received: by 2002:a17:906:7ad8:b0:7c0:89ac:83f9 with SMTP id k24-20020a1709067ad800b007c089ac83f9mr23563173ejo.11.1671096776067;
        Thu, 15 Dec 2022 01:32:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:32:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] Get rid of "git --super-prefix"
Date:   Thu, 15 Dec 2022 10:32:41 +0100
Message-Id: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a general summary see the v3's CL at
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com/

Changes since v4:

* This isn't on top of the now-ejected "ab/submodule-no-abspath" any
  longer. Per
  https://lore.kernel.org/git/kl6la647ow7e.fsf@chooglen-macbookpro.roam.corp.google.com/
  we're not changing the output here anymore

* Extract & amend the test that "ab/submodule-no-abspath" added to
  test the existing behavior (using $(pwd) now).

* There were a couple of cases where I missed passing the
  "super_prefix", per earlier discussions we haven't found cases where
  it's used in practice, but let's keep diligently passing it along.

* I ejected the previous 10/10 to refactor "git fetch". I have more
  patches on top of this to do some post-refactoring (e.g. saving
  memory churn by getting rid of "submodule_prefix" from "struct
  repository"), but none of that's essential for now, so let's drop
  that patch.

Junio: There's a conflict here in t/t7527* with
ed/fsmonitor-inotify. The conflict is easily solved. This side should
be kept, except for the new "git -C ..." command that was added to
test_when_finished(), which needs to be carried over. A --remerge-diff
off the solved conflict:

	diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
	remerge CONFLICT (content): Merge conflict in t/t7527-builtin-fsmonitor.sh
	index 40c96c5f819..963c4df461e 100755
	--- a/t/t7527-builtin-fsmonitor.sh
	+++ b/t/t7527-builtin-fsmonitor.sh
	@@ -933,20 +933,8 @@ test_expect_success 'submodule always visited' '
	 # to do the work and this may try to read the index.  This will
	 # try to start the daemon in the submodule.

	-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 4824f33224f (read-tree: add "--super-prefix" option, eliminate global)
	 test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
	-	test_when_finished "rm -rf super; \
	-================================
	-have_t2_error_event () {
	-	log=$1
	-	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
	-
	-	tr '\047' Q <$1 | grep -e "$msg"
	-}
	-
	-test_expect_success "stray submodule super-prefix warning" '
	 	test_when_finished "git -C super/dir_1/dir_2/sub fsmonitor--daemon stop; \
	 			    rm -rf super; \
	->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> f4fb2e9797d (Merge branch 'so/diff-merges-more' into seen)
	 			    rm -rf sub;   \
	 			    rm super-sub.trace" &&

Branch & passing CI at:
https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local-4

Glen Choo (1):
  read-tree + fetch tests: test failing "--super-prefix" interaction

Ævar Arnfjörð Bjarmason (8):
  submodule absorbgitdirs tests: add missing "Migrating git..." tests
  submodule.c & submodule--helper: pass along "super_prefix" param
  submodule--helper: don't use global --super-prefix in "absorbgitdirs"
  submodule--helper: convert "foreach" to its own "--super-prefix"
  submodule--helper: convert "sync" to its own "--super-prefix"
  submodule--helper: convert "status" to its own "--super-prefix"
  submodule--helper: convert "{update,clone}" to their own
    "--super-prefix"
  read-tree: add "--super-prefix" option, eliminate global

 Documentation/git.txt              |  8 +--
 builtin.h                          |  4 --
 builtin/checkout.c                 |  2 +-
 builtin/read-tree.c                |  1 +
 builtin/rm.c                       |  2 +-
 builtin/submodule--helper.c        | 87 ++++++++++++++++--------------
 cache.h                            |  2 -
 entry.c                            | 12 ++---
 entry.h                            |  6 ++-
 environment.c                      | 13 -----
 git.c                              | 41 +++-----------
 parse-options.h                    |  4 ++
 submodule.c                        | 50 ++++++++---------
 submodule.h                        |  8 +--
 t/t1001-read-tree-m-2way.sh        |  2 +-
 t/t5616-partial-clone.sh           | 43 +++++++++++++++
 t/t7412-submodule-absorbgitdirs.sh | 64 +++++++++++++++++++---
 t/t7527-builtin-fsmonitor.sh       | 36 +++++--------
 unpack-trees.c                     | 24 +++++----
 unpack-trees.h                     |  1 +
 20 files changed, 230 insertions(+), 180 deletions(-)

Range-diff against v3:
 1:  5f463bbefb5 !  1:  f479003941b submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
    +    submodule absorbgitdirs tests: add missing "Migrating git..." tests
     
    -    Change the "Migrating git directory" messages to avoid emitting
    -    absolute paths. We could use "old_git_dir" and "new_gitdir.buf" here
    -    sometimes, but not in all the cases covered by these tests,
    -    i.e. sometimes the latter will be an absolute path with a different
    -    prefix.
    +    Fix a blind spots in the tests surrounding "submodule absorbgitdirs"
    +    and test what output we emit, and how emitted the message and behavior
    +    interacts with a "git worktree" where the repository isn't at the base
    +    of the working directory.
     
    -    So let's just strip off the common prefix of the two strings, which
    -    handles the cases where we have nested submodules nicely. Note that
    -    this case is different than the one in get_submodule_displaypath() in
    -    "builtin/submodule--helper.c" handles, as we're dealing with the paths
    -    to the two ".git" here, not worktree paths.
    -
    -    Before this change we had no tests at all for this "Migrating git
    -    directory" output.
    +    The "$(pwd)" instead of "$PWD" here is needed due to Windows, where
    +    the latter will be a path like "/d/a/git/[...]", whereas we need
    +    "D:/a/git/[...]".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## submodule.c ##
    -@@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
    - 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
    - 	struct strbuf new_gitdir = STRBUF_INIT;
    - 	const struct submodule *sub;
    -+	size_t off = 0;
    - 
    - 	if (submodule_uses_worktrees(path))
    - 		die(_("relocate_gitdir for submodule '%s' with "
    -@@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
    - 		die(_("could not create directory '%s'"), new_gitdir.buf);
    - 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
    - 
    --	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
    -+	while (real_old_git_dir[off] && real_new_git_dir[off] &&
    -+	       real_old_git_dir[off] == real_new_git_dir[off])
    -+		off++;
    -+	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
    - 		get_super_prefix_or_empty(), path,
    --		real_old_git_dir, real_new_git_dir);
    -+		real_old_git_dir + off, real_new_git_dir + off);
    - 
    - 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
    - 
    -
      ## t/t7412-submodule-absorbgitdirs.sh ##
    +@@ t/t7412-submodule-absorbgitdirs.sh: TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup a real submodule' '
    ++	cwd="$(pwd)" &&
    + 	git init sub1 &&
    + 	test_commit -C sub1 first &&
    + 	git submodule add ./sub1 &&
     @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'setup a real submodule' '
      '
      
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'setup a real submodule'
      	git status >expect.1 &&
      	git -C sub1 rev-parse HEAD >expect.2 &&
     -	git submodule absorbgitdirs &&
    -+	cat >expect <<-\EOF &&
    -+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
    ++	cat >expect <<-EOF &&
    ++	Migrating git directory of '\''sub1'\'' from
    ++	'\''$cwd/sub1/.git'\'' to
    ++	'\''$cwd/.git/modules/sub1'\''
     +	EOF
     +	git submodule absorbgitdirs 2>actual &&
     +	test_cmp expect actual &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'setup nested submodule'
      	git status >expect.1 &&
      	git -C sub1/nested rev-parse HEAD >expect.2 &&
     -	git submodule absorbgitdirs &&
    -+	cat >expect <<-\EOF &&
    -+	Migrating git directory of '\''sub1/nested'\'' from '\''sub1/nested/.git'\'' to '\''.git/modules/sub1/modules/nested'\''
    ++	cat >expect <<-EOF &&
    ++	Migrating git directory of '\''sub1/nested'\'' from
    ++	'\''$cwd/sub1/nested/.git'\'' to
    ++	'\''$cwd/.git/modules/sub1/modules/nested'\''
     +	EOF
     +	git submodule absorbgitdirs 2>actual &&
     +	test_cmp expect actual &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 're-setup nested submodu
      	git status >expect.1 &&
      	git -C sub1/nested rev-parse HEAD >expect.2 &&
     -	git submodule absorbgitdirs &&
    -+	cat >expect <<-\EOF &&
    -+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
    ++	cat >expect <<-EOF &&
    ++	Migrating git directory of '\''sub1'\'' from
    ++	'\''$cwd/sub1/.git'\'' to
    ++	'\''$cwd/.git/modules/sub1'\''
     +	EOF
     +	git submodule absorbgitdirs 2>actual &&
     +	test_cmp expect actual &&
      	test -f sub1/.git &&
      	test -f sub1/nested/.git &&
      	test -d .git/modules/sub1/modules/nested &&
    +@@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a nested submodule' '
    + 	test_cmp expect.2 actual.2
    + '
    + 
    ++test_expect_success 'absorb the git dir outside of primary worktree' '
    ++	test_when_finished "rm -rf repo-bare.git" &&
    ++	git clone --bare . repo-bare.git &&
    ++	test_when_finished "rm -rf repo-wt" &&
    ++	git -C repo-bare.git worktree add ../repo-wt &&
    ++
    ++	test_when_finished "rm -f .gitconfig" &&
    ++	test_config_global protocol.file.allow always &&
    ++	git -C repo-wt submodule update --init &&
    ++	git init repo-wt/sub2 &&
    ++	test_commit -C repo-wt/sub2 A &&
    ++	git -C repo-wt submodule add ./sub2 sub2 &&
    ++	cat >expect <<-EOF &&
    ++	Migrating git directory of '\''sub2'\'' from
    ++	'\''$cwd/repo-wt/sub2/.git'\'' to
    ++	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
    ++	EOF
    ++	DO_IT=1 git -C repo-wt submodule absorbgitdirs 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'setup a gitlink with missing .gitmodules entry' '
    + 	git init sub2 &&
    + 	test_commit -C sub2 first &&
     @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'setup a gitlink with missing .gitmodules entry' '
      test_expect_success 'absorbing the git dir fails for incomplete submodules' '
      	git status >expect.1 &&
 2:  c930fc38356 =  2:  6424307a432 read-tree + fetch tests: test failing "--super-prefix" interaction
 3:  2e4a2236898 =  3:  b2e543bde03 submodule.c & submodule--helper: pass along "super_prefix" param
 4:  6e10a47c60a !  4:  bde9038c4e3 submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    @@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule
      	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
      	struct strbuf new_gitdir = STRBUF_INIT;
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
    - 	       real_old_git_dir[off] == real_new_git_dir[off])
    - 		off++;
    - 	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
    + 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
    + 
    + 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
     -		get_super_prefix_or_empty(), path,
     +		super_prefix ? super_prefix : "", path,
    - 		real_old_git_dir + off, real_new_git_dir + off);
    + 		real_old_git_dir, real_new_git_dir);
      
      	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
     @@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path,
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
     -}
     +# try to start the daemon in the submodule.
      
    - test_expect_success "stray submodule super-prefix warning" '
    +-test_expect_success "stray submodule super-prefix warning" '
    ++test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
      	test_when_finished "rm -rf super; \
    --			    rm -rf sub;   \
    --			    rm super-sub.trace" &&
    -+			    rm -rf sub" &&
    - 
    - 	create_super super &&
    - 	create_sub sub &&
    + 			    rm -rf sub;   \
    + 			    rm super-sub.trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "stray submodule super-prefix warning" '
      
      	test_path_is_dir super/dir_1/dir_2/sub/.git &&
      
    --	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
    --		git -C super submodule absorbgitdirs &&
    --
    --	! have_t2_error_event super-sub.trace
    -+	cat >expect <<-\EOF &&
    -+	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/dir_2/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
    ++	cwd="$(cd super && pwd)" &&
    ++	cat >expect <<-EOF &&
    ++	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
    ++	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
    ++	'\''$cwd/.git/modules/dir_1/dir_2/sub'\''
     +	EOF
    -+	git -C super submodule absorbgitdirs >out 2>actual &&
    + 	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
    +-		git -C super submodule absorbgitdirs &&
    ++		git -C super submodule absorbgitdirs >out 2>actual &&
     +	test_cmp expect actual &&
    -+	test_must_be_empty out
    ++	test_must_be_empty out &&
    + 
    +-	! have_t2_error_event super-sub.trace
    ++	# Confirm that the trace2 log contains a record of the
    ++	# daemon starting.
    ++	test_subcommand git fsmonitor--daemon start <super-sub.trace
      '
      
      # On a case-insensitive file system, confirm that the daemon
 5:  da86eb3b867 =  5:  4da58e7ea50 submodule--helper: convert "foreach" to its own "--super-prefix"
 6:  2eb583148a6 =  6:  8dff576df7d submodule--helper: convert "sync" to its own "--super-prefix"
 7:  8d8925c7e1f =  7:  8800a433e29 submodule--helper: convert "status" to its own "--super-prefix"
 8:  754a7489aa5 =  8:  54c1e29de1e submodule--helper: convert "{update,clone}" to their own "--super-prefix"
 9:  f952fa3d01f !  9:  4824f33224f read-tree: add "--super-prefix" option, eliminate global
    @@ submodule.c: int submodule_move_head(const char *path,
      
      			/* make sure the index is clean as well */
     -			submodule_reset_index(path);
    -+			submodule_reset_index(path, NULL);
    ++			submodule_reset_index(path, super_prefix);
      		}
      
      		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
    @@ unpack-trees.c: static int check_submodule_move_head(const struct cache_entry *c
      		flags |= SUBMODULE_MOVE_HEAD_FORCE;
      
     -	if (submodule_move_head(ce->name, old_id, new_id, flags))
    -+	if (submodule_move_head(ce->name, NULL, old_id, new_id, flags))
    ++	if (submodule_move_head(ce->name, o->super_prefix, old_id, new_id,
    ++				flags))
      		return add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
      	return 0;
      }
    @@ unpack-trees.c: int stash_worktree_untracked_merge(const struct cache_entry * co
     
      ## unpack-trees.h ##
     @@ unpack-trees.h: struct unpack_trees_options {
    - 		     dry_run;
    + 		     skip_cache_tree_update;
      	enum unpack_trees_reset_type reset;
      	const char *prefix;
     +	const char *super_prefix;
10:  1aa4019527a <  -:  ----------- fetch: rename "--submodule-prefix" to "--super-prefix"
-- 
2.39.0.rc2.1048.g0e5493b8d5b

