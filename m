From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] tests for push --quiet
Date: Sat,  3 Sep 2011 18:34:14 +0200
Message-ID: <1315067656-2846-2-git-send-email-drizzd@aon.at>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, tobiasu@tmux.org,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 18:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QztDZ-0007K4-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 18:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab1ICQhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 12:37:14 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23410 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752917Ab1ICQhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 12:37:13 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id 514C8130045;
	Sat,  3 Sep 2011 18:37:11 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315067656-2846-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180659>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5523-push-upstream.sh |    7 +++++++
 t/t5541-http-push.sh     |    8 ++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index c229fe6..9ee52cf 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -108,4 +108,11 @@ test_expect_failure TTY 'push --no-progress suppresses progress' '
 	! grep "Writing objects" err
 '
 
+test_expect_success TTY 'quiet push' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push --quiet --no-progress upstream master 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
 test_done
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index a73c826..0dcb8df 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -5,6 +5,7 @@
 
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 if test -n "$NO_CURL"; then
 	skip_all='skipping test, git built without http support'
@@ -154,5 +155,12 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_failure TTY 'quiet push' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit quiet &&
+	test_terminal git push --quiet --no-progress 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
 stop_httpd
 test_done
-- 
1.7.6.1
