From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 17/21] git p4: avoid shell when mapping users
Date: Sat, 26 Jan 2013 22:11:20 -0500
Message-ID: <1359256284-5660-18-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIkM-0006tw-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab3A0DRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:17:09 -0500
Received: from honk.padd.com ([74.3.171.149]:44474 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551Ab3A0DRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:17:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 90D192F3F;
	Sat, 26 Jan 2013 19:17:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EE83322838; Sat, 26 Jan 2013 22:17:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214668>

The extra quoting and double-% are unneeded, just to work
around the shell.  Instead, avoid the shell indirection.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index a989704..c43d044 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1050,7 +1050,8 @@ class P4Submit(Command, P4UserMap):
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
1.8.1.1.460.g6fa8886
