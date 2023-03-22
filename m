Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E1C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCVRoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCVRoT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:44:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A071285F
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:43:57 -0700 (PDT)
Received: (qmail 10580 invoked by uid 109); 22 Mar 2023 17:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15921 invoked by uid 111); 22 Mar 2023 17:43:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:43:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:43:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] fast-export: drop unused parameter from
 anonymize_commit_message()
Message-ID: <20230322174322.GD11424@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the comment above the function indicates, we do not bother actually
storing commit messages in our anonymization map. But we still take the
message as a parameter, and just ignore it. Let's stop doing that, which
will make -Wunused-parameter happier.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12adf75964c..f3cc5486861 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -556,7 +556,7 @@ static const char *anonymize_refname(const char *refname)
  * We do not even bother to cache commit messages, as they are unlikely
  * to be repeated verbatim, and it is not that interesting when they are.
  */
-static char *anonymize_commit_message(const char *old)
+static char *anonymize_commit_message(void)
 {
 	static int counter;
 	return xstrfmt("subject %d\n\nbody\n", counter++);
@@ -683,7 +683,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 
 	mark_next_object(&commit->object);
 	if (anonymize) {
-		reencoded = anonymize_commit_message(message);
+		reencoded = anonymize_commit_message();
 	} else if (encoding) {
 		switch(reencode_mode) {
 		case REENCODE_YES:
-- 
2.40.0.595.g9b96b494d8c
