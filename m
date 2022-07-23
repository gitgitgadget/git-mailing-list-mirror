Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533AAC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiGWBx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiGWBxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3974DC2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b6so3685906wmq.5
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zA3FqPWk918PLJS2zx3eFQDUL3N+E7rCPAuR0ipNNO0=;
        b=HxKm984KNj41T5U6noytOOSbZ9+GGKTVVvRRuWTGNtuDiCop5V776HsCFXeUd0rqP/
         /cCS8RBDSjzvFVM98xFvqapjEgUUcqNCLRdtjkLF+u3MTHJ4Ho1t5AWK5zGyQMOO6pjr
         Xi66/M5WX9Ao8qvUp8grcJHwIo809LCvPThNe+6pckkIhKfI6qIT+oCdmrymE31VEiMk
         rlMt1bnDDLl3JZ73oFq8P39qd74/VNDGlJtNFsY7e5s+0XAll0rJD4VVE9hOzfG3wmLK
         M4F3Gg6dKgXd+cixvnPoaA++1XJq1VI+T4U0t9xAnoQ0RUol98MJ/+h9ePBePIpoyCm6
         PhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zA3FqPWk918PLJS2zx3eFQDUL3N+E7rCPAuR0ipNNO0=;
        b=4S1l2rJ2Rta1gR+qN3Eq1Q5B1aqqOTkuzdV00jGxAN5YBQA8ksY/pr5ubb5miBhc7N
         31mkTMCDUeUAlFHqYoD1BkSFh5xBFflyAA/QzjyCqucd17NB2wPIBXDV/3qmLeyaRBjg
         StH3Lo6H+fbcw7i0TM21UzzIOHoHDEmMF3ZDTRTeLV28me/3So6d/S8C2m0Hp07sKW9M
         s6+yGH6p0u9XgLWhoGcgfzZfsyvfZeii+EoLaNGYFQZBhzdUdpL7Z+XASNaZjWZPzKnn
         Wx3DVn2i1qBBNFcRwGbaDyzAAhPpeAA3kmQqMloogoqGg7FryucPUP215xattfGtC/E7
         0oFg==
X-Gm-Message-State: AJIora9LhB0f6MQU5Rn8FgAbbIZ8rmEFqx3v6tFVhfYyhrQKBZHtihMg
        VDK3kTXVuBX08fUAjBYOlAGnIuvTgXA=
X-Google-Smtp-Source: AGRyM1v/Mmynyf7ZskjjIkKH5ISVopXNb/L+HY21m13wlmqU6LZ+foty55ZUYCO2gIPlug0/bR19GQ==
X-Received: by 2002:a05:600c:1991:b0:3a3:3f0d:d9d9 with SMTP id t17-20020a05600c199100b003a33f0dd9d9mr1444809wmq.79.1658541199912;
        Fri, 22 Jul 2022 18:53:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q184-20020a1c43c1000000b003a302fb9df7sm10088195wma.21.2022.07.22.18.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:19 -0700 (PDT)
Message-Id: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:10 +0000
Subject: [PATCH v5 0/8] Fix merge restore state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as a simple series to fix restore_state() in builtin/merge.c,
fixing an issue reported by ZheNing Hu[3]. It now fixes several bugs and has
grown so much it's hard to call it simple. Anyway...

Changes since v4:

 * Made use of the error() function in another place to simplify code
   (should have caught this in v3)
 * Split the fixes for 'resolve' and the trivial merge into separate
   patches, and make sure one doesn't mask the other but both codepaths are
   exercises in the testsuite
 * better test descriptions
 * use strvec to simplify some code

[1]
https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

