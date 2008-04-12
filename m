From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix config key miscount in url.*.insteadOf
Date: Sat, 12 Apr 2008 15:32:00 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804121530000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Blake <ebb9@byu.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 21:32:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JklT0-0007ON-4K
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 21:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYDLTcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYDLTcE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 15:32:04 -0400
Received: from iabervon.org ([66.92.72.58]:53062 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbYDLTcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 15:32:03 -0400
Received: (qmail 22274 invoked by uid 1000); 12 Apr 2008 19:32:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Apr 2008 19:32:00 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79378>

Also tighten test to require it to be correct.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
After all of the changing the name of the config option, I left the wrong 
count for the key length, causing it to eat the first character of the 
URL.

 remote.c              |    2 +-
 t/t5516-fetch-push.sh |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 08af7f9..369dc33 100644
--- a/remote.c
+++ b/remote.c
@@ -315,7 +315,7 @@ static int handle_config(const char *key, const char *value)
 	}
 	if (!prefixcmp(key, "url.")) {
 		struct rewrite *rewrite;
-		name = key + 5;
+		name = key + 4;
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 793ffc6..6d7e738 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -103,9 +103,9 @@ test_expect_success 'fetch with wildcard' '
 test_expect_success 'fetch with insteadOf' '
 	mk_empty &&
 	(
-		TRASH=$(pwd) &&
+		TRASH=$(pwd)/ &&
 		cd testrepo &&
-		git config url./$TRASH/.insteadOf trash/
+		git config url.$TRASH.insteadOf trash/
 		git config remote.up.url trash/. &&
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
@@ -145,8 +145,8 @@ test_expect_success 'push with wildcard' '
 
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
-	TRASH=$(pwd) &&
-	git config url./$TRASH/.insteadOf trash/ &&
+	TRASH=$(pwd)/ &&
+	git config url.$TRASH.insteadOf trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-- 
1.5.4.3.610.gea6cd
