From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 5/8] git-p4: reinterpret confusing p4 message
Date: Sat, 19 Feb 2011 08:17:58 -0500
Message-ID: <1298121481-7005-6-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqmiB-0001ch-Gu
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab1BSNSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:40 -0500
Received: from honk.padd.com ([74.3.171.149]:51190 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 19A4D20C9;
	Sat, 19 Feb 2011 05:18:18 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id ECB8431ADE; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167280>

Error output will look like this:

glom$ git p4 clone //deopt
Importing from //deopt into .
Reinitialized existing Git repository in /tmp/x/.git/
Doing initial import of //deopt from revision #head into refs/remotes/p4/master
p4 returned an error: //deopt/... - must refer to client glom.

This particular p4 error is misleading.
Perhaps the depot path was misspelled.
Depot path:  //deopt

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index db19b17..6b847c4 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1445,6 +1445,10 @@ class P4Sync(Command):
             if 'code' in info and info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
                                  % info['data'])
+                if info['data'].find("must refer to client") >= 0:
+                    sys.stderr.write("This particular p4 error is misleading.\n")
+                    sys.stderr.write("Perhaps the depot path was misspelled.\n");
+                    sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
-- 
1.7.4.1
