Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F6820987
	for <e@80x24.org>; Wed, 28 Sep 2016 21:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754517AbcI1Vv2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:51:28 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33162 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbcI1Vv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:51:26 -0400
Received: by mail-pf0-f181.google.com with SMTP id 21so21419092pfy.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XdA0FQ1JZWZm3IpAv50QNE2QqC0gu9Ms6kifnAaxunM=;
        b=Z+f+6oUpkkP8fqYmloJxyqLnNYjxumlS3XTxnqqslOWEgDBg6pfUlJIGgnxKmHo75g
         agz5AtOl+rUwPJ4F3EIXFaV8fz7uppA9r5OqNNkbREXGDhBRBlTooTAzJWG040ltUEqs
         n09RhX90ZEYWO470NCaRUah5k3KLr2jCm1X6WSL/O7J07OzpHniRaJ4JJGrlI4J5oZxy
         sszgerZX3to51pthy+SKcpcZmbBKB94hvYSz1V7NbCylCwmw2Fm8QRbrGiWhHL4gkKc8
         TjEbBo6fTrGgGSiahEgh9C/Syrfr1Bda8nFfS77z1vRDn6+Li2sWlJcTubLRgp6Htkhq
         jP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XdA0FQ1JZWZm3IpAv50QNE2QqC0gu9Ms6kifnAaxunM=;
        b=ga6OGZ4T9BdgbLp1xqVg3P/a507UGBvG3WdKqfYXv/Z53/IirptkeSPeXmf4Mya1dE
         pyzS6fvHV1sNNvog1CDIDNeG7RhETYU+MMOPc0F+n58Cts1KhdBWsbsWRaTUVZbdXoPe
         VjVBpIRuAAHz++gX8YlM+eoo7uk5dvWXx/Ogpnx8wH6wZl63V+T1y4ZqB6M5ccOpU7xo
         YEsLeHzYWFQrd1hNawKuBwP8Rqj7eET7Bo1RAExFEWle2nk7s6zqr9j8GadpSb1+Q84q
         4eyHSjCRBdJFe57aSgThwEEnwOnVOlxuqs0Vb6JFKoVVd30B7qG4aboq0WTddLi9HKwa
         FIQA==
X-Gm-Message-State: AA6/9Rkqg3MYNhrkVm5pfg5XK218tDumkc9vLDsIgwe79p4Ds4HAsF8geQk38IQXRtMiY5j+
X-Received: by 10.98.159.14 with SMTP id g14mr15606924pfe.87.1475099485368;
        Wed, 28 Sep 2016 14:51:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8def:9119:a35:c58b])
        by smtp.gmail.com with ESMTPSA id x9sm14748373pff.19.2016.09.28.14.51.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Sep 2016 14:51:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v5 3/4] ls-files: pass through safe options for --recurse-submodules
Date:   Wed, 28 Sep 2016 14:50:42 -0700
Message-Id: <1475099443-145608-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475099443-145608-1-git-send-email-bmwill@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com>
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
index e0e5cf5..f377e36 100644
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
index 7d225ac..79107d8 100755
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
2.8.0.rc3.226.g39d4020

