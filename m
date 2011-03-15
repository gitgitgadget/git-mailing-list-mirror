From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH 3/3] git-p4: Fix error message crash in P4Sync.commit.
Date: Tue, 15 Mar 2011 13:08:03 +0100
Message-ID: <1300190883-31833-3-git-send-email-torarvid@gmail.com>
References: <1300190883-31833-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 14:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzTzI-0001Aw-82
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 14:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab1CONIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 09:08:24 -0400
Received: from thalia-smout.broadpark.no ([80.202.8.21]:46152 "EHLO
	thalia-smout.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727Ab1CONIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 09:08:22 -0400
Received: from terra-smin.broadpark.no ([80.202.8.13])
 by thalia-smout.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI300DNBLPW7I40@thalia-smout.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:20 +0100 (CET)
Received: from exchange.qsystems.no ([84.49.55.106]) by terra-smin.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI3008QSLPW7Z20@terra-smin.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:20 +0100 (CET)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with
 Microsoft SMTPSVC(6.0.3790.4675); Tue, 15 Mar 2011 13:08:20 +0100
Received: by pingvin1 (Postfix, from userid 1000)	id 8DCB5240910; Tue,
 15 Mar 2011 13:08:20 +0100 (CET)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
In-reply-to: <1300190883-31833-1-git-send-email-torarvid@gmail.com>
X-OriginalArrivalTime: 15 Mar 2011 12:08:20.0656 (UTC)
 FILETIME=[ACFB6B00:01CBE309]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169070>

There is an error message that crashes the script because of an invalid ref
to the non-existing "path" variable. It is almost never printed, which
would explain why nobody encountered this problem before... But anyway,
this oneliner fixes it.

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d47596f..47ba7ad 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1160,7 +1160,7 @@ class P4Sync(Command):
             if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
                 new_files.append (f)
             else:
-                sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
+                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
-- 
1.7.3.1.68.g06779.dirty
