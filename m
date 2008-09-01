From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Bust the ghost of long-defunct diffcore-pathspec.
Date: Mon, 01 Sep 2008 23:53:54 +0200
Message-ID: <20080901215353.30399.33432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 23:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHMB-000749-O4
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbYIAVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYIAVxh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:53:37 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:53438 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbYIAVxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:53:37 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id C9A4332A7B9
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 23:53:35 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 9D29D32A777
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 23:53:35 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6B26F1F0C0
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 23:53:54 +0200 (CEST)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94615>

This concept was retired by 77882f60d9df2fd410ba7d732b01738315643c05,
more than 2 years ago.
---

 Documentation/gitdiffcore.txt |   23 +++++++++--------------
 diffcore.h                    |    1 -
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 2bdbc3d..fc54bfb 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -52,9 +52,8 @@ unmerged       :000000 000000 0000000... 0000000... U file6
 The diffcore mechanism is fed a list of such comparison results
 (each of which is called "filepair", although at this point each
 of them talks about a single file), and transforms such a list
-into another list.  There are currently 6 such transformations:
+into another list.  There are currently 5 such transformations:
 
-- diffcore-pathspec
 - diffcore-break
 - diffcore-rename
 - diffcore-merge-broken
@@ -62,21 +61,22 @@ into another list.  There are currently 6 such transformations:
 - diffcore-order
 
 These are applied in sequence.  The set of filepairs 'git-diff-{asterisk}'
-commands find are used as the input to diffcore-pathspec, and
-the output from diffcore-pathspec is used as the input to the
+commands find are used as the input to diffcore-break, and
+the output from diffcore-break is used as the input to the
 next transformation.  The final result is then passed to the
 output routine and generates either diff-raw format (see Output
 format sections of the manual for 'git-diff-{asterisk}' commands) or
 diff-patch format.
 
 
-diffcore-pathspec: For Ignoring Files Outside Our Consideration
----------------------------------------------------------------
+Pathspec filtering: For Ignoring Files Outside Our Consideration
+----------------------------------------------------------------
 
-The first transformation in the chain is diffcore-pathspec, and
+The first transformation in the chain is pathspec filtering, which
+occurs before calling diffcore, and
 is controlled by giving the pathname parameters to the
-'git-diff-{asterisk}' commands on the command line.  The pathspec is used
-to limit the world diff operates in.  It removes the filepairs
+'git-diff-{asterisk}' commands on the command line.  The pathspec is
+used to limit the world diff operates in.  It removes the filepairs
 outside the specified set of pathnames.  E.g. If the input set
 of filepairs included:
 
@@ -88,11 +88,6 @@ but the command invocation was `git diff-files myfile`, then the
 junkfile entry would be removed from the list because only "myfile"
 is under consideration.
 
-Implementation note.  For performance reasons, 'git-diff-tree'
-uses the pathname parameters on the command line to cull set of
-filepairs it feeds the diffcore mechanism itself, and does not
-use diffcore-pathspec, but the end result is the same.
-
 
 diffcore-break: For Splitting Up "Complete Rewrites"
 ----------------------------------------------------
diff --git a/diffcore.h b/diffcore.h
index cc96c20..8ae3578 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -92,7 +92,6 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern void diffcore_pathspec(const char **pathspec);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
