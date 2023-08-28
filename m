Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34FC83F1D
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjH1Vse (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjH1VsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFEBF9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:13 -0700 (PDT)
Received: (qmail 588 invoked by uid 109); 28 Aug 2023 21:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4565 invoked by uid 111); 28 Aug 2023 21:48:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 17/22] grep: mark unused parmaeters in pcre fallbacks
Message-ID: <20230828214812.GQ3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When USE_LIBPCRE2 is not defined, we compile several noop fallbacks.
These need to have their parameters annotated to avoid
-Wunused-parameter warnings (and obviously we cannot remove the
parameters, since the functions must match the non-fallback versions).

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 0124eb1960..fc2d0c837a 100644
--- a/grep.c
+++ b/grep.c
@@ -452,18 +452,20 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_general_context_free(p->pcre2_general_context);
 }
 #else /* !USE_LIBPCRE2 */
-static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre2_pattern(struct grep_pat *p UNUSED,
+				  const struct grep_opt *opt UNUSED)
 {
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
 }
 
-static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
-		regmatch_t *match, int eflags)
+static int pcre2match(struct grep_pat *p UNUSED, const char *line UNUSED,
+		      const char *eol UNUSED, regmatch_t *match UNUSED,
+		      int eflags UNUSED)
 {
 	return 1;
 }
 
-static void free_pcre2_pattern(struct grep_pat *p)
+static void free_pcre2_pattern(struct grep_pat *p UNUSED)
 {
 }
 
-- 
2.42.0.505.g4c6fb48dec

