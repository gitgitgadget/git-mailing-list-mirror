Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE513C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6352076E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC+ACPnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHSO2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgHSO2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:28:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FEC061342
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so21754635wra.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Nm9NToXXZPc36xOHORm95YmqHPjhog2RFKnTRhYc5Q=;
        b=DC+ACPnKyI/q91t+NgrKTvMuMYhASSLad5Fb5hQ5iaMurjIbklfrm52fk5WQIRfnBS
         bnrB3txpMVSmyuoQrJ7IB4IWOLbxFbrAvLbzdKKO0DuGWDxqQVuqUahdSp6MgLrfyUBr
         JifTGYUIYZUAWfH3vvlquTigWlLY3efcG62gOpZ+nP5fuEKQv8qMLPSwAXmwW0er74j1
         10pe4erOJDtUbvEklZ2+Ca9vMHuLJjszFFlgOdXjgywz5iib3mLcMFx6qzSOdch4RqQS
         nLBa1x2a8Juo9auYhfD6KkPf/5ClMy8FxEL1G4i861dVFsv9psQhL14O0dP1MsHYB3kl
         h7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Nm9NToXXZPc36xOHORm95YmqHPjhog2RFKnTRhYc5Q=;
        b=noi9L3Hi4qwdVHgu44Q/TVngYAg5+yEXR6sgzC3CQgFIwzrwnXQMBjMaycy49jLcX1
         Br483RPq1nmDTydT5iVfq5saNGL044IRk9b1uKYyhpQ3emNRD42MBl3Ko/9DdmCPoTbX
         2aNcDnEBfak71roHjF4+7hQ0nGuFAp6Nk/wo9sv7IyuJJaNDeCaHctzeaPRpQySHEeR5
         3TZDP6iBhXnBiq5fabmShENM1TdG8dLQfWYtnMgMZK3v3rJk/tnqWgaNYgXfMbv+kqM4
         gDlKkXBJQMyhaGyAAwCbYAisiNyEgFzeZrX25qxIvPTCCLqfKJCFjbr1WCR3PXPj4Ppv
         1l1w==
X-Gm-Message-State: AOAM5306Gt6KJxW5iCSY3FbjKDAQdt1mW+Q51tFzY2qNYNaRyizbam0p
        hZL2UygvG+UKsmvF2IIZwriXNUlL3ek=
X-Google-Smtp-Source: ABdhPJxGmFw84il3Gw62gr/ebYzca1eVPafHkYET8Vla+mGl4+CEUTDG6n93UMm3GYGu9n5fSPsS2Q==
X-Received: by 2002:adf:e902:: with SMTP id f2mr24755867wrm.174.1597847283834;
        Wed, 19 Aug 2020 07:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm43211625wrt.80.2020.08.19.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:28:03 -0700 (PDT)
Message-Id: <a3e903e4c0b29a3c37a43b0e76060aa3bb250cfa.1597847278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
        <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:27:58 +0000
Subject: [PATCH v2 4/4] refs: read FETCH_HEAD and MERGE_HEAD generically
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

The FETCH_HEAD and MERGE_HEAD refs must be stored in a file, regardless of the
type of ref backend. This is because they can hold more than just a single ref.

To accomodate them for alternate ref backends, read them from a file generically
in refs_read_raw_ref()

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cf91711968..3ee3afaf41 100644
--- a/refs.c
+++ b/refs.c
@@ -1527,11 +1527,37 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+static int refs_read_special_head(struct ref_store *ref_store,
+				  const char *refname, struct object_id *oid,
+				  struct strbuf *referent, unsigned int *type)
+{
+	struct strbuf full_path = STRBUF_INIT;
+	struct strbuf content = STRBUF_INIT;
+	int result = -1;
+	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
+
+	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
+		goto done;
+
+	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+
+done:
+	strbuf_release(&full_path);
+	strbuf_release(&content);
+	return result;
+}
+
 int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
-	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent, type);
+	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
+		return refs_read_special_head(ref_store, refname, oid, referent,
+					      type);
+	}
+
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type);
 }
 
 /* This function needs to return a meaningful errno on failure */
-- 
gitgitgadget
