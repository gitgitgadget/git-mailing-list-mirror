Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ADCC388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB3520759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="psMzDqos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgKDUdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:37 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C455C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id a65so18399182qkg.13
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PM/AzyRA8KNE7ZW+WjB1WMcfusap3M5gw014br9AfBo=;
        b=psMzDqosmiRbpQloiOYo7UCGdeCUrslW1TMwd79Ye7kDiWlqx3QY2nJqGXzcFmChLF
         mFOYwv+mtrzWJe+U2O8KDvagLj1DyUF8U6qt5+AZweYSKt7ZXhyK7Xbe+keUkgkHhHc6
         g8m22vNKi3p1knGK4BQoZPESShld5XEI5Ygnfd/n2LJB+W0wGt+XI5q02LG30GQsejz3
         Bab8WUF+bEnMT+VcUd1gBfCcXwoZmyNC//3zr5waB2zCXGiqzq5WbgUfzFoQF+yUTGNV
         vC3YneDlA3B8FgCGhYPzbFId2fVWkhK4NkAuJ5tz6swFQLvV6+Ev4EUvfuWlWTtdeEPg
         zMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PM/AzyRA8KNE7ZW+WjB1WMcfusap3M5gw014br9AfBo=;
        b=X76qtZidUpJN1jYgqxbh9wygOtY0p4POxElY+Ze/fSQfvHxsvGJeGbQEY7vYy48O6c
         Fdz7B2uLjhz5S7B4FO54PaMKlBeyeWYGHF5Fu3a25Ul7E47RHlqQDujCxgplnmSqIl1j
         XhRq725qE6l4oPGruMENtIL47hjJrgbavJ1GtbR3/VZ1eroRCffZADCY6olrqmw4ieN8
         UeFGdb6FLYd2wmT3m8f+VOrK7AGgDR8zArSn+nNOWJMfGmi9rk5CW/PI7y+0Fis5FSfo
         tIVZpnSjnymIARqoB69ne6nVuJjfaqg521V1NCY3ej/sHO35QTKaZjGONv8fMLYiHBHB
         AImQ==
X-Gm-Message-State: AOAM530L/vI+2Fd+fSHBBvdd/uInagyezuVajjiz5GSEz7HYeyTFICs2
        ddDDe5uHJ+RyeT+QRhaJSllNDjTFLAsuZA==
X-Google-Smtp-Source: ABdhPJxVXogyLIlaauooDmsC5JF/Qvtca13aSNjSW4i8wA7cNdvMjIi1jvJe+HgdQXUBmVkU9JBZfQ==
X-Received: by 2002:a37:508:: with SMTP id 8mr26965830qkf.207.1604522015986;
        Wed, 04 Nov 2020 12:33:35 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:35 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 01/19] convert: make convert_attrs() and convert structs public
Date:   Wed,  4 Nov 2020 17:33:00 -0300
Message-Id: <2726f6dc05c319e2baaf76a05d62426e0695fe65.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
[matheus.bernardino: squash and reword msg]
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
2.28.0

