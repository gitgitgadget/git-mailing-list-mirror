From: Bryan larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/1] Support configurable SMTP port for stg mail.
Date: Thu, 21 Jul 2005 16:18:33 -0400
Message-ID: <20050721201832.8000.49433.stgit@h164.c77.b0.tor.eicat.ca>
Cc: catalin.marinas@gmail.com, Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvhV6-0003th-M5
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVGUUSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGUUSc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:18:32 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:27801 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261852AbVGUUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 16:18:31 -0400
Received: (qmail 8523 invoked from network); 21 Jul 2005 20:18:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Subject:Date:Message-Id;
  b=glpPronqJLK/t19IlDrX+gQzlFQLoZbxi4TUErfTVtWbZJCW474HZ4yEmMjR8CP6G/sIXORDKdQUHOdOw4LUqzD4SGw9GTI0oe5dCvCTRxEabhxZzVMNYlzVzqGQiIYduUn6k4BZphPYv7gCIGbnrJx4W5MzE1Fgo+Iwkimj4NA=  ;
Received: from unknown (HELO h164.c77.b0.tor.eicat.ca) (bryanlarsen@72.0.77.164 with plain)
  by smtp104.mail.sc5.yahoo.com with SMTP; 21 Jul 2005 20:18:30 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The example configuration file makes it appear that the SMTP port is configurable.  Make it so.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/commands/mail.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -68,6 +68,12 @@ def __parse_addresses(string):
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
         s = smtplib.SMTP(smtpserver)
     except Exception, err:
