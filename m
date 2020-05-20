Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87312C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D7C20709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRb/vuUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETRgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C267C061A0F
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so3999269wra.7
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpzLWA6haZQ3c4ORdWtnBLobeJAY2qEE8+ghelo2V0Y=;
        b=CRb/vuUJQxwLnMfaT8kOjqMaCQFghShNG+V6FuX1qLTpeXI05ngtFhbpswsqhoBByR
         Zw1GyYIiZTzCNMnslQU1CAYnQLRd57esZJijdgS/dwJqVD4/JDEipRYzWmG94ZyzuYvv
         jUjqqzoPU8N8YXYRqlCHQrpwjxs1kHMVtu80URaFb4i1Y48fPsDOr8k7qz08WHB8JKs6
         UDNKFWDNokfUKtvWH75T4ONXg03Ncfim0a5HUKEAjOIedTra7TEqkmtuZavhMggfe6o4
         uh4XYMyWKu0SKfIgpnF6P5Uyyxv4y3DY6UhsH0WiOLE++v8dq3Z56VUwV0xU8bmXiU+w
         AnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lpzLWA6haZQ3c4ORdWtnBLobeJAY2qEE8+ghelo2V0Y=;
        b=bY0fdaNA/e8pRfvohUryEA2PU5Xazu5twzzGDMLT0ojR/XKJZ3y7h0ZI5c13lDZMyn
         xjTch3ukkzJdBq71JO+2lSIN/KhuGOGhbPcS0K7DTNsdK3wX9KfRsZznU5ZfaObEfies
         trI09d/WqQXBs21wLcyQ1RAvCoSj7EJznt0j0qf+bBtjYtZOEkDh/j0fmtSkyiQIKw0j
         gcvwsBd+GFCFpzUMg31wPeOwou9wVzQ9KGNjRVvlBG07QJaXOn0zuK1Htve8oVzGNbJH
         GvAQ4JSvo09Y7LeKUlI5kUwxhbaB7IeS5Zr/bYn/vgVH/kgj4L0BNjxrIqZ/AANFlT4K
         lyKQ==
X-Gm-Message-State: AOAM5304yxkKJ9hB4d7vpW8Q0vzh+CSYpE61H14KwakY3lTq9X26T7EO
        FXNzeYGXjjxiruGNyjr9ZCbN1AIo
X-Google-Smtp-Source: ABdhPJyI2W0SkC3yDA3TSEv0K4JluW0EzQGn5ovHSVeGF292/RRfXw8lhRDwQMkiCrv69c/0trG7tA==
X-Received: by 2002:adf:a153:: with SMTP id r19mr2789576wrr.285.1589996174790;
        Wed, 20 May 2020 10:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm3561829wrg.84.2020.05.20.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:14 -0700 (PDT)
Message-Id: <15ec202d79cc62dc0a026fbffc41bc6681a50985.1589996173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com>
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:07 +0000
Subject: [PATCH 1/6] refs.h: clarify reflog iteration order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index a92d2c74c83..e010f8aec28 100644
--- a/refs.h
+++ b/refs.h
@@ -432,19 +432,35 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/*
+ * Callback to process a reflog entry found by the iteration functions (see
+ * below)
+ */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate over reflog entries in the log for `refname`. */
+
+/* oldest entry first */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
+
+/* youngest entry first */
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/*
+ * Iterate over reflog entries in the log for `refname` in the main ref store.
+ */
+
+/* oldest entry first */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
+
+/* youngest entry first */
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
 /*
-- 
gitgitgadget

