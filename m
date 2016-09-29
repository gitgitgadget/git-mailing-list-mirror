Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD7A207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbcI2Vue (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:50:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35853 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934529AbcI2VuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:50:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id qn7so31453058pac.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrW8NuA+3Kz66z6lx6YI9TucfU3DTfHz41ybYB4ThHw=;
        b=n9pjJVN35oE1Eqwt+nZDB3Plijp0HzCUFVQXqAWuMim35rcavQ/raSCdIwDV+73RHA
         OgJQNZQ3fcnYg8F0MkIE97TgXsfAfk2G63IWuvzU2k8iw+3FegWrh3Q2+YxWSEVjsSzy
         1tyv8BIF7ET+Z+XYrxmVuzZ6aWauV5zQNJ8WgOaux2mRX7VBSKsQat25cvmPXP/kwtll
         Fyjgs0qLlHxSv7fSGe1LKt6PFF4V+hmFyFrBJ/GMKmVZgbhWtbAEuq6c4puJWxZti8ty
         +GLlwXXv1eBG+kOAZrDAT9u9TAAaUARQue+5gIKtGtyVy+N2q+RzX2Jj3Qo6DIbHEAiG
         enHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wrW8NuA+3Kz66z6lx6YI9TucfU3DTfHz41ybYB4ThHw=;
        b=ReUx2dbzRVBp/tgYE3dvG5bfnsUIvRDj2XbnEdE8TZows1MRKGKJeHc3QGa1H5KkrB
         k9Ihhuvc3T2W1SlsTyk/f+LZ+/eJ/6qnJFuandRYM5qAUwHkuc0jF5v5CPwLqCwlqjTE
         iPjXOFJLXE+IUOobtdFW68gN3TZE+yNygrvFeqoTTSYPIjFN/JGLrdZ237Y8o3VUSUqP
         Beyy0MHU5wLCVCJ1LY5cl0hovUbGUEkWq6scK7PDJr31UVUDDwwOT9GKvf/q1ZTxEMAz
         /mTRP8cPA7Jo6P/aea8FM7TbJiZblgzV84GC8FLwP0J9MV0fr+WD++z4LzdAzHvabdEU
         mAtw==
X-Gm-Message-State: AA6/9Rk1Gxa6IsXW3GMmbVYO9LpU69M8Z435iZu1nJjPnrUcPzYzAc/iQUbeKgt0EdNpL+wv
X-Received: by 10.66.216.199 with SMTP id os7mr6040132pac.155.1475185815945;
        Thu, 29 Sep 2016 14:50:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4c71:119f:edd5:cf6c])
        by smtp.gmail.com with ESMTPSA id w63sm22492858pfk.43.2016.09.29.14.50.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 14:50:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v6 3/4] ls-files: pass through safe options for --recurse-submodules
Date:   Thu, 29 Sep 2016 14:48:42 -0700
Message-Id: <1475185723-36871-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475185723-36871-1-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass through some known-safe options when recursing into submodules.
(--cached, --stage, -v, -t, -z, --debug, --eol)

Other options are compiled into an argv_array but if an unsafe option is
given the caller will be errored out.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 51 ++++++++++++++++++++++++++++++++--
 t/t3007-ls-files-recurse-submodules.sh | 17 ++++++++----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 63befed..6f744ef 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,6 +30,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static struct argv_array submodules_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static const char *super_prefix;
@@ -168,6 +169,45 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/*
+ * Compile an argv_array with all of the options supported by --recurse_submodules
+ */
+static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
+{
+	if (line_terminator == '\0')
+		argv_array_push(&submodules_options, "-z");
+	if (show_tag)
+		argv_array_push(&submodules_options, "-t");
+	if (show_valid_bit)
+		argv_array_push(&submodules_options, "-v");
+	if (show_cached)
+		argv_array_push(&submodules_options, "--cached");
+	if (show_deleted)
+		argv_array_push(&submodules_options, "--deleted");
+	if (show_modified)
+		argv_array_push(&submodules_options, "--modified");
+	if (show_others)
+		argv_array_push(&submodules_options, "--others");
+	if (dir->flags & DIR_SHOW_IGNORED)
+		argv_array_push(&submodules_options, "--ignored");
+	if (show_stage)
+		argv_array_push(&submodules_options, "--stage");
+	if (show_killed)
+		argv_array_push(&submodules_options, "--killed");
+	if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
+		argv_array_push(&submodules_options, "--directory");
+	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES))
+		argv_array_push(&submodules_options, "--empty-directory");
+	if (show_unmerged)
+		argv_array_push(&submodules_options, "--unmerged");
+	if (show_resolve_undo)
+		argv_array_push(&submodules_options, "--resolve-undo");
+	if (show_eol)
+		argv_array_push(&submodules_options, "--eol");
+	if (debug_mode)
+		argv_array_push(&submodules_options, "--debug");
+}
+
 /**
  * Recursively call ls-files on a submodule
  */
@@ -182,6 +222,9 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 
+	/* add supported options */
+	argv_array_pushv(&cp.args, submodules_options.argv);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -567,11 +610,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules)
+		compile_submodule_options(&dir, show_tag);
+
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
+	    (show_deleted || show_others || show_unmerged ||
 	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol || with_tree ||
-	     (line_terminator == '\0')))
+	     with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index b5a53c3..e76fa30 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,18 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files correctly outputs files in submodule with -z' '
+	lf_to_nul >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules -z >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files does not output files not added to a repo' '
 	cat >expect <<-\EOF &&
 	.gitmodules
@@ -86,15 +98,10 @@ test_incompatible_with_recurse_submodules () {
 	"
 }
 
-test_incompatible_with_recurse_submodules -z
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.10.0

