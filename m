From: Len Brown <len.brown@intel.com>
Subject: git-send-email w/ headers
Date: Wed, 4 Oct 2006 12:50:50 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200610041250.50272.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Wed Oct 04 18:51:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV9vZ-0003qA-5t
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 18:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWJDQsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161600AbWJDQsl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 12:48:41 -0400
Received: from hera.kernel.org ([140.211.167.34]:20899 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161257AbWJDQsk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 12:48:40 -0400
Received: from lenb-laptop (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k94GmDJT001802
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 4 Oct 2006 16:48:38 GMT
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/1997/Wed Oct  4 15:20:43 2006 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28329>

git-send-email seems to strip out my custom headers.

git-format-patch says it can do this:

CONFIGURATION
You can specify extra mail header lines to be added to each message in the repository configuration as follows:
headers = "Organization: git-foo\n"

So I have this:
$ cat .git/config
[format]
        headers = Reply-To: Len Brown <lenb@kernel.org>\nOrganization: Intel Open Source Technology Center\n

$ git-format-patch -o foo -n --thread master..lenb
seems to correctly pick up the headers:

$ cat foo/0001-test-create-junk.txt
From 6706b39a213064d00af0ec58a159b71b0719a3b4 Mon Sep 17 00:00:00 2001
Message-Id: <6706b39a213064d00af0ec58a159b71b0719a3b4.1159941986.git.len.brown@intel.com>
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Date: Wed, 4 Oct 2006 01:11:12 -0400
Subject: [PATCH 1/14] test: create junk

Signed-off-by: Len Brown <len.brown@intel.com>
---
 junk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/junk b/junk
new file mode 100644
index 0000000..9ecf3cf
--- /dev/null
+++ b/junk
@@ -0,0 +1 @@
+this
--
1.4.2.3.g128e

$ git-send-email  --no-chain-reply-to --compose --to lenb@kernel.org --smtp-server smpt.comcast.net --suppress-from foo

and i receive a message w/o the Organization and Reply-to headers:

$ cat ~/Documents/test.e-mail-received
From len.brown@intel.com Wed Oct  4 12:34:51 2006
Return-Path: <len.brown@intel.com>
Received: from alnrmhc12.comcast.net (alnrmhc12.comcast.net [206.18.177.52])
        by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k94GVifO030722
        for <lenb@kernel.org>; Wed, 4 Oct 2006 16:32:17 GMT
Received: from localhost.localdomain (c-65-96-213-102.hsd1.ma.comcast.net[65.96.213.102])
          by comcast.net (alnrmhc12) with SMTP
          id <20061004163139b1200eq2t6e>; Wed, 4 Oct 2006 16:31:39 +0000
From: Len Brown <len.brown@intel.com>
To: lenb@kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/14] test: create junk
Date: Wed,  4 Oct 2006 12:34:51 -0400
Message-Id: <11599796921715-git-send-email-len.brown@intel.com>
X-Mailer: git-send-email 1.4.2.3.g128e
In-Reply-To: <11599796913223-git-send-email-len.brown@intel.com>
References: <11599796913223-git-send-email-len.brown@intel.com>
X-Virus-Scanned: ClamAV 0.88.4/1997/Wed Oct  4 15:20:43 2006 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,
        FORGED_RCVD_HELO autolearn=ham version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
Status: R
X-Status: NGC
X-KMail-EncryptionState:
X-KMail-SignatureState:
X-KMail-MDN-Sent:

Signed-off-by: Len Brown <len.brown@intel.com>
---
 junk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/junk b/junk
new file mode 100644
index 0000000..9ecf3cf
--- /dev/null
+++ b/junk
@@ -0,0 +1 @@
+this
--
1.4.2.3.g128e

Same thing happens if I use the SMTP server inside Intel.
I haven't figured out how to send directly via kernel.org using this command
kmail uses a password and ssh to talk to kernel.org.
This is actually sort of an issue too, because smtp.comcast.net
limits the number of messages sent per connection and
will drop after 10 messages with this:
requested action aborted: too many messages on a single connection

thanks,
-Len
