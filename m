Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F887C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FB2603E5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhKLWXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWXs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C358C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z200so8957372wmc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2k1WT5QbVyExei9pXjdL4v8SwAww5Py18CwHzhbVsg=;
        b=kkLstaxXCahqfU7cTWVM3V6j2Ff/wb7k1QqgoVwpw73iMeaLKpA6HgUcjVtBCnIPZe
         SBwUdRxzExXl3VQqBDZJf6a30QGYGNN6BRYs3uOAiYQ54AXTCKrn4uE0/zz2MkGFr675
         /45psih5tRUct+y9/XXlzuvvODOfcIjcL2++G6pEYoGvpPfbZJQ4UTVP2sYDBvJazJiU
         FsOLQcZ6yRu1okL9xMwnvPB/dFC+RwrdB/fTYQNSnf2BQNdpC494pOlNNasOCIXIcrsF
         aXQl8cszzsCHV3FvSKbKITiYrMqshhCnGGaP8A6tnZgniTzRmyrIcXpGEJO4t14JLfE0
         UqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2k1WT5QbVyExei9pXjdL4v8SwAww5Py18CwHzhbVsg=;
        b=RuIssb6rX7FS3U5eaR2deJnWk/KyMn0FqTg3etJXovVWBThsN8FLIIezYDG54A/1/T
         RDikm7ikVuP24yGVswMeUt16d62R+JOOKKYr55K7Q6WKkqcKDnkeSMw2HSmxqtzWh+q5
         W43D/0EmQnuK2gR4GmmFTtjz9Ow6jJMNY503OnBMiBBGjAYYi9i81dcFqiE3ZHd+25gE
         X4m2V+mnIG3RLAV5Z5aighhHxoQ2DNTgvds3AddZleOLYzGAMDQn3WJ9R7heVgg92WAm
         m8jgGi8RbYQDYYEPrZuTnmKvDUfJOaoM3f6/oTOapf6o+LoCGGvJ3EMk+7QNYM1a8LTe
         4IpQ==
X-Gm-Message-State: AOAM530EiPgc0NlgOOmUGfveHIv+70a/w/5LYO4/HMuCaX4AGPee1ca5
        4KTYlDlFgaHHWHt++ZR1Ibf9TEVCx2slhw==
X-Google-Smtp-Source: ABdhPJywJkhWvpCrl/kyw9ugbLSWEuSdH/ZdeM+4DMMMldI5xxTo6lgscrkJcTSJ1AL3k8UjEpUYkw==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr20511675wmq.111.1636755655583;
        Fri, 12 Nov 2021 14:20:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] cat-file: move "usage" variable to cmd_cat_file()
Date:   Fri, 12 Nov 2021 23:20:03 +0100
Message-Id: <patch-v2-05.10-664c5db634e-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