Elijah Newren (8):
  merge-ort-wrappers: make printed message match the one from recursive
  merge-resolve: abort if index does not match HEAD
  merge: abort if index does not match HEAD for trivial merges
  merge: do not abort early if one strategy fails to handle the merge
  merge: fix save_state() to work when there are stat-dirty files
  merge: make restore_state() restore staged state too
  merge: ensure we can actually restore pre-merge state
  merge: do not exit restore_state() prematurely

 builtin/merge.c                          | 57 ++++++++++++++++-----
 git-merge-resolve.sh                     | 10 ++++
 merge-ort-wrappers.c                     |  4 +-
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 65 ++++++++++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 t/t7607-merge-state.sh                   | 32 ++++++++++++
 7 files changed, 154 insertions(+), 17 deletions(-)
 create mode 100755 t/t7607-merge-state.sh


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1231%2Fnewren%2Ffix-merge-restore-state-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1231/newren/fix-merge-restore-state-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1231

Range-diff vs v4:

 1:  bd36d16c8d9 = 1:  bd36d16c8d9 merge-ort-wrappers: make printed message match the one from recursive
 2:  b79f44e54b9 ! 2:  b656756fd37 merge-resolve: abort if index does not match HEAD
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## builtin/merge.c ##
     -@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     - 		 */
     - 		refresh_cache(REFRESH_QUIET);
     - 		if (allow_trivial && fast_forward != FF_ONLY) {
     -+			/*
     -+			 * Must first ensure that index matches HEAD before
     -+			 * attempting a trivial merge.
     -+			 */
     -+			struct tree *head_tree = get_commit_tree(head_commit);
     -+			struct strbuf sb = STRBUF_INIT;
     -+
     -+			if (repo_index_has_changes(the_repository, head_tree,
     -+						   &sb)) {
     -+				struct strbuf err = STRBUF_INIT;
     -+				strbuf_addstr(&err, "error: ");
     -+				strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     -+					    sb.buf);
     -+				strbuf_addch(&err, '\n');
     -+				fputs(err.buf, stderr);
     -+				strbuf_release(&err);
     -+				strbuf_release(&sb);
     -+				return -1;
     -+			}
     -+
     - 			/* See if it is really trivial. */
     - 			git_committer_info(IDENT_STRICT);
     - 			printf(_("Trying really trivial in-index merge...\n"));
     -
       ## git-merge-resolve.sh ##
      @@
       #
     @@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'resolve, non-triv
       	test_path_is_missing .git/MERGE_HEAD
       '
       
     -+test_expect_success 'resolve, trivial, related file removed' '
     -+	git reset --hard &&
     -+	git checkout B^0 &&
     -+
     -+	git rm a &&
     -+	test_path_is_missing a &&
     -+
     -+	test_must_fail git merge -s resolve C^0 &&
     -+
     -+	test_path_is_missing a &&
     -+	test_path_is_missing .git/MERGE_HEAD
     -+'
     -+
      +test_expect_success 'resolve, non-trivial, related file removed' '
      +	git reset --hard &&
      +	git checkout B^0 &&
 -:  ----------- > 3:  3adfd921995 merge: abort if index does not match HEAD for trivial merges
 3:  02930448ea1 ! 4:  c5755271cf1 merge: do not abort early if one strategy fails to handle the merge
     @@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'subtree' '
       	test_path_is_missing .git/MERGE_HEAD
       '
       
     -+test_expect_success 'resolve && recursive && ort' '
     ++test_expect_success 'with multiple strategies, recursive or ort failure do not early abort' '
      +	git reset --hard &&
      +	git checkout B^0 &&
      +
     @@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'subtree' '
      +	git add a &&
      +
      +	sane_unset GIT_TEST_MERGE_ALGORITHM &&
     -+	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
     ++	test_must_fail git merge -s recursive -s ort -s octopus C^0 >output 2>&1 &&
      +
     -+	grep "Trying merge strategy resolve..." output &&
      +	grep "Trying merge strategy recursive..." output &&
      +	grep "Trying merge strategy ort..." output &&
     ++	grep "Trying merge strategy octopus..." output &&
      +	grep "No merge strategy handled the merge." output
      +'
      +
 4:  daf8d224160 ! 5:  e7c6de9e0c1 merge: fix save_state() to work when there are stat-dirty files
     @@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'subtree' '
      +	git merge -s resolve -s recursive D^0
      +'
      +
     - test_expect_success 'resolve && recursive && ort' '
     + test_expect_success 'with multiple strategies, recursive or ort failure do not early abort' '
       	git reset --hard &&
       	git checkout B^0 &&
 5:  f401bd5ad0d ! 6:  d39d6472455 merge: make restore_state() restore staged state too
     @@ Commit message
          changes.  Fix this by adding the "--index" option to "git stash apply".
          While at it, also squelch the stash apply output; we already report
          "Rewinding the tree to pristine..." and don't need a detailed `git
     -    status` report afterwards.
     +    status` report afterwards.  Also while at it, switch to using strvec
     +    so folks don't have to count the arguments to ensure we avoided an
     +    off-by-one error, and so it's easier to add additional arguments to
     +    the command.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose
       			  const struct object_id *stash)
       {
      -	const char *args[] = { "stash", "apply", NULL, NULL };
     -+	const char *args[] = { "stash", "apply", "--index", "--quiet",
     -+			       NULL, NULL };
     ++	struct strvec args = STRVEC_INIT;
       
       	if (is_null_oid(stash))
       		return;
     @@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose
       	reset_hard(head, 1);
       
      -	args[2] = oid_to_hex(stash);
     -+	args[4] = oid_to_hex(stash);
     ++	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
     ++	strvec_push(&args, oid_to_hex(stash));
       
       	/*
       	 * It is OK to ignore error here, for example when there was
     + 	 * nothing to restore.
     + 	 */
     +-	run_command_v_opt(args, RUN_GIT_CMD);
     ++	run_command_v_opt(args.v, RUN_GIT_CMD);
     ++	strvec_clear(&args);
     + 
     + 	refresh_cache(REFRESH_QUIET);
     + }
      
       ## t/t6424-merge-unrelated-index-changes.sh ##
     -@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'resolve && recursive && ort' '
     +@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'with multiple strategies, recursive or ort failure do not e
       
       	test_seq 0 10 >a &&
       	git add a &&
      +	git rev-parse :a >expect &&
       
       	sane_unset GIT_TEST_MERGE_ALGORITHM &&
     - 	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
     -@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'resolve && recursive && ort' '
     - 	grep "Trying merge strategy resolve..." output &&
     + 	test_must_fail git merge -s recursive -s ort -s octopus C^0 >output 2>&1 &&
     +@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'with multiple strategies, recursive or ort failure do not e
       	grep "Trying merge strategy recursive..." output &&
       	grep "Trying merge strategy ort..." output &&
     + 	grep "Trying merge strategy octopus..." output &&
      -	grep "No merge strategy handled the merge." output
      +	grep "No merge strategy handled the merge." output &&
      +
 6:  ad5354c219c = 7:  7f5c6884d68 merge: ensure we can actually restore pre-merge state
 7:  6212d572604 ! 8:  954dec526a2 merge: do not exit restore_state() prematurely
     @@ Commit message
      
       ## builtin/merge.c ##
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     - 	const char *args[] = { "stash", "apply", "--index", "--quiet",
     - 			       NULL, NULL };
     + {
     + 	struct strvec args = STRVEC_INIT;
       
      -	if (is_null_oid(stash))
      -		return;
     @@ builtin/merge.c: static void restore_state(const struct object_id *head,
      +	if (is_null_oid(stash))
      +		goto refresh_cache;
      +
     - 	args[4] = oid_to_hex(stash);
     + 	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
     + 	strvec_push(&args, oid_to_hex(stash));
       
     - 	/*
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     - 	 */
     - 	run_command_v_opt(args, RUN_GIT_CMD);
     + 	run_command_v_opt(args.v, RUN_GIT_CMD);
     + 	strvec_clear(&args);
       
      -	refresh_cache(REFRESH_QUIET);
      +refresh_cache:
     @@ t/t7607-merge-state.sh (new)
      +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +. ./test-lib.sh
      +
     -+test_expect_success 'set up custom strategy' '
     ++test_expect_success 'Ensure we restore original state if no merge strategy handles it' '
      +	test_commit --no-tag "Initial" base base &&
      +
      +	for b in branch1 branch2 branch3

-- 
gitgitgadget
