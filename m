Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73B42018E
	for <e@80x24.org>; Mon, 11 Jul 2016 05:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbcGKFEz (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 01:04:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:42699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbcGKFEz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 01:04:55 -0400
Received: (qmail 13463 invoked by uid 102); 11 Jul 2016 05:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:04:56 -0400
Received: (qmail 28976 invoked by uid 107); 11 Jul 2016 05:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 01:04:51 -0400
Date:	Mon, 11 Jul 2016 01:04:51 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/5] doc/rev-list-options: explain "-g" output formats
Message-ID: <20160711050451.GB32514@sigill.intra.peff.net>
References: <20160711050201.GA18031@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160711050201.GA18031@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We document that asking for HEAD@{now} will switch the
output to show HEAD@{timestamp}, but not that specifying
`--date` has a similar effect, or that it can be overridden
with HEAD@{0}. Let's do so.

These rules come from 794151e (reflog-walk: always make
HEAD@{0} show indexed selectors, 2012-05-04), though that is
simply the culmination of years of these heuristics growing
organically.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6720ff3..5267ee1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -252,10 +252,25 @@ list.
 +
 With `--pretty` format other than `oneline` (for obvious reasons),
 this causes the output to have two extra lines of information
-taken from the reflog.  By default, `ref@{Nth}` notation is
-used in the output.  When the starting commit is specified as
-`ref@{now}`, output also uses `ref@{timestamp}` notation
-instead.  Under `--pretty=oneline`, the commit message is
+taken from the reflog.  The reflog designator in the output may be shown
+as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
+reflog) or as `ref@{timestamp}` (with the timestamp for that entry),
+depending on a few rules:
++
+--
+1. If the starting point is specified as `ref@{Nth}`, show the index
+format.
++
+2. If the starting point was specified as `ref@{now}`, show the
+timestamp format.
++
+3. If neither was used, but `--date` was given on the command line, show
+the timestamp in the format requested by `--date`.
++
+4. Otherwise, show the index format.
+--
++
+Under `--pretty=oneline`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
-- 
2.9.0.406.g77f030d

