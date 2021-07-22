Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B9C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAFC608FE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGUX2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGUX2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55001C0613D3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso3762955otq.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvPhGN/LXQPgBTsBvQjl4UYAK5fBO4DCjawb/Hqt+pE=;
        b=r8hbPELTKfhH9dspBCfzZhlD8o5ARzEb43RbXNEKBKxfvSAcUBTBiERMKDewzbQp93
         wIVCyhaCN2bLZOJybLGIJ+/19T863UdtD7h+BBWuoEju7UHl3AEgZjAiHFsBwtHNFvfi
         9D9+gNZDSVZr/aljQshBDHFpjBQKXUiUhSxt5duqJKXslaqwPyeT+vs0jrWxnnxZZ4sk
         wuUQIld/qFXQPomU954QxRso1RCnzA1CmqWWiUbPioaJRb8at345aY67fxMayHx9uoz7
         50KJoUSUnM25DPCbjYziw0mPoNEy2tBJnMjut4bBJTGNZOSIj5YvNSwvmHMnzwqOaFKA
         vYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvPhGN/LXQPgBTsBvQjl4UYAK5fBO4DCjawb/Hqt+pE=;
        b=Nyg47tldI1UR/Mo61MZXbdjnPyROuxfQ5TZ24O+V6POrabSCzCAI9yeX9kFRnq7PbN
         GYNF8SOsy+LiTMnhaWI8OOXPhCUpIgBMB0jn/gN/ryaiSVEz9fgHQZvC1spj9WnbaIf5
         yGCMVLs7zap1YmATqLPivIaGrLy32axECeb66WUJUPRuV1WdzVMZ5wcCeILVtswwe7fE
         S5HKnID+98pbSE6D4igPtURhSMtnTAICMS7gsxA4pW1PYojoXALurCPAwy731HtLd3TO
         08+7txCkN7rEbB1qd+hBEsYcZXF9zKgAVZaOX+h4NdYYmFUvRSWjF4Lx1QBv31bMCnWl
         p6Eg==
X-Gm-Message-State: AOAM532pDclHNvfzOErTzuLadWU19FrWVfXlX7TPH8+A0S9zDAvIqRlE
        l7oH7t+Py0DxwzLtB4uwA93GhbSL1h4dyw==
X-Google-Smtp-Source: ABdhPJzx4URVgdRCZVURjp7CNehACSbhRFVrazOSr6ZZ5Ur9Nc4uEvrch40Y9BBNBN7ui60no0WcrQ==
X-Received: by 2002:a05:6830:1b6b:: with SMTP id d11mr27096895ote.234.1626912545535;
        Wed, 21 Jul 2021 17:09:05 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j30sm5036350otc.43.2021.07.21.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] merge: split cmd_merge()
Date:   Wed, 21 Jul 2021 19:08:51 -0500
Message-Id: <20210722000854.1899129-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to re-use most of cmd_merge() for a new command.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 56a526f42c..2770dabf22 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1259,7 +1259,8 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	return is_throwaway_tag;
 }
 
-int cmd_merge(int argc, const char **argv, const char *prefix)
+static int merge_common(int argc, const char **argv, const char *prefix,
+	const struct option *options, const char * const usage[])
 {
 	struct object_id result_tree, stash, head_oid;
 	struct commit *head_commit;
@@ -1273,7 +1274,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	int orig_argc = argc;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_merge_usage, builtin_merge_options);
+		usage_with_options(usage, options);
 
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
@@ -1299,8 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (branch_mergeoptions)
 		parse_branch_merge_options(branch_mergeoptions);
-	argc = parse_options(argc, argv, prefix, builtin_merge_options,
-			builtin_merge_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (shortlog_len < 0)
 		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
 
@@ -1314,7 +1314,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (orig_argc != 2)
 			usage_msg_opt(_("--abort expects no arguments"),
-			      builtin_merge_usage, builtin_merge_options);
+				usage, options);
 
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
@@ -1336,8 +1336,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (quit_current_merge) {
 		if (orig_argc != 2)
 			usage_msg_opt(_("--quit expects no arguments"),
-				      builtin_merge_usage,
-				      builtin_merge_options);
+				usage, options);
 
 		remove_merge_branch_state(the_repository);
 		goto done;
@@ -1349,7 +1348,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (orig_argc != 2)
 			usage_msg_opt(_("--continue expects no arguments"),
-			      builtin_merge_usage, builtin_merge_options);
+				usage, options);
 
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
@@ -1416,8 +1415,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+		usage_with_options(usage, options);
 
 	if (!head_commit) {
 		/*
@@ -1458,8 +1456,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				      argc, argv, &merge_msg);
 
 	if (!head_commit || !argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+		usage_with_options(usage, options);
 
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
@@ -1740,3 +1737,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	free(branch_to_free);
 	return ret;
 }
+
+int cmd_merge(int argc, const char **argv, const char *prefix)
+{
+	return merge_common(argc, argv, prefix, builtin_merge_options, builtin_merge_usage);
+}
-- 
2.32.0.40.gb9b36f9b52

