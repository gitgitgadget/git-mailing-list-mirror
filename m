From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 1/7] git-submodule: Avoid 'fatal: cannot describe' message
Date: Fri, 14 Mar 2008 01:56:35 +0800
Message-ID: <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhC-0002de-Pa
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYCMR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYCMR4x
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:53 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43769 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757104AbYCMR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:44 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 42EC0470AB; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77117>

When "git submodule status" command tries to show the name of the
submodule HEAD revision more descriptively, but the submodule
repository lacked a suitable tag to do so, it leaked "fatal: cannot
describe" message to the UI.  Squelch it by using '--always'.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5f1d5ef..2f40620 100755
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
1.5.4.4.653.g7cf1e
