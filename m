Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC7C55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524982076E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5nd3RlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKMQNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKMQNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:13:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2123C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:13:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id s13so8932957wmh.4
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nkhaS0OjU2QMyVX0qym37yZgiLhg8AhxOSYnUNRXI8=;
        b=m5nd3RlIf42gJJqgk4iTl126zVlGh3s1mzLihN6JKkPc20ptltCC1aAtSiIcgjqLkU
         /ao9i1/cnss0ZtfNsCP9fcBpRQvOYnwy9Gl37kqtLOziNuZ2N/QZxjfsXiTWLTm1zg9f
         eG1zTlntBdt2XSvEdeyl7kniGPghjotGQZA9yipeVR3+IAY9Uw/n/ZUbP2Y0QMJuz3k/
         tRrYV+6x+PDZfll2iPRAyHO8UubtqAFeQkSynqG0EF0AleHu2TedLfuvdtbrpqWC8Xx6
         41cu515dtihXALM0xIRJvcJocxkU3uZEjs1EMjEjAJicSidCLeYdDMgIQj/cSHmMhUbx
         NAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nkhaS0OjU2QMyVX0qym37yZgiLhg8AhxOSYnUNRXI8=;
        b=hUk5U1YvL8IZ1Hfdg1iW1su0SVtwFOHXZzyS0TyUjpN0Bz5Lt+DMnDnGfAO+dhnYb+
         tLUJAmSJXCqoGb7qoyS4ycVMBWdQFSKZVkJHVVPhAtEugysSrG+gtlCteNxZvP7QVI0q
         yIxRuRS3N/4E029AzQiIBYsMX5UOi9wIP4iT2Qbfo2fjvLCm261SqABpfvMUBB67FCba
         RrygFjG49BvluP8hnd8SBxKBxeFy+RqWQNqgmaMdHA2S/9CL+ieU9pqc0P44T5+mrNPb
         hB+/rH/9BEd51DurzxOKfYpNXbp3721GkqqtCNipjIPa/9ySpkgLsr3t+wQ5HmDGNuwq
         dhlw==
X-Gm-Message-State: AOAM5315xpQmFMfXSW6AOZTKnAMhaz8r3nqNLyzZijN9I7sUraFobawO
        BPIk7asctnfzwaohatg8P3PNcSB5pFJRPA==
X-Google-Smtp-Source: ABdhPJz1X8PQ+2ThrdGNoAeLGbn59pEFAOnA/yp66s9x/cTeiBPnoGF4KmP//WIfSroS17j4LNHMFA==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr3269674wmj.101.1605284009159;
        Fri, 13 Nov 2020 08:13:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 89sm11792365wrp.58.2020.11.13.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:13:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] tests: support testing with an arbitrary default branch (sort of)
