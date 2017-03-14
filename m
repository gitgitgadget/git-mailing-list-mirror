Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A748A20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdCNVra (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:30 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36455 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbdCNVr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:28 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so75982091pfb.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55AqR/4GgcX/uIDee/n5sspv7zZIP9A9R8V29UqGwYI=;
        b=eUjLdJCg901o7aQ3S/N1m9OBFRMw4G7tH4TWqUVVS+VGHT7iE4h+L8LJSR4+Vn5bT3
         Y10pohLiVBSKex4MZZfJ3E1Jkcav7FR1M1ZaNjybiSe08oAGXvKghSfA01KflWS2x8qt
         kJGkYZNi0c2HNuPj8mYHUevO5L5JTpfYKID0YvNgqEYXSqKDuG2Dx5eLCarTqWjooen1
         ga8O7G9kKSuCbmkATq21L+a3Iaq72t4Oe6mx002TawJszFOdPxGKZaFhsXbVVtTZaCP6
         ofMNiAavpwRg5uHuooIfusmRsq9r/qQ2Vo7Fpp3flo6QOUs/Gu2aWy+hpHO1HgjkqEtH
         48Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55AqR/4GgcX/uIDee/n5sspv7zZIP9A9R8V29UqGwYI=;
        b=OWmdwDTl+3ejGoPWBIh4YmpuZrJW3qUshdBE4Q+6YywVKO+VNw+8GtGGJnQ3CcmbiZ
         toPuxkPXaoup2D1a9oaXN4tTQ06gBcyi8Hv+KFAcFw0KRWAD4uwjgBJ3fjDgsa9HgUMi
         H6ZwtTOGhDU6EFD3z9/WRsndQ9z4ytx3otBViEjIyAaYkwqQ1ODcNWfDWc/C0dyPi4xz
         JRxCLmVvvU4JLrdJy+Eoe0Z6MV5odqwb+AKXTctfHEZXBkZuBRsKR/Vs6pgfYA9tw02h
         qEOCCfVhCfmew6+BY9zHVksPNqSSe9sAFZTLHTw46l9KmF5NBxAXPatiP8rk7vHJBN0u
         PuJw==
X-Gm-Message-State: AMke39kHL6r1pqSMiixE65MO56C5TXE6Gru/JtJwwZOEStOPQnrRjSqdQAqz2xj7tZB7zKW9
X-Received: by 10.99.38.2 with SMTP id m2mr45056701pgm.169.1489528032144;
        Tue, 14 Mar 2017 14:47:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id i3sm40301262pfk.47.2017.03.14.14.47.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 19/19] builtin/read-tree: add --recurse-submodules switch
Date:   Tue, 14 Mar 2017 14:46:42 -0700
Message-Id: <20170314214642.7701-20-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
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
 t/t1013-read-tree-submodule.sh  |  8 ++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

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
index 4e775a38b6..fb4f7b014e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -792,6 +792,11 @@ test_submodule_switch_recursing () {
 	then
 		RESULTR=failure
 	fi
+	RESULTOI=success
+	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
+	then
+		RESULTOI=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -832,7 +837,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... but an ignored file is fine.
-	test_expect_success "$command: added submodule removes an untracked ignored file" '
+	test_expect_$RESULTOI "$command: added submodule removes an untracked ignored file" '
 		test_when_finished "rm submodule_update/.git/info/exclude" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 20526aed34..de1ba02dc5 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -5,6 +5,14 @@ test_description='read-tree can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
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
2.12.0.rc1.49.g0cfd38c5f6.dirty

