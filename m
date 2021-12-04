Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D4C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355656AbhLDUDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352970AbhLDUDu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7CC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so13285973wrp.11
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8baBi+iB5EmUXfaV+i/d7WzegeVzHB95Yq+6OcrJZkE=;
        b=NYAGf0ZQLra/jShPLzZP2bKCTB2iisNt/kTAi6mXCk0xQo9h1jFzJPH1Z92UTo667E
         QKbQ1mp7/+cccAVV5kG+UgaYx8c1pMUJtLxeH5mX4B+1zGitHvqR8A4riJSoE4cWOyRh
         Jzt4+8d6K+9HMzO9rMc1aggHgUp9Fy+kFmUVSqr8jRU6qJxSCTmyMDOR9VvSrEhgwf94
         x5cte2qHFLCIaoRZp4G1pY1lO3t9DiXmz51KdVu2NBDJnOutEkXV0ykZ8UOHlWv2pWVl
         2dwWrzLCFqjsDzEYktAsYev0dLw0vxnnhCjVuIpyDgCy7MiH+JMI607e8EkSE5k7Hn4S
         glvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8baBi+iB5EmUXfaV+i/d7WzegeVzHB95Yq+6OcrJZkE=;
        b=X48MhNwukewz+HyPzhGgAR/kHf1z3psGBVgri/C5W174YLyjd3VvNNiVF2uHuKI800
         Da2ixHT2VnQvAGp/nr6aLTRBTyRiHlUD44X49kf/6CSpgL8l80ojRwrB1UYlCRm9/jU2
         idAFBOKS24ERMxJSTz8sYbZY7c+jMgNEs+KowQFJK6oL9EyTFg8FDlS41SB1pfPKBKRO
         vXwHMlK3O/pOr6Nbf9+HpE5l33uKnSFy3JdJyD0Y/DstOGvPmpUlOfhtty53Rhcu/0gb
         EQVk7ZUL8gnnHGsDhyTfCMyZVsu+jwn1Boj2KW+wAvxagimON1JXD+cnEmhqCMMCgB70
         2RTg==
X-Gm-Message-State: AOAM530DFZ7VXqTO4ZVxHJ1t8Zce8g2pCxHcDVzlG0PD1xZ3Ltx/Q2BM
        qXCb63NPK0r/CPxSWRmchHcbGWNPn64=
X-Google-Smtp-Source: ABdhPJxwF+14GdBXlBLIXO4pTEx42LZCAjaw4IDihVi66CG5cWKE9BIpg6dGrtpZCBfx8Lrza3Tr1g==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr31463761wrx.156.1638648022535;
        Sat, 04 Dec 2021 12:00:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm6431684wrx.60.2021.12.04.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:22 -0800 (PST)
Message-Id: <e41cfe3c1bbf4c26202102782631a614a450ac27.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:15 +0000
Subject: [PATCH 1/6] sparse-checkout: pass use_stdin as a parameter instead of
 as a global
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

add_patterns_from_input() has relied on a global variable,
set_opts.use_stdin, which has been used by both the `set` and `add`
subcommands of sparse-checkout.  Once we introduce an
add_opts.use_stdin, the hardcoding of set_opts.use_stdin will be
incorrect.  Pass the value as function parameter instead to allow us to
make subsequent changes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..8612328e5dd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -525,7 +525,8 @@ static struct sparse_checkout_set_opts {
 } set_opts;
 
 static void add_patterns_from_input(struct pattern_list *pl,
-				    int argc, const char **argv)
+				    int argc, const char **argv,
+				    int use_stdin)
 {
 	int i;
 	if (core_sparse_checkout_cone) {
@@ -535,7 +536,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 		hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
 		pl->use_cone_patterns = 1;
 
-		if (set_opts.use_stdin) {
+		if (use_stdin) {
 			struct strbuf unquoted = STRBUF_INIT;
 			while (!strbuf_getline(&line, stdin)) {
 				if (line.buf[0] == '"') {
@@ -559,7 +560,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 			}
 		}
 	} else {
-		if (set_opts.use_stdin) {
+		if (use_stdin) {
 			struct strbuf line = STRBUF_INIT;
 
 			while (!strbuf_getline(&line, stdin)) {
@@ -580,7 +581,8 @@ enum modify_type {
 };
 
 static void add_patterns_cone_mode(int argc, const char **argv,
-				   struct pattern_list *pl)
+				   struct pattern_list *pl,
+				   int use_stdin)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct pattern_entry *pe;
@@ -588,7 +590,7 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 	struct pattern_list existing;
 	char *sparse_filename = get_sparse_checkout_filename();
 
-	add_patterns_from_input(pl, argc, argv);
+	add_patterns_from_input(pl, argc, argv, use_stdin);
 
 	memset(&existing, 0, sizeof(existing));
 	existing.use_cone_patterns = core_sparse_checkout_cone;
@@ -614,17 +616,19 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 }
 
 static void add_patterns_literal(int argc, const char **argv,
-				 struct pattern_list *pl)
+				 struct pattern_list *pl,
+				 int use_stdin)
 {
 	char *sparse_filename = get_sparse_checkout_filename();
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
 					   pl, NULL, 0))
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
-	add_patterns_from_input(pl, argc, argv);
+	add_patterns_from_input(pl, argc, argv, use_stdin);
 }
 
-static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
+static int modify_pattern_list(int argc, const char **argv, int use_stdin,
+			       enum modify_type m)
 {
 	int result;
 	int changed_config = 0;
@@ -633,13 +637,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, pl);
+			add_patterns_cone_mode(argc, argv, pl, use_stdin);
 		else
-			add_patterns_literal(argc, argv, pl);
+			add_patterns_literal(argc, argv, pl, use_stdin);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(pl, argc, argv);
+		add_patterns_from_input(pl, argc, argv, use_stdin);
 		break;
 	}
 
@@ -675,7 +679,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, m);
+	return modify_pattern_list(argc, argv, set_opts.use_stdin, m);
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-- 
gitgitgadget

