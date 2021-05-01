Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67889C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFB61477
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEAPoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:44:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:42154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhEAPoA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:44:00 -0400
Received: (qmail 26667 invoked by uid 109); 1 May 2021 15:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 15:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10899 invoked by uid 111); 1 May 2021 15:43:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 11:43:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 11:43:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 9/9] docs: document symlink restrictions for dot-files
Message-ID: <YI13DTkOpDRP4YGa@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We stopped allowing symlinks for .gitmodules files in 10ecfa7649
(verify_path: disallow symlinks in .gitmodules, 2018-05-04), and we
stopped following symlinks for .gitattributes, .gitignore, and .mailmap
in the commits from 204333b015 (Merge branch 'jk/open-dotgitx-with-nofollow',
2021-03-22). The reasons are discussed in detail there, but we never
adjusted the documentation to let users know.

This hasn't been a big deal since the point is that such setups were
mildly broken and thought to be unusual anyway. But it certainly doesn't
hurt to be clear and explicit about it.

Suggested-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt | 7 +++++++
 Documentation/gitignore.txt     | 5 +++++
 Documentation/gitmailmap.txt    | 7 +++++++
 Documentation/gitmodules.txt    | 8 ++++++++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index cfcfa800c2..dfda94d996 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1247,6 +1247,13 @@ to:
 [attr]binary -diff -merge -text
 ------------
 
+NOTES
+-----
+
+Note that Git does not follow symbolic links when accessing a
+`.gitattributes` file in the working tree. This keeps behavior
+consistent when the file is accessed from the index or a tree versus
+from the filesystem.
 
 EXAMPLES
 --------
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 5751603b13..4b6fd8d2cd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -149,6 +149,11 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
+Note that Git does not follow symbolic links when accessing a
+`.gitignore` file in the working tree. This keeps behavior consistent
+when the file is accessed from the index or a tree versus from the
+filesystem.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 3fb39f801f..eb65eeb37f 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -55,6 +55,13 @@ this would also match the 'Commit Name <commit&#64;email.xx>' above:
 	Proper Name <proper@email.xx> CoMmIt NaMe <CoMmIt@EmAiL.xX>
 --
 
+NOTES
+-----
+
+Note that Git does not follow symbolic links when accessing a `.mailmap`
+file in the working tree. This keeps behavior consistent when the file
+is accessed from the index or a tree versus from the filesystem.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 8e333dde1b..ca1c42b405 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -98,6 +98,14 @@ submodule.<name>.shallow::
 	shallow clone (with a history depth of 1) unless the user explicitly
 	asks for a non-shallow clone.
 
+NOTES
+-----
+
+Note that Git does not allow the `.gitmodules` file within a working
+tree to be a symbolic link, and will refuse to check out such a tree
+entry. This keeps behavior consistent when the file is accessed from the
+index or a tree versus from the filesystem, and helps Git reliably
+enforce security checks of the file contents.
 
 EXAMPLES
 --------
-- 
2.31.1.875.g5dccece0aa
