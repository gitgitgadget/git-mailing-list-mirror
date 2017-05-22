Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F6E2023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761720AbdEVTsS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:18 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35857 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761712AbdEVTsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so91692327pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QaHfkcgfGF/sifQJ1poSJ+ryfTzCmDs8cHW1twiVZG4=;
        b=FGS7vXS1RpzOhJVH3P4hNG9EF7ns1HVNGuwfZpUXRlBOmPDnnfnd96hCW8Ii8/zo8w
         Z7LbARybt5YoZ1k3d0idXHkLLhpAuPlmA1dOtz2Ns9yPPp30rsySSXTtH90mP4Cgq0/Z
         KBTmTFafJ6nme1vUASJUZ0/7T7RgZ/ZyCnh201crX5oJf5KZevtxR27grFT960dsYc/g
         2TiU92axLtdzD+d0xy8cvk9j6l1nUbwfrekXFi8DGKfGVkZAgt2PJ3cNgD2Azcwydnz0
         gK5Z+GHrzqh4fPwb+DFH8DqC+YHUzQ7QAzGlm4rYGEZ+xhqjZ7zuiGN7HZdMDDs7uBsY
         qJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QaHfkcgfGF/sifQJ1poSJ+ryfTzCmDs8cHW1twiVZG4=;
        b=s1pt3N2l8pRyOAc8T8IrRNWdoPhjF9yL9QKfxitw/VGkcIKkFOZgv92zXHoul7rZvD
         sI+B6VBCbCPe71IWOXsQ7XJGnW0cXLmZDL0K3YW0QEomFpWAOMHaJM3B1wZYXDo7g7ZC
         wSYdkZXIjGLx4BfiE3jRtvFmSPniNBAenv9sJhqueUhpaxq2jWtEewNO5Rf5eNkfSMvK
         oOw98CGboTyMNnydj6zJURnk2ZJzPZKn7HBTGcMlKcfUf5yma49QTULRO+hXHu/Y4hZa
         gRPj71WjrlwcUdHmirPOkYRS1igXxkywiEGLiI0ZQOCyNPtVm+/xvGJ6F196TZ3b1GrZ
         PA2g==
X-Gm-Message-State: AODbwcA8Yusxz4CLPdpPFE6gCXEbMiPKFUnzdyH8S8h8MOnHRTrVJr7X
        BVw5SB5sc9VHc3JE
X-Received: by 10.98.11.205 with SMTP id 74mr27715149pfl.214.1495482493297;
        Mon, 22 May 2017 12:48:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id n7sm31031096pfk.74.2017.05.22.12.48.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/6] Introduce submodule.recurse option for worktree manipulators
Date:   Mon, 22 May 2017 12:48:03 -0700
Message-Id: <20170522194806.13568-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170522194806.13568-1-sbeller@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any command that understands '--recurse-submodules' can have its
default changed to true, by setting the submodule.recurse
option.

This patch includes read-tree/checkout/reset for working tree
manipulating commands. Later patches will cover other commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt  |  5 +++++
 builtin/checkout.c        |  9 +++------
 submodule.c               |  6 +++++-
 t/lib-submodule-update.sh | 12 ++++++++++++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..e367becf72 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3063,6 +3063,11 @@ submodule.active::
 	submodule's path to determine if the submodule is of interest to git
 	commands.
 
+submodule.recurse::
+	Specifies if commands recurse into submodules by default. This
+	applies to all commands that have a `--recurse-submodules` option.
+	Defaults to false.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2787b343b1..ad44ee843a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1194,7 +1194,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.prefix = prefix;
 	opts.show_progress = -1;
 
-	gitmodules_config();
+	load_submodule_config();
 	git_config(git_checkout_config, &opts);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
@@ -1214,11 +1214,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
-	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		load_submodule_config();
-		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-			set_config_update_recurse_submodules(recurse_submodules);
-	}
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+		set_config_update_recurse_submodules(recurse_submodules);
 
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
diff --git a/submodule.c b/submodule.c
index dda5ed210f..5d7aa711c8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -91,7 +91,11 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 
 static int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "submodule.fetchjobs")) {
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_update_recurse_submodules = v;
+	} else if (!strcmp(var, "submodule.fetchjobs")) {
 		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
 		parallel_jobs = git_config_int(var, value);
 		if (parallel_jobs < 0)
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 0f70b5ec7b..b30164339e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -990,6 +990,18 @@ test_submodule_switch_recursing () {
 		)
 	'
 
+	test_expect_success "git -c submodule.recurse=true $cmd_args --recurse-submodules: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -c submodule.recurse=true $cmd_args --recurse-submodules modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# superproject nor the submodule's work tree.
 	test_expect_success "$command: updating to a missing submodule commit fails" '
-- 
2.13.0.18.g7d86cc8ba0

