From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/{t5541,lib-httpd}: replace problematic '!()' notation with test_must_fail
Date: Tue, 20 Jul 2010 13:27:55 -0500
Message-ID: <a6Z8194aVj9d_uiPj0QZaVCfPhZWVDzj2NuBws8RYnYVr4pe9tF4BSy7a4J8g7UAxPIvHfvIwT8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, rctay89@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 20 20:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHYo-000381-OP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761347Ab0GTS2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:28:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59028 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab0GTS2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:28:53 -0400
Received: by mail.nrlssc.navy.mil id o6KIS9Gv029994; Tue, 20 Jul 2010 13:28:09 -0500
X-OriginalArrivalTime: 20 Jul 2010 18:28:09.0276 (UTC) FILETIME=[4DBE5FC0:01CB2839]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151345>

From: Brandon Casey <drafnel@gmail.com>

The '!()' notation is interpreted as a pattern-list on Ksh.  The Ksh man
page describe it as follows:

   !(pattern-list)
      Matches anything except one of the given patterns.

Ksh performs a file glob using the pattern-list and then tries to execute
the first file in the list.  If a space is added between the '!' and the
open parens, then Ksh will not interpret it as a pattern list, but in this
case, it is preferred to use test_must_fail, so lets do so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/lib-httpd.sh       |    2 +-
 t/t5541-http-push.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 71effc5..e733f65 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -145,7 +145,7 @@ test_http_push_nonff() {
 		echo "changed" > path2 &&
 		git commit -a -m path2 --amend &&
 
-		!(git push -v origin >output 2>&1) &&
+		test_must_fail git push -v origin >output 2>&1 &&
 		(cd "$REMOTE_REPO" &&
 		 test $HEAD = $(git rev-parse --verify HEAD))
 	'
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 504884b..b0c2a2c 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -128,7 +128,7 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 
 	# push master too; this ensures there is at least one '"'push'"' command to
 	# the remote helper and triggers interaction with the helper.
-	!(git push -v origin +master master:retsam >output 2>&1) &&
+	test_must_fail git push -v origin +master master:retsam >output 2>&1 &&
 
 	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
 	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output &&
-- 
1.6.6.2
