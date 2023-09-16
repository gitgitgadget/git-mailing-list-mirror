Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60639C2BA12
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 22:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjIPWMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIPWL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 18:11:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262551B9
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 15:11:50 -0700 (PDT)
Received: (qmail 14128 invoked by uid 109); 16 Sep 2023 22:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 22:11:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16195 invoked by uid 111); 16 Sep 2023 22:11:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 18:11:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 18:11:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/4] merge-ort: lowercase a few error messages
Message-ID: <20230916221146.GA1003640@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
 <20230916060059.GA498798@coredump.intra.peff.net>
 <20230916072909.GA992098@coredump.intra.peff.net>
 <xmqq34zdbxgn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34zdbxgn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2023 at 02:49:12PM -0700, Junio C Hamano wrote:

> > <sigh> This fails CI because with GIT_TEST_MERGE_ALGORITHM=recursive, we
> > run the old merge-recursive code, which uses the capitalized version.
> >
> > I'm inclined to just drop this minor cleanup for now, and we can worry
> > about it later once merge-recursive goes the way of the dodo.
> 
> I wonder if it is just the matter of making matching changes to the
> original error messages in merge-recursive that share the
> capitalized version?

It is, but I didn't want to touch merge-recursive at all if it is
destined for removal. But really, it is not much extra work to do so. So
here's an updated patch.

-- >8 --
Subject: [PATCH] merge-ort: lowercase a few error messages

As noted in CodingGuidelines, error messages should not be capitalized.
Fix up a few of these that were copied verbatim from merge-recursive to
match our modern style.

We'll likewise fix up the matching ones from merge-recursive. We care a
bit less there, since the hope is that it will eventually go away. But
besides being the right thing to do in the meantime, it is necessary for
t6406 to pass both with and without GIT_TEST_MERGE_ALGORITHM set (one of
our CI jobs sets it to "recursive", which will use the merge-recursive.c
code). An alternative would be to use "grep -i" in the test to check
the message, but it's nice for the test suite to be be more exact (we'd
notice if the capitalization fix regressed).

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ort.c           | 4 ++--
 merge-recursive.c     | 4 ++--
 t/t6406-merge-attr.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

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
diff --git a/merge-recursive.c b/merge-recursive.c
index 6a4081bb0f..0d7e57e2df 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1383,12 +1383,12 @@ static int merge_mode_and_contents(struct merge_options *opt,
 						  extra_marker_size);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				ret = err(opt, _("Failed to execute internal merge"));
+				ret = err(opt, _("failed to execute internal merge"));
 
 			if (!ret &&
 			    write_object_file(result_buf.ptr, result_buf.size,
 					      OBJ_BLOB, &result->blob.oid))
-				ret = err(opt, _("Unable to add %s to database"),
+				ret = err(opt, _("unable to add %s to database"),
 					  a->path);
 
 			free(result_buf.ptr);
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
2.42.0.662.g15203389d6

