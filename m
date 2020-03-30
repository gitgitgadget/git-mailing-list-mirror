Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C1C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2273A2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC3OEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:04:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727191AbgC3OEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:04:07 -0400
Received: (qmail 15178 invoked by uid 109); 30 Mar 2020 14:04:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:04:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18751 invoked by uid 111); 30 Mar 2020 14:14:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:14:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:04:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] bisect: stop referring to sha1_array
Message-ID: <20200330140406.GE2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our join_sha1_array_hex() function long ago switched to using an
oid_array; let's change the name to match.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 64b579b6ea..d5e830410f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -473,7 +473,7 @@ static void read_bisect_paths(struct argv_array *array)
 	fclose(fp);
 }
 
-static char *join_sha1_array_hex(struct oid_array *array, char delim)
+static char *join_oid_array_hex(struct oid_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
 	int i;
@@ -765,7 +765,7 @@ static enum bisect_error handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
-		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
+		char *good_hex = join_oid_array_hex(&good_revs, ' ');
 		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
 			fprintf(stderr, _("The merge base %s is bad.\n"
 				"This means the bug has been fixed "
@@ -796,7 +796,7 @@ static void handle_skipped_merge_base(const struct object_id *mb)
 {
 	char *mb_hex = oid_to_hex(mb);
 	char *bad_hex = oid_to_hex(current_bad_oid);
-	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
+	char *good_hex = join_oid_array_hex(&good_revs, ' ');
 
 	warning(_("the merge base between %s and [%s] "
 		"must be skipped.\n"
-- 
2.26.0.597.g7e08ed78ff

