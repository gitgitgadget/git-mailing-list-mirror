Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4CC433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhLJD7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhLJD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B71C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so5700094wmd.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5O7bMp84Jyts8epnhDhcyGVe2LpRReexaYYndBHitCk=;
        b=YMz4yxmMySMxHvzv5g+X4UQBlbQD/nwZWu9RzOMPDIb8ol1LPCcb/Ilk3E7vLekJiQ
         z8Bn71RhAB5vmswSAjMA3JlbL7eCYZMMDIDRHjwY4V3+dWeZwKkUUxeKnaSm57ichbyu
         vAnqC6O53af8W3svIPS2X33jYABgyT/REz8yFKktrKgTULfqx3my7X4bL9/SmFRr8bb1
         7K3KAKlHDttHKWuVrxMHwKcGXVPV0GRe81Rj3quP7fnHfrIiaB0/9RUGjMuacm+a5OA3
         YJL0w12e6Era2a/b0I9C+/pUA0ha1hUfDdHQOsfdji7bSYwr0svqmoYBNpH52gXXfzT7
         KBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5O7bMp84Jyts8epnhDhcyGVe2LpRReexaYYndBHitCk=;
        b=aHQe4JuLjL/L+8HQwt+hvxVrAEKlxOkFUZht6JSHh23eZzk6ii3w68Hojtv0z0P5HT
         jCojty3TamFBbuYF0XR26L9ZKhUzaY68BZ9H1y5sRAZb1Ma2OogSMkgp8fpZ1WEsmBCn
         Z6WDwe9rotgRF0v+xObgRl6oQCMgVh/UGBgnQ6iNebXDCSwDu7tpmusMCrZdaf77kjKC
         ZyrjVxrMnW43c3ShVdTqfsjOaVQSsSqS0bGqfzz5X80GwP79Eqm/CLAWXKCReDEizspx
         nKIwG3pvRuH1f21so3QoUOcwdSVWkVRJ3tx67F+px8vZGPx6fRB16HtvJBcjUh28gaLP
         lKRA==
X-Gm-Message-State: AOAM533Tf4gB8HAcl10lt+CJmjSiyAplFWDEZhBP66thEsN3V93Qzp45
        Ufy42RCPfX8rUnAtxBVL1aQHa+2Q85c=
X-Google-Smtp-Source: ABdhPJwUmPaZWJUwIChipReW8cHUw/1s4aeRM9l05v6DE3vfTlOl10VJaSCyCPOHqQ2ZpcavcqMVVw==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr13103295wmq.191.1639108574970;
        Thu, 09 Dec 2021 19:56:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm10405608wmi.36.2021.12.09.19.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:14 -0800 (PST)
Message-Id: <814aed2d125b4d5e41b70e731f1475a22bde64db.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:04 +0000
Subject: [PATCH v3 01/10] sparse-checkout: pass use_stdin as a parameter
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

