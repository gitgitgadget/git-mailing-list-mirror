Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34325C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E975D233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLPOvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:51:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5534C0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:59 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id u21so17312760qtw.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puVqJJ5gGLTw+4mFp2qq77BG0nJblqp6ma3R+aZyDKs=;
        b=SyWA7JdJ3Hlmd15g8beuzm1P2n6ycApkiHNwxX6leTNypl8hvkdX4Gh2hH9FqfnXVr
         SlwI172IInOvpTunGuZe9QkbydkIK785O+N8UlW1bZt3l6WfrbydgUjf/CHYqbTv4UtO
         +G2YC6gMEKVrFZxhSfjVGBzA6pMil6lSZQoR9Oa3Ad/DDSyB3/FPggDD6SAKOmIjj51e
         Dhf7peG2p//egZwF3tblRp9oYFcxfljc85QD9qOAsJd9tm1AMIv9Zjdiik28gLtF+sSi
         R8dSQmmMj6719MwrMXKMgrJWi3n/XUGtjU57I2jlLA3/MaAbScpT8QYLnnJkkWhuWvlr
         kjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puVqJJ5gGLTw+4mFp2qq77BG0nJblqp6ma3R+aZyDKs=;
        b=KnIax19fJUtpCpUU20BYRQhTgDoAjpteP28VaSj+EgME0Z0VphZhwScdrrqHyYLU5P
         IH7xYcFKM1U9L0wPg2b0wK+/55jHl75qnhiFhHlt0d3r0ftKqQp/boZQoa+N3g2i7c91
         1TojBOqBe7beEkZ4kSHgmzUieCNwhtbIqxCfniKNjyS2697vyQgELcaDrkJ9QP3vyZJo
         wmrQV/gtAC9+aAzy7zYiMg76WeUJeUdHhw6WTMM2yHKtlILOoAfuUciOPqI/N3CTrG+K
         GNVK/FzIpEVUJ5KYUegcP/PssvZWS9iVKTWUeQsd+t6Pq3YNV/0fbYb6+7An/Qe4co6X
         nXug==
X-Gm-Message-State: AOAM5326rNg//O1OfQ8LAlSG91qMoCX0guO+DryMMu9JjR/LYhiNlE5F
        fkmKEvq67M1V1hEXfddHXnxJIgBdT4qJ6w==
X-Google-Smtp-Source: ABdhPJwE5iKq4XJ/JgeeErAo6nAtc3jQVaxHqAOyNhmlnnrXW5aKMVnh/9KjCQ/4cIoJB8oPHkx5DA==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr44906861qtu.136.1608130258718;
        Wed, 16 Dec 2020 06:50:58 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:50:57 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 1/9] convert: make convert_attrs() and convert structs public
Date:   Wed, 16 Dec 2020 11:50:30 -0300
Message-Id: <fa041852375a8733624b31b20cda1626ff93482e.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move convert_attrs() declaration from convert.c to convert.h, together
with the conv_attrs struct and the crlf_action enum. This function and
the data structures will be used outside convert.c in the upcoming
parallel checkout implementation. Note that crlf_action is renamed to
convert_crlf_action, which is more appropriate for the global namespace.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 35 ++++++++---------------------------
 convert.h | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07..f13b001273 100644
--- a/convert.c
+++ b/convert.c
@@ -24,17 +24,6 @@
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
 
-enum crlf_action {
-	CRLF_UNDEFINED,
-	CRLF_BINARY,
-	CRLF_TEXT,
-	CRLF_TEXT_INPUT,
-	CRLF_TEXT_CRLF,
-	CRLF_AUTO,
-	CRLF_AUTO_INPUT,
-	CRLF_AUTO_CRLF
-};
-
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
 	unsigned nul, lonecr, lonelf, crlf;
@@ -172,7 +161,7 @@ static int text_eol_is_crlf(void)
 	return 0;
 }
 
-static enum eol output_eol(enum crlf_action crlf_action)
+static enum eol output_eol(enum convert_crlf_action crlf_action)
 {
 	switch (crlf_action) {
 	case CRLF_BINARY:
@@ -246,7 +235,7 @@ static int has_crlf_in_index(const struct index_state *istate, const char *path)
 }
 
 static int will_convert_lf_to_crlf(struct text_stat *stats,
-				   enum crlf_action crlf_action)
+				   enum convert_crlf_action crlf_action)
 {
 	if (output_eol(crlf_action) != EOL_CRLF)
 		return 0;
@@ -499,7 +488,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, int conv_flags)
+		       enum convert_crlf_action crlf_action, int conv_flags)
 {
 	struct text_stat stats;
 	char *dst;
@@ -585,8 +574,8 @@ static int crlf_to_git(const struct index_state *istate,
 	return 1;
 }
 
-static int crlf_to_worktree(const char *src, size_t len,
-			    struct strbuf *buf, enum crlf_action crlf_action)
+static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
+			    enum convert_crlf_action crlf_action)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
@@ -1247,7 +1236,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 	return value;
 }
 
-static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
+static enum convert_crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
 
@@ -1297,18 +1286,10 @@ static int git_path_check_ident(struct attr_check_item *check)
 	return !!ATTR_TRUE(value);
 }
 
-struct conv_attrs {
-	struct convert_driver *drv;
-	enum crlf_action attr_action; /* What attr says */
-	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
-	int ident;
-	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
-};
-
 static struct attr_check *check;
 
-static void convert_attrs(const struct index_state *istate,
-			  struct conv_attrs *ca, const char *path)
+void convert_attrs(const struct index_state *istate,
+		   struct conv_attrs *ca, const char *path)
 {
 	struct attr_check_item *ccheck = NULL;
 
diff --git a/convert.h b/convert.h
index e29d1026a6..5678e99922 100644
--- a/convert.h
+++ b/convert.h
@@ -63,6 +63,30 @@ struct checkout_metadata {
 	struct object_id blob;
 };
 
+enum convert_crlf_action {
+	CRLF_UNDEFINED,
+	CRLF_BINARY,
+	CRLF_TEXT,
+	CRLF_TEXT_INPUT,
+	CRLF_TEXT_CRLF,
+	CRLF_AUTO,
+	CRLF_AUTO_INPUT,
+	CRLF_AUTO_CRLF
+};
+
+struct convert_driver;
+
+struct conv_attrs {
+	struct convert_driver *drv;
+	enum convert_crlf_action attr_action; /* What attr says */
+	enum convert_crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
+	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
+};
+
+void convert_attrs(const struct index_state *istate,
+		   struct conv_attrs *ca, const char *path);
+
 extern enum eol core_eol;
 extern char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(const struct index_state *istate,
-- 
2.29.2

