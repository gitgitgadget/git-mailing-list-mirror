Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C5C636D3
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBKCoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKCoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:44:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056F29424
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:44:37 -0800 (PST)
Received: (qmail 21936 invoked by uid 109); 11 Feb 2023 02:44:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30587 invoked by uid 111); 11 Feb 2023 02:44:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:44:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:44:36 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/2] doc/ls-remote: clarify pattern format
Message-ID: <Y+cBFF0OPSq8DGnA@coredump.intra.peff.net>
References: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We document that you can specify "refs" to ls-remote, but we don't
explain any further than that they are "matched" as patterns. Since this
can be interpreted in a lot of ways, let's clarify that they are
tail-matched globs.

Likewise, let's use the word "patterns" to refer to them consistently,
rather than "refs", and mention more explicitly that only one pattern
needs to be matched (though there is also an example already that shows
this in action).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-ls-remote.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index f17567945f..2a941292a4 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
-	      [--symref] [<repository> [<refs>...]]
+	      [--symref] [<repository> [<patterns>...]]
 
 DESCRIPTION
 -----------
@@ -85,11 +85,14 @@ OPTIONS
 	either a URL or the name of a remote (see the GIT URLS and
 	REMOTES sections of linkgit:git-fetch[1]).
 
-<refs>...::
+<patterns>...::
 	When unspecified, all references, after filtering done
-	with --heads and --tags, are shown.  When <refs>... are
-	specified, only references matching the given patterns
-	are displayed.
+	with --heads and --tags, are shown.  When <patterns>... are
+	specified, only references matching one or more of the given
+	patterns are displayed. Each pattern is interpreted as a glob
+	(see `glob` in linkgit:gitglossary[7]) which is matched against
+	the "tail" of a ref, starting from a slash separator (so `bar`
+	matches `refs/heads/bar` but not `refs/heads/foobar`).
 
 EXAMPLES
 --------
-- 
2.39.1.795.g4b3688ded9
