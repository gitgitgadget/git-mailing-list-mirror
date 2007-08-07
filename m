From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Ask for SMTP password if it's not provided
Date: Mon, 06 Aug 2007 22:16:15 -0400
Message-ID: <20070807021614.21226.13314.stgit@gx.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 04:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIEcP-00089N-B1
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbXHGCQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 22:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765438AbXHGCQS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:16:18 -0400
Received: from c60.cesmail.net ([216.154.195.49]:14218 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbXHGCQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:16:17 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 06 Aug 2007 22:16:16 -0400
Received: from gx.roinet.com (c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166])
	by relay.cesmail.net (Postfix) with ESMTP id E6A81618FE1;
	Mon,  6 Aug 2007 22:16:15 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55198>

Mention this in examples/gitconfig, explain SMTP options in more detail.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 examples/gitconfig     |    9 ++++++++-
 stgit/commands/mail.py |    6 +++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index 3abbe6a..e402208 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -18,10 +18,17 @@
 	# 'refresh' will automatically mark the conflicts as resolved
 	#autoresolved = no
 
+	# SMTP server for sending patches
 	#smtpserver = localhost:25
+
+	# Set to 'yes' to use SMTP over TLS
+	#smtptls = no
+
+	# Username for SMTP authentication, required if TLS is used
 	#smtpuser = username
+
+	# Password for SMTP.  If not provided, it will be asked
 	#smtppassword = password
-	#smtptls = no
 
 	# delay between messages in seconds (defaults to 5)
 	#smtpdelay = 5
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 7ed5c27..69712cb 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -15,7 +15,7 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os, re, time, datetime, socket, smtplib
+import sys, os, re, time, datetime, socket, smtplib, getpass
 import email, email.Utils, email.Header
 from optparse import OptionParser, make_option
 
@@ -492,10 +492,10 @@ def func(parser, options, args):
 
     if (smtppassword and not smtpuser):
         raise CmdException, 'SMTP password supplied, username needed'
-    if (smtpuser and not smtppassword):
-        raise CmdException, 'SMTP username supplied, password needed'
     if (smtpusetls and not smtpuser):
         raise CmdException, 'SMTP over TLS requested, username needed'
+    if (smtpuser and not smtppassword):
+        smtppassword = getpass.getpass("Please enter SMTP password: ")
 
     total_nr = len(patches)
     if total_nr == 0:
