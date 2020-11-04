Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67588C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C37F20782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="KgXKuFPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKDUdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:41 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59AEC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:40 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so13141728qte.11
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LANo81IZbyoQvhS7wIk0r084jTdectz5T+8yX2ILzok=;
        b=KgXKuFPBPZBlU1rs+nd7GQyNHplbgUibTITvxkOIv2U8VjB1AUkvcTJzmUOzhiDKod
         HhTkSWX1rMSOYyCg9AbBpq/oC9qCMqzu2ML5APwCr3WuOqOVSqqX7P6gaDiLH2sIDNIv
         CYV4kgF8Ii/3WBKfv+ibQPjMS3OIzsTJpqJAJSZmR0XMKeOnn87SeIB3seZNDIsUNddQ
         eLkZsy5/IxHFct+w7LU+msNbaZ59yu11GCxDBXUJQXeIJ7ZjHwFaOx889BB7rHEeLspn
         84Cy416HL8RbV4P2uYHQmrt3lIFwxvRXXc1d6OU7BgTB7jJEaJeGyb3irVQU1fgwsHnN
         5hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LANo81IZbyoQvhS7wIk0r084jTdectz5T+8yX2ILzok=;
        b=VcENwdzA+qmrC8GyuyNbf1eFtgsx/UDBkb5wk5jypAGMEHflH5++/sumaicLIp2Dso
         jOy0ZItWSwK7ifYgVX/bMlmiFXy9sFEr0a1Gc80YUzH2pOK8h8SFK2GeBA5MjPt+uLOt
         e1uXArfplCd8EG2RvqwHuHUsgGlV9QJBLk5U5MEuhKYuiIdvAIHZ8Pg9Jj6lThunjaPb
         DwiJpzE0I4PGlFy7BMg8fEit3i+1caENY2JvUsPy56GtdnA0+ozmNB7xTdeslatxH/GG
         e3D7j1oyNgRDrpAPNLOicvvUcjA6F0y23QyASD1/vrCCD/fv2GoSg9zqJQgO4PWVNjnv
         b4Eg==
X-Gm-Message-State: AOAM530kcO/E/rYIv4mZMv93hopJR/ieg4QYncu239lXIXi5IBt3c3h0
        uCDKny0Owq+Q8FSF1o2xp9+Zem/6HZRNEg==
X-Google-Smtp-Source: ABdhPJyqqYHZmxX1PNjzTCIoUThVWsOHAvFRBFV3iXXj/JlUFhxQ8JP+UPLAlQoig92dl8Uo0gVqNQ==
X-Received: by 2002:ac8:594f:: with SMTP id 15mr10418733qtz.347.1604522019497;
        Wed, 04 Nov 2020 12:33:39 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:38 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 02/19] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Wed,  4 Nov 2020 17:33:01 -0300
Message-Id: <fc03417592c25a111fbf77f9e5b9e5468b9070ae.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Separate the attribute gathering from the actual conversion by adding
_ca() variants of the conversion functions. These variants receive a
precomputed 'struct conv_attrs', not relying, thus, on a index state.
They will be used in a future patch adding parallel checkout support,
for two reasons:

- We will already load the conversion attributes in checkout_entry(),
  before conversion, to decide whether a path is eligible for parallel
  checkout. Therefore, it would be wasteful to load them again later,
  for the actual conversion.

- The parallel workers will be responsible for reading, converting and
  writing blobs to the working tree. They won't have access to the main
  process' index state, so they cannot load the attributes. Instead,
  they will receive the preloaded ones and call the _ca() variant of
  the conversion functions. Furthermore, the attributes machinery is
  optimized to handle paths in sequential order, so it's better to leave
  it for the main process, anyway.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: squash, remove one function definition and reword]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 47 ++++++++++++++++++++++++-----------------------
 convert.h | 37 ++++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/convert.c b/convert.c
index f13b001273..ab3d517233 100644
--- a/convert.c
+++ b/convert.c
@@ -1447,7 +1447,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const struct index_state *istate,
+static int convert_to_working_tree_internal(const struct conv_attrs *ca,
 					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing,
@@ -1455,11 +1455,8 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 					    struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
-	struct conv_attrs ca;
-
-	convert_attrs(istate, &ca, path);
 
-	ret |= ident_to_worktree(src, len, dst, ca.ident);
+	ret |= ident_to_worktree(src, len, dst, ca->ident);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1469,49 +1466,53 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 	 * is a smudge or process filter (even if the process filter doesn't
 	 * support smudge).  The filters might expect CRLFs.
 	 */
-	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
-		ret |= crlf_to_worktree(src, len, dst, ca.crlf_action);
+	if ((ca->drv && (ca->drv->smudge || ca->drv->process)) || !normalizing) {
+		ret |= crlf_to_worktree(src, len, dst, ca->crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
 		}
 	}
 
-	ret |= encode_to_worktree(path, src, len, dst, ca.working_tree_encoding);
+	ret |= encode_to_worktree(path, src, len, dst, ca->working_tree_encoding);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
 
 	ret_filter = apply_filter(
-		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, meta, dco);
-	if (!ret_filter && ca.drv && ca.drv->required)
-		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
+		path, src, len, -1, dst, ca->drv, CAP_SMUDGE, meta, dco);
+	if (!ret_filter && ca->drv && ca->drv->required)
+		die(_("%s: smudge filter %s failed"), path, ca->drv->name);
 
 	return ret | ret_filter;
 }
 
-int async_convert_to_working_tree(const struct index_state *istate,
-				  const char *path, const char *src,
-				  size_t len, struct strbuf *dst,
-				  const struct checkout_metadata *meta,
-				  void *dco)
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
 }
 
-int convert_to_working_tree(const struct index_state *istate,
-			    const char *path, const char *src,
-			    size_t len, struct strbuf *dst,
-			    const struct checkout_metadata *meta)
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, NULL);
 }
 
 int renormalize_buffer(const struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL, NULL);
+	struct conv_attrs ca;
+	int ret;
+
+	convert_attrs(istate, &ca, path);
+	ret = convert_to_working_tree_internal(&ca, path, src, len, dst, 1, NULL, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index 5678e99922..a4838b5e5c 100644
--- a/convert.h
+++ b/convert.h
@@ -99,15 +99,34 @@ const char *get_convert_attr_ascii(const struct index_state *istate,
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
 		   struct strbuf *dst, int conv_flags);
-int convert_to_working_tree(const struct index_state *istate,
-			    const char *path, const char *src,
-			    size_t len, struct strbuf *dst,
-			    const struct checkout_metadata *meta);
-int async_convert_to_working_tree(const struct index_state *istate,
-				  const char *path, const char *src,
-				  size_t len, struct strbuf *dst,
-				  const struct checkout_metadata *meta,
-				  void *dco);
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta);
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco);
+static inline int convert_to_working_tree(const struct index_state *istate,
+					  const char *path, const char *src,
+					  size_t len, struct strbuf *dst,
+					  const struct checkout_metadata *meta)
+{
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_ca(&ca, path, src, len, dst, meta);
+}
+static inline int async_convert_to_working_tree(const struct index_state *istate,
+						const char *path, const char *src,
+						size_t len, struct strbuf *dst,
+						const struct checkout_metadata *meta,
+						void *dco)
+{
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return async_convert_to_working_tree_ca(&ca, path, src, len, dst, meta, dco);
+}
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
 int renormalize_buffer(const struct index_state *istate,
-- 
2.28.0