Date:   Fri, 13 Nov 2020 17:13:20 +0100
Message-Id: <20201113161320.16458-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 704fed9ea2 ("tests: start moving to a different default main
branch name", 2020-10-23) we've been needlessly skipping tests if the
branch is "master" in preparation for an eventual switch to another name.

As I noted in [1] I don't see why we shouldn't be doing a more
graceful approach here where we don't start skipping unrelated tests
just because some s/master/main/g changes are in flight.

Furthermore the seeming goal of eliminating the string "master" from
anywhere in git's sources results in needless patch churn, and has
nothing to do with the goal of changing the branch name in the UX.

This patch demonstrates that things could be much simpler if we don't
set ourselves that requirement. Now we:

 * Can set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=<some-name>, but this
   no longer overrides config, so it behaves like other GIT_TEST_*
   variables.

 * Have a test-tool helper that gives us refs.c's idea of the main
   branch name to share the logic between the tests and the main C
   code.

 * A lot of tests (but a small minority of the total) have master
   "master" hardcoded in some way. We now inventory them in
   tests-that-need-master.txt, we can still remove the names from that
   file and manually change the code later, but this accomplishes a
   clean test run with a relatively easy-to-review diff.

   We ignore GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=<name> when it comes
   to these files, unless
   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME_HARDER=true is set.

 * The changes to t5515-fetch-merge-logic.sh and
   t5560-http-backend-noserver.sh show how much easier it is to just
   punt on certain tests. In these tests that heavily rely on the
   "master" name (not inherently, it's just hardcoded in a lot of
   places) we just give up and keep using "master".

1. https://lore.kernel.org/git/87pn4hfmc4.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I need to walk away from the computer now, but this is an RFC of what
I was commenting on upthread.

 Makefile                            |   1 +
 config.c                            |  10 +
 config.h                            |   1 +
 refs.c                              |   7 +-
 t/helper/test-default-branch-name.c |  16 ++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0001-init.sh                     |   2 +-
 t/t5515-fetch-merge-logic.sh        |   3 +
 t/t5560-http-backend-noserver.sh    |   4 +
 t/test-lib.sh                       |  27 ++-
 t/tests-that-need-master.txt        | 343 ++++++++++++++++++++++++++++
 12 files changed, 403 insertions(+), 13 deletions(-)
 create mode 100644 t/helper/test-default-branch-name.c
 create mode 100644 t/tests-that-need-master.txt

diff --git a/Makefile b/Makefile
index 790a883932..fb94c836e2 100644
--- a/Makefile
+++ b/Makefile
@@ -696,6 +696,7 @@ TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
+TEST_BUILTINS_OBJS += test-default-branch-name.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
diff --git a/config.c b/config.c
index 2bdff4457b..0c12864b79 100644
--- a/config.c
+++ b/config.c
@@ -1706,6 +1706,16 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 	return val;
 }
 
+/*
+ * Parse environment variable 'k' as a char *; if missing, use the
+ * default value 'def'.
+ */
+const char* git_env_str(const char *k, const char *def)
+{
+	const char *v = getenv(k);
+	return v && strlen(v) ? v : def;
+}
+
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
diff --git a/config.h b/config.h
index 91cdfbfb41..36a7284f8a 100644
--- a/config.h
+++ b/config.h
@@ -298,6 +298,7 @@ int git_config_copy_section_in_file(const char *, const char *, const char *);
 const char *git_etc_gitconfig(void);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
+const char* git_env_str(const char *, const char *);
 int git_config_system(void);
 int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/refs.c b/refs.c
index 392f0bbf68..ca8875e945 100644
--- a/refs.c
+++ b/refs.c
@@ -567,15 +567,12 @@ char *repo_default_branch_name(struct repository *r)
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
 	char *ret = NULL, *full_ref;
-	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
 
