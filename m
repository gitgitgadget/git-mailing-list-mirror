From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/8] git-p4: reinterpret confusing p4 message
Date: Sat, 5 Feb 2011 17:52:14 -0500
Message-ID: <20110205225214.GF30963@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlqzV-0006Y7-Aw
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1BEWwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:52:24 -0500
Received: from honk.padd.com ([74.3.171.149]:33462 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab1BEWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:52:24 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 82136EF;
	Sat,  5 Feb 2011 14:52:22 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9B86131AE6; Sat,  5 Feb 2011 17:52:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110205224848.GA30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166125>

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
1.7.2.3
