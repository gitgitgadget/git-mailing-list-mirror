From: Bryan larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/1] Support configurable SMTP port for stg mail.
Date: Thu, 21 Jul 2005 16:20:58 -0400
Message-ID: <20050721202058.8047.77221.stgit@h164.c77.b0.tor.eicat.ca>
Cc: catalin.marinas@gmail.com, Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:21:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvhXW-0004FG-NE
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVGUUU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVGUUU7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:20:59 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:58299 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261869AbVGUUU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 16:20:57 -0400
Received: (qmail 2856 invoked from network); 21 Jul 2005 20:20:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Subject:Date:Message-Id;
  b=DniuyIY1PLMB/KQrzqJ/daqrN4UMMkKxBaFzW9ldKdJ1ctgLoMY02g8ni4kuInGFXxK8woeRhX21aOKT3O1DRW28f+Z5YYBiQCP7eUAS4ASkTxHIMZGmKFDCItrY+MI+IDYrI1lIlvUOWVwH3874HYX/54bRvQ1vsbVfL49kbk0=  ;
Received: from unknown (HELO h164.c77.b0.tor.eicat.ca) (bryanlarsen@72.0.77.164 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 21 Jul 2005 20:20:56 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The example configuration file makes it appear that the SMTP port is configurable.  Make it so.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/commands/mail.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -68,8 +68,14 @@ def __parse_addresses(string):
 def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep):
     """Send the message using the given SMTP server
     """
+    if smtpserver.find(':')==-1:
+        smtpport=25
+    else:
+        smtpport=int(smtpserver[smtpserver.find(':')+1:])
+        smtpserver=smtpserver[:smtpserver.find(':')]
+
     try:
-        s = smtplib.SMTP(smtpserver)
+        s = smtplib.SMTP(smtpserver, smtpport)
     except Exception, err:
         raise CmdException, str(err)
 