-	if (env && *env)
-		ret = xstrdup(env);
-	else if (repo_config_get_string(r, config_key, &ret) < 0)
+	if (repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret)
-		ret = xstrdup("master");
+		ret = xstrdup(git_env_str("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME", "master"));
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
diff --git a/t/helper/test-default-branch-name.c b/t/helper/test-default-branch-name.c
new file mode 100644
index 0000000000..1a0c8502ee
--- /dev/null
+++ b/t/helper/test-default-branch-name.c
@@ -0,0 +1,16 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "refs.h"
+
+/*
+ * usage:
+ * tool-test default-branch-name
+ */
+int cmd__default_branch_name(int argc, const char **argv)
+{
+	const char *name = git_default_branch_name();
+
+	puts(name);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a0d3966b29..ad4bd7274c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -21,6 +21,7 @@ static struct test_cmd cmds[] = {
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
+	{ "default-branch-name", cmd__default_branch_name },
 	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 07034d3f38..e0dda6bfd8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -10,6 +10,7 @@ int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
+int cmd__default_branch_name(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 69a320489f..68adb9a832 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -562,7 +562,7 @@ test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
 	git -C main-branch-env symbolic-ref HEAD >actual &&
-	grep env actual
+	grep nmb actual
 '
 
 test_expect_success 'invalid default branch name' '
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 70a9d2d8ab..939c8b2f83 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -11,6 +11,9 @@ test_description='Merge logic in fetch'
 GIT_TEST_PROTOCOL_VERSION=0
 export GIT_TEST_PROTOCOL_VERSION
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 build_script () {
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9fafcf1945..27b31745ad 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 
 test_description='test git-http-backend-noserver'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index fa347ed3e1..11ea009717 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1382,6 +1382,26 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME
 
+# Check if we're doing tests with the main branch != master, and if
+# we'd like to override that for known-broken tests.
+GIT_TEST_MAIN=$(test-tool default-branch-name)
+if test "$GIT_TEST_MAIN" = "master"
+then
+	test_set_prereq MAIN_BRANCH_IS_MASTER
+else
+	if test -z "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME_HARDER" &&
+	   grep -q $TEST_NAME "$TEST_DIRECTORY/tests-that-need-master.txt"
+	then
+		echo overriding
+		GIT_TEST_MAIN=master
+		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+		test_set_prereq MAIN_BRANCH_IS_MASTER
+	fi
+fi
+export GIT_TEST_MAIN
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+# Initialize the repository after we know the main branch name.
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	test_create_repo "$TRASH_DIRECTORY"
@@ -1711,10 +1731,3 @@ test_lazy_prereq SHA1 '
 test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
-# Special-purpose prereq for transitioning to a new default branch name:
-# Some tests need more than just a mindless (case-preserving) s/master/main/g
-# replacement. The non-trivial adjustments are guarded behind this
-# prerequisite, acting kind of as a feature flag
-test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
-	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = main
-'
diff --git a/t/tests-that-need-master.txt b/t/tests-that-need-master.txt
new file mode 100644
index 0000000000..d7a693b19e
--- /dev/null
+++ b/t/tests-that-need-master.txt
@@ -0,0 +1,343 @@
+t0002-gitfile.sh
+t0020-crlf.sh
+t0021-conversion.sh
+t0027-auto-crlf.sh
+t0028-working-tree-encoding.sh
+t0041-usage.sh
+t0050-filesystem.sh
+t0060-path-utils.sh
+t0100-previous.sh
+t1004-read-tree-m-u-wf.sh
+t1008-read-tree-overlay.sh
+t1009-read-tree-new-index.sh
+t1011-read-tree-sparse-checkout.sh
+t1021-rerere-in-workdir.sh
+t1090-sparse-checkout-scope.sh
+t1091-sparse-checkout-builtin.sh
+t1300-config.sh
+t1301-shared-repo.sh
+t1305-config-include.sh
+t1309-early-config.sh
+t1400-update-ref.sh
+t1402-check-ref-format.sh
+t1403-show-ref.sh
+t1405-main-ref-store.sh
+t1406-submodule-ref-store.sh
+t1407-worktree-ref-store.sh
+t1408-packed-refs.sh
+t1410-reflog.sh
+t1411-reflog-show.sh
+t1413-reflog-detach.sh
+t1414-reflog-walk.sh
+t1416-ref-transaction-hooks.sh
+t1430-bad-ref-name.sh
+t1450-fsck.sh
+t1500-rev-parse.sh
+t1503-rev-parse-verify.sh
+t1505-rev-parse-last.sh
+t1506-rev-parse-diagnosis.sh
+t1507-rev-parse-upstream.sh
+t1508-at-combinations.sh
+t1511-rev-parse-caret.sh
+t1512-rev-parse-disambiguation.sh
+t1513-rev-parse-prefix.sh
+t1514-rev-parse-push.sh
+t1700-split-index.sh
+t2007-checkout-symlink.sh
+t2009-checkout-statinfo.sh
+t2010-checkout-ambiguous.sh
+t2011-checkout-invalid-head.sh
+t2012-checkout-last.sh
+t2015-checkout-unborn.sh
+t2017-checkout-orphan.sh
+t2020-checkout-detach.sh
+t2022-checkout-paths.sh
+t2023-checkout-m.sh
+t2024-checkout-dwim.sh
+t2027-checkout-track.sh
+t2030-unresolve-info.sh
+t2060-switch.sh
+t2070-restore.sh
+t2106-update-index-assume-unchanged.sh
+t2400-worktree-add.sh
+t2401-worktree-prune.sh
+t2402-worktree-list.sh
+t2405-worktree-submodule.sh
+t3040-subprojects-basic.sh
+t3200-branch.sh
+t3201-branch-contains.sh
+t3202-show-branch-octopus.sh
+t3203-branch-output.sh
+t3204-branch-name-interpretation.sh
+t3205-branch-color.sh
+t3206-range-diff.sh
+t3210-pack-refs.sh
+t3211-peel-ref.sh
+t3301-notes.sh
+t3302-notes-index-expensive.sh
+t3303-notes-subtrees.sh
+t3304-notes-mixed.sh
+t3308-notes-merge.sh
+t3320-notes-merge-worktrees.sh
+t3400-rebase.sh
+t3402-rebase-merge.sh
+t3403-rebase-skip.sh
+t3405-rebase-malformed.sh
+t3406-rebase-message.sh
+t3407-rebase-abort.sh
+t3408-rebase-multi-line.sh
+t3409-rebase-preserve-merges.sh
+t3412-rebase-root.sh
+t3413-rebase-hook.sh
+t3415-rebase-autosquash.sh
+t3416-rebase-onto-threedots.sh
+t3418-rebase-continue.sh
+t3419-rebase-patch-id.sh
+t3420-rebase-autostash.sh
+t3423-rebase-reword.sh
+t3427-rebase-subtree.sh
+t3430-rebase-merges.sh
+t3431-rebase-fork-point.sh
+t3432-rebase-fast-forward.sh
+t3434-rebase-i18n.sh
+t3435-rebase-gpg-sign.sh
+t3436-rebase-more-options.sh
+t3500-cherry.sh
+t3501-revert-cherry-pick.sh
+t3502-cherry-pick-merge.sh
+t3503-cherry-pick-root.sh
+t3504-cherry-pick-rerere.sh
+t3505-cherry-pick-empty.sh
+t3506-cherry-pick-ff.sh
+t3507-cherry-pick-conflict.sh
+t3508-cherry-pick-many-commits.sh
+t3509-cherry-pick-merge-df.sh
+t3512-cherry-pick-submodule.sh
+t3600-rm.sh
+t3701-add-interactive.sh
+t3901-i18n-patch.sh
+t3903-stash.sh
+t3910-mac-os-precompose.sh
+t4014-format-patch.sh
+t4015-diff-whitespace.sh
+t4017-diff-retval.sh
+t4038-diff-combined.sh
+t4041-diff-submodule-option.sh
+t4048-diff-combined-binary.sh
+t4052-stat-output.sh
+t4056-diff-order.sh
+t4057-diff-combined-paths.sh
+t4061-diff-indent.sh
+t4066-diff-emit-delay.sh
+t4068-diff-symmetric-merge-base.sh
+t4103-apply-binary.sh
+t4108-apply-threeway.sh
+t4121-apply-diffs.sh
+t4122-apply-symlink-inside.sh
+t4150-am.sh
+t4200-rerere.sh
+t4201-shortlog.sh
+t4202-log.sh
+t4203-mailmap.sh
+t4204-patch-id.sh
+t4207-log-decoration-colors.sh
+t4208-log-magic-pathspec.sh
+t4214-log-graph-octopus.sh
+t4216-log-bloom.sh
+t4253-am-keep-cr-dos.sh
+t4257-am-interactive.sh
+t5150-request-pull.sh
+t5304-prune.sh
+t5305-include-tag.sh
+t5312-prune-corruption.sh
+t5317-pack-objects-filter-objects.sh
+t5322-pack-objects-sparse.sh
+t5323-pack-redundant.sh
+t5400-send-pack.sh
+t5401-update-hooks.sh
+t5402-post-merge-hook.sh
+t5403-post-checkout-hook.sh
+t5404-tracking-branches.sh
+t5405-send-pack-rewind.sh
+t5407-post-rewrite-hook.sh
+t5410-receive-pack-alternates.sh
+t5500-fetch-pack.sh
+t5501-fetch-push-alternates.sh
+t5502-quickfetch.sh
+t5503-tagfollow.sh
+t5504-fetch-receive-strict.sh
+t5505-remote.sh
+t5506-remote-groups.sh
+t5509-fetch-push-namespaces.sh
+t5510-fetch.sh
+t5511-refspec.sh
+t5512-ls-remote.sh
+t5514-fetch-multiple.sh
+t5516-fetch-push.sh
+t5517-push-mirror.sh
+t5518-fetch-exit-status.sh
+t5519-push-alternates.sh
+t5520-pull.sh
+t5521-pull-options.sh
+t5523-push-upstream.sh
+t5526-fetch-submodules.sh
+t5527-fetch-odd-refs.sh
+t5528-push-default.sh
+t5529-push-errors.sh
+t5530-upload-pack-error.sh
+t5531-deep-submodule-push.sh
+t5533-push-cas.sh
+t5534-push-signed.sh
+t5537-fetch-shallow.sh
+t5538-push-shallow.sh
+t5539-fetch-http-shallow.sh
+t5540-http-push-webdav.sh
+t5541-http-push-smart.sh
+t5542-push-http-shallow.sh
+t5543-atomic-push.sh
+t5545-push-options.sh
+t5548-push-porcelain.sh
+t5550-http-fetch-dumb.sh
+t5551-http-fetch-smart.sh
+t5552-skipping-fetch-negotiator.sh
+t5553-set-upstream.sh
+t5561-http-backend.sh
+t5570-git-daemon.sh
+t5571-pre-push-hook.sh
+t5572-pull-submodule.sh
+t5580-unc-paths.sh
+t5581-http-curl-verbose.sh
+t5582-fetch-negative-refspec.sh
+t5601-clone.sh
+t5604-clone-reference.sh
+t5605-clone-local.sh
+t5606-clone-options.sh
+t5607-clone-bundle.sh
+t5608-clone-2gb.sh
+t5609-clone-branch.sh
+t5610-clone-detached.sh
+t5611-clone-config.sh
+t5612-clone-refspec.sh
+t5614-clone-submodules-shallow.sh
+t5616-partial-clone.sh
+t5617-clone-submodules-remote.sh
+t5700-protocol-v1.sh
+t5701-git-serve.sh
+t5702-protocol-v2.sh
+t5703-upload-pack-ref-in-want.sh
+t5801-remote-helpers.sh
+t6000-rev-list-misc.sh
+t6001-rev-list-graft.sh
+t6004-rev-list-path-optim.sh
+t6006-rev-list-format.sh
+t6007-rev-list-cherry-pick-file.sh
+t6008-rev-list-submodule.sh
+t6009-rev-list-parent.sh
+t6012-rev-list-simplify.sh
+t6013-rev-list-reverse-parents.sh
+t6016-rev-list-graph-simplify-history.sh
+t6017-rev-list-stdin.sh
+t6018-rev-list-glob.sh
+t6019-rev-list-ancestry-path.sh
+t6030-bisect-porcelain.sh
+t6040-tracking-info.sh
+t6050-replace.sh
+t6101-rev-parse-parents.sh
+t6110-rev-list-sparse.sh
+t6111-rev-list-treesame.sh
+t6112-rev-list-filters-objects.sh
+t6120-describe.sh
+t6200-fmt-merge-msg.sh
+t6302-for-each-ref-filter.sh
+t6400-merge-df.sh
+t6402-merge-rename.sh
+t6404-recursive-merge.sh
+t6405-merge-symlinks.sh
+t6406-merge-attr.sh
+t6407-merge-binary.sh
+t6409-merge-subtree.sh
+t6411-merge-filemode.sh
+t6412-merge-large-rename.sh
+t6413-merge-crlf.sh
+t6414-merge-rename-nocruft.sh
+t6415-merge-dir-to-symlink.sh
+t6416-recursive-corner-cases.sh
+t6417-merge-ours-theirs.sh
+t6418-merge-text-auto.sh
+t6419-merge-ignorecase.sh
+t6422-merge-rename-corner-cases.sh
+t6425-merge-rename-delete.sh
+t6427-diff3-conflict-markers.sh
+t6430-merge-recursive.sh
+t6432-merge-recursive-space-options.sh
+t6433-merge-toplevel.sh
+t6434-merge-recursive-rename-options.sh
+t6436-merge-overwrite.sh
+t6437-submodule-merge.sh
+t6439-merge-co-error-msgs.sh
+t6501-freshen-objects.sh
+t7003-filter-branch.sh
+t7004-tag.sh
+t7030-verify-tag.sh
+t7060-wtstatus.sh
+t7063-status-untracked-cache.sh
+t7102-reset.sh
+t7113-post-index-change-hook.sh
+t7201-co.sh
+t7400-submodule-basic.sh
+t7403-submodule-sync.sh
+t7406-submodule-update.sh
+t7407-submodule-foreach.sh
+t7409-submodule-detached-work-tree.sh
+t7417-submodule-path-url.sh
+t7501-commit-basic-functionality.sh
+t7502-commit-porcelain.sh
+t7503-pre-commit-and-pre-merge-commit-hooks.sh
+t7504-commit-msg-hook.sh
+t7505-prepare-commit-msg-hook.sh
+t7508-status.sh
+t7510-signed-commit.sh
+t7512-status-help.sh
+t7517-per-repo-email.sh
+t7600-merge.sh
+t7606-merge-custom.sh
+t7608-merge-messages.sh
+t7610-mergetool.sh
+t7611-merge-abort.sh
+t7612-merge-verify-signatures.sh
+t7614-merge-signoff.sh
+t7701-repack-unpack-unreachable.sh
+t7800-difftool.sh
+t7810-grep.sh
+t8001-annotate.sh
+t8003-blame-corner-cases.sh
+t8004-blame-with-conflicts.sh
+t9001-send-email.sh
+t9100-git-svn-basic.sh
+t9145-git-svn-master-branch.sh
+t9151-svn-mergeinfo.sh
+t9155-git-svn-fetch-deleted-tag.sh
+t9156-git-svn-fetch-deleted-tag-2.sh
+t9163-git-svn-reset-clears-caches.sh
+t9169-git-svn-dcommit-crlf.sh
+t9300-fast-import.sh
+t9301-fast-import-notes.sh
+t9302-fast-import-unpack-limit.sh
+t9350-fast-export.sh
+t9351-fast-export-anonymize.sh
+t9400-git-cvsserver-server.sh
+t9401-git-cvsserver-crlf.sh
+t9402-git-cvsserver-refs.sh
+t9500-gitweb-standalone-no-errors.sh
+t9501-gitweb-standalone-http-status.sh
+t9502-gitweb-standalone-parse-output.sh
+t9600-cvsimport.sh
+t9601-cvsimport-vendor-branch.sh
+t9602-cvsimport-branches-tags.sh
+t9603-cvsimport-patchsets.sh
+t9800-git-p4-basic.sh
+t9801-git-p4-branch.sh
+t9806-git-p4-options.sh
+t9807-git-p4-submit.sh
+t9811-git-p4-label-import.sh
+t9903-bash-prompt.sh
-- 
2.29.2.222.g5d2a92d10f8

