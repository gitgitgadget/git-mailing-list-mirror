From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 2/4] git-rebase: add keep_empty flag
Date: Fri, 30 Mar 2012 15:48:40 -0400
Message-ID: <1333136922-12872-3-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhos-0005UV-96
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761340Ab2C3TtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:49:05 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60961 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761338Ab2C3TtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:49:02 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDhog-00011H-5s; Fri, 30 Mar 2012 15:49:00 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194394>

Add a command line switch to git-rebase to allow a user the ability to specify
that they want to keep any commits in a series that are empty.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt |    6 ++++++
 git-rebase.sh                |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..9717d3e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -238,6 +238,12 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
+--keep-empty::
+	Informs git-rebase that comits which are empty should not be
+	automatically removed.  This is at times useful when empty commits
+	are used to hold developer information and notes, but contain no real
+	code changes
+
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 69c1374..24a2840 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -97,6 +98,7 @@ state_dir=
 action=
 preserve_merges=
 autosquash=
+keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_basic_state () {
@@ -220,6 +222,9 @@ do
 	-i)
 		interactive_rebase=explicit
 		;;
+	-k)
+		keep_empty=yes
+		;;
 	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
-- 
1.7.7.6
