Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC4C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B6E22B40
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkUE3gQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgGaP1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbgGaP1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1B1C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so25403436wrx.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2mvynDhsDkOUwou6n4B1jVPfJLoekWR9pvFneaLCaFc=;
        b=FkUE3gQ7MtfPCDF6KX7fsuvM+YwJJj/Dnol7ut1Xn50t5cHXNGaIzQDsCcnxUsIJ72
         htr0tH6898k49fNa7Q3s8ZoE8hCkjm3yJsyD9VZIz4pEwvHD6P99VlQZRSY7rSt4l1N6
         rHBkGva8R3DvI4KS93aH9pqMW4Pois615/XnSmx4LRr2M8FvRKpbwP7sRUy22sKpOnCb
         wu5jX93uILu5T/Ot+6IVtZ1J1UBZsn+iDzR/1aFwCtK0bjYaYKD1iMDCwaYCfQBnIfQy
         lGbSrzRyZ4XXULQdv/2XopEiOpqovYz84TXgU10TNbeH23Y0L562z5dilg5FQK0gyL5p
         2CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2mvynDhsDkOUwou6n4B1jVPfJLoekWR9pvFneaLCaFc=;
        b=VQJX+X6AUPeZN3Ok8WCC/i+FxpWaZvLFA0Bhsdu4uun7kkJafAxqGxnYKnuLkew79Z
         wVJ7rHDbC6u+8qo3vFEWPqq/L4JnOq5XpErLLNz9HpaDNDdNuR8BavWmwpBG4By58Ai7
         pkKNmac/d2qkzmnlhZuGjeeitlYAcbxNrLq45sQl5A1GAUaa5XnOaTLVWDDFIzIBxlRg
         4J6AoGQLRCawphXbnqSPecCkuiIKYB4zVRWdaY5npInlJvkTGdDeM6CurSydSa4vco/p
         xXhuNS9BxB3tLRKvXRKYbGMuSXF7vo8C+sx/EEvicsvOVY1tEHhouUHfzrT3liXXaNlo
         uuTA==
X-Gm-Message-State: AOAM5319JDLUzwWIOCR0zS5OrbEhj1nKEt8h9ON2pOR+rYo360Mho5A1
        UAvCnCcfyWxDBPa+HLKErrL/Gkcq
X-Google-Smtp-Source: ABdhPJzGGKTiq+4M0eqkGxux+LFjcuERPIhB0AuZpdEk/XjWDboSp3I4pmZ6WxEpMBnrPAdxjS4rdQ==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr3783373wri.278.1596209249084;
        Fri, 31 Jul 2020 08:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12sm3238864wme.22.2020.07.31.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:28 -0700 (PDT)
Message-Id: <ea8a78374fdd47b3aa022a5d447e5c003a6a9eca.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:06 +0000
Subject: [PATCH v20 10/21] Iteration  over entire ref namespace is iterating
 over "refs/"
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

This changes behavior for in for_each_[raw]ref and
for_each_fullref_in_pattern.

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 ref-filter.c | 7 ++++---
 refs.c       | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f2b078db11..88c82b2cca 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1943,6 +1943,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
+	const char *all = "refs/";
 	int ret;
 
 	if (!filter->match_as_path) {
@@ -1951,7 +1952,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in(all, cb, cb_data, broken);
 	}
 
 	if (filter->ignore_case) {
@@ -1960,12 +1961,12 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in(all, cb, cb_data, broken);
 	}
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in(all, cb, cb_data, broken);
 	}
 
 	find_longest_prefixes(&prefixes, filter->name_patterns);
diff --git a/refs.c b/refs.c
index 5e65e79f24..d4b5397c8f 100644
--- a/refs.c
+++ b/refs.c
@@ -1458,7 +1458,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1518,8 +1518,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

