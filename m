Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC9C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCDK0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCDK0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:26:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73A13DFF
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:26:41 -0800 (PST)
Received: (qmail 16780 invoked by uid 109); 4 Mar 2023 10:26:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:26:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3722 invoked by uid 111); 4 Mar 2023 10:26:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:26:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:26:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 2/5] bundle: document handling of "-" as stdin
Message-ID: <ZAMc4DPOSjqxY/UT@coredump.intra.peff.net>
References: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have always allowed "bundle create -" to write to stdout, but it was
never documented. And a recent patch let reading operations like "bundle
list-heads -" read from stdin.

Let's document all of these cases.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably could be squashed into the previous patch, but the bit for
"create" is weird then.

 Documentation/git-bundle.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 18a022b4b40..d19f4cf2b3c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -66,7 +66,7 @@ create [options] <file> <git-rev-list-args>::
 	Used to create a bundle named 'file'.  This requires the
 	'<git-rev-list-args>' arguments to define the bundle contents.
 	'options' contains the options specific to the 'git bundle create'
-	subcommand.
+	subcommand. If 'file' is `-`, the bundle is written to stdout.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
@@ -77,19 +77,21 @@ verify <file>::
 	Finally, information about additional capabilities, such as "object
 	filter", is printed. See "Capabilities" in linkgit:gitformat-bundle[5]
 	for more information. The exit code is zero for success, but will
-	be nonzero if the bundle file is invalid.
+	be nonzero if the bundle file is invalid. If 'file' is `-`, the
+	bundle is read from stdin.
 
 list-heads <file>::
 	Lists the references defined in the bundle.  If followed by a
 	list of references, only references matching those given are
-	printed out.
+	printed out. If 'file' is `-`, the bundle is read from stdin.
 
 unbundle <file>::
 	Passes the objects in the bundle to 'git index-pack'
 	for storage in the repository, then prints the names of all
 	defined references. If a list of references is given, only
 	references matching those in the list are printed. This command is
 	really plumbing, intended to be called only by 'git fetch'.
+	If 'file' is `-`, the bundle is read from stdin.
 
 <git-rev-list-args>::
 	A list of arguments, acceptable to 'git rev-parse' and
-- 
2.40.0.rc1.500.g967c04631e

