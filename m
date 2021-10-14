Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB3C43217
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4EE6113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJNAJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhJNAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:09:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45903C061767
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i12so13777752wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkYrxre2dnsOXLTpy002kGSMxv8nM7qfZ/JSb0vU+ss=;
        b=YVXIS0GtU99Vu0wbUJp5X2kIXna5aXkCFW4YC/crajndf2itYTV7xjdH1EpRSR9s4Z
         8bIGnjBK6zjUlaRX40iZ2AIB2Sk4KFFdA9M3aW0JWu9twSgkgImWP5DMHek1OGHpEks+
         BA9GnAMkQ6GQtsqVMbM3XQZIJnNIeIL/m2htO79bZb2NFy4AoAPYLGxXGfX2Z/Pxti4v
         fzEtc3sXAnE7AdFaxMtLCoXlveMUP1jNFJZQeSlCrtxsrZG6FxxUOu9A+RFnh1MsMSDC
         ZewGanMaUJ+8JCRQJ3uHPD3EA3Si2gCbnh81WHs1k6xSDaSfy6LvjkEyCuZC0CiI10OM
         NMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkYrxre2dnsOXLTpy002kGSMxv8nM7qfZ/JSb0vU+ss=;
        b=py7rFcvYSxSz0IAfH8pzs+1XymSVihzt2IiERhy/+TC73LmBfPQBHb77EW+a2a2UYY
         liwbKKY0+u074zNBqMUmzwzUw/TStH+GXpgXOVnGKIxAtsMQxUBn5UgjIlVL5tMEhCiH
         gqR4Y0aeisnHZ8PFwOiPgcuLNuNqyFunRTqFX8t1ySNV4kLaz10Ktbd9ZNd4bcLcQPfq
         4i1oZm6T570BkF8GyYfoOmOSwUoo4rM7CPhMFTrEE5in8It522x5XtvBRABzXWmj8kiT
         KmaHii9p4uxWxSGobCPZJj1IuFCRd8XUNUc5uJ5J8JOyTkk0wam8J326YY4zR48ToD0w
         CeAQ==
X-Gm-Message-State: AOAM532RticAnGfnusQ1bQyzpvpxRQQ4RkU68eN9QcLH6XE5wNLmJso9
        iaNb2jXK3uf7cL8jBCyIXQF6nR1W1azNOw==
X-Google-Smtp-Source: ABdhPJyalaPuZgujLLw1udLal7UXq46aWQtac0fC91n3lyaigIhNJzU++ufXXqeCWPzwkTa11vFPmg==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr2688250wrs.262.1634170008628;
        Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/20] refs API: post-migration API renaming [1/2]
Date:   Thu, 14 Oct 2021 02:06:31 +0200
Message-Id: <patch-19.20-4c80b05bf1d-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits all callers of refs_resolve_ref_unsafe() were
migrated to the transitory refs_werrres_ref_unsafe() function.

As a first step in getting rid of it let's remove the old function
from the public API (it went unused in a preceding commit).

We then provide both a coccinelle rule to do the rename, and a macro
to avoid breaking the existing callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/refs.pending.cocci |  5 +++++
 refs.c                                | 15 +--------------
 refs.h                                | 22 +++++++++-------------
 3 files changed, 15 insertions(+), 27 deletions(-)
 create mode 100644 contrib/coccinelle/refs.pending.cocci

diff --git a/contrib/coccinelle/refs.pending.cocci b/contrib/coccinelle/refs.pending.cocci
new file mode 100644
index 00000000000..b33cb8a12aa
--- /dev/null
+++ b/contrib/coccinelle/refs.pending.cocci
@@ -0,0 +1,5 @@
+@@
+expression refs, refname, resolve_flags, oid, flags, failure_errno;
+@@
+- refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
++ refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
diff --git a/refs.c b/refs.c
index 9aa41b55c7b..a19f156b66a 100644
--- a/refs.c
+++ b/refs.c
@@ -1668,7 +1668,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-const char *refs_werrres_ref_unsafe(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    struct object_id *oid,
@@ -1765,19 +1765,6 @@ const char *refs_werrres_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
-				    int resolve_flags, struct object_id *oid,
-				    int *flags)
-{
-	int failure_errno = 0;
-	const char *refn;
-	refn = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
-				       oid, flags, &failure_errno);
-	if (!refn)
-		errno = failure_errno;
-	return refn;
-}
-
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index 3938f99c902..d908a161c06 100644
--- a/refs.h
+++ b/refs.h
@@ -11,18 +11,6 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
-/*
- * Callers should not inspect "errno" on failure, but rather pass in a
- * "failure_errno" parameter, on failure the "errno" will indicate the
- * type of failure encountered, but not necessarily one that came from
- * a syscall. We might have faked it up.
- */
-const char *refs_werrres_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags, int *failure_errno);
-
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
@@ -70,16 +58,24 @@ const char *refs_werrres_ref_unsafe(struct ref_store *refs,
  * resolved. The function returns NULL for such ref names.
  * Caps and underscores refers to the special refs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
+ *
+ * Callers should not inspect "errno" on failure, but rather pass in a
+ * "failure_errno" parameter, on failure the "errno" will indicate the
+ * type of failure encountered, but not necessarily one that came from
+ * a syscall. We might have faked it up.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
+#define refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno) \
+	refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    struct object_id *oid,
-				    int *flags);
+				    int *flags, int *failure_errno);
+
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags);
 
-- 
2.33.1.1346.g48288c3c089

