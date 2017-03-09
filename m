Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097ED202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbdCIWQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:25 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33882 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbdCIWQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:23 -0500
Received: by mail-pf0-f174.google.com with SMTP id v190so33700299pfb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiwRzMDdkRh2CokrvZ0pLzAROs9rtv606iQwcwbsOEM=;
        b=jQzBITYxjoZskEZNrsyakDLHdupKPv2kFsEaG7c5U2tFxE1ME3/k1oIRDWpDX9r6x5
         AXy4I0nnqu8KlfL2r28Mg8dYorE6HG135vnkj60Eb9UFqGlFZo3pGt+3sqVRLZ92t3eQ
         7Gycywd24xCHwWT9iexZZ9baShf/zA0oWv+DVU9VfgI0jbSDC1Uh5ZYeTQxW85haReFg
         pLclMMlhZN6LVboSAnM+Tsns+Ox2ATm/GlhgQ0RvZzGvC3E6N8Qe3c1dKbhncWBHnzGT
         +RAeQiS9fMP6+XAxC+P8ZWlRF6N72EegggGC7CAPGQWUJ0Zbktj1PG6AmqTVTHGIuogE
         CK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xiwRzMDdkRh2CokrvZ0pLzAROs9rtv606iQwcwbsOEM=;
        b=bGnel29rjBOEkemtr8Ld7Qi4MFrguYl0GJVVxiPWmMoIWM4xFk+T0ALU5RBTXowMbl
         g+lSKQEdhQpgyLpCTvJyzVna5AjyaWqe4npePPWjWP7+VLvuApFh+ovpghklgBjAdMp7
         /PN/3SI55TehNtp1omdiALLobLmDatsnO2fVGhWO0wo9cXj068yws0IJMZFJv5yVozLG
         HgB8/2OBmSmYYwpdoaXDD0ARkLTSlB3LtIwdYYiHzvSSJGxEKxoLpecQxf2NntXAeQ5h
         dGmA5R4pvbKMCfgJoG0HjX0sWSJ5aewopXQrFu9BuHG0ljQ7PJ6P0TFw77+RGWnBSyY3
         zz9A==
X-Gm-Message-State: AMke39mXjfKgl9a1/Dl4yEmExqFXHwIox9oR4xDt+nZx72SfjxxZFpdJAJlJmqgv3vnl0IcB
X-Received: by 10.98.62.219 with SMTP id y88mr16815087pfj.62.1489097776896;
        Thu, 09 Mar 2017 14:16:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id d66sm14318364pfe.90.2017.03.09.14.16.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 17/17] builtin/read-tree: add --recurse-submodules switch
Date:   Thu,  9 Mar 2017 14:15:43 -0800
Message-Id: <20170309221543.15897-18-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new known failure mode is introduced[1], which is actually not
a failure but a feature in read-tree. Unlike checkout for which
the recursive submodule tests were originally written, read-tree does
warn about ignored untracked files that would be overwritten.
For the sake of keeping the test library for submodules generic, just
mark the test as a failure.

[1] KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-read-tree.txt |  6 ++++++
 builtin/read-tree.c             | 29 +++++++++++++++++++++++++++++
 t/lib-submodule-update.sh       |  7 ++++++-
 t/t1013-read-tree-submodule.sh  |  7 +++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index fa1d557e5b..ed9d63ef4a 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -115,6 +115,12 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
 
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject by
+	calling read-tree recursively, also setting the submodules HEAD to be
+	detached at that commit.
+
 --no-sparse-checkout::
 	Disable sparse checkout support even if `core.sparseCheckout`
 	is true.
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8ba64bc785..23e212ee8c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -15,10 +15,13 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 static int nr_trees;
 static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static int list_tree(unsigned char *sha1)
 {
@@ -96,6 +99,23 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
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
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -137,6 +157,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
 			 N_("debug unpack-trees")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_END()
 	};
 
@@ -152,6 +175,12 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
+	}
+
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 0b659b530d..e195b590a1 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -787,6 +787,11 @@ test_submodule_switch_recursing () {
 	then
 		RESULT=failure
 	fi
+	RESULT1=success
+	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
+	then
+		RESULT1=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -827,7 +832,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... but an ignored file is fine.
-	test_expect_success "$command: added submodule removes an untracked ignored file" '
+	test_expect_$RESULT1 "$command: added submodule removes an untracked ignored file" '
 		test_when_finished "rm submodule_update/.git/info/exclude" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 20526aed34..7019d0a04f 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -5,6 +5,13 @@ test_description='read-tree can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+
+test_submodule_switch_recursing "git read-tree --recurse-submodules -u -m"
+
+test_submodule_forced_switch_recursing "git read-tree --recurse-submodules -u --reset"
+
 test_submodule_switch "git read-tree -u -m"
 
 test_submodule_forced_switch "git read-tree -u --reset"
-- 
2.12.0.rc1.45.g207f5fbb2b

