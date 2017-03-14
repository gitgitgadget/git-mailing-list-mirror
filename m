Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6AC020951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdCNVrO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:14 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34548 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdCNVrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id v190so75886027pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lJeadsfRYcqMu0skU0W+v2BeUKaDquhIR8bw9Cn2Ro=;
        b=cbb7xjrikijkj/XK753ynmsJ1YENPCS1Bh9+c/RPvj1coguaVVxVkrVVyrrTZI0IRj
         FNO9hZHn9rV5N5dmzVwwt9HB5MAZKRtVBiLKNMikQL6331DeBYP8I63rRM3UJKrX+q97
         YNSdQJjKSTJbDUupkjNjzMos9gl8ao0BhoAxvxuMy1Bml3wEdcG0NsADHtc/pgYdifcv
         U8jCaSaOueh2m6Vs01tlKEZyY/NVvJpDkSX3WtrTB6of9Vtg37XwzOBAMWyGT+cL0d5d
         9qOF3l4OQK8JNwxsAPUXe6f3Ml7yNPk0WE1QzI0mvSZe0JW5MPGM8uLXmWZE9ywzvjPw
         DUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lJeadsfRYcqMu0skU0W+v2BeUKaDquhIR8bw9Cn2Ro=;
        b=b7nR3XPBMzicuqzdEC8TiY+r1YGONMeDWqogcuR/89iXvrl3v0BS0745kqEQkLQ7A/
         gh9gDrbDShEnHfGVgdZnQDJ+64KbRunUEOm33+d+I8dX6heys70+bJyDVkK/PFuKmK1A
         9UsSLRBdLS9sv5MQDh2lQXetHf2UuJqIOTbbYg/3D7uu98ZzgpkX2A18KfG+TDx9HWpZ
         TOuqnJ79GV3bPGU1yLMQbbcRtcGtZNw4JNYzVLJXJ1gzCpMQaEQ9DjsEhIRrdwI+vIa1
         xD403CK2YauNCGeAD4KNdxs9ifHr33Ck4UOf75joL4FfT6rKhmbGK0Xi4+FYmgEXAGDq
         9ncw==
X-Gm-Message-State: AMke39lViOX0JRHVcpQdyqn/2N+WPwI+cRCBLAfdv43LyH+tCr4XVEdblhmbvj4rhlUJMuic
X-Received: by 10.99.225.5 with SMTP id z5mr45131365pgh.145.1489528030864;
        Tue, 14 Mar 2017 14:47:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id b77sm40374047pfl.2.2017.03.14.14.47.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 18/19] builtin/checkout: add --recurse-submodules switch
Date:   Tue, 14 Mar 2017 14:46:41 -0700
Message-Id: <20170314214642.7701-19-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This exposes a flag to recurse into submodules
in builtin/checkout making use of the code implemented
in prior patches.

A new failure mode is introduced in the submodule
update library, as the directory/submodule conflict
is not solved in prior patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-checkout.txt |  7 +++++++
 builtin/checkout.c             | 28 ++++++++++++++++++++++++++++
 t/lib-submodule-update.sh      | 26 +++++++++++++++++++++-----
 t/t2013-checkout-submodule.sh  |  6 ++++++
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c0662dd..d6399c0af8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -256,6 +256,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f174f50303..e9c5fcfaf8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -21,12 +21,31 @@
 #include "submodule-config.h"
 #include "submodule.h"
 
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
 	NULL,
 };
 
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1163,6 +1182,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
@@ -1193,6 +1215,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
+	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
+		git_config(submodule_config, NULL);
+		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+			set_config_update_recurse_submodules(recurse_submodules);
+	}
+
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index ae560dc95c..4e775a38b6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -782,6 +782,16 @@ test_submodule_forced_switch () {
 
 test_submodule_switch_recursing () {
 	command="$1"
+	RESULTDS=success
+	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
+	then
+		RESULTDS=failure
+	fi
+	RESULTR=success
+	if test "$KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED" = 1
+	then
+		RESULTR=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -891,7 +901,7 @@ test_submodule_switch_recursing () {
 	'
 	# Replacing a submodule with files in a directory must succeeds
 	# when the submodule is clean
-	test_expect_success "$command: replace submodule with a directory" '
+	test_expect_$RESULTDS "$command: replace submodule with a directory" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -903,7 +913,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... absorbing a .git directory.
-	test_expect_success "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
+	test_expect_$RESULTDS "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -931,7 +941,7 @@ test_submodule_switch_recursing () {
 	'
 
 	# ... must check its local work tree for untracked files
-	test_expect_success "$command: replace submodule with a file must fail with untracked files" '
+	test_expect_$RESULTDS "$command: replace submodule with a file must fail with untracked files" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -987,7 +997,8 @@ test_submodule_switch_recursing () {
 		)
 	'
 
-	test_expect_success "$command: modified submodule updates submodule recursively" '
+	# recursing deeper than one level doesn't work yet.
+	test_expect_$RESULTR "$command: modified submodule updates submodule recursively" '
 		prolog &&
 		reset_work_tree_to_interested add_nested_sub &&
 		(
@@ -1006,6 +1017,11 @@ test_submodule_switch_recursing () {
 # the superproject as well as the submodule is allowed.
 test_submodule_forced_switch_recursing () {
 	command="$1"
+	RESULT=success
+	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
+	then
+		RESULT=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -1151,7 +1167,7 @@ test_submodule_forced_switch_recursing () {
 	'
 
 	# ... but stops for untracked files that would be lost
-	test_expect_success "$command: replace submodule with a file" '
+	test_expect_$RESULT "$command: replace submodule with a file stops for untracked files" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6847f75822..e8f70b806f 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -63,6 +63,12 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '
 
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
+test_submodule_switch_recursing "git checkout --recurse-submodules"
+
+test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
+
 test_submodule_switch "git checkout"
 
 test_submodule_forced_switch "git checkout -f"
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

