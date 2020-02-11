Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C8C3B187
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8E20675
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGbixXi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgBKPCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:02:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgBKPCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:02:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so3952803wmb.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/CAWFNr6SfcYDyJQWmHDrcDqWWNxIQXMF796aXZJeOY=;
        b=MGbixXi2kFMz6NiM+kxqV7xqbRbmo4CzCHNaIzmpG1Uo+6DnJyX/AbKRmtZeS2Y6kD
         lGY1GSDq+glwrR9UwlsZLTzB3U+fT2NcMxaPyRtb7Q/5B5Gqhzemuma/YJMJOaVuQbnp
         7iwxiam9uoM7CHHsSSLfqHuO4M2Ny7QjS6T6SLPJPi3qQm8TQBy3IXe87BKzmkGvtOcL
         KJZPOobGlw/TlTumpMq7UkaEnd0DFEiNsbf9geTXylW/KRqSNhqvqeSAC7xkxVWoR0OV
         LotQYqb0t0JJ8PKfrbDIYi2yeh49uBIa1+ZcEWLk3bdZEM/Bl4IBeFwdC6czI3VxFB5v
         g9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/CAWFNr6SfcYDyJQWmHDrcDqWWNxIQXMF796aXZJeOY=;
        b=tbWbCiAStitz6VRems2vOQC2ruCgMyleNqKpQG5zzVccn/wwIQhcM0EJ48UzWrchKs
         GwOVTRI+Hi4pZrTdQIAngQ+g+CYWavyxob44ENdJHa1mgNHjnkwyKGA0Qz+BrvK+88Pi
         pU/IWoDKoutTgrfqU5qdAZeAIMJmH6lbazxv+w3u+deW9Ip8oCtCQNLjdpUeCIN8Ngy4
         YGKQPiKrjKCdQHQYwLPAiisspu2q8ZsSX+9dKmlnLorGbAd4xzPx5cY3zXbMIwPjEJNc
         B6KW11eb8WcALy8fImVRWLnYlkCWkWaI+aCMKBuU/yu5B6xFW3jSSMcoho2bPcA7xBn4
         dLNA==
X-Gm-Message-State: APjAAAWgZOMfShx6Lf2ngZ+RUA15ggHpV5IaIEJJytQjLPaLqFFehc/y
        K2+LYr/U9P4kUsLHJMJxkExST0L5
X-Google-Smtp-Source: APXvYqyZCkt9b7oRqPBXOUaPFQV432yCxtM9Sqcsg6E2PWOiFMoZig3RG6AtynvZ2jp9I2+oUcZyGA==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr6306713wml.182.1581433346199;
        Tue, 11 Feb 2020 07:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm5476872wrw.76.2020.02.11.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 07:02:25 -0800 (PST)
Message-Id: <75ee62caa940e7232e0edb50788302f36a08b5b9.1581433344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com>
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 15:02:21 +0000
Subject: [PATCH 1/4] sparse-checkout: extract add_patterns_from_input()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of extending the sparse-checkout builtin with "add"
and "remove" subcommands, extract the code that fills a pattern list
based on the input values. The input changes depending on the
presence of "--stdin" or the value of core.sparseCheckoutCone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c | 64 +++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 7aeb384362..41d8aaf9a2 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -412,36 +412,16 @@ static struct sparse_checkout_set_opts {
 	int use_stdin;
 } set_opts;
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+static void add_patterns_from_input(struct pattern_list *pl,
+				    int argc, const char **argv)
 {
 	int i;
-	struct pattern_list pl;
-	int result;
-	int changed_config = 0;
-
-	static struct option builtin_sparse_checkout_set_options[] = {
-		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
-			 N_("read patterns from standard in")),
-		OPT_END(),
-	};
-
-	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("set sparse-checkout patterns"), NULL, 1, 0);
-
-	memset(&pl, 0, sizeof(pl));
-
-	argc = parse_options(argc, argv, prefix,
-			     builtin_sparse_checkout_set_options,
-			     builtin_sparse_checkout_set_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-
 	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
 
-		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
-		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
-		pl.use_cone_patterns = 1;
+		hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl->use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
 			struct strbuf unquoted = STRBUF_INIT;
@@ -455,7 +435,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 					strbuf_swap(&unquoted, &line);
 				}
 
-				strbuf_to_cone_pattern(&line, &pl);
+				strbuf_to_cone_pattern(&line, pl);
 			}
 
 			strbuf_release(&unquoted);
@@ -463,7 +443,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			for (i = 0; i < argc; i++) {
 				strbuf_setlen(&line, 0);
 				strbuf_addstr(&line, argv[i]);
-				strbuf_to_cone_pattern(&line, &pl);
+				strbuf_to_cone_pattern(&line, pl);
 			}
 		}
 	} else {
@@ -473,13 +453,39 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			while (!strbuf_getline(&line, stdin)) {
 				size_t len;
 				char *buf = strbuf_detach(&line, &len);
-				add_pattern(buf, empty_base, 0, &pl, 0);
+				add_pattern(buf, empty_base, 0, pl, 0);
 			}
 		} else {
 			for (i = 0; i < argc; i++)
-				add_pattern(argv[i], empty_base, 0, &pl, 0);
+				add_pattern(argv[i], empty_base, 0, pl, 0);
 		}
 	}
+}
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+{
+	struct pattern_list pl;
+	int result;
+	int changed_config = 0;
+
+	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("set sparse-checkout patterns"), NULL, 1, 0);
+
+	memset(&pl, 0, sizeof(pl));
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_set_options,
+			     builtin_sparse_checkout_set_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	add_patterns_from_input(&pl, argc, argv);
 
 	if (!core_apply_sparse_checkout) {
 		set_config(MODE_ALL_PATTERNS);
-- 
gitgitgadget

