From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] git-p4: fix sync new branch regression
Date: Wed, 16 Mar 2011 16:52:46 -0400
Message-ID: <20110316205246.GA23387@arf.padd.com>
References: <20110316205008.GA22702@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Horowitz <michael.horowitz@ieee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxiB-0007mH-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1CPUwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:52:51 -0400
Received: from honk.padd.com ([74.3.171.149]:43583 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab1CPUwu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:52:50 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 7738D20B9;
	Wed, 16 Mar 2011 13:52:49 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D6EA05AB92; Wed, 16 Mar 2011 16:52:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110316205008.GA22702@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169196>

e32e00d (git-p4: better message for "git-p4 sync" when not
cloned, 2011-02-19) broke another use case, that of using
"git-p4 sync" to import a new branch into an existing repository.

Refine the fix again, on top of the fix in ac34efc.

Reported-by: Michael Horowitz <michael.horowitz@ieee.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
Tested-by: Michael Horowitz <michael.horowitz@ieee.org>
---
 contrib/fast-import/git-p4 |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 7cb479c..2eacb95 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1763,7 +1763,9 @@ class P4Sync(Command):
 
                 changes.sort()
             else:
-                if not isinstance(self, P4Clone) and not self.p4BranchesInGit:
+                # catch "git-p4 sync" with no new branches, in a repo that
+                # does not have any existing git-p4 branches
+                if len(args) == 0 and not self.p4BranchesInGit:
                     die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
-- 
1.7.4.1
