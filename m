Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754181FD4F
	for <e@80x24.org>; Mon, 28 May 2018 09:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeE1Jj0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:39:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:54504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754090AbeE1JjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:39:25 -0400
Received: (qmail 22276 invoked by uid 109); 28 May 2018 09:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 May 2018 09:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20801 invoked by uid 111); 28 May 2018 09:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 May 2018 05:39:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2018 05:39:23 -0400
Date:   Mon, 28 May 2018 05:39:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] show-index: update documentation for index v2
Message-ID: <20180528093923.GB20229@sigill.intra.peff.net>
References: <20180528093740.GA6902@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528093740.GA6902@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 32637cdf4a (show-index.c: learn about index v2,
2007-04-09) changed the output format of show-index to
include the object CRC32 but didn't update the
documentation. Let's fix that and generally describe the
output in more detail.

There are a few other fixes here while we're rewording:

 - refer to index-pack along with pack-objects, since either
   can create .idx files

 - use "linkgit:" for referring to other commands

 - expand the bit about verify-pack, giving reasons why you
   might want this command instead. I almost omitted this
   entirely, but referring to verify-pack might help a
   reader who is looking for more information.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-show-index.txt | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index a8a9509e0e..424e4ba84c 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -14,13 +14,27 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Read the idx file for a Git packfile created with
-'git pack-objects' command from the standard input, and
-dump its contents.
+Read the `.idx` file for a Git packfile (created with
+linkgit:git-pack-objects[1] or linkgit:git-index-pack[1]) from the
+standard input, and dump its contents. The output consists of one object
+per line, with each line containing two or three space-separated
+columns:
 
-The information it outputs is subset of what you can get from
-'git verify-pack -v'; this command only shows the packfile
-offset and SHA-1 of each object.
+  - the first column is the offset in bytes of the object within the
+    corresponding packfile
+
+  - the second column is the object id of the object
+
+  - if the index version is 2 or higher, the third column contains the
+    CRC32 of the object data
+
+The objects are output in the order in which they are found in the index
+file, which should be (in a correctly constructed file) sorted by object
+id.
+
+Note that you can get more information on a packfile by calling
+linkgit:git-verify-pack[1]. However, as this command considers only the
+index file itself, it's both faster and more flexible.
 
 GIT
 ---
-- 
2.17.0.1391.g6fdbf40724
