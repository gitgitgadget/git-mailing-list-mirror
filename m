Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25645C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiJRBFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJRBFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:05:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF56857FA
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:05:29 -0700 (PDT)
Received: (qmail 28784 invoked by uid 109); 18 Oct 2022 01:05:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:05:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13457 invoked by uid 111); 18 Oct 2022 01:05:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:05:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:05:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/12] object-file: mark unused parameters in hash_unknown
 functions
Message-ID: <Y0372DFS6hG3jwof@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 0'th entry of our hash_algos array fills out the virtual methods
with a series of functions which simply BUG(). This is the right thing
to do, since the point is to catch use of an invalid algo parameter, but
we need to annotate them to appease -Wunused-parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5e30960234..957790098f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -140,27 +140,32 @@ static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	oid->algo = GIT_HASH_SHA256;
 }
 
-static void git_hash_unknown_init(git_hash_ctx *ctx)
+static void git_hash_unknown_init(git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to init unknown hash");
 }
 
-static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+static void git_hash_unknown_clone(git_hash_ctx *dst UNUSED,
+				   const git_hash_ctx *src UNUSED)
 {
 	BUG("trying to clone unknown hash");
 }
 
-static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
+static void git_hash_unknown_update(git_hash_ctx *ctx UNUSED,
+				    const void *data UNUSED,
+				    size_t len UNUSED)
 {
 	BUG("trying to update unknown hash");
 }
 
-static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
+static void git_hash_unknown_final(unsigned char *hash UNUSED,
+				   git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to finalize unknown hash");
 }
 
-static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
+				       git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to finalize unknown hash");
 }
-- 
2.38.0.371.g300879f34e

