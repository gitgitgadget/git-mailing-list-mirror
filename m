Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1BC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CFA619A9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCWOVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhCWOU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A4C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y2so12556837qtw.13
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XeZ2/dOOH2e1H7LrW9YirBFZV9NINSOgSh+1C3VxPw=;
        b=YffQ4TIjKmug4ijEQVb9tSwgOQJ7rNXDiaZQbT2iKeX0mmBviRWGmkcr6FnrAbf4+J
         DsxovUmVLxlargn0NMaCncxrqjqrC/JxaqIn9nj16pchHumLGbbg3rHkzIeDPfB9EIoZ
         cEmH674s2SoUEgC9shbVRVTVz/aPbTNibjExh1WISVSx7sADqDUyzri9EL8xENYHX9en
         aHHfcBiqr9ECw4VL3O+5L/5Rxwd8BHbLtVmIocboXvcBCywMvSIkirv6BGq542RUEaZZ
         qSO5sVrCcf3JWMdDYKGI2DvQ0MAdVirVab9MICSxeNsbC2BX/Q82ZgmXCzsSQR2MrfAQ
         VWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XeZ2/dOOH2e1H7LrW9YirBFZV9NINSOgSh+1C3VxPw=;
        b=kru59sYkxdyxhEql4BJI1febf63bOF58yWG3qeMfTj3ysD9rsUE3cG42zY+eIxBC10
         Uo3+0v69IIaAM467h834Dk6EvL5kyI5Vm6xP8ZsBWwMeTG1ToITYA3We9hJDzqYLaG7d
         dl4GaFsOe1iVQJueH5Buu7BGDpH/goN9PHv14s2Kic99AADKRywXBrBkC4qxoe0JGV9d
         EP9D5XpQZNuvxcShGMfmOHiYG45gRzkc3so19z1qnMm+1Z+2GXjKddd1wEPk41tX07fz
         QH/OPSAWzWknU33o96XYlVdkmP+vUfWdrKrgLkC0sDMYHT2F7tbIlf7GzBQ/78JDQdM4
         fBig==
X-Gm-Message-State: AOAM533JFLJWi3PBYqvv05CaUEXAlIK1xY563KjlsLZPIosJ/L+WX7oh
        TAK+SOhckJC5ZrMPXrKYfOR+kxO9RO45/Q==
X-Google-Smtp-Source: ABdhPJzukAqzTz5vQzB1WrEKQjw23LLK2i0lDYNocqi7olNGeSRbPcQXJa4StQUqegdiI1y3SN/HXQ==
X-Received: by 2002:ac8:4755:: with SMTP id k21mr4565641qtp.102.1616509227414;
        Tue, 23 Mar 2021 07:20:27 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 2/9] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Tue, 23 Mar 2021 11:19:29 -0300
Message-Id: <91d1a3063b05de58eeecfdf1f7bb7931974156b3.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Separate the attribute gathering from the actual conversion by adding
_ca() variants of the conversion functions. These variants receive a
precomputed 'struct conv_attrs', not relying, thus, on an index state.
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
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 60 +++++++++++++++++++++++++++++--------------------------
 convert.h | 37 +++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/convert.c b/convert.c
index d0a1a4ad9b..f2be014af8 100644
--- a/convert.c
+++ b/convert.c
@@ -1446,19 +1446,16 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const struct index_state *istate,
-					    const char *path, const char *src,
-					    size_t len, struct strbuf *dst,
-					    int normalizing,
-					    const struct checkout_metadata *meta,
-					    struct delayed_checkout *dco)
+static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
+					       const char *path, const char *src,
+					       size_t len, struct strbuf *dst,
+					       int normalizing,
+					       const struct checkout_metadata *meta,
+					       struct delayed_checkout *dco)
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
@@ -1468,49 +1465,56 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
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
+	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
+						   meta, dco);
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
+	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
+						   meta, NULL);
 }
 
 int renormalize_buffer(const struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL, NULL);
+	struct conv_attrs ca;
+	int ret;
+
+	convert_attrs(istate, &ca, path);
+	ret = convert_to_working_tree_ca_internal(&ca, path, src, len, dst, 1,
+						  NULL, NULL);
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
2.30.1

