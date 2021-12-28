Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDAC43217
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhL1N3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhL1N26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53555C061746
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so38326460wrr.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRRe+1oxaGXPQLLZaNQgDvJAlEXXarXjHIoVUtyIO0k=;
        b=eRZQXvZzCyDz0BhLRTosYshacYHHzLg4WmO93FY8WpkikyoU3MihdWp7AVoTid0aWC
         439sgMsngR6wul7EMS0Odyex6MRuTUNTMRkEQ/kkIZiXTwR1F4TxXbx5DRU5DR/EB2kD
         yVXeZfFKGqcuvqEru7uykMoLcJdtH1VDqCGUNjwuBkRJaL+Upum8cGhB1RqkX1icscRu
         Sef2yFAE4bK0S1eXWt9IgHmGiMpaNA3CVJkmnqZbMkzneIn4bw/OIAh6SBWkSjxJpXL5
         qGPkZckLWvevqJlQME07Ggxfi7HAkU6NcII5JAKhzB4LQEKyvYjKUKjaSEgiz7x6kcM0
         aQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRRe+1oxaGXPQLLZaNQgDvJAlEXXarXjHIoVUtyIO0k=;
        b=2W1W7G9cRsLyqeZP95fGIlTe9el3cvUzL7uFHXZjH9F7DxHMqrK0uSlJyCG5wdhZqj
         zpF3PVB+IANUPR4JPBQguXgD8oW/63NK71EPKKDLokMcxeR2UXOx+tfQRn2cIE/Jeofu
         bPEK2/jWMr/4zR4i+l8Biq0fQluZl1QG1UcTn00xESicD7SLG3zcWswQKIYGazPZPcLm
         EwdUYcbTwrpxA22mR63RMqj+TTW8O2WgVdz3V1OEl/A1wZZkIz6l0upVU/tSmROY70Bu
         OOpd0dVv5ahJ1dmteYHu2a9pTIO4HR6PkhjPFbXos5nU2wakCoLT66P1GR3bIVybsX/g
         AOTA==
X-Gm-Message-State: AOAM530fMS+IojC10nneNNg+8/noODGFhXIytchgx6QaScdcD0pDTwS8
        Gya/O5zdh28EK76O4zIabPnF0AWBUXeo84UQ
X-Google-Smtp-Source: ABdhPJyw3daEGEC7mZWT8TUr0Wn5z3CF++ymAB7OkOn1s9UexcjUunTWkD1ZAetNdrJJTJch7ayjcg==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr17122201wrm.171.1640698136711;
        Tue, 28 Dec 2021 05:28:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/10] cat-file: move "usage" variable to cmd_cat_file()
Date:   Tue, 28 Dec 2021 14:28:45 +0100
Message-Id: <patch-v6-05.10-9573437374a-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
2.34.1.1257.g2af47340c7b

