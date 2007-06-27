From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Display a message when the server refused some
	recipients.
Date: Wed, 27 Jun 2007 21:48:44 +0200
Message-ID: <20070627194844.22513.16185.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 21:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3dVd-0001C8-6R
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbXF0Ts7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbXF0Ts7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 15:48:59 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59925 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbXF0Ts6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 15:48:58 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7BF925AEA6;
	Wed, 27 Jun 2007 21:48:57 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DD6F71F150;
	Wed, 27 Jun 2007 21:48:44 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51063>

When the smtp server directly refuses some recipients, an exception is
only raised when no recipient got the parcel.  This patch displays the
recipients which were denied.

Subsequent delivery is still done, no change here.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/mail.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 899cb1a..04bdf02 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -176,7 +176,9 @@ def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
             s.ehlo()
             s.login(smtpuser, smtppassword)
 
-        s.sendmail(from_addr, to_addr_list, msg)
+        result = s.sendmail(from_addr, to_addr_list, msg)
+        if len(result):
+            print "mail server refused delivery for the following recipients: %s" % result
         # give recipients a chance of receiving patches in the correct order
         time.sleep(sleep)
     except Exception, err:
