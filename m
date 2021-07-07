Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D5DC07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F066761CBE
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGGTKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhGGTKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF85C061764
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so14011244wmq.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cfBVhUna2lbjAsrA3JNI32sKNpt3u/ybL18YS4VeEvg=;
        b=qO2bSnZ7FS9y5qfn07yp3ghCtfS8fBN72dKWaMjd7zEve5tbuhdMsQkiI5kwN8yDkr
         pCHscGWxyUrSSSAAmnsI+MpUgSkbAwN+p85rF/B26ugL2ve2mNxQn+CA7zX4W/D3ZmZK
         pQzPHogkFyN1XmvXOzUMGEycJ42FG3cAXXpgxVmNuOHFpLGGTsIoIv8XQshgnTBKvtcr
         CHZqVZCjacAlfXjr6v8wuoaGAcbBe/80xeg1aB0OFAa+l4XOby57ebDMpGmO2Ejtct1u
         742NGGjOBjdsbT0KRteNF06buYziMkpbgJDQHOxfm9Kq7W3k4PDonDcSW+U9E6boBsn6
         +Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cfBVhUna2lbjAsrA3JNI32sKNpt3u/ybL18YS4VeEvg=;
        b=aeLccGmwSBzhvlQFXD6CsXDhj9AdkBCcZf3wLVKZnn7O4F9T26ZPr/bCsLDIiOcTI2
         YRIimCG8sBuRjvbQ56qkfKZr9RPPSzokla+Zd/gWUVU2GmXZcJH8WgsD9clJNvQoYriJ
         fSZWvgY8HFG3pU+p4jFV14mBQ5SyRmPhZlnbj0hCr9qLuIL5Y25FfN5L6Negn5Rux/7k
         PkobmvZ/RpSocoCCVTvBITRIzEl4hvgAf+8MH5uXlk6TlRfxpJtmFCgmvQaTmXUgcAw7
         Xsjp2uGPIO49PCdiZXm3QGm7duVqQsD+w2TxY4HAzQ9tXXGuQdpWmVDigSOiQcXdsqCq
         TI6A==
X-Gm-Message-State: AOAM5302kqcJpEIMvj8mIBhArFHLRupuCKz4TPPulYlqtZIrGo0oc3yw
        /HLM1xIn4BbKoO2nWvMh8b6f2nJgZ04=
X-Google-Smtp-Source: ABdhPJwTodhw0dVCiezvYsJ2Z/Au20JGgvxJzu0jQ4Cn7zTYjF8+aB3imEy1xfhR+rtj7uBMWawhyw==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr28495614wmg.76.1625684874320;
        Wed, 07 Jul 2021 12:07:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm18081403wrs.39.2021.07.07.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:54 -0700 (PDT)
Message-Id: <6918c214d1b41b16c47625f0935389440253ec4c.1625684869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:48 +0000
Subject: [PATCH v5 5/6] refs: explicitly return failure_errno from
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
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               |  8 +++++---
 refs/files-backend.c | 14 ++++++++++----
 refs/refs-internal.h |  6 ++++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index de3826f60c9..96df78a9509 100644
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
@@ -1681,7 +1683,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	*failure_errno = 0;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f38c9703504..7aafdf2ce3d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -455,9 +455,14 @@ stat_ref:
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type);
-
+	ret = parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
+	errno = *failure_errno;
 out:
+	/*
+	 * Many system calls in this function can fail with ENOTDIR/EISDIR, and
+	 * we want to collect all of them, so simply copy the error out from
+	 * errno.
+	 */
 	*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
@@ -465,7 +470,8 @@ out:
 }
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type)
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -484,7 +490,7 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
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

