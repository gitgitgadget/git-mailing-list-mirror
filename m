From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: Avoid 'fatal: cannot describe' message
Date: Thu, 10 Apr 2008 22:45:29 +0800
Message-ID: <1207838729-5567-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 10 16:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjy2i-00052V-Re
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 16:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbYDJOpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 10:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbYDJOpf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 10:45:35 -0400
Received: from mail.qikoo.org ([60.28.205.235]:56625 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758582AbYDJOpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 10:45:34 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id BE474470AE; Thu, 10 Apr 2008 22:45:29 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79215>

When "git submodule status" command tries to show the name of the
submodule HEAD revision more descriptively, but the submodule
repository lacked a suitable tag to do so, it leaked "fatal: cannot
describe" message to the UI.  Squelch it by using '--always'.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 56ec353..7674346 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -327,7 +327,7 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags "$2"
+			git describe --contains --tags --always "$2"
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
-- 
1.5.5.23.g2a5f
