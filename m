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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA3C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F0861441
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhD2PdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhD2PdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45937C061342
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n127so24296541wmb.5
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0JyrnzQZNBv61TfTAVE5NfNsgGDmaT7cbsksCUDIFSU=;
        b=davSZGMdMwkyyAy1mZUxiOdWOH3O/hvo1ywS/8lokaYfPwFW3P9uE6FVyoEaLXgYB6
         9w5Ya1n3fqVK42YoycTQ3+miCUWp5OGQ3CXZfcBI87H3E2D0PV70d3l3HD9bb7ibhsSv
         zlSHL8iTcQdgjBCTveGonkREqLwCebk1opjwg8zldjKn7szPTDK4ZJgX7Wh76oyO24D/
         4538dp7defFj9D35JeSPR2eRlKs3CupNcsJD3emcss4LhSN8JHj77x7By0/bb8auxu/U
         skBgsvLDEcuSmxoT/NO14G2jAwEPQwBPoiG3ocUlnvrfmm261vFRrTV/OoAaX4u3aSPc
         8R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0JyrnzQZNBv61TfTAVE5NfNsgGDmaT7cbsksCUDIFSU=;
        b=My7H6ZJrCOmGOyc8VFSUYt1lkM5Tlr57clfZbJwcvY3o/uW9/Z3BHhGkm11m0JGkNR
         94fmL1uJsuTezytODwq3drWR+CeNso5Obzhw9olpF2haxoShxTUxNOFJuk6ZWu0xGlfX
         e6K/+LYiahG+kzNvBCS2WOJUezhUh8wdyCz3VzU06iMKcLqLjlIl+fSReo2djfXWxZIw
         MePbcWw1ys6vjMEVuenKGZjLqi21jXGl53Mk7U5IHpuG9z9jZEkqAxuko+c4O2ZsF630
         Dy9jxxeCojjHntV1P0dIK+7XDi+J1/4inQuuRr0OQEq8nI2TMQG/ctEWO1Y7QPzOAgCq
         +whQ==
X-Gm-Message-State: AOAM533ZQp1oYUAkoVmV8x9oXjqqMHx7rJbPa85RvTHerVB94Xpg0kyO
        Do30Va/kMH9UzCGfDiXXAZOB+3J1O0M=
X-Google-Smtp-Source: ABdhPJzTbdznUnzO1Jx5DHUaem/PWxxUXJzf47ea4CBnBXAbCrpzR45FNCsRb6Qf/2TYylF82iP/7g==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr667868wmf.178.1619710335042;
        Thu, 29 Apr 2021 08:32:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm6124173wrm.66.2021.04.29.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Message-Id: <9e161eeb5f6b6945499e036e27bd7cb511b336aa.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:08 +0000
Subject: [PATCH 8/8] refs: explicitly propagate errno from refs_read_raw_ref
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

The function refs_resolve_ref_unsafe_with_errno should produce an errno output.
Rather than taking the value from the errno (which might contain garbage
beforehand), explicitly propagate the failure_errno coming out of
refs_read_raw_ref().

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 597e4d1f18f9..a25d18873c56 100644
--- a/refs.c
+++ b/refs.c
@@ -1684,12 +1684,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-/* This function needs to return a meaningful errno on failure */
-static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
-						 const char *refname,
-						 int resolve_flags,
-						 struct object_id *oid,
-						 int *flags)
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -1702,6 +1701,7 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
 		flags = &unused_flags;
 
 	*flags = 0;
+	*failure_errno = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
@@ -1728,6 +1728,8 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
 				      &read_flags, &read_failure)) {
 			*flags |= read_flags;
 
+			*failure_errno = read_failure;
+
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
 				return NULL;
@@ -1779,22 +1781,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
 				    int resolve_flags, struct object_id *oid,
 				    int *flags)
 {
-	const char *result = refs_resolve_ref_unsafe_errno(
-		refs, refname, resolve_flags, oid, flags);
-	errno = 0;
-	return result;
-}
-
-const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
-					       const char *refname,
-					       int resolve_flags,
-					       struct object_id *oid,
-					       int *flags, int *failure_errno)
-{
-	const char *result = refs_resolve_ref_unsafe_errno(
-		refs, refname, resolve_flags, oid, flags);
-	*failure_errno = errno;
-	return result;
+	int ignore;
+	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						  oid, flags, &ignore);
 }
 
 /* backend functions */
-- 
gitgitgadget
