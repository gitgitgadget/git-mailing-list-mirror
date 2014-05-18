From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/4] git-rebase: document ack
Date: Mon, 19 May 2014 00:17:49 +0300
Message-ID: <1400447743-18513-3-git-send-email-mst@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 23:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm8U2-00060j-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 23:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbaERVS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 17:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbaERVSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 17:18:55 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4ILItee008712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:55 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4ILIsuH002854
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:54 -0400
Content-Disposition: inline
In-Reply-To: <1400447743-18513-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249511>

document ack! behaviour and use

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-rebase.txt | 45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..c27aef4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -384,7 +384,7 @@ or by giving more than one `--exec`:
 +
 If `--autosquash` is used, "exec" lines will not be appended for
 the intermediate commits, and will only appear at the end of each
-squash/fixup series.
+squash/fixup/ack series.
 
 --root::
 	Rebase all commits reachable from <branch>, instead of
@@ -398,13 +398,13 @@ squash/fixup series.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is a commit whose title begins with
+	When the commit log message begins with "squash! ..." ("fixup! ..."
+	or "ack! ..."), and there is a commit whose title begins with
 	the same ..., automatically modify the todo list of rebase -i
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
-	"fixup! " or "squash! " after the first, in case you referred to an
+	commit from `pick` to `squash` (`fixup` or `ack`).  Ignores subsequent
+	"ack! ", "fixup! " or "squash! " after the first, in case you referred to an
 	earlier fixup/squash with `git commit --fixup/--squash`.
 +
 This option is only valid when the '--interactive' option is used.
@@ -624,6 +624,41 @@ consistent (they compile, pass the testsuite, etc.) you should use
 'git stash' to stash away the not-yet-committed changes
 after each commit, test, and amend the commit if fixes are necessary.
 
+----------------
+RECORDING ACKS
+----------------
+
+Interactive mode with --autosquash can be used to concatenate
+commit log for several commits, which is useful to record
+extra information about the commit, such as ack signatures.
+This allows, for example, the following workflow:
+
+1. receive patches by mail and commit
+2. receive by mail ack signatures for the patches
+3. prepare a series for submission
+4. submit
+
+where point 2. consists of several instances of
+	i) create a (possibly empty) commit with signature
+	  in the commit message
+
+Sometimes the ack signature added in i. cannot be amended to the
+commit it acks, because that commit is buried deeply in a
+patch series.  That is exactly what rebase --autosquash
+option is for: use it
+after plenty of "i"s, to automaticlly rearrange
+commits, and squashing multiple sign-off commits into
+the commit that is signed.
+
+Start it with the last commit you want to retain as-is:
+
+	git rebase --autosquash -i <after-this-commit>
+
+An editor will be fired up with all the commits in your current branch
+which come after the given commit. Ack commits will be
+re-arranged to come after the commit that is acked,
+and the action will be utomticlly changed from `pick` to `ack`
+to cause them to be squashed into the acked commit.
 
 RECOVERING FROM UPSTREAM REBASE
 -------------------------------
-- 
MST
