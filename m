Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F76C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CE5206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="i63hEBYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgHJVef (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:34 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1DC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:34 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id a19so5013811qvy.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40sUyRu1dFi+4Bq4gLlKro3POd6437kVSlHaHPlTBaE=;
        b=i63hEBYBZCSNtBZAYWL5rMIRhDMT0XP1ofxP4Xmpx/Z36TIDMJ1HGDe2DoDR9dKkui
         lxiwrws61Ra0FUGVddWdnFkoF0nzFgTEbacpU8hZaDhM/4RzCsm+LL5zkTC7QxYRMGjZ
         j5nfwAeXBUbw5Zv/BuAuscTFU6S5orVcl5M+irXzYauShoF7QCNbymJTbmRTWFmBE2US
         C5oUtY6dhcRpT6hOkTwGrdVqSqcWHqCMWl+lFSc+gSR/GOSA3tUTtROlZTQJIA24i1ZD
         SuZaF+oIQiJKfpHa5daIuGnoqDMGvK3LffKkOK85Uu5Kz3z/hk3wKrZNlho50vaoyFKu
         DPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40sUyRu1dFi+4Bq4gLlKro3POd6437kVSlHaHPlTBaE=;
        b=GD+1UkxQM5sEzgySHBmMIA8OMk9OT4FZ/GIIYHlSZ/ZfcinDcp+e74Fg7AzPyVX3cO
         VwhQzGSZJk+id7QL+Z08JaxEd6qg5DTihoL17OLGwsPQcPYEGvJXq7DxWPnNDBRH2Sjb
         T+5ZAMg6lkFTpu65P+xrLZu5TP86tMXDeCO2x8sBfZhppptYrXtkX1dLMZpKpGvoWyFe
         Jnd/jNHkRfGfrWgDxPlS3GZcl2duUK0sUfRl5BoFoKV+YLcPOfh4h598htDRtslPtoKG
         NbeQNWwUt7qxLsxGSPtJpDSjuFGTq1Ru2ijxINTp7ZFIidJW1YYOW6aTmJ/r6yBBYP8K
         oslA==
X-Gm-Message-State: AOAM533LWaBorI699mlC8WBwVjuSHl4sJnJWv53fmx8Dc7nh6JIQJgw+
        5K5GkP/fLD7NJIJoTIfJvBY1cMwmNQA=
X-Google-Smtp-Source: ABdhPJwhOjcfnBwxETIm3/CeM8lWJKtkxvuI1FrFtUaQqr5cVuohiPrvVDB8nb6U9WxE39YxJM52gw==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr30878883qve.158.1597095273416;
        Mon, 10 Aug 2020 14:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:32 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC PATCH 02/21] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Mon, 10 Aug 2020 18:33:10 -0300
Message-Id: <b5cef40e2ac256b9001d3bf74e2122cbb4cbd375.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

[matheus.bernardino: squash, remove one function definition and reword]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 convert.h |  9 +++++++++
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index 9710d770dc..757dc2585c 100644
--- a/convert.c
+++ b/convert.c
@@ -1450,7 +1450,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const struct index_state *istate,
+static int convert_to_working_tree_internal(const struct conv_attrs *ca,
 					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing,
@@ -1458,11 +1458,8 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
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
@@ -1472,24 +1469,24 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
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
@@ -1500,7 +1497,9 @@ int async_convert_to_working_tree(const struct index_state *istate,
 				  const struct checkout_metadata *meta,
 				  void *dco)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, dco);
 }
 
 int convert_to_working_tree(const struct index_state *istate,
@@ -1508,13 +1507,36 @@ int convert_to_working_tree(const struct index_state *istate,
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
2.27.0

