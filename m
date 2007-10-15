From: Jeff King <peff@peff.net>
Subject: [PATCH] git-rebase: document suppression of duplicate commits
Date: Mon, 15 Oct 2007 00:47:30 -0400
Message-ID: <20071015044730.GA12118@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <lh@elementstorage.no>
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Oct 15 06:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhHrx-00044r-FP
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 06:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXJOErm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 00:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXJOErm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 00:47:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2191 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXJOErl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 00:47:41 -0400
Received: (qmail 17363 invoked by uid 111); 15 Oct 2007 04:47:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Oct 2007 00:47:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2007 00:47:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60943>

git-rebase uses format-patch's --ignore-if-in-upstream
option, but we never document the user-visible behavior. The
example is placed near the top of the example list rather
than at the bottom because it is:
  a. a simple example
  b. a reasonably common scenario for many projects (mail
     some patches which get accepted upstream, then rebase)

Signed-off-by: Jeff King <peff@peff.net>
---
On Sat, Oct 13, 2007 at 07:04:52PM -0400, Michael Witten wrote:
> I can make a patch, but at the moment I'm swamped and I don't want to
> think about doing that.

And whoever said procrastination didn't get things done?

 Documentation/git-rebase.txt |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e8e7579..b6efb48 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -28,7 +28,10 @@ The current branch is reset to <upstream>, or <newbase> if the
 `git reset --hard <upstream>` (or <newbase>).
 
 The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order.
+then reapplied to the current branch, one by one, in order. Note that
+any commits in HEAD which introduce the same textual changes as a commit
+in <upstream>..HEAD are omitted (i.e., a patch already accepted upstream
+with a different commit message or timestamp will be skipped).
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
@@ -62,6 +65,26 @@ would be:
 The latter form is just a short-hand of `git checkout topic`
 followed by `git rebase master`.
 
+If the upstream branch already contains a change you have made (e.g.,
+because you mailed a patch which was applied upstream), then that commit
+will be skipped. For example, running `git-rebase master` on the
+following history (in which A' and A introduce the same set of changes,
+but have different committer information):
+
+------------
+          A---B---C topic
+         /
+    D---E---A'---F master
+------------
+
+will result in:
+
+------------
+                   B'---C' topic
+                  /
+    D---E---A'---F master
+------------
+
 Here is how you would transplant a topic branch based on one
 branch to another, to pretend that you forked the topic branch
 from the latter branch, using `rebase --onto`.
-- 
1.5.3.4.1155.gfe96ee-dirty
