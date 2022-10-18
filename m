Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ADC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJRBJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJRBIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:08:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F488F274
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:08:49 -0700 (PDT)
Received: (qmail 28800 invoked by uid 109); 18 Oct 2022 01:08:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:08:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13471 invoked by uid 111); 18 Oct 2022 01:08:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:08:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:08:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/12] apply: mark unused parameters in handlers
Message-ID: <Y038oMvRImqg3k4Z@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In parse_git_diff_header(), we have a table-driven parser that maps
strings to handler functions. Not all handlers need all of the
parameters; let's mark the unused ones to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 2b7cd930ef..fa9a02771c 100644
--- a/apply.c
+++ b/apply.c
@@ -892,9 +892,9 @@ static int parse_traditional_patch(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_hdrend(struct gitdiff_data *state,
-			  const char *line,
-			  struct patch *patch)
+static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
+			  const char *line UNUSED,
+			  struct patch *patch UNUSED)
 {
 	return 1;
 }
@@ -1044,7 +1044,7 @@ static int gitdiff_renamedst(struct gitdiff_data *state,
 	return 0;
 }
 
-static int gitdiff_similarity(struct gitdiff_data *state,
+static int gitdiff_similarity(struct gitdiff_data *state UNUSED,
 			      const char *line,
 			      struct patch *patch)
 {
@@ -1054,7 +1054,7 @@ static int gitdiff_similarity(struct gitdiff_data *state,
 	return 0;
 }
 
-static int gitdiff_dissimilarity(struct gitdiff_data *state,
+static int gitdiff_dissimilarity(struct gitdiff_data *state UNUSED,
 				 const char *line,
 				 struct patch *patch)
 {
@@ -1104,9 +1104,9 @@ static int gitdiff_index(struct gitdiff_data *state,
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
  */
-static int gitdiff_unrecognized(struct gitdiff_data *state,
-				const char *line,
-				struct patch *patch)
+static int gitdiff_unrecognized(struct gitdiff_data *state UNUSED,
+				const char *line UNUSED,
+				struct patch *patch UNUSED)
 {
 	return 1;
 }
-- 
2.38.0.371.g300879f34e

