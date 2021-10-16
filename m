Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04418C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF63961073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhJPJnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbhJPJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFBDC061767
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y3so30851019wrl.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV61pg3p6apTs5MLYcOm15T2lzjSG2WI8P687D6XF70=;
        b=XogMt3IOIABjgqkPtZiFSk2QevZhCo9jUVDtFudYAjjGRTI84IgqoLE+k5BVOnb4Pj
         rJYZi9WWQp7zDDCXcOIJNDcWbZWDhvoKoRUYIkZ3uLZuLroVXiYy5s4C54oggIMYbKW5
         dydxSYj3LIl9y1ujAF/TH119o4Hs+vnO06PdsmIHOHveBDkdmNpMylOrjyJviJcf8ezC
         Y6DEi14+EiwA1tdqZCo+x2IV0W59sEB2umksJdZZ33cz8wajGMn2vkVKl7PVvfzPHOSq
         7X9RzRBBcrrAacX3aRVHIzrdyeVi3S8spvrxr+PPWp1UGQjgRTvhBTCaw4jVOACL6KWr
         dBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV61pg3p6apTs5MLYcOm15T2lzjSG2WI8P687D6XF70=;
        b=VlvwpA5c+A1G9M7CXrCF6AtcC8Ab3wLPHzDiw9oW7UNAWmy5OuGIkpESn+c4n0Qq+Q
         JuIHn+aykcPPOr1FYQSQTXXw06z2+uCn+AeHQKv9KCKh8iUKoRmzajG/5aQ7eGN6SZdM
         ovn8rQA8aYysN4Ftf+HJhJziyy7ZwvZU38zf9up2+0QshBnI+pyL5CGhIKDv6SRK02Yz
         96VVtmt2Fs/tNr+ZaWPeRL8fS3XMUTvxlPvrpswGci/S4/7XbHiR4oxwpCPCic1gmVJJ
         Afx7CNjCtwBGyPma3218LYegXICXHeslhRWihuDDrF9GAZ+uKfsK8az77YOVq6QQuVYc
         7Y3g==
X-Gm-Message-State: AOAM531Xr4D6SjxIVhvAaziiEoijUdMQNbRnot3SrR9Gej3iU7bcu4rZ
        UOfKhxtd4OhAEsZlJfxxBl+O/oZmAA5jHw==
X-Google-Smtp-Source: ABdhPJxKorn9pCjzcGXpG06qDgmneqGtfgPlUZvIY5OIELaesgCyz4vQg+qMtOC+UcWCXgWdebVAmg==
X-Received: by 2002:adf:bbc3:: with SMTP id z3mr21071780wrg.10.1634377185128;
        Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/21] refs API: post-migration API renaming [1/2]
Date:   Sat, 16 Oct 2021 11:39:26 +0200
Message-Id: <patch-v2-20.21-56f855d32b7-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
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
index e90c59539b4..4e06745c97a 100644
--- a/refs.c
+++ b/refs.c
@@ -1669,7 +1669,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-const char *refs_werrres_ref_unsafe(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    struct object_id *oid,
@@ -1766,19 +1766,6 @@ const char *refs_werrres_ref_unsafe(struct ref_store *refs,
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
2.33.1.1338.g20da966911a

