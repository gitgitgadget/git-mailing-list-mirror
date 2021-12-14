Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9212C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhLNEJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLNEJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D8C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k9so12504112wrd.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5O7bMp84Jyts8epnhDhcyGVe2LpRReexaYYndBHitCk=;
        b=EiYNNNYoMRs6bAs3Z3+q7In6VQf0nwAm/nxMUEuTy7IHrL9Ir1lpjGQIxSvUA7xHaZ
         AbVTvp9bbC6latiUEKDcDqKSNNiYkeN0JfYnJUWOQ3oj9/dfZHc9H4t/jWhY4kE/5D9V
         GB+JLbZAGi+BAgWGTWouj+86Rf1PBylIUZHLK0uF+++Q9Somv1nN6WVRu6DErA29jqod
         l/2b65+UtpfciJXm0DrOKN5drALRqdPNnzZUPZPSBWOGVGnc0svBqY9VVWs8T+oCF9ec
         tQBxwsjhiGYRpY7013vikxQJhzMQiNvU+1UXW6TvDbZP0BMfRY/q6OvhSEAtosEyTsqQ
         BCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5O7bMp84Jyts8epnhDhcyGVe2LpRReexaYYndBHitCk=;
        b=d2RONYb/2NQsv2CYLgDsMMAZsvJQ/0X0mSJzTUHRp9s0dWSxrfePxvDC5LO/3TrCFN
         y6kmeRva7pnjmGM+qppNXq3fPkAX9s3csNe+Z+P+u4wPhog7bzAlPs6yZSRsnmsbAH74
         DyxTWlSEyh7q4c0WdDzO91Q9OUiQD47xzn7zAshWVPykUP6SuSPSb/SWPG1v04jgqNzq
         5QfldK8BGDNIqjKarLTsXeQpe/5+lXUvB4titfXajGTsFP0WEBuikv62F1ZCpe7eSfcW
         96nTfyZgosXQ1ZFhJZU/lIDsGCa06vkpCIBlvvo5DyUn2wAGP0M2E1vhtIW7W/sDhzb+
         dtyQ==
X-Gm-Message-State: AOAM531ktZJS60pDGCbpcj18u/0Z1c0C5aeahtopTARWhuC/rHk5X5z4
        dnJZWgpM94vD680XlMj8HbblgrCpozA=
X-Google-Smtp-Source: ABdhPJw4imstSEqPC5KVhj/h/b9meaK1dvdVSb+Lx/DAPtZgx3q4UViuUj+OyuxAib3b9E6vMfS5Ow==
X-Received: by 2002:a05:6000:1a43:: with SMTP id t3mr3069589wry.555.1639454953790;
        Mon, 13 Dec 2021 20:09:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm898074wmq.11.2021.12.13.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:13 -0800 (PST)
Message-Id: <814aed2d125b4d5e41b70e731f1475a22bde64db.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:03 +0000
Subject: [PATCH v4 01/10] sparse-checkout: pass use_stdin as a parameter
 instead of as a global
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
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

