Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4C120133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbdCFVZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:25:08 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36026 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbdCFVZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:25:07 -0500
Received: by mail-pf0-f173.google.com with SMTP id o126so18071864pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/ZUh+FAXeLefpke01pATJd9U02m6kWMcSEcUtdG7bo=;
        b=CNM8EIE1G3RwhwjM7UFni2l/cZaAta8NyKObPSP9C4HEhCeHCPae6pxhavjPVtfJII
         5OcgdSutHDwtlJA3VY20rm3yA/UvPVPFyZyCjUTfRnYtI0TyvtNxcYVhnPPSmMSV6zVQ
         lBJ4A2yK/z5pKrQaCaXuT/KfTyknSiNGc0EfhRRNq0Cum26XgUdEi450sYv49rCW8XA3
         s3baWb1NZk67uXoeEIWzGdyDhY34Kdg8BDjEJqw4ziu5cFjqRbhzkT7s9R8l/rOjxlkB
         TWpcL2haHeFEV8qNc3Xn+vEm/FUMqvkY36Jo+LRiQZfyqz2HL3vdlVrpSouAMwHE4Ddu
         9kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/ZUh+FAXeLefpke01pATJd9U02m6kWMcSEcUtdG7bo=;
        b=Pf7cUd89dVLf118yo9iSjqm7VIr+feKAxNv2TISHFneiKT4j+wIUmrE0Gi9SGqQcOQ
         dpqBtOWcuKrM8c+BhX7w0JNUrd9gNeSZdH5IRng8XabsAyMiCSpnBaj/rQC0oTLgmTr/
         qe+lxtYeYQ7rgyJaSmH8M4BlVcDNM0HvEfurQOqX1JsqO9Ez1ZN1mJF4LTRZzDoMdYoy
         oXOVRKujXf/hLkkNVWGuDg+K3Ewy2k9gM+Yas7C4LKRJ/sK+iYxpOl+5ZEnRt8D1/NzS
         Q07HYnP7u4gzHFOCoeWc9FAUi7p7XqjkmAymO0/rT4Y/7exhEZI/dudUtyobSpN6/l/2
         ZF0Q==
X-Gm-Message-State: AMke39k6AZJskUUc3gvYc/3ZCr85WDvGJX4Sw+HLf3h3zeZW9T4+yYFAg0mLAPzYzhF7Fmbu
X-Received: by 10.98.103.146 with SMTP id t18mr23746739pfj.135.1488833985675;
        Mon, 06 Mar 2017 12:59:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id a78sm15756734pfc.25.2017.03.06.12.59.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 18/18] builtin/read-tree: add --recurse-submodules switch
Date:   Mon,  6 Mar 2017 12:59:19 -0800
Message-Id: <20170306205919.9713-19-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new known failure mode is introduced[1], which is actually not
a failure but a feature in read-tree. Unlike checkout for which
the recursive submodule tests were originally written, read-tree does
warn about ignored untracked files that would be overwritten.
For the sake of keeping the test library for submodules genric, just
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
index 8ba64bc785..2dc5cc06da 100644
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
+int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
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
index 6a78139f90..949ebd546c 100755
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
2.12.0.rc1.52.ge239d7e709.dirty

