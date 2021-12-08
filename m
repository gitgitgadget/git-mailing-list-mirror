Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F34C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhLHMiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhLHMiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB12C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so3857804wrb.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxfn007D2gjQgcWCYEZuZmC9qy4tCBUyAcJkasWsuuw=;
        b=RLMSWrTMMPXzRmyONCoRses5xt83KhkNLDh+0Ipr3l6LQC3P8ltx0nEdP1e8TxgNYC
         W8Zezk3kSPfeIj0BwC7tFDOJF2noZ0ZBSNLFbJsYFXS57S1MJcxBwcJK+qXTGtJJskcT
         rBmt0XAFCw1azp79PMSI6iDB1nnbIRGi5wtoqyiqK/tPqN2TmgNryrNMHis0odkDpZVu
         6VpR5ywvfRbGpYvr+4ApxRECXUhshz+GFM6ruosxsaPGpKmrpuTML/35soR62VQcaJlc
         CyzMwMKZE/sn/hS+gsKfIbkBpvf5hJ5z7rjebxZRnaMuS6Vc+SXKWwvNMmAf1SNzydiu
         y4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxfn007D2gjQgcWCYEZuZmC9qy4tCBUyAcJkasWsuuw=;
        b=YNx57aB35/xpIV7ViGtcy83AD+JiCHYeGqOA2NcSSMhRlObaBVkssoiddnvSHlGsKD
         R4yvLncg3omOrh5OX2wkVbrfVtG211F7rU4TvCFFx0GxHT7/Ve9ngVAyZ36CBGUDtJ4F
         PV49+C+sB5MGTkbKMdvVHW4ZkwVg+O4A6TwKRn6OfZfmtPyAs67RO4xV8d4dzpAYVr0Z
         HeFdMeXv5ehaq4IImOZAGFfFXOByS+kv3Onr/lFpuOdtMPcPMtZyY63/Vfqoyz/m5Q+9
         0ZODucDsHFn+HmdCWmrQFMQheNKgtBP5ovGOp3mygCvDu79huQvXf+x749oHsl4nsHGm
         oKyg==
X-Gm-Message-State: AOAM533K9sSH9DWFx9628HF8glp+wvZF5XA9sIWx1ghrWSgTMwBtbC2p
        WfzC0z/KfJTJzVzXbbpgGtUqjjz5LdGfZg==
X-Google-Smtp-Source: ABdhPJyX7ObbGfZEWdaA8kohBh2p3of6cT/K6ssOBXHlUIzibYMuk9LPrUatb0nV3Pa3JLQiL2jo7Q==
X-Received: by 2002:adf:bc89:: with SMTP id g9mr58144937wrh.578.1638966870684;
        Wed, 08 Dec 2021 04:34:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/10] cat-file: move "usage" variable to cmd_cat_file()
Date:   Wed,  8 Dec 2021 13:34:18 +0100
Message-Id: <patch-v4-05.10-32365ff569b-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no benefit to defining this at a distance, and it makes the
code harder to read as you've got to scroll up to see the usage that
corresponds to the options.

In subsequent commits I'll make use of usage_msg_opt(), which will be
quite noisy if I have to use the long "cat_file_usage" variable,
there's no other command being defined in this file, so let's rename
it to just "usage".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1df7f797cb6..6d0f645301b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -618,18 +618,6 @@ static int batch_objects(struct batch_options *opt)
 	return retval;
 }
 
-static const char * const cat_file_usage[] = {
-	N_("git cat-file <type> <object>"),
-	N_("git cat-file (-e | -p) <object>"),
-	N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
-	   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-	   "             [--textconv | --filters]"),
-	N_("git cat-file (--textconv | --filters )\n"
-	   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
-	NULL
-};
-
 static int git_cat_file_config(const char *var, const char *value, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
@@ -664,6 +652,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	struct batch_options batch = {0};
 	int unknown_type = 0;
 
+	const char * const usage[] = {
+		N_("git cat-file <type> <object>"),
+		N_("git cat-file (-e | -p) <object>"),
+		N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
+		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
+		   "             [--textconv | --filters]"),
+		N_("git cat-file (--textconv | --filters )\n"
+		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
+		NULL
+	};
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
 		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
@@ -700,7 +699,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
-	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
@@ -708,35 +707,35 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (batch.enabled) {
 		if (batch.cmdmode != opt || argc)
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 		if (batch.cmdmode && batch.all_objects)
 			die("--batch-all-objects cannot be combined with "
 			    "--textconv nor with --filters");
 	}
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && opt != 'c' && opt != 'w') {
 		error("--path=<path> needs --textconv or --filters");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && batch.enabled) {
 		error("--path=<path> incompatible with --batch");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (batch.buffer_output < 0)
-- 
2.34.1.926.g895e15e0c0c

