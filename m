Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D595C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377289AbiFVXdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiFVXdH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 19:33:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B515836
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 16:33:06 -0700 (PDT)
Received: (qmail 3134 invoked by uid 109); 22 Jun 2022 23:33:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Jun 2022 23:33:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1577 invoked by uid 111); 22 Jun 2022 23:33:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Jun 2022 19:33:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Jun 2022 19:33:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] revisions.txt: escape "..." to avoid asciidoc horizontal
 ellipsis
Message-ID: <YrOmsA04FZae89be@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In asciidoc's HTML output of the "gitrevisions" and "git-rev-parse"
documentation, the header:

  The ... (three-dot) Symmetric Difference Notation

is rendered using "&8230;", a horizontal ellipsis. This is visually
ugly, but also hard to search for or cut-and-paste. We really mean three
ascii dots (0x2e) here, so let's make sure it renders as such.

The simplest way to do that is just escaping the leading dot, as the
instances in the rest of the section do. Arguably this should all be
converted to use backticks, which would let us drop the quoting here and
elsewhere (e.g., {carat}). But that does change the rendering slightly.
So let's fix the bug first, and we can decide on migrating the whole
section separately.

Note that this produces an empty doc-diff of the manpages. Curiously,
asciidoc produces the same ellipsis entity in the XML file, but docbook
then converts it back into three literal dots for the roff output! So
the roff manpages have been correct all along (which may be a reason
nobody noticed this until now).

Reported-by: Arthur Milchior
Signed-off-by: Jeff King <peff@peff.net>
---
This was originally reported via https://github.com/git/git-scm.com/issues/1700,
hence no email address for the reporter. I'm not sure if that makes it
too useless to keep, but I mostly wanted to give credit.

 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f5f17b65a1..cef8c3c66f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -283,7 +283,7 @@ The '..' (two-dot) Range Notation::
  for commits that are reachable from r2 excluding those that are reachable
  from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
-The '...' (three-dot) Symmetric Difference Notation::
+The '\...' (three-dot) Symmetric Difference Notation::
  A similar notation 'r1\...r2' is called symmetric difference
  of 'r1' and 'r2' and is defined as
  'r1 r2 --not $(git merge-base --all r1 r2)'.
-- 
2.37.0.rc1.390.g1f5e45eb84
