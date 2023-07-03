Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA516EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGCGoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGCGoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B3CE
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:43:59 -0700 (PDT)
Received: (qmail 14008 invoked by uid 109); 3 Jul 2023 06:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2607 invoked by uid 111); 3 Jul 2023 06:44:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:43:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/14] test-ref-store: drop unimplemented reflog-expire
 command
Message-ID: <20230703064358.GA3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reflog-expire command has been unimplemented since it was added in
80f2a6097c (t/helper: add test-ref-store to test ref-store functions,
2017-03-26). This causes -Wunused-parameter to complain, since the
function just calls die() without looking at its arguments.

We could mark these as UNUSED to silence the warning. But let's just
drop the function. It has no callers in the test suite and is not doing
anything useful, beyond perhaps reminding us that it's something we
_could_ be testing.

But since the bulk of the work in adding such tests would be the shell
bits that actually examine the reflog state before and after expiration,
this is not even a useful step in that direction. Somebody who wants to
do that work later can easily add this function back.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-ref-store.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index fb18831ec2..aa900cbfab 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -268,11 +268,6 @@ static int cmd_delete_reflog(struct ref_store *refs, const char **argv)
 	return refs_delete_reflog(refs, refname);
 }
 
-static int cmd_reflog_expire(struct ref_store *refs, const char **argv)
-{
-	die("not supported yet");
-}
-
 static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 {
 	const char *msg = notnull(*argv++, "msg");
@@ -326,7 +321,6 @@ static struct command commands[] = {
 	{ "reflog-exists", cmd_reflog_exists },
 	{ "create-reflog", cmd_create_reflog },
 	{ "delete-reflog", cmd_delete_reflog },
-	{ "reflog-expire", cmd_reflog_expire },
 	/*
 	 * backend transaction functions can't be tested separately
 	 */
-- 
2.41.0.586.g3c0cc15bc7

