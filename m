Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ADAC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D0A61260
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbhIXSjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:39:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:54652 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345615AbhIXSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:39:32 -0400
Received: (qmail 19104 invoked by uid 109); 24 Sep 2021 18:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:37:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11097 invoked by uid 111); 24 Sep 2021 18:37:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:37:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:37:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 08/16] refs-internal.h: move DO_FOR_EACH_* flags next to each
 other
Message-ID: <YU4bBmkszJMyiqta@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are currently two DO_FOR_EACH_* flags, which must not have their
bits overlap. Yet they're defined hundreds of lines apart. Let's move
them next to each other to make it clear that they are related and are a
complete set (which matters if you are adding a new flag and would like
to know what the next available bit is).

Signed-off-by: Jeff King <peff@peff.net>
---
You can probably guess how I found this problem. :)

 refs/refs-internal.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345..7b30910974 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -248,6 +248,14 @@ int refs_rename_ref_available(struct ref_store *refs,
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
+/*
+ * Only include per-worktree refs in a do_for_each_ref*() iteration.
+ * Normally this will be used with a files ref_store, since that's
+ * where all reference backends will presumably store their
+ * per-worktree refs.
+ */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
 /*
  * Reference iterators
  *
@@ -498,14 +506,6 @@ int do_for_each_repo_ref_iterator(struct repository *r,
 				  struct ref_iterator *iter,
 				  each_repo_ref_fn fn, void *cb_data);
 
-/*
- * Only include per-worktree refs in a do_for_each_ref*() iteration.
- * Normally this will be used with a files ref_store, since that's
- * where all reference backends will presumably store their
- * per-worktree refs.
- */
-#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
-
 struct ref_store;
 
 /* refs backends */
-- 
2.33.0.1071.gb37e412355

