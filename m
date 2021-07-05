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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E4DC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D45C613B6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGEMex (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhGEMew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B709C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so18195808otp.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijwD+gT8iEgp1bswAK/Dmr6YWV3KhscvxuZVFSHlW9g=;
        b=XhAQmUY6kcCWGDrh6UWhHUrKhEIlXoY2+yTcmID9y0ZU6t4szfDIlkVgDK1pj6IaJT
         3uxHnBhXzPKfLHoeVNst12YengQWPM7J6FJDiF3VgaQNSf5ajpcsaHIRysin212yHWO+
         UwSWu/BD7bLBIReMpFq3rY9iPtZUiCZ1ytVFpnxDu2JIO1N9U0Ip4gsxL+s6sxOTrHzh
         tpqFZzELcKrjOWky+Bo/QrTP+ruJJLE0D7Gm7tzIg4Hk3Jd9u79VNSDRlqb222/cRd37
         7VcuYfosFIcUB9UuMibmoQWwgJOfAYL4G5Bs4+OZc/rqI5x7FJSuv1bWiv2MfHo25ZxO
         rz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijwD+gT8iEgp1bswAK/Dmr6YWV3KhscvxuZVFSHlW9g=;
        b=MAtyR742SoZCjhERTcunDtJ+wGhPfdRArsE923dobr47xPBudX+Hy7crdn4T1FYqfX
         5OlJqqwzaA8c0DRQndPW7J1HoM+5okI/Kq8fzDFkpF+gY2ooJIb4C/+L3DTN9MgjPahN
         U9dgKGfK/+D0HkzYvwST5QLqfC1jOAXLFBmhuM+xTxoLqKKmchWU/nc7J6o0S+1+XuEq
         MKZB2wNn6lfbYszVUu5IjtCc8zLxqzS3tnp/6e6gZCT7inpZLD+0t4evETNAjR2PvmSx
         fJB8b4nls+Hlgm0wv8UpyWPBkwxpNbCVYm3WXkRScBH/BODh6gX8sf3cSghKceZ9v6/w
         P8hQ==
X-Gm-Message-State: AOAM531SMdGhGLIuVR/rK1UaBpIYjNThioj9Qu84MSQ5dEpX7UiHNbXF
        dWEh73WdZho9QsQ0U8pIHN+MbwPdpjF5pA==
X-Google-Smtp-Source: ABdhPJyAwWlLHKg+3Idw95/tWy3ZQ663uWdCg9GEvy5oVMRNebV/cApf78OwnQv+o8YRJISR/0stUQ==
X-Received: by 2002:a9d:4783:: with SMTP id b3mr10741955otf.78.1625488334781;
        Mon, 05 Jul 2021 05:32:14 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 5sm2225715oot.29.2021.07.05.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 02/35] merge: split cmd_merge()
Date:   Mon,  5 Jul 2021 07:31:36 -0500
Message-Id: <20210705123209.1808663-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
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
index 05e631229d..9c944f5f0f 100644
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
@@ -1738,3 +1735,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	free(branch_to_free);
 	return ret;
 }
+
+int cmd_merge(int argc, const char **argv, const char *prefix)
+{
+	return merge_common(argc, argv, prefix, builtin_merge_options, builtin_merge_usage);
+}
-- 
2.32.0.36.g70aac2b1aa

