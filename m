Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C2C433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46BA60E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhJPJmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbhJPJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C44C06176C
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so30850511wrl.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZBSzSS+JAEkX5OFYI+tGaQjHH7ZgkuB4KEiANw1hTU=;
        b=fRsRCSNq8AnWXEINe601WPMzPrOXm6h4+BCPgoeltIB5eJPpOcqGm2UU6GgYVJuST3
         LgzB/u/pb9fHZdqFWFyd5uYPU5a7WSeglKCYSLsOZEkoRypewNc9pYMrg5hxcxPwPy/Q
         r3goYV0Sc6oqT0wGpJmvAUDOJBkop+41H0oJfJwB1v3jpyvG4MOd/RqHYIF0gUfg/XH0
         c1WhuCUm8iv3cSZeOE3jIv43FoMXqZgZEqw/vG+OXnQ4LQ0IbcTQ93nIQGJJwP3VxnEY
         9C4CeifuyoLpVf7x7uN1TWWl9hiN4qRqjhwLneWHfFmNJDbPtYp3qgJMs6CDr/PFcDHP
         J5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZBSzSS+JAEkX5OFYI+tGaQjHH7ZgkuB4KEiANw1hTU=;
        b=T7N4fIXkfc2l2nDSLhbkBBR4ktUFmIMH8+8WnccnQHIh9E44HtIkoGlGRMAiaVCVF1
         /UeVwiRerjCPuDyNFSGAb3AoItUwP8PSkex1wQDn738fBEQc64yt7FFqVQW1rx+byCMp
         d1Y+hRYaTcc+/4nM5opAbQEWZS+zLiEHmYajGnat+/nJITcu+Tv5P1pQoCD8izzJcIR6
         NWYIq6EiQe9+m7XAl1XDwj4wQt0LpLOCjkbxctW+5DaWhdTmPo8fBQbw+tKmkC/YMVQ9
         QqYMNQXTrGH/M4eeExZbjiUPoUx5enO3Up1FB/aHhRMfZOJe7AfP6cz52wLVTCQH3Uqs
         iEPw==
X-Gm-Message-State: AOAM530MiSQ01wSzHeskwkEoTg84/EsuSdAwDpNyK9pI8rlwm5Ra1Gut
        bp4LEqpRZZ5l3JND4oqScwMnyb8TJQMQKQ==
X-Google-Smtp-Source: ABdhPJxASb/CWn0i6Svkt0PmA6e4vorU2s9HGoqNZO6KPjvlBxZmmKdp/tSG7U5ke5kHNZAIrVLB9Q==
X-Received: by 2002:adf:ee8a:: with SMTP id b10mr20937361wro.335.1634377171629;
        Sat, 16 Oct 2021 02:39:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/21] refs API: add a version of refs_resolve_ref_unsafe() with "errno"
Date:   Sat, 16 Oct 2021 11:39:08 +0200
Message-Id: <patch-v2-02.21-f6d784b4979-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
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
index 7f019c2377e..ad56dbb0125 100644
--- a/refs.c
+++ b/refs.c
@@ -1679,17 +1679,19 @@ int refs_read_raw_ref(struct ref_store *ref_store,
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
@@ -1700,7 +1702,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
+			*failure_errno = EINVAL;
 			return NULL;
 		}
 
@@ -1718,9 +1720,12 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -1731,9 +1736,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -1760,7 +1765,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
+				*failure_errno = EINVAL;
 				return NULL;
 			}
 
@@ -1768,10 +1773,23 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
2.33.1.1338.g20da966911a

