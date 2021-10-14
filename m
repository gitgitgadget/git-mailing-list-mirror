Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC0C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BC96113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJNAIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNAIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC5C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so13819394wrc.10
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVh4a02a0MZJTqSJLkGG2ikpEvd5JeCFm3gR5JXQWcQ=;
        b=av97jK8uVZwmMlWBMi7xMfQzky+SLzpWJA8CRu8+NS2o0rr+JZZBNpN6YWTGD9h3LL
         a6NficbX9fKGC37l/MS80FPAp9/aMjiZlfGpTde/wo7ApN+CBP/7C7L8HukMoLPuagc/
         O4wVI4J+j3k+sqeRDIUnS8J5jmFGWYzzFCcZLF33aYSEyrWH4vamTOWSMdUARVXfdxCa
         ZJa3jrrK98H/zjH14myHT8p0DtJz/yTDd2Hc886EXab8JQSUHbX9yBpI2QFGHQ1zdttO
         g9D7MYdy5ycAhRTr+cZY+AU5mcTmXJKTQuoZmlzkJxdPTPH7B8TPbE+NzKcsC1hIYf6/
         tqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVh4a02a0MZJTqSJLkGG2ikpEvd5JeCFm3gR5JXQWcQ=;
        b=QVbWN+qiAREt/Yubt7NpxXK3aycLinuSVXw+F2MBC8NkNyk6s85Sf5I0m/QEXo72nM
         7zQHgh0YGv7x9NfZuKoxXW/wIi289IDCgSoLVkUbXiCZb3ReVAVIBBgZ8swiOS2Uvjhu
         +0VByTm3Uuir0kPPSNyQjsEeWdBtgbrar0WLM2tIAP/7NvFVKS+quovO0putmGJRCG0J
         kRrWZd1bg0mWGwkf/gE0sppEkYjXu6VxW6gPgkSDwD2EKpbgqVjD3JCmToRf29KGqR0O
         TTm2+GqGKFFV70uk6nDXBZAXkx7832kxgGKgYw6c2GJoWLNlf4xeC+/RfGHDLOnMyCJY
         KPAQ==
X-Gm-Message-State: AOAM533oyANnVhlk7Jbx+rmXPCQkANUrxNFozGpdxInQ+gz05EhtFRFF
        2leFGA03wLPls9369qkWv5wockdQfuGklA==
X-Google-Smtp-Source: ABdhPJyhmBKT7brKwRJeyAJyh7bXfrpjTsLQPLgKhDbe41YOhKYZaXRkvmcOmHpRDb3QSPiCmF05NA==
X-Received: by 2002:adf:a4ca:: with SMTP id h10mr2742150wrb.28.1634169996084;
        Wed, 13 Oct 2021 17:06:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/20] refs API: add a version of refs_resolve_ref_unsafe() with "errno"
Date:   Thu, 14 Oct 2021 02:06:14 +0200
Message-Id: <patch-02.20-46641111885-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new refs_werrres_ref_unsafe() function, which is like
refs_resolve_ref_unsafe() except that it explicitly saves away the
"errno" to a passed-in parameter, the refs_resolve_ref_unsafe() then
becomes a wrapper for it.

In subsequent commits we'll migrate code over to it, before finally
making "refs_resolve_ref_unsafe()" with an "errno" parameter the
canonical version, so this this function exists only so that we can
incrementally migrate callers, it will be going away in a subsequent
commit.

As the added comment notes has a rather tortured name to be the same
length as "refs_resolve_ref_unsafe", to avoid churn as we won't need
to re-indent the argument lists, similarly the documentation and
structure of it in refs.h is designed to minimize a diff in a
subsequent commit, where that documentation will be added to the new
refs_resolve_ref_unsafe().

At the end of this migration the "meaningful errno" TODO item left in
76d70dc0c63 (refs.c: make resolve_ref_unsafe set errno to something
meaningful on error, 2014-06-20) will be resolved.

As can be seen from the use of refs_read_raw_ref() we'll also need to
convert some functions that the new refs_werrres_ref_unsafe() itself
calls to take this "failure_errno". That will be done in subsequent
commits.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 36 +++++++++++++++++++++++++++---------
 refs.h | 12 ++++++++++++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2166f37399d..46e3c785016 100644
--- a/refs.c
+++ b/refs.c
@@ -1678,17 +1678,19 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 					   type, &errno);
 }
 
-/* This function needs to return a meaningful errno on failure */
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+const char *refs_werrres_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
-				    struct object_id *oid, int *flags)
+				    struct object_id *oid,
+				    int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
 	int symref_count;
 
+	assert(failure_errno);
+
 	if (!oid)
 		oid = &unused_oid;
 	if (!flags)
@@ -1699,7 +1701,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
+			*failure_errno = EINVAL;
 			return NULL;
 		}
 
@@ -1717,9 +1719,12 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
+		errno = 0;
 		if (refs_read_raw_ref(refs, refname,
 				      oid, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
+			if (errno)
+				*failure_errno = errno;
 
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
@@ -1730,9 +1735,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			 * may show errors besides ENOENT if there are
 			 * similarly-named refs.
 			 */
-			if (errno != ENOENT &&
-			    errno != EISDIR &&
-			    errno != ENOTDIR)
+			if (*failure_errno != ENOENT &&
+			    *failure_errno != EISDIR &&
+			    *failure_errno != ENOTDIR)
 				return NULL;
 
 			oidclr(oid);
@@ -1759,7 +1764,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
+				*failure_errno = EINVAL;
 				return NULL;
 			}
 
@@ -1767,10 +1772,23 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		}
 	}
 
-	errno = ELOOP;
+	*failure_errno = ELOOP;
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    int *flags)
+{
+	int failure_errno = 0;
+	const char *refn;
+	refn = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+				       oid, flags, &failure_errno);
+	if (!refn)
+		errno = failure_errno;
+	return refn;
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index d5099d4984e..c8afde6bb50 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,18 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
+/*
+ * Callers should not inspect "errno" on failure, but rather pass in a
+ * "failure_errno" parameter, on failure the "errno" will indicate the
+ * type of failure encountered, but not necessarily one that came from
+ * a syscall. We might have faked it up.
+ */
+const char *refs_werrres_ref_unsafe(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    struct object_id *oid,
+				    int *flags, int *failure_errno);
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
-- 
2.33.1.1346.g48288c3c089

