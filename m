From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] git-p4: Fix error message crash in P4Sync.commit.
Date: Tue,  8 Feb 2011 13:20:10 +0100
Message-ID: <1297167610-1795-1-git-send-email-torarvid@gmail.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 13:50:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmn1y-0006Hd-5T
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 13:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1BHMut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 07:50:49 -0500
Received: from smtp2.powertech.no ([195.159.0.177]:33566 "EHLO
	smtp3.powertech.no" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751519Ab1BHMus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 07:50:48 -0500
Received: from exchange.qsystems.no (unknown [77.40.144.122])
	by smtp3.powertech.no (Postfix) with ESMTP id 7D211CE2AE;
	Tue,  8 Feb 2011 13:20:25 +0100 (CET)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 8 Feb 2011 13:20:25 +0100
Received: by pingvin1 (Postfix, from userid 1000)
	id 4921E584D7; Tue,  8 Feb 2011 13:20:25 +0100 (CET)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
X-OriginalArrivalTime: 08 Feb 2011 12:20:25.0429 (UTC) FILETIME=[9085C050:01CBC78A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166351>

There is an error message that crashes the script because of an invalid ref
to the non-existing "path" variable. It is almost never printed, which
would explain why nobody encountered this problem before... But anyway,
this oneliner fixes it.
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index ca3cea0..29b9e32 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1086,7 +1086,7 @@ class P4Sync(Command):
             if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
                 new_files.append (f)
             else:
-                sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
+                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
-- 
1.7.3.1.68.g06779.dirty
