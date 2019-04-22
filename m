Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FC31F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfDVPPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:15:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726132AbfDVPPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 11:15:43 -0400
Received: (qmail 31255 invoked by uid 109); 22 Apr 2019 15:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 15:15:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31879 invoked by uid 111); 22 Apr 2019 15:16:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 11:16:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 11:15:41 -0400
Date:   Mon, 22 Apr 2019 11:15:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] doc/ls-files: put nested list for "-t" option into block
Message-ID: <20190422151541.GA1633@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description for the "-t" option contains a sub-list of all of the
possible file status outputs. But because of the newline separating that
list from the description paragraph, asciidoc treats the sub-list
entries as a continuation of the overall options list, rather than as
children of the "-t" description.

We could fix it by adding a "+" before the sub-list to connect it to the
rest of the "-t" text. But using a pair of "--" to delimit the block is
perhaps more readable, and may have better compatibility with
asciidoctor, as in 39a869b2f2 (Documentation/rev-list-options: wrap
--date=<format> block with "--", 2019-03-30).

The extra blank line comes from 5bc0e247c4 (Document ls-files -t as
semi-obsolete., 2010-07-28), but the problem actually seems older than
that. Before then, we did:

  -t:: some text...
    H:: cached
    M:: unmerged
    etc...

but asciidoc also treats that as one big list. So this problem seems to
have been around forever.

Signed-off-by: Jeff King <peff@peff.net>
---
Junio: I happened to notice this while hunting for "ls-files" options
       that could make your makefile de-dup patch unnecessary (but
       didn't find anything).

Todd: Just an FYI that your "--" strategy is spreading. :)

 Documentation/git-ls-files.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 5298f1bc30..8461c0e83e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -118,6 +118,7 @@ OPTIONS
 	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
 	`--name-status` for more user-friendly alternatives.
 +
+--
 This option identifies the file status with the following tags (followed by
 a space) at the start of each line:
 
@@ -128,6 +129,7 @@ a space) at the start of each line:
 	C::	modified/changed
 	K::	to be killed
 	?::	other
+--
 
 -v::
 	Similar to `-t`, but use lowercase letters for files
-- 
2.21.0.1180.g837af34674
