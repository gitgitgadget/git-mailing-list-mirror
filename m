Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E5C433E3
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F6661986
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCTAEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCTAEB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8BBC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so8132795wml.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k+yspLm/RWGBF4nOoRv16D5B6QfCBOFG70DbofWSpA0=;
        b=qf4snRHsGDEmSs5oT/n5dgGI/RXLQKm695dg/7BFrXMirHTW7Ku/HleVvK06EKxNbZ
         eeQqJrE8Q4NwrsM1tneKTU0OIlBu10rvuP6E5tbB5mphGAdZirYyROqU14ky3hxlpo5S
         O96G+b1+vVu0X7zGyrvqkYSB4J/moiDUwTJVpx6AuaW5GzZ5J1m6RnyNlE0lKCYT0DYB
         2kDFvJTgcfEVhlijegit52ThNXyO7Rdf6nNk0Fq+HdeOOcx0U4uS8lu3pot2S51p2exS
         sG0Qi9Ar7aUH9mfbUFJIcY4QT3k0IoeWmDl0yjPenXZSHGCSpiz0WIgpyG8HZxTtouJa
         Yk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k+yspLm/RWGBF4nOoRv16D5B6QfCBOFG70DbofWSpA0=;
        b=L+swBQWV72CWRFcKHIUEIJbBhBS2XuilyBvx94f/18o2eG0zJsjI9fLkwe0ako0/7e
         zVVNH4n+vwVRc8zx1qNxDbhiOPrJLSAkahXtNYUrcOCjco4RcAoDHCoaU24GnR+lqvf/
         2fUtsoNA/dQpUh2SAbKHh757CrtNJQjL9+ZbWi/xmwAGXBE4ubk8blnxtB6L+DY/jyTM
         6iUsMTc1Xco8/SvpSuDzs2xHKaRCSJaBt5YMBszzP0Erui6Uyg5T799vBpWHn15mIbWl
         e6yyBOdLUIiBZ4hEjcQC+a5Yh0i/6RL7iDepduytu+QxIxkELXrOmQmEsxdJ6Dvo+RMB
         zDdA==
X-Gm-Message-State: AOAM531EbmU/gmRcv2pzroMqLjfkz2kKyI+hFAUlnIimI+5p3Pny+LON
        GvaJWoqWMUBysh62fg/9TL1NriKaDT0=
X-Google-Smtp-Source: ABdhPJzML3AOYoMrCCZGk4+SiVZ6cXkqU04zeV7uEyVOvVchSSkXoI2BZ1ggIjFyYVe9iXrLcjno5w==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr5672465wmq.175.1616198640284;
        Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm10019809wrp.79.2021.03.19.17.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Message-Id: <c1c9605c1932cab6191f47beb992a15c64ada237.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:47 +0000
Subject: [PATCH v3 04/13] merge-ort: let renormalization change modify/delete
 into clean delete
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When we have a modify/delete conflict, but the only change to the
modification is e.g. change of line endings, then if renormalization is
requested then we should be able to recognize such a case as a
not-modified/delete and resolve the conflict automatically.

This fixes t6418.10 under GIT_TEST_MERGE_ALGORITHM=ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index cdc1e2fe7a24..c7083e3769aa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2549,6 +2549,61 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	return onelen - twolen;
 }
 
+static int read_oid_strbuf(struct merge_options *opt,
+			   const struct object_id *oid,
+			   struct strbuf *dst)
+{
+	void *buf;
+	enum object_type type;
+	unsigned long size;
+	buf = read_object_file(oid, &type, &size);
+	if (!buf)
+		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
+	}
+	strbuf_attach(dst, buf, size, size + 1);
+	return 0;
+}
+
+static int blob_unchanged(struct merge_options *opt,
+			  const struct version_info *base,
+			  const struct version_info *side,
+			  const char *path)
+{
+	struct strbuf basebuf = STRBUF_INIT;
+	struct strbuf sidebuf = STRBUF_INIT;
+	int ret = 0; /* assume changed for safety */
+	const struct index_state *idx = &opt->priv->attr_index;
+
+	if (!idx->initialized)
+		initialize_attr_index(opt);
+
+	if (base->mode != side->mode)
+		return 0;
+	if (oideq(&base->oid, &side->oid))
+		return 1;
+
+	if (read_oid_strbuf(opt, &base->oid, &basebuf) ||
+	    read_oid_strbuf(opt, &side->oid, &sidebuf))
+		goto error_return;
+	/*
+	 * Note: binary | is used so that both renormalizations are
+	 * performed.  Comparison can be skipped if both files are
+	 * unchanged since their sha1s have already been compared.
+	 */
+	if (renormalize_buffer(idx, path, basebuf.buf, basebuf.len, &basebuf) |
+	    renormalize_buffer(idx, path, sidebuf.buf, sidebuf.len, &sidebuf))
+		ret = (basebuf.len == sidebuf.len &&
+		       !memcmp(basebuf.buf, sidebuf.buf, basebuf.len));
+
+error_return:
+	strbuf_release(&basebuf);
+	strbuf_release(&sidebuf);
+	return ret;
+}
+
 struct directory_versions {
 	/*
 	 * versions: list of (basename -> version_info)
@@ -3136,8 +3191,13 @@ static void process_entry(struct merge_options *opt,
 		modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
 		delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
 
-		if (ci->path_conflict &&
-		    oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
+		if (opt->renormalize &&
+		    blob_unchanged(opt, &ci->stages[0], &ci->stages[side],
+				   path)) {
+			ci->merged.is_null = 1;
+			ci->merged.clean = 1;
+		} else if (ci->path_conflict &&
+			   oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
 			/*
 			 * This came from a rename/delete; no action to take,
 			 * but avoid printing "modify/delete" conflict notice
-- 
gitgitgadget

