X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] De-emphasise the symbolic link documentation.
Date: Thu, 30 Nov 2006 10:50:28 +0000
Message-ID: <200611301050.29012.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 10:53:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 4e3d1873218553ea
X-UID: 176
X-Length: 2819
Content-Disposition: inline
X-OriginalArrivalTime: 30 Nov 2006 10:52:13.0047 (UTC) FILETIME=[97951870:01C7146D]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32721>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpjXV-0003Qd-06 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755620AbWK3KxK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757679AbWK3KxJ
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:53:09 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:61648 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1755620AbWK3KxI
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:53:08 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 30 Nov 2006 10:52:13 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GpjUt-0002z8-00 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 10:50:31 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The fact that git has previously used symbolic links for representing
symbolic refs doesn't seem relevant to the current function of
git-symbolic-ref.  This patch makes less of a big deal about the
symbolic link history and instead focuses on what git does now.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I've not been using git long enough to have ever experienced the symbolic-link
refs.  It seems unnecessary that the man pages talk about something that doesn't
happen in such strong terms.  (Was also slightly inaccurate, as it's not just
cygwin that uses symbolic refs)

 Documentation/git-symbolic-ref.txt |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 68ac6a6..4bc35a1 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -19,29 +19,22 @@ argument to see on which branch your working tree is on.
 Give two arguments, create or update a symbolic ref <name> to
 point at the given branch <ref>.
 
-Traditionally, `.git/HEAD` is a symlink pointing at
-`refs/heads/master`.  When we want to switch to another branch,
-we did `ln -sf refs/heads/newbranch .git/HEAD`, and when we want
+A symbolic ref is a regular file that stores a string that
+begins with `ref: refs/`.  For example, your `.git/HEAD` is
+a regular file whose contents is `ref: refs/heads/master`.
+
+NOTES
+-----
+In the past, `.git/HEAD` was a symbolic link pointing at
+`refs/heads/master`.  When we wanted to switch to another branch,
+we did `ln -sf refs/heads/newbranch .git/HEAD`, and when we wanted
 to find out which branch we are on, we did `readlink .git/HEAD`.
 This was fine, and internally that is what still happens by
 default, but on platforms that do not have working symlinks,
 or that do not have the `readlink(1)` command, this was a bit
 cumbersome.  On some platforms, `ln -sf` does not even work as
-advertised (horrors).
-
-A symbolic ref can be a regular file that stores a string that
-begins with `ref: refs/`.  For example, your `.git/HEAD` *can*
-be a regular file whose contents is `ref: refs/heads/master`.
-This can be used on a filesystem that does not support symbolic
-links.  Instead of doing `readlink .git/HEAD`, `git-symbolic-ref
-HEAD` can be used to find out which branch we are on.  To point
-the HEAD to `newbranch`, instead of `ln -sf refs/heads/newbranch
-.git/HEAD`, `git-symbolic-ref HEAD refs/heads/newbranch` can be
-used.
-
-Currently, .git/HEAD uses a regular file symbolic ref on Cygwin,
-and everywhere else it is implemented as a symlink.  This can be
-changed at compilation time.
+advertised (horrors).  Therefore symbolic links are now deprecated
+and symbolic refs are used by default.
 
 Author
 ------
-- 
1.4.4.1
