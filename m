Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63C71FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdFOLdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 07:33:53 -0400
Received: from mout.web.de ([212.227.15.3]:58951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752438AbdFOLdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 07:33:50 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEmbK-1daH901H8E-00G4vD; Thu, 15
 Jun 2017 13:33:44 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] checkout: don't write merge results into the object database
Message-ID: <b46827a5-2a8f-c343-ac1f-814fc8a16943@web.de>
Date:   Thu, 15 Jun 2017 13:33:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/7C9+G1ItxszvgVgm9mk51ZvGaM3m3+J9Z2fl/4lrpmMmTh98I1
 veQxmVLRo6h3fHomPecJ9AXrRZDiS8shMfLtu6hdsg7rUu3rPfQbr3gEFfk7IS4aP9PirNg
 j5lkB7AMF/2Ji3D0J128IPuY9I3Gc0lKmme/m20m9DsxWjYio0hohsqKIiRFO92YHM+/wqR
 ZREhPZt5W8jv2q1n5A0zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/iD4dfqJb2Y=:yvXdywguxcWKZwfEtMo0Ag
 s3cWE8DtI4fMV6mE7ZuxSvTTEIk6YL3UpiwdJO0J9KyXgZKVsuU1VEMFqSmJiYtnTacav7bvz
 SmPgtf3LoaMTISp+mCzQueyuJjakk1K4xHvBiL6oZLCCblvIcjEzpXZevZ2aKkctRv/HVaA3R
 /qgLiHNU7+sr1d4lIaCjy0JcLKvComhu5ij2RoC8v1vgRe+TDbWDd7L3BG2549C0Xq0dsmuA+
 MP2maFl5gXOJaQOQ5F+oZAD7dKSJP0FtQ5MkThhrQqB7xzwL94ZwqaloN743jZ8ck7Pk9vbSu
 /5/X84fU0SBIJCy2v2OEQJf3lmCk9gLXgAHqRcnUPVnRP9wjf6evS67JFl8Iuosuez1cRkIHc
 tVdKjNzQGSsAtG+rO9CXnQVnOdYekzTm0+sXH7eBb5Z+/vim8fRjyKfXJDdPSwiUECTQB06tr
 g99W43Tr1y12pj/7YnGhBQ11j4myEdsfU30jvm4CUoN9ryxPqsOVuFGtER32rOyHfaKAA8VWH
 OaUIjh5zd5gaVoJ8YrIKT6mLNBdiaNgeeMU3YPc1bP7O41keLCQZiCd2neUqvX76y7n6q+Pwu
 8ix2RLwfCmVjHht0fi96wjx3kKLOGgVg8zk89YaK3VFXFDGpxwGOi8WvLWXHkgCWHrq7Qtg4r
 J0xu2Iw1FxbHskEDPYJ8UaZQehVUzo2pgvlXhpKYUDscGOCL3g0o8h+Q282yTxyL6+B8BoqS1
 sa7EWZLW+aoXhHh3X+lgaEjFpDdJjjIMzAkhyhbyMJdIUTSPQdu76n1cn3+e7e/NiR9twsftR
 cgygjgm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Merge results need to be written to the worktree, of course, but we
don't necessarily need object entries for them, especially if they
contain conflict markers.  Use pretend_sha1_file() to create fake
blobs to pass to make_cache_entry() and checkout_entry() instead.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1624eed7e7..f51c15af9f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -215,7 +215,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 
 	/*
 	 * NEEDSWORK:
-	 * There is absolutely no reason to write this as a blob object
+	 * There is absolutely no reason to build a fake blob object
 	 * and create a phony cache entry.  This hack is primarily to get
 	 * to the write_entry() machinery that massages the contents to
 	 * work-tree format and writes out which only allows it for a
@@ -225,8 +225,8 @@ static int checkout_merged(int pos, const struct checkout *state)
 	 * (it also writes the merge result to the object database even
 	 * when it may contain conflicts).
 	 */
-	if (write_sha1_file(result_buf.ptr, result_buf.size,
-			    blob_type, oid.hash))
+	if (pretend_sha1_file(result_buf.ptr, result_buf.size,
+			      OBJ_BLOB, oid.hash))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
 	ce = make_cache_entry(mode, oid.hash, path, 2, 0);
-- 
2.13.0

