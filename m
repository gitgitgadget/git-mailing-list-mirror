Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A061C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DA020738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="LM5ncCbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403943AbgJ2CRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgJ2CPW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19BC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b18so865645qkc.9
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Lv3aK8stRDSfcPzJc3HwDuGlPwpS3bnVg+tImaWaOg=;
        b=LM5ncCbBTbPFdnuif1NQzuQycQJY2+eiCnHYo9Qiu4xB7d8lk69ZZCCaiMpf+mQBga
         SVrPQc0VHQoqVDWm/IewnBDpRT9SwQf9YIGW075SaDeWMGU9TmkLgoxd4VbULa67KMC4
         X4XH9avOjWXHrMjVJnJL+NqO32Vqx61gW339wA2WA/ERNupIYzxgLBqURcdqA4jju2Cn
         A9PCZPYoa3pqevOv3zd0PaPZMyOxyxp++unDvZkF4SnBAjopPxbpKAYJzbRi39K/6Q0s
         Q4FHWPEG3rogi/gVwVqZRd71v99xf0Jz9MIs6R1V3I96Mu2bGyq0LByyYutUYe0FKByj
         L/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Lv3aK8stRDSfcPzJc3HwDuGlPwpS3bnVg+tImaWaOg=;
        b=Yslq/aJBfCH/nhqYxYQCussh9t1Xkb7TIMiORDLebzI2wOJt5p4j/iXFv+QJixl0bM
         wMJofHYbHtDQhJqmv03uGCzWbyyo7mbhRT3dgGAI/85hXHD29TTldDp/qsLF9PT5Q/sz
         DxKcECaRt19han8OdT3oI6R+sxXTb72LVss3RB5c0uZmRoSXKNz5OCPF5KptGffBqWh1
         LUsdwbeDjRBf7BEU3lQT58FeRsI3Kh8SyQf1PIknhzHFrq0G7BdxxG8bhRNJ7t8n2ucY
         sn9KK3vGxqH4C+nxqxyaysWYlIY9AitdlhgDuQWbHbfZANkaEToavutYlNDbvUXZrwvj
         PyXw==
X-Gm-Message-State: AOAM530XYCiJt6d24h39sv0yVN/JWhagnOxw2AkC7T7KMAQR8Yaqy6D1
        qLs4rFF5S9tL6tVpbM6TREiDfvMJ2vP9+Q==
X-Google-Smtp-Source: ABdhPJwat8hwfPQv/K25Zpud9NNyTT9AmiI34BxzV6yHnq/ItKHyG1GNLrtkB2mNkbe43zHnTDjTyw==
X-Received: by 2002:a05:620a:c0f:: with SMTP id l15mr1712880qki.494.1603937720977;
        Wed, 28 Oct 2020 19:15:20 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 01/19] convert: make convert_attrs() and convert structs public
Date:   Wed, 28 Oct 2020 23:14:38 -0300
Message-Id: <dfc3e0fd62bcf0223dc51485521116e1aca2ee07.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move convert_attrs() declaration from convert.c to convert.h, together
with the conv_attrs struct and the crlf_action enum. This function and
the data structures will be used outside convert.c in the upcoming
parallel checkout implementation.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: squash and reword msg]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 23 ++---------------------
 convert.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07..eb14714979 100644
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
index e29d1026a6..aeb4a1be9a 100644
--- a/convert.h
+++ b/convert.h
@@ -37,6 +37,27 @@ enum eol {
 #endif
 };
 
+enum crlf_action {
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
+	enum crlf_action attr_action; /* What attr says */
+	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
+	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
+};
+
 enum ce_delay_state {
 	CE_NO_DELAY = 0,
 	CE_CAN_DELAY = 1,
@@ -102,6 +123,9 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 int would_convert_to_git_filter_fd(const struct index_state *istate,
 				   const char *path);
 
+void convert_attrs(const struct index_state *istate,
+		   struct conv_attrs *ca, const char *path);
+
 /*
  * Initialize the checkout metadata with the given values.  Any argument may be
  * NULL if it is not applicable.  The treeish should be a commit if that is
-- 
2.28.0

