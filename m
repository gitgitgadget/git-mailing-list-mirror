Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C5E2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbdCBA5B (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:57:01 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34257 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753791AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pf0-f169.google.com with SMTP id b5so9013140pfa.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bq7I9fgyiQTvAkK1eKg8Vwe/FeJX194Fobk2WDLqx04=;
        b=PuLjuzOA3BQJwnMUJmDZ0ew8TmDLoICZlzlejZDzyQXrEW/ft9s/tKGeM86ZQTedeb
         WPfc8CVEH3IOcRxoOlkR0iMUjU2+6dhrjOHvOZOPnam8Lr4i92NC+F3sm8qPPXIxi9dg
         1q9JDHr8jA5BpuaVZX1pUDOhKQgpkWCMJkeIJiQ6v+CHFZcP7g5Z6MwG4eAP+Ux4Pqmc
         wc9BKGcr5N4Ecu+wKTBjQFjAiaEIFEIJQj7ZoCs1UDoxkSi773ZNxcO9pnzRPi4TSR20
         izYflPKhIqIYwBAzpULj6k0y2DrTSy1TWskIXJYmw+Id3DYK/85a3M0eR3hAHZdMrdlc
         mQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bq7I9fgyiQTvAkK1eKg8Vwe/FeJX194Fobk2WDLqx04=;
        b=KYSmRnNPUNvFobhO7hiGJmWuNrDa+8dvYwM3WNRVnuCOQmPKHHK8SDjVunppheLl1Y
         /CDKTJVTsZ0FoEVU5/2uV9AOnkY5mp8cnQOhCZg83jw4T3e1yWrMGJdZKxDceVALaXEU
         39AQLPM81zLzR7GRWSCvZpsa84jsi8dc+POwL/1MvP6GSbZntL30LPu8jw+wfwx0ddle
         M1DKtjGPWLnXBvmKjpUWbQFF2sZFoJIm1grvbuh7cUu5q/Ebb1SKLNMmHU1bb06hKc/n
         dpUcmCkFciTIB1jEZQTRA8Qsssc5vB3G2fOFvplSya+JhvbXkGT1QiUXPuop69rwtjpH
         H42w==
X-Gm-Message-State: AMke39mgqEqvCUYFuuLaJirWd15hTnSqQ7bO7xEVPgaNGEn8qZvUCi5knjUXLQIwR6A1/Q5w
X-Received: by 10.99.146.70 with SMTP id s6mr11935548pgn.109.1488415705464;
        Wed, 01 Mar 2017 16:48:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id y21sm12831328pgh.52.2017.03.01.16.48.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 17/18] builtin/checkout: add --recurse-submodules switch
Date:   Wed,  1 Mar 2017 16:47:58 -0800
Message-Id: <20170302004759.27852-18-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-checkout.txt |  7 +++++++
 builtin/checkout.c             | 28 ++++++++++++++++++++++++++++
 t/lib-submodule-update.sh      | 23 +++++++++++++++++------
 t/t2013-checkout-submodule.sh  |  5 +++++
 4 files changed, 57 insertions(+), 6 deletions(-)

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
index aa196d4d42..d71972c3db 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -782,6 +782,11 @@ test_submodule_forced_switch () {
 
 test_submodule_switch_recursing () {
 	command="$1"
+	RESULT=success
+	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
+	then
+		RESULT=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -891,7 +896,7 @@ test_submodule_switch_recursing () {
 	'
 	# Replacing a submodule with files in a directory must succeeds
 	# when the submodule is clean
-	test_expect_success "$command: replace submodule with a directory" '
+	test_expect_$RESULT "$command: replace submodule with a directory" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -903,7 +908,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... absorbing a .git directory.
-	test_expect_success "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
+	test_expect_$RESULT "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -931,7 +936,7 @@ test_submodule_switch_recursing () {
 	'
 
 	# ... must check its local work tree for untracked files
-	test_expect_success "$command: replace submodule with a file must fail with untracked files" '
+	test_expect_$RESULT "$command: replace submodule with a file must fail with untracked files" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -987,7 +992,8 @@ test_submodule_switch_recursing () {
 		)
 	'
 
-	test_expect_success "$command: modified submodule updates submodule recursively" '
+	# recursing deeper than one level doesn't work yet.
+	test_expect_failure "$command: modified submodule updates submodule recursively" '
 		prolog &&
 		reset_work_tree_to_interested add_nested_sub &&
 		(
@@ -1006,6 +1012,11 @@ test_submodule_switch_recursing () {
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
@@ -1100,7 +1111,7 @@ test_submodule_forced_switch_recursing () {
 		)
 	'
 	# Replacing a submodule with files in a directory ...
-	test_expect_success "$command: replace submodule with a directory" '
+	test_expect_$RESULT "$command: replace submodule with a directory" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -1151,7 +1162,7 @@ test_submodule_forced_switch_recursing () {
 	'
 
 	# ... but stops for untracked files that would be lost
-	test_expect_success "$command: replace submodule with a file" '
+	test_expect_$RESULT "$command: replace submodule with a file stops for untracked files" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6847f75822..aa35223369 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -63,6 +63,11 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '
 
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+test_submodule_switch_recursing "git checkout --recurse-submodules"
+
+test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
+
 test_submodule_switch "git checkout"
 
 test_submodule_forced_switch "git checkout -f"
-- 
2.12.0.rc1.52.ge239d7e709.dirty

