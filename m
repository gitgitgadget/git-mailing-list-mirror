From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] fix push --quiet via http
Date: Sat,  3 Sep 2011 18:34:15 +0200
Message-ID: <1315067656-2846-3-git-send-email-drizzd@aon.at>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, tobiasu@tmux.org,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 18:37:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QztDi-0007Ny-VZ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab1ICQhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 12:37:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23417 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752926Ab1ICQhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 12:37:14 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id EAC82A7EB9;
	Sat,  3 Sep 2011 18:37:12 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315067656-2846-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180660>

A verbosity of 0 means quiet for remote helpers.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 remote-curl.c        |    2 +-
 t/t5541-http-push.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5798aa5..2341106 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -762,7 +762,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv[argc++] = "--thin";
 	if (options.dry_run)
 		argv[argc++] = "--dry-run";
-	if (options.verbosity < 0)
+	if (options.verbosity == 0)
 		argv[argc++] = "--quiet";
 	else if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 0dcb8df..e756a08 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -155,7 +155,7 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure TTY 'quiet push' '
+test_expect_success TTY 'quiet push' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit quiet &&
 	test_terminal git push --quiet --no-progress 2>&1 | tee output &&
-- 
1.7.6.1
