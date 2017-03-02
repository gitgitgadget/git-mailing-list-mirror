Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5204D2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbdCBA5A (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:57:00 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35225 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pf0-f171.google.com with SMTP id j5so16196586pfb.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0AKL08UpgSFVrWeGGrk8RybE/hbuCk0CnKSdqVS02w=;
        b=tbmYISi2amTmY6mspUZRSr2j8DE69GqvFpnj1ndXxxDMvwSfoZxcYGLqVCZYNZYrcI
         MMtjTh0XtiqHzybvw+TrFOI1qgMNtDE+9XFtLne5AAYqeDvv34PwNfxxMPOFWiOPDCcP
         DHN7qj0UqgPRXBeikE+HMwC4/Cy6J27kF2Q4oPSkE0TUpDn1A7D08EYqX47+RRaJny8m
         OEawsQrEWJQtfq1n2REAhJNAaObL8zXWVsmXrMz4Wu/6MCEoKAK8wT0ayQxhnO4qzWlR
         I8KWCc86Lq5KSWb9tNafMZFFgM4ryd0vDJJ0BAQffBwho9ZByNCVaHXbmhHjJ61nhc38
         r4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0AKL08UpgSFVrWeGGrk8RybE/hbuCk0CnKSdqVS02w=;
        b=bANb9KPFVzqk7eWzGyu//x0Bmr9pdXEP+f8lLJdAyRq8CdzV/omppWEEe5z/I043ce
         SEPT+K1EwrqKSiZcv1gqA+EEsR/ssy+PlFJscHJB+L5fd1cs1d+cVclMOjRz8m3GL7sP
         cttL4+KzIhRJJ9/ybluwIuLjduq9C99KAguV4f3ZUUbu8QsbgKEJND2MdTLXVq7e7iNZ
         hs8I8mhl68vsbR6Yye4jRJMICAjNopU5QMfut9FtFZwPoeRr+THGrYoLbiwJ4v/a/lY/
         14bPYoVVLDr1hZ+T/Il2QpLTR0pJ/dlFcTTp2Gj+YIkC1Elgpod9sMOcDgI+N3ZDLhfz
         ZMkQ==
X-Gm-Message-State: AMke39mzdHEyrQ1KEUt5x2VuhBN0ch/Ijjy9tv9+7GT+p8J9ycqv+vRGoGzSFKIhZpGXyZRA
X-Received: by 10.98.53.65 with SMTP id c62mr12357383pfa.58.1488415706719;
        Wed, 01 Mar 2017 16:48:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id q73sm12741788pfa.129.2017.03.01.16.48.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 18/18] builtin/read-tree: add --recurse-submodules switch
Date:   Wed,  1 Mar 2017 16:47:59 -0800
Message-Id: <20170302004759.27852-19-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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
index d71972c3db..5caae06bc5 100755
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

