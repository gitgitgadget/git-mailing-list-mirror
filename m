Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71FC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD5220738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Q9IpFO9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgJ2CRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgJ2CP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D899EC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so773319qvz.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66zkwNbHD03qTLRBYhQMFq46TKZEM4VBeSWiT5pW1/c=;
        b=Q9IpFO9pBHQzywYsUjc1X/QSfNG7ZZ7hqow7XTcdYhBHUZaGU7gSNZcDJjvvxUEJ21
         9vj53EG+JLXFN7uR1K+b+XbciQbFDiDmtbI9oNe7ak+x27vljGQWvdb3Q9Vxn1CFv4hO
         kchDLQA0gyNGfvL1Nyo7q3lQyCAufuLJLp+JYyNd2o6Yhb4qInqFfd0jXOK4I8vj7qbS
         OA0sF2qvhoj+SO+HaTjGXNE/YphWe55jWeGZXafSgAtb/SdZkvZ41I+WefSHS7e6Wfni
         UMMOFxKOwfvAi9Lx4mOf8aCc/lZuCo/zvJ09YNGi7wmXXbe08Uik0i75J1z0pAdjz3ab
         uc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66zkwNbHD03qTLRBYhQMFq46TKZEM4VBeSWiT5pW1/c=;
        b=ZT2eef0CtnM15RPWiaULPy/JtrYz1oB0c3PJVkIGvWe5A6sFFHFOTUG4LMCtM5616G
         k/y2Ifiu/6unJuwX28M24dlRmXisJfjDfbDFKvuhqZU3fHX7cgMHbjYxMxB9EvBUjvsf
         QIqQPExBmKeP+6HjBG0QntMA0LFc9m9ShOwThhjMUIAQhDr9d8GytfCxkP+t10IWyN98
         FeOdJXBw7OBq1/zVQbGrEqvAu3S+cocui/etioczSuMmryeqVd42QBOCbPpyUdnnkhfY
         IhmSoSdYzm7eGlnuVh3HiBh+TeQfDlFIWCKtgKFHS/YiouWg6bJ7cpduP521v5yl9q3S
         JFkg==
X-Gm-Message-State: AOAM531lycDxdNA3tOgjXSCnG32NcwIqaQ3I9ko1GOqHFMxCCJjOM6He
        rx49qoHK/VE1Z7J2Aj34BVvuYu8dosdfAw==
X-Google-Smtp-Source: ABdhPJxrDs1UsfA6FX9eZxep+17LdqWjo1McRpBEkkM/78CKn3LBo8Y5F4GfZ54uSK+tlrPeba1mGQ==
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr1932855qve.25.1603937725608;
        Wed, 28 Oct 2020 19:15:25 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:24 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 02/19] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Wed, 28 Oct 2020 23:14:39 -0300
Message-Id: <c5fbd1e16d616a4c238d98a35f3671238300c17f.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
 convert.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 convert.h |  9 +++++++++
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index eb14714979..191a42a0ae 100644
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
@@ -1469,24 +1466,24 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
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
@@ -1497,7 +1494,9 @@ int async_convert_to_working_tree(const struct index_state *istate,
 				  const struct checkout_metadata *meta,
 				  void *dco)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, dco);
 }
 
 int convert_to_working_tree(const struct index_state *istate,
@@ -1505,13 +1504,36 @@ int convert_to_working_tree(const struct index_state *istate,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, NULL);
+}
+
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco)
+{
+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
+}
+
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta)
+{
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
index aeb4a1be9a..46d537d1ae 100644
--- a/convert.h
+++ b/convert.h
@@ -100,11 +100,20 @@ int convert_to_working_tree(const struct index_state *istate,
 			    const char *path, const char *src,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta);
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta);
 int async_convert_to_working_tree(const struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  const struct checkout_metadata *meta,
 				  void *dco);
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco);
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
 int renormalize_buffer(const struct index_state *istate,
-- 
2.28.0

