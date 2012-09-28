From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 17/21] git p4: avoid shell when mapping users
Date: Fri, 28 Sep 2012 08:04:21 -0400
Message-ID: <1348833865-6093-18-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:10:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZOg-000413-FD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581Ab2I1MKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:10:11 -0400
Received: from honk.padd.com ([74.3.171.149]:58380 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I1MKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:10:10 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 366D95AF2;
	Fri, 28 Sep 2012 05:10:10 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 763DD31413; Fri, 28 Sep 2012 08:10:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206575>

The extra quoting and double-% are unneeded, just to work
around the shell.  Instead, avoid the shell indirection.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index a6806bc..a92d84f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -982,7 +982,8 @@ class P4Submit(Command, P4UserMap):
     def p4UserForCommit(self,id):
         # Return the tuple (perforce user,git email) for a given git commit id
         self.getUserMapFromPerforceServer()
-        gitEmail = read_pipe("git log --max-count=1 --format='%%ae' %s" % id)
+        gitEmail = read_pipe(["git", "log", "--max-count=1",
+                              "--format=%ae", id])
         gitEmail = gitEmail.strip()
         if not self.emails.has_key(gitEmail):
             return (None,gitEmail)
-- 
1.7.12.1.403.g28165e1
