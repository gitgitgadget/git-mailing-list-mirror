From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 6/8] git-p4: better message for "git-p4 sync" when not cloned
Date: Sat, 19 Feb 2011 08:17:59 -0500
Message-ID: <1298121481-7005-7-git-send-email-pw@padd.com>
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
	id 1PqmiC-0001ch-2q
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab1BSNSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:43 -0500
Received: from honk.padd.com ([74.3.171.149]:51194 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 293FE20CA;
	Sat, 19 Feb 2011 05:18:18 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EEE9631AE6; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167281>

A common error is to do "git-p4 sync" in a repository that
was not initialized by "git-p4 clone".  There will be no
p4 refs.  The error message in this case is a traceback
for an assertion, which is confusing.

Change it instead to explain the likely problem.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-By: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b847c4..04e6c3d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1676,6 +1676,8 @@ class P4Sync(Command):
 
                 changes.sort()
             else:
+                if not self.p4BranchesInGit:
+                    die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
                                                               self.changeRange)
-- 
1.7.4.1
