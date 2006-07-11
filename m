From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] tests: Set EDITOR=: and VISUAL=: globally
Date: Tue, 11 Jul 2006 12:01:54 -0700
Message-ID: <20060711190154.GA28468@soma>
References: <11526072802855-git-send-email-normalperson@yhbt.net> <7vlkr04i4p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 21:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0NUd-0005rw-Pq
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWGKTB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGKTB4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:01:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55004 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751095AbWGKTB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 15:01:56 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 78D117DC021;
	Tue, 11 Jul 2006 12:01:54 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 11 Jul 2006 12:01:54 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkr04i4p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23726>

This way we don't have to remember to set it for each test; and
if we forget, we won't cause interactive editors to be spawned
for non-interactive tests.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Junio C Hamano <junkio@cox.net> wrote:
 > Eric Wong <normalperson@yhbt.net> writes:
 > 
 > > I have VISUAL set in my environment, and it caused git-commit to
 > > spawn my editor during the test.
 > 
 > I think it would be better to remove "EDITOR=: VISUAL=:"
 > settings from annotate-tests.sh, t1400-update-ref.sh and
 > t4013-diff-various.sh, and move that to test-lib.sh; there is no
 > point overriding them differently in each of these automated
 > tests.

 I've been under the impression this has already been set, but it turns
 it that was only the case in my config.mak on a different machine :)
 
 t/annotate-tests.sh     |    2 +-
 t/t1400-update-ref.sh   |    1 -
 t/t4013-diff-various.sh |    2 +-
 t/test-lib.sh           |    3 +++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 1148b02..b6a2edd 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -94,7 +94,7 @@ test_expect_success \
 test_expect_success \
     'merge-setup part 4' \
     'echo "evil merge." >>file &&
-     EDITOR=: VISUAL=: git commit -a --amend'
+     git commit -a --amend'
 
 test_expect_success \
     'Two lines blamed on A, one on B, two on B1, one on B2, one on A U Thor' \
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6a3515d..04fab26 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -190,7 +190,6 @@ test_expect_success \
 	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -F M -a &&
 	 h_OTHER=$(git-rev-parse --verify HEAD) &&
 	 echo FIXED >F &&
-	 EDITOR=true \
 	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend &&
 	 h_FIXED=$(git-rev-parse --verify HEAD) &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 06837d1..36658fb 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -70,7 +70,7 @@ test_expect_success setup '
 	for i in 1 2; do echo $i; done >>dir/sub &&
 	git update-index file0 dir/sub &&
 
-	EDITOR=: VISUAL=: git commit --amend &&
+	git commit --amend &&
 	git show-branch
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 05f6e79..b0d7990 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -9,6 +9,8 @@ LC_ALL=C
 PAGER=cat
 TZ=UTC
 export LANG LC_ALL PAGER TZ
+EDITOR=:
+VISUAL=:
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME
@@ -30,6 +32,7 @@ unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+export EDITOR VISUAL
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
1.4.1.g710d
