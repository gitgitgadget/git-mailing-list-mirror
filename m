Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B743C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197A6233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgLPOvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:51:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D445C0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:03 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n142so22681931qkn.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nA4SBSS7XoEFEnQTziTT1MJOB946dIbf5DNIKUcaDPw=;
        b=mJyYepblFna4yQiRS/KbPsksPqYGGrY8IBjvbfnrIcYR2tC985SJ+BROEdXKT5kggV
         bF56bpapWzdIoeu2bmt9WWFalsaNaZqoOLbY5w4wsaTgdbmHK2T5Vp2vujyC3HcE4lrj
         MGB0SbWWK+L+Oa0TltCC23Jf7t30eLSC9qm+0jmluKkBU4iZ7RsZKJ+UyuEE6UTWWI0I
         7Syc6yC233A1taE7u0WiwoLlyyv/avY1u0TH+c7LwlKKHQ4EPgu7STbtvz5eYPqDThHH
         IauAE3FPSsIQJmT0pGy3ZIoE12DRdNddeblPW2qJ1HIJOoGDBWaVqzBAY4ld9G3E5t2A
         RPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nA4SBSS7XoEFEnQTziTT1MJOB946dIbf5DNIKUcaDPw=;
        b=sfVSnYfavBB+RIXuCAEyZ8CnXIgBf3VR/8l25hkJrWUKy66BQ6d+YnTroI8a2vWd5I
         PAzYdWtf+AJJz5Yfd/IfOfUu3kdScQBSyOsmV+1pYaZGIWAbwAvGZ5wmQCa9i1RVdNkd
         RrHhRncI3Tqa+pWo/YhcfuOGUTnKWmutbQRB6Ll0/54kXEV6jIH1prjDccmMz//5Lskz
         02xTeDfo749CLxAVs6ULWKap4wsqOmWLvSwr7d/UG3qzet7fs+tDjnoJn3plfFPQwqOk
         ITkiPpYJsos4N6lyV4gX3dUapj+5GTaSerOeqxuItJnRMaeaVefj9DzF/j7GQ5wDWOuw
         Zz8g==
X-Gm-Message-State: AOAM5330VSDTzkmiZF7QTlREmQ2alK5JZdlSxEUMox2XW/oOY9mPQF0q
        eOIGEdNN2uv3qWfrLlatDfGtvnHHy3+PjQ==
X-Google-Smtp-Source: ABdhPJzOzXJq/e1Wiz3pazZkzlg07UExdNbn72tan2K4AZw9tnN+J/o7QLxxmsHfIBCkt8zHt8/k4w==
X-Received: by 2002:a05:620a:13c6:: with SMTP id g6mr44425308qkl.433.1608130262045;
        Wed, 16 Dec 2020 06:51:02 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:01 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 2/9] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Wed, 16 Dec 2020 11:50:31 -0300
Message-Id: <2d3c1dc0a12df04be83883019d725bd6dbeee1fb.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
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
index f13b001273..0307374241 100644
--- a/convert.c
+++ b/convert.c
@@ -1447,19 +1447,16 @@ void convert_to_git_filter_fd(const struct index_state *istate,
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
@@ -1469,49 +1466,56 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
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
2.29.2

