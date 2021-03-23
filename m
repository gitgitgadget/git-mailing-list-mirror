Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D77C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A913E619A9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhCWOVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhCWOU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215DC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so14992233qtx.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KP8FuX2CGg2Ar0PYLslZ4LneJHEVXrslFdqU4j7m3eE=;
        b=Si5v5jwkTsRGr2S/Mrf6yxtA1YHwVuhZy1tOVMCGZe0J/ncqw5QjGUyTKzG/OiN6B4
         s2eAk4eKbYzGCRwjGLxNf5Am5HBN7vToQ9Y4Js+T4cWzmP9RAKL5ChE9RyvG9VJ45ITd
         C3S28r7/uCGzAHSvgrlUyBHKftwjjeu6y3yHDIPF/g5SQMks6yGheE5VOg+9lkg8eUub
         m3sHOJI+0KSXOVjr39tyZWwfW6XjnADM2zViVcFR0N+LNr/JjEPo1KdKiNN2RnRQ4YjT
         MAD3fq3zHCs/Je7zK/oBhztv0/pUs9uBqrxAjd2mcgc4FbnngxFL32TYgADjjp8/5UZs
         xSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KP8FuX2CGg2Ar0PYLslZ4LneJHEVXrslFdqU4j7m3eE=;
        b=k7VlpViChFZDZ8Wkwp12zo1bx7i+w0zsO0g/sm0dBWrOnTSm5sg99o7iRxI1+UUcs1
         aOuSpwjRPeEaEPx5JleV8bcdTyDEGSidjiBEJpGlCO2lzo/yNWbhm/vFptw+3PT8H24u
         sKPrV1tpVAW+7taU4ljvMuymjGVbvtFgUuMK6SZSIxcvj6Fmsno7tpSa+jK352FGxqWy
         erXCth5c0orAYJB3OrkrrS+y7ClcpEmjslHGXbdl+Bw+AiKyT0/KkM35MwiMgdS9MACC
         KDMGVA6Ao3oNrYFXPR8nb0jZfRQdv6bjK8sMXB2NpKrbZktf5QRNYlO11z3YQhPU3ani
         HMgw==
X-Gm-Message-State: AOAM533t2fkBAk3EFNGFhPfoOkuxn+Fa/Nf+t9369hW9PiDcbTOrelVX
        QwYp8H9fo01oAK2DHQmrSkSX17S1dskJuw==
X-Google-Smtp-Source: ABdhPJwmlh/wKjwsxZBq8VQBx4yVT3IETJWxLEb2IkEHYwB8i+1t9449RbJMjtfmM8lmsthWtjmcHQ==
X-Received: by 2002:ac8:7b8d:: with SMTP id p13mr4486896qtu.367.1616509225553;
        Tue, 23 Mar 2021 07:20:25 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 1/9] convert: make convert_attrs() and convert structs public
Date:   Tue, 23 Mar 2021 11:19:28 -0300
Message-Id: <5e8a1b6a1cb612dd5012a2d8866f16535e1edbf5.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
index 2d3a5a713c..d0a1a4ad9b 100644
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
2.30.1

