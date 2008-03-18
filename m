From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] builtin-remote: Fix missing newline at end of listing of pushed branches
Date: Tue, 18 Mar 2008 21:52:00 +0100
Message-ID: <200803182152.00187.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:26:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4sA-0004ng-GV
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765971AbYCSUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755933AbYCSUSQ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:18:16 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:47242 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765960AbYCSUSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:18:13 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 2F66613A531;
	Tue, 18 Mar 2008 21:52:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E9C0353180;
	Tue, 18 Mar 2008 21:52:00 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77533>

Without this the output of 'git remote show' does not end with a new-line:

bash> git remote show repo
* remote repo
  URL: repo.or.cz:/srv/git/kdbg.git
  Tracked remote branches
    maint master mob
  Local branch pushed with 'git push'
    +master:masterbash>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-remote.c  |    1 +
 t/t5505-remote.sh |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 24e6929..d62130d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -469,6 +469,7 @@ static int show_or_prune(int argc, const char **argv, int prune)
 					spec->dst ? ":" : "",
 					skip_prefix(spec->dst, "refs/heads/"));
 			}
+			printf("\n");
 		}
 cleanup_states:
 		/* NEEDSWORK: free remote */
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ecfc999..8a88140 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -106,6 +106,8 @@ cat > test/expect << EOF
     master
   Tracked remote branches
     side master
+  Local branches pushed with 'git push'
+    master:upstream +refs/tags/lastbackup
 EOF
 
 test_expect_success 'show' '
@@ -118,6 +120,10 @@ test_expect_success 'show' '
 	  echo 1 > file &&
 	  test_tick &&
 	  git commit -m update file) &&
+	 git config remote.origin.push \
+		refs/heads/master:refs/heads/upstream &&
+	 git config --add remote.origin.push \
+		+refs/tags/lastbackup &&
 	 git remote show origin > output &&
 	 git diff expect output)
 '
-- 
1.5.5.rc0.11.g12588.dirty
