Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEECD37B5
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 06:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbjIPGBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 02:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjIPGBK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 02:01:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04A1BEE
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 23:01:01 -0700 (PDT)
Received: (qmail 1598 invoked by uid 109); 16 Sep 2023 06:01:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 06:01:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9142 invoked by uid 111); 16 Sep 2023 06:01:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 02:01:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 02:00:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/4] merge-ort: lowercase a few error messages
Message-ID: <20230916060059.GA498798@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 05:34:09AM -0400, Jeff King wrote:

> A few small cleanups for merge-ort collected from playing with
> -Wunused-parameter. The first one actually fixes a user-visible bug, and
> the rest are just cleanups.
> 
>   [1/4]: merge-ort: drop custom err() function
>   [2/4]: merge-ort: stop passing "opt" to read_oid_strbuf()
>   [3/4]: merge-ort: drop unused parameters from detect_and_process_renames()
>   [4/4]: merge-ort: drop unused "opt" parameter from merge_check_renames_reusable()

Here's one more clean-up on top. I hesitated on this for the initial
send just because I didn't know if we might want to switch these error
messages to path_msg(), which does capitalize sometimes. But Elijah's
response convinced me that we should just leave them in place, in which
case it makes sense to do a minimal style fixup.

Junio, this is on top of what you've queued in
jk/ort-unused-parameter-cleanups.

-- >8 --
Subject: [PATCH] merge-ort: lowercase a few error messages

As noted in CodingGuidelines, error messages should not be capitalized.
Fix up a few of these that were copied verbatim from merge-recursive to
match our modern style.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ort.c           | 4 ++--
 t/t6406-merge-attr.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3953c9f745..7857ce9fbd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2105,12 +2105,12 @@ static int handle_content_merge(struct merge_options *opt,
 					  &result_buf);
 
 		if ((merge_status < 0) || !result_buf.ptr)
-			ret = error(_("Failed to execute internal merge"));
+			ret = error(_("failed to execute internal merge"));
 
 		if (!ret &&
 		    write_object_file(result_buf.ptr, result_buf.size,
 				      OBJ_BLOB, &result->oid))
-			ret = error(_("Unable to add %s to database"), path);
+			ret = error(_("unable to add %s to database"), path);
 
 		free(result_buf.ptr);
 		if (ret)
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 05ad13b23e..72f8c1722f 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -180,7 +180,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
 	test_must_fail git merge main 2>err &&
-	grep "^error: Failed to execute internal merge" err &&
+	grep "^error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
-- 
2.42.0.661.g2507eb519e

