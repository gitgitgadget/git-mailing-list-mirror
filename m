Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3722C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D112071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="MvLU/XSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIVWud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVWud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F46C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so17036427qtj.11
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+M8Jp93lWrJDq5UT7sko6pi28WFvhePCh9ZafQmKs0=;
        b=MvLU/XSc4PYG2Ha21q3bWGdZLiS3UugcdaUPWQ2UdxxFMsHBzjZa9JcHxTov2zoKUb
         3QWq13onYGw34XAPwbasFCOjT7jZYKLDOa8vgA0oi+udSdJSqf5OEBH462NbsydT8Ff8
         2BPAz02Zy2redzrM54/plN7tmmJnExdeE6GyCxA4NXccYe6ER2A6qzqqZwIj2D8F9bM2
         RXibULWTZE9IJCYInzyytYmCq9AzOQ/yqsDZ9pprsHumvpTtwMM0j3N+pDMbWV0FU4X5
         BI8UY+wkdvwm42ifuIuzICVwrMDTEV7bNwN/rVSnPYgpAmapiE+aYB5ivRyyfZ6YNa3C
         ntTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+M8Jp93lWrJDq5UT7sko6pi28WFvhePCh9ZafQmKs0=;
        b=tofaF6rRsXDI/fxu30ilyza7WgBZJ5pKxTOfgR8KiCipbHYP8wxcdbooinjbl6xUTc
         l0o0Gto/y3D6gqZfa5SP+H8cEROPY1M9I/zijNGVfnZDZ0ycbpWlYOhqyPQE1ogvfLlE
         gsWSTRXhmfUxCs9IJUCMRSygPVPvRNwEVf1KMJhWa8P+5furwPGWzd5yCjhrsgpiYxgg
         PwTSiT9LCnsQ+XlbxN5dVGM/m3Z2992qcbs0mZDkR/H6zNUkwofARkwzEQuOsANlmCCL
         webLqhU7yzFQSYFVaecmT8XnWCDndViI+JXGsjP7D4QP6lv9uxpwCPXkjaBVB6x/Cbub
         tmxw==
X-Gm-Message-State: AOAM530pNQa9XwqLNJxFZ1Ig8XsDjY0dBU9PHxs82CexnDtNN7aGr5nX
        wu2fgaxWGLmft9GXgI3vF+Udm/Hg86yb2Q==
X-Google-Smtp-Source: ABdhPJzJOTq20igwcXNF8wCW3EFEN0ax5nEZZeLsVy8WZrwp6NhmLPaj9xdApk53xCMU7Ab9SdujrA==
X-Received: by 2002:ac8:2934:: with SMTP id y49mr2396968qty.202.1600815030476;
        Tue, 22 Sep 2020 15:50:30 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:29 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 01/19] convert: make convert_attrs() and convert structs public
Date:   Tue, 22 Sep 2020 19:49:15 -0300
Message-Id: <b9d2a329d3e9c4ff631d1a43e2af46088dc994ab.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
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
index 8e6c292421..941a845692 100644
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

