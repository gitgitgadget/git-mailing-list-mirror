From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/4] git-p4: ensure submit clientPath exists before chdir
Date: Fri,  9 Dec 2011 18:48:14 -0500
Message-ID: <1323474497-14339-2-git-send-email-pw@padd.com>
References: <1323474497-14339-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZABJ-0006rx-Oa
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab1LIXsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:48:42 -0500
Received: from honk.padd.com ([74.3.171.149]:43992 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab1LIXsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:48:41 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 22465EE;
	Fri,  9 Dec 2011 15:48:41 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 172EB313BB; Fri,  9 Dec 2011 18:48:38 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.4.gc2b11.dirty
In-Reply-To: <1323474497-14339-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186706>

From: Gary Gibbons <ggibbons@perforce.com>

Submitting patches back to p4 requires a p4 "client".  This
is a mapping from server depot paths into a local directory.
The directory need not exist or be populated with files; only
the mapping on the server is required.  When there is no
directory, make git-p4 automatically create it.

[ reword description --pw ]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b975d67..99d3abe 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1099,6 +1099,10 @@ class P4Submit(Command, P4UserMap):
         print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()
 
+        # ensure the clientPath exists
+        if not os.path.exists(self.clientPath):
+            os.makedirs(self.clientPath)
+
         chdir(self.clientPath)
         print "Synchronizing p4 checkout..."
         p4_sync("...")
-- 
1.7.8.rc4.42.g8317d
