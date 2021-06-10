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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05640C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D681B613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFJNAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJNAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:00:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22647C0617A8
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so2193440wri.11
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/GbomKuqk5Dom33iQGel4Kf1HS0OwkV76inPEQSI9nM=;
        b=sgUbSR96JerMUkIExLfgNL9926vG7fCRDKpmUieL3WaBSbKcexWqny2Eie6WGBIMBE
         guUbssICgeOjjVwwXpX5NnL6ZvqTJ8iXGFDPtY2vu6rVry09Flt6wMwNQao5smaj39xd
         vseJXy36+GKBRWbekBU7KmNawASc+4kdDLFJvPu5dQcHKPeSq4NHGaj+qOnZNJ9vWTif
         8B6GTNxKBLNZfYguFSvJe6KSJFSz20OrMkkYixkfIL0dvqNqzvIPTtXqtCrPH/t6txHq
         N/zDgN91CSEmEh+Ti1JTlGui80phk27GdP0+NP0xovcGhZbXXM3U/3iJMIaiAdRPimRx
         qpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/GbomKuqk5Dom33iQGel4Kf1HS0OwkV76inPEQSI9nM=;
        b=lqo3HxIO8VsnOTYpyut63KFCdzZmYhP4EK4B1jD/wfEAG58sf/aKlNcdlxnKL2BhY9
         QmkJ2jBs2VDv3jqj3gtFoAbtMkfe2mvgpv8sf7D0EPbD9uzGiKUcySfU0l3QWaPKag6B
         mwcarYFixEgpEbj6GJ398EeCc0rK/TkRzSkl7WEjMFpqa3pf2fQoWng1H0WWiWfo4gp6
         Af04SbgozHrAM95kgXTd8nsU4tqVu540FzQK5/Km67d2smHfOezBIItwHL27OiOJbwoO
         gIB35QvU/0I7ZXI0TyOus6Y0vh7/BaRaBZDYJ/18hcMXJe8vYCw14rpR9yqSr5MdPucL
         QIrQ==
X-Gm-Message-State: AOAM531+7b3D7YPlDxJEMnd1uLdha35fizIckUIkj8+R0yj9ikW6Mfl4
        POFZR2lZadjN3UhrDSQFZzsCzZbCZho=
X-Google-Smtp-Source: ABdhPJwiNEAkbb+MeiWlrf/R96WZ2DWMfob1qi829RD8tFZvowAXp2SW+ID1HOucLRfn0ARMNOAOHA==
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr5346099wrz.236.1623329874793;
        Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm2876166wmr.42.2021.06.10.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
Message-Id: <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:48 +0000
Subject: [PATCH v2 8/8] refs: explicitly propagate errno from
 refs_read_raw_ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 191cbf5a330f..92c4796078bb 100644
--- a/refs.c
+++ b/refs.c
@@ -1686,11 +1686,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-/* This function needs to return a meaningful errno on failure */
-static const char *
-refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
-				       const char *refname, int resolve_flags,
-				       struct object_id *oid, int *flags)
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -1703,11 +1703,12 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
 		flags = &unused_flags;
 
 	*flags = 0;
+	*failure_errno = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
+			*failure_errno = EINVAL;
 			return NULL;
 		}
 
@@ -1730,6 +1731,8 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
 				      &read_flags, &read_failure)) {
 			*flags |= read_flags;
 
+			*failure_errno = read_failure;
+
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
 				return NULL;
@@ -1767,7 +1770,7 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
+				*failure_errno = EINVAL;
 				return NULL;
 			}
 
@@ -1775,7 +1778,7 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
 		}
 	}
 
-	errno = ELOOP;
+	*failure_errno = ELOOP;
 	return NULL;
 }
 
@@ -1783,22 +1786,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
 				    int resolve_flags, struct object_id *oid,
 				    int *flags)
 {
-	const char *result = refs_resolve_ref_unsafe_implicit_errno(
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
-	const char *result = refs_resolve_ref_unsafe_implicit_errno(
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
