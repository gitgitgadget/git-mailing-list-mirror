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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A393C4332E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AF064F2B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhCQV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhCQV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C4C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so3321150wrd.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k+yspLm/RWGBF4nOoRv16D5B6QfCBOFG70DbofWSpA0=;
        b=oi7GE5wjCSRIGMVwW2TcopKpVAal/O7UCXHAxNHeBtefwXTK3jr06UjtsxPF804Ffs
         lPKqRne3jKXSwXEGzeOpUT8bfxKFrpq1QwfEWgNj0O0TuQilXhZMamegW2jE2JTG7qKc
         iqsj2BBmD3ZeP4UGoNI12GKfeMj6M0Hmq1rz7Y6b6z3iArfVabu+cm53M5bsdDW67Olw
         b76PZL9aTBMv2P0RxLb+7NXlGd8qRgknJ7w4hpXvgLMAgpfRDxMDrX6pboP7upohX9PU
         bhnSzLosAhEIdWt4Wzbs0rZVqCj/cnOzNZla7UxhlierkCfQvG9cFVMOyYD7rUH3vFxH
         xLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k+yspLm/RWGBF4nOoRv16D5B6QfCBOFG70DbofWSpA0=;
        b=lUBtJmy8mZYqnyyOWJQbte3yII4AUw5IjU/w1vEkZcH9v6+nE9zBDDby8ljCkwJMr7
         FGpwsNlzIbhFKDFeRlgGdDa27hDyQY788eCCzSkmzP6XW7SbYfuQ1Iao6tBLd0K6485f
         8yDvTPFqwf12oFAojqgjBJYOSMy5vWP2HOIRjdRVUcHdlPBgeiOiqMj1IUqTbxS2mMq6
         YeP2+wJ0baKFKGEtgt5pOnvrlkpsHpSRLuKGOHMIgW9hNAxg/m7iwrPCqA1MmqIFbacb
         FGrH3eSyKszdtIcpA7E55x0jEarIUXXgxpMUL1bdnBEATo40wPMpEO4jlK96k5cHo90X
         BVGw==
X-Gm-Message-State: AOAM530OX6wdg9NLtsiEfSHdKZaWBhEDiaHvP0eVfLtxKsj9PT0TQW2u
        RuUiGymYi380K00CV4Cx8MYyL7Nciy0=
X-Google-Smtp-Source: ABdhPJxDiIUzjYOAZ6s3W6GQoO62DAC5ItM0aG+OEoowiXQYUZIoyC34ngQLuurt3pXoH7EQIb+nCg==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr6296943wru.366.1616016489225;
        Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm185837wrn.86.2021.03.17.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Message-Id: <c1c9605c1932cab6191f47beb992a15c64ada237.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:56 +0000
Subject: [PATCH v2 04/13] merge-ort: let renormalization change modify/delete
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

