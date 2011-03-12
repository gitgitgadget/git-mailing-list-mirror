From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] git-p4: fix clone @all regression
Date: Sat, 12 Mar 2011 11:23:23 -0500
Message-ID: <20110312162323.GB8509@arf.padd.com>
References: <20110312162246.GA8509@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 17:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyRbI-00063i-St
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 17:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab1CLQX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 11:23:27 -0500
Received: from honk.padd.com ([74.3.171.149]:44213 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab1CLQX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 11:23:27 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 8840920B3;
	Sat, 12 Mar 2011 08:23:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A151E3207D; Sat, 12 Mar 2011 11:23:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110312162246.GA8509@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168947>

Commit e32e00dc88948a730b8b1f3b8129f30c313713e7
"git-p4: better message for "git-p4 sync" when not cloned"
broke the use of the "@all" revision specifier, e.g.,
"git-p4 clone //depot/xxx@all".

Fix it as per Tor Arvid's quick patch.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Reported-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Based-on-patch-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2df3bb2..7cb479c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1763,7 +1763,7 @@ class P4Sync(Command):
 
                 changes.sort()
             else:
-                if not self.p4BranchesInGit:
+                if not isinstance(self, P4Clone) and not self.p4BranchesInGit:
                     die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
-- 
1.7.4.1
