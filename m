From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 2/2] t5570: Update for clone-progress-to-stderr branch
Date: Mon, 21 Oct 2013 13:54:12 -0400
Message-ID: <1382378052-89929-2-git-send-email-brian@gernhardtsoftware.com>
References: <1382378052-89929-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 21 20:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYJpr-0003Py-6E
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 20:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab3JUSEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 14:04:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35811 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab3JUSD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 14:03:59 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2013 14:03:59 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2DB0527361DC; Mon, 21 Oct 2013 17:54:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (u-of-rochester-128-151-150-17.wireless.rochester.edu [128.151.150.17])
	by silverinsanity.com (Postfix) with ESMTPA id C97E427361C9;
	Mon, 21 Oct 2013 17:54:19 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <1382378052-89929-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236437>

git clone now reports its progress to standard error, which throws off
t5570.  Using test_i18ngrep instead of test_cmp allows the test to be
more flexible by only looking for the expected error and ignoring any
other output from the program.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t5570-git-daemon.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index dc55e51..e061468 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -122,8 +122,7 @@ test_remote_error()
 	fi
 
 	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" "$@" 2>output &&
-	echo "fatal: remote error: $msg: /$repo" >expect &&
-	test_cmp expect output
+	test_i18ngrep "fatal: remote error: $msg: /$repo" output &&
 	ret=$?
 	chmod +x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git"
 	(exit $ret)
-- 
1.8.3.4 (Apple Git-47)
