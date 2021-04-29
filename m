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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A399C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254CD61139
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhD2PdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbhD2PdE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B4C06138E
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so67398177wrr.2
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ns/C6v70aGGA915pkoG9rhASze7Hid+Pp0Hs8N9wQAI=;
        b=ZXK/L0f+DRKbrB6lDh3sCbyHTfMpU9C7qr7OizB5qsKNMDPdmwdNZTC07g/0cA28Nn
         R63IDD39FEVaU9M+wAnmdzQG4BhMFT4DACFy/y2Inj6zanBvGYJKLABuS4XijnDEu6c2
         0Yx8ERkU9QF38bVTCz75QKCDqqI2VzNt8mJR+dVk0EriLI0Rqry6kJpMARNOnxPTGk7S
         NaIHlg3/s+twgM3W8IFhS7/HAlCsGJ/TRxF+W6AG0bDQ4pXSayrWMjcGHj8Z7Sdg+zd/
         NMbvAyGzKWJd7m2JBUEtWPG50FIB/lFmbRxeuxxKOeEn0eqi+WKgoRzQ7X8fxBvyfH+U
         QQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ns/C6v70aGGA915pkoG9rhASze7Hid+Pp0Hs8N9wQAI=;
        b=mTQAAGAXBqlopTZuAD41xbkCiTzPoK+47pG+pFREXCwr75LBcwONj7MeIjvZgmsX3B
         hl+qFM8o4VyM5ZJUfE3MT3IPJYoasVD4Q+l7+/2wY7YK47FjrZd1j829vxU/6gkhsPFS
         0udhtaADBhjBrr1llduA0OZ1YmfeNuEvLEggSWlg7IFH09t/pq/rcU99oXJvG2rJl/+J
         jpmrYC9kZTW8LX99W8G28fBkQ4t+wadLrPHvavSXba2lF+Cqd9ljGzTrLnX4FvB6Wyv8
         O1NWKc+a6Ttun9PWBV+Qd14r9dG2IShnagaBT/9S4BpqArIm65EEYtXI8ZkJosMsfqwk
         O0CQ==
X-Gm-Message-State: AOAM530hXR6DM5sUQXPlyBnPUCE3Nj58bVxsvyoCiFjEpCzUIGn5Q8Yb
        9kZbFNPueXJp/d2dCuRXVtOtj0cmHtk=
X-Google-Smtp-Source: ABdhPJzY7CLgF0OmppiKgYvbm+ayr+wvE9Jr9uaIcQX9jXgUgyfeRFERNzJv+sIceaqzD4E7uCkLPQ==
X-Received: by 2002:a5d:4b52:: with SMTP id w18mr413458wrs.41.1619710333968;
        Thu, 29 Apr 2021 08:32:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm401487wmq.29.2021.04.29.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:13 -0700 (PDT)
Message-Id: <1bb350ea5d21eacf95426192c89173b502b7e06a.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:06 +0000
Subject: [PATCH 6/8] refs: clear errno return in refs_resolve_ref_unsafe()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is done in a separate commit, to pinpoint the precise cause should there be
regressions in error reporting.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 08f69e2a16f6..6e746cb01f24 100644
--- a/refs.c
+++ b/refs.c
@@ -1685,10 +1685,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid, int *flags)
+static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
+						 const char *refname,
+						 int resolve_flags,
+						 struct object_id *oid,
+						 int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -1777,14 +1778,24 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    int *flags)
+{
+	const char *result = refs_resolve_ref_unsafe_errno(
+		refs, refname, resolve_flags, oid, flags);
+	errno = 0;
+	return result;
+}
+
 const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 					       const char *refname,
 					       int resolve_flags,
 					       struct object_id *oid,
 					       int *flags, int *failure_errno)
 {
-	const char *result = refs_resolve_ref_unsafe(refs, refname,
-						     resolve_flags, oid, flags);
+	const char *result = refs_resolve_ref_unsafe_errno(
+		refs, refname, resolve_flags, oid, flags);
 	*failure_errno = errno;
 	return result;
 }
-- 
gitgitgadget

