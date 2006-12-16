X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Align section headers of 'git status' to new 'git add'.
Date: Fri, 15 Dec 2006 21:53:13 -0500
Message-ID: <20061216025313.GB19955@spearce.org>
References: <0191094fd2ac0afb27b31b9a90d98dfa4ec03b17.1166237566.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 02:53:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <0191094fd2ac0afb27b31b9a90d98dfa4ec03b17.1166237566.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34588>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvPfv-0001XS-9y for gcvg-git@gmane.org; Sat, 16 Dec
 2006 03:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753319AbWLPCxS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbWLPCxR
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 21:53:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56321 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753319AbWLPCxR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 21:53:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvPfb-0008Gi-W8; Fri, 15 Dec 2006 21:53:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D5D0920FB65; Fri, 15 Dec 2006 21:53:13 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that 'git add' is considered a first-class UI for 'update-index'
and that the 'git add' documentation states "Even modified files
must be added to the set of changes about to be committed" we should
make the output of 'git status' align with that documentation and
common usage.

So now we see a status output such as:

  # Added but not yet committed:
  #   (will commit)
  #
  #       new file: x
  #
  # Changed but not added:
  #   (use "git add file1 file2" to include for commit)
  #
  #       modified:   x
  #
  # Untracked files:
  #   (use "git add" on files to include for commit)
  #
  #       y

which just reads better in the context of using 'git add' to
manipulate a commit (and not a checkin, whatever the heck that is).

We also now support 'color.status.added' as an alias for the existing
'color.status.updated', as this alias more closely aligns with the
current output and documentation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt     |    4 ++--
 Documentation/git-reset.txt  |    2 +-
 Documentation/tutorial-2.txt |   10 +++++-----
 wt-status.c                  |    9 +++++----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a3587f8..9154804 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -166,8 +166,8 @@ color.status::
 color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
 	one of `header` (the header text of the status message),
-	`updated` (files which are updated but not committed),
-	`changed` (files which are changed but not updated in the index),
+	`added` or `updated` (files which are added but not committed),
+	`changed` (files which are changed but not added in the index),
 	or `untracked` (files which are not tracked by git). The values of
 	these variables may be specified as in color.diff.<slot>.
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 73a0ffc..4a4ceb6 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -31,7 +31,7 @@ OPTIONS
 --soft::
 	Does not touch the index file nor the working tree at all, but
 	requires them to be in a good order. This leaves all your changed
-	files "Updated but not checked in", as gitlink:git-status[1] would
+	files "Added but not yet committed", as gitlink:git-status[1] would
 	put it.
 
 --hard::
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 6389de5..eb2ba6b 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -342,23 +342,23 @@ situation:
 ------------------------------------------------
 $ git status
 #
-# Updated but not checked in:
+# Added but not yet committed:
 #   (will commit)
 #
 #       new file: closing.txt
 #
 #
-# Changed but not updated:
-#   (use git-update-index to mark for commit)
+# Changed but not added:
+#   (use "git add file1 file2" to include for commit)
 #
 #       modified: file.txt
 #
 ------------------------------------------------
 
 Since the current state of closing.txt is cached in the index file,
-it is listed as "updated but not checked in".  Since file.txt has
+it is listed as "added but not yet committed".  Since file.txt has
 changes in the working directory that aren't reflected in the index,
-it is marked "changed but not updated".  At this point, running "git
+it is marked "changed but not added".  At this point, running "git
 commit" would create a commit that added closing.txt (with its new
 contents), but that didn't modify file.txt.
 
diff --git a/wt-status.c b/wt-status.c
index 2173d4f..c388ce1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -21,7 +21,8 @@ static int parse_status_slot(const char *var, int offset)
 {
 	if (!strcasecmp(var+offset, "header"))
 		return WT_STATUS_HEADER;
-	if (!strcasecmp(var+offset, "updated"))
+	if (!strcasecmp(var+offset, "updated")
+		|| !strcasecmp(var+offset, "added"))
 		return WT_STATUS_UPDATED;
 	if (!strcasecmp(var+offset, "changed"))
 		return WT_STATUS_CHANGED;
@@ -146,7 +147,7 @@ static void wt_status_print_updated_cb(struct diff_queue_struct *q,
 		if (q->queue[i]->status == 'U')
 			continue;
 		if (!shown_header) {
-			wt_status_print_header("Updated but not checked in",
+			wt_status_print_header("Added but not yet committed",
 					"will commit");
 			s->commitable = 1;
 			shown_header = 1;
@@ -163,7 +164,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 {
 	int i;
 	if (q->nr)
-		wt_status_print_header("Changed but not updated", use_add_msg);
+		wt_status_print_header("Changed but not added", use_add_msg);
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
@@ -178,7 +179,7 @@ void wt_status_print_initial(struct wt_status *s)
 	read_cache();
 	if (active_nr) {
 		s->commitable = 1;
-		wt_status_print_header("Updated but not checked in",
+		wt_status_print_header("Added but not yet committed",
 				"will commit");
 	}
 	for (i = 0; i < active_nr; i++) {
-- 
