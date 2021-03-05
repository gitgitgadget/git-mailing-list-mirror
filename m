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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE9C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB836500A
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhCEAzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhCEAzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB4C06175F
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so248341wri.3
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2XHT0qtqnB4tNtQ0moq3xlQD5oEUDKqsLTsQNqfCRBk=;
        b=Hez0efFKxol3PEfuAMtSMu0UOEniaU5QI9Oxkn8jsZ1wh8ANUl7pN8FcQOaOp1JbZh
         muSESHKWi4Y3fdEH1qVAUFxZxj7vezt+S+MkZjQL+zV+HHfD/ibd6+JGU1FalYx/2mqk
         Qn1Uxra/WbwDDqAsTnc3UWdzDeQmaDe2CDUWniPE/ZncTW8HYdqi2D5EiyxMfDFhxCXF
         B9J7F+gHw+xtvpqKJPiH/pR0r84kMJIMvJsB9X1CGBtYkEBUkvzR8LPoMsptX/ty7lRt
         aiXvYKrfTbCV/VVMTlrUahU8/rUz2J+ghhTou/+vCpTcBX+YZHnWvyyJWFTQoMIBriT/
         ukZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2XHT0qtqnB4tNtQ0moq3xlQD5oEUDKqsLTsQNqfCRBk=;
        b=Hev4+l0uSH0Ha+hJnmQx8CZQWxEH9K4I0Q/oDf2DopMX2aXQiZaB50tNQfK4cFfShx
         PSEpkiDjBpi1ClleVw2/rs0L+v5zIAdCLJ9LYwVHLec2ZzgN/a5fHNfqndZV7JqGRWIx
         x+kWQJwT/xoqHrZ+WYDH7Cc6qhVxqYg5nXRdYiaelSvFQLJGGkMPCIfyhgft2xjt7ioT
         pgeUzpVm4W38MPozDQxu8wLcEHrUeQD4UPoM55doa1C3T/4igjBBFU1f6CKUWW1nRzBC
         IxrYGQXXc3CBKzP9sRohYNwmO7Ue2lfj4s3sRfmt5rGc940c+ZM9trN877KwB6qO4ru1
         RqJw==
X-Gm-Message-State: AOAM532kmqFQKtbaj+mokKOHDrfPMSUQHtd3BuMd1t71xQ7tcyM3Rmgx
        2DFXTJZY6dM+fCqg1lb/Z2bwBgeBsRk=
X-Google-Smtp-Source: ABdhPJxWeuEBbelUbODEjQJmhQfdpT3Kce0+fLkbnjW8gnx0AN+PhLl2Jbb7DdmNfM5W6kWIL//czw==
X-Received: by 2002:a5d:4e8d:: with SMTP id e13mr6844532wru.251.1614905742091;
        Thu, 04 Mar 2021 16:55:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm1707852wro.15.2021.03.04.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:41 -0800 (PST)
Message-Id: <b70ef4d7000a1d83b1588a9be1e8f4273a382cc7.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:31 +0000
Subject: [PATCH 05/11] merge-ort: let renormalization change modify/delete
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
 merge-ort.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 87c553c0882c..c4bd88b9d3db 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2416,6 +2416,60 @@ static int string_list_df_name_compare(const char *one, const char *two)
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
+	initialize_attr_index(opt);
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
@@ -3003,8 +3057,13 @@ static void process_entry(struct merge_options *opt,
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

