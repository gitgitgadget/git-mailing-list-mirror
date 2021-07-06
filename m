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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22591C07E9C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE39D61C6F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhGFS6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhGFS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:58:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B054C061760
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:56:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d2so239879wrn.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bFtXuM/sWnA/8YoiJSWANhxAp8hySBtltE3zBJr8eFM=;
        b=e2OZmdPUlY/bVXJdxtaJXzQ5sFSoHAuWhsX/B0JRFuHGpxrCilduHKH0/QNL2+JWPl
         EbitVrkYm+R9KUttoNdKW1vxloivdqdSc/Qv3sFdaVD81TVmze6j7L8Tg5V9E4KOTHYf
         npvLfgVER2MyYOXyjbhnj6dXOfmcLehf2Xw030NMdCU6vD41+V0kO5Q82jRvkWhEuZob
         BPbqzo8J5ny9awgTS+0KQB5ldYmzqCgXAcrICMB2y9fN0lnLWpCvyQAgewOOzydHApyV
         jQzrv5dLjSoEu+JbALDmqotoABhuNiaclQQ5u9IwPOD4snbp66buK/HAEE2+k0x9RIu1
         Pf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bFtXuM/sWnA/8YoiJSWANhxAp8hySBtltE3zBJr8eFM=;
        b=WE4rdmi9GyKfqbow8VUgT7EihDnjI+pz3azPW8R6TmMK9MeI1TGMzBg0lWwHcpwudq
         dAqGtQPDFxyEJXoCJ1Vsics5r8d4CUd37UqSrEArzUbdGV/DV6ilmWyh3GiFfIFKlHma
         P/OvGKS+hSBtqzSadwYWPOmAdGkbzKEv4q1H9sxq+6e4Nlq+yw9jxnwYrEDJ4ApUVhuT
         y0kyqwD71vFWI2sWu0hcDyFlbpNC7yEbrxiXuUkR/vWoE8W1yeCEZ00342zyB771i5Cz
         wfScASPvfEFjOh5cvgK9i/qbQJ6q6/uAj6bF9XsUNi3RiM0GcFcJOxs6lXSPYw/n4mFA
         N65Q==
X-Gm-Message-State: AOAM532Wo08yRnlWXoi5zi6QG0JPx6FcpqbIw5CzMW1gBM7GN7mfBXqA
        WmdfH0dykvtDoramaxrMMfOeN1Q061w=
X-Google-Smtp-Source: ABdhPJyTVxZaTQXZHPKtTmypTiiOiRXNDm4YvZoD6mlUbwhIRTePpWl7UBAvd6zGo9cIwq8c7N+d5Q==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr23648662wrt.296.1625597761689;
        Tue, 06 Jul 2021 11:56:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm16485194wmh.36.2021.07.06.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:56:01 -0700 (PDT)
Message-Id: <ab147afb38d6e74e0e2fc1fbb83346e6ee32cdd5.1625597757.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:55:56 +0000
Subject: [PATCH v4 5/6] refs: explicitly return failure_errno from
 parse_loose_ref_contents
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The EINVAL error from parse_loose_ref_contents is used in files-backend
to create a custom error message.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               |  8 +++++---
 refs/files-backend.c | 13 +++++++++----
 refs/refs-internal.h |  6 ++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 25d80e544d0..eca7310e7a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1653,7 +1653,8 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
@@ -1663,7 +1664,8 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
 
-	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+	result = parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
 
 done:
 	strbuf_release(&full_path);
@@ -1683,7 +1685,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f38c9703504..b43ec4c66cb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -455,9 +455,13 @@ stat_ref:
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type);
-
+	ret = parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
+	errno = *failure_errno;
 out:
+	/* Collect all types of failures from errno. Many system calls in this
+	 * function can fail with ENOTDIR/EISDIR, and we want to collect all of
+	 * them.
+	 */
 	*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
@@ -465,7 +469,8 @@ out:
 }
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type)
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -484,7 +489,7 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 	if (parse_oid_hex(buf, oid, &p) ||
 	    (*p != '\0' && !isspace(*p))) {
 		*type |= REF_ISBROKEN;
-		errno = EINVAL;
+		*failure_errno = EINVAL;
 		return -1;
 	}
 	return 0;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54f57c6a2df..bf581e70cf6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -689,10 +689,12 @@ struct ref_store {
 };
 
 /*
- * Parse contents of a loose ref file.
+ * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
+ * invalid contents.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type);
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
-- 
gitgitgadget

