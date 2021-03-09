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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E085C433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5AE652AD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhCIGZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIGYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F4C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so2258868wmj.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/7W4BM4TjzMwevmR71MKrJDU2rtlNSWiwjy3rU5NatI=;
        b=Hf7BwG5f2SeJN+CvnmjAe4oO33cr8Lg+vdZtPHTd9VzLiXfPhF+i+PxZgys6dtZhHp
         +wEvFPeTYm7Ij6J6MMLFA9MVOrTn9V+OIkgKCEhdVtEWTTI3z3Y7SbnaAQxwcGR7zrhG
         bydq+QWnw9rkxxFoT15Bf8R5+ikr6O1tPDM9acLIMLJvszBQWazrBP1PN8SDqB604AF1
         aCWP0+dFtAeJxuvtg8pj9EXVWl6libovUbQqIeWx3r81hEaet8wLWWONfXXpa18ffYUc
         kFjjiikIiq48XXS7W5AXKzrlWerFl1f1UtYBeBrA0h8/1ci1C9M5NCdVPTTlP6DC/jnp
         /v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/7W4BM4TjzMwevmR71MKrJDU2rtlNSWiwjy3rU5NatI=;
        b=GcXPYapZWZAhxtkHYehV9SxsvBNy4UuQ4q5OPA7vpob9jXX58wpjPAf5unpksYuD3M
         l/dE8riHBXuaQ7C9vMsfRS0m9xn0E3DVqUz/jqrQE4QeAKh61VemRvcFDp2fXW9jrSia
         QAc5OFLQ1fQuGshhgRBZRbpLjXP4KtN6rhqzarRKsHzkYsLiJ/MdFkjVtvk+F1Rb/bsN
         GzRTOREGq4JCTmdUqUPwdx2ai8F9LMHlSMZH/gASiGP9EwSQ6bzpow0w51iYEbvaAce1
         y8+tWScpsqkc3QuEzK7Bu44ti2Uj2yHTzyd3PmBF/XaHl61/di4Xnl5YpEnDBy/GJWST
         5bRw==
X-Gm-Message-State: AOAM530X6XfOn7KR0NIXtmZ6A9SPNfHef1TuC7+OSNLFUk3Fjx9P+U+M
        7YUEiJl2ld6Qpks1YtRFOogGsCRZmuY=
X-Google-Smtp-Source: ABdhPJzm++wNuynBDz0eyKrIQV7ogl5QmuwwxhQoBO9NwmS5Pq7C8VRS5VUCtk7sID9oIrLlza+fCg==
X-Received: by 2002:a1c:4382:: with SMTP id q124mr2271352wma.16.1615271090036;
        Mon, 08 Mar 2021 22:24:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm22040661wru.46.2021.03.08.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:49 -0800 (PST)
Message-Id: <7fcabded50166523588177216ab6b8e8973d1905.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:39 +0000
Subject: [PATCH v2 04/10] merge-ort: let renormalization change modify/delete
 into clean delete
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index ea720eb51971..db46f496cb82 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2414,6 +2414,61 @@ static int string_list_df_name_compare(const char *one, const char *two)
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
@@ -3001,8 +3056,13 @@ static void process_entry(struct merge_options *opt,
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

