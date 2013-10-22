From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Catch more exceptions in compat_log_entry()
Date: Tue, 22 Oct 2013 10:31:26 -0400
Message-ID: <20131022143126.11775.85272.stgit@IRBT4585>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 16:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYd9G-0006q6-EK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 16:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3JVOlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 10:41:20 -0400
Received: from c60.cesmail.net ([216.154.195.49]:16568 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3JVOlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 10:41:19 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2013 10:41:19 EDT
Received: from unknown (HELO smtprelay1.cesmail.net) ([192.168.1.111])
  by c60.cesmail.net with ESMTP; 22 Oct 2013 10:31:30 -0400
Received: from [127.0.1.1] (206.83.81.178.ptr.us.xo.net [206.83.81.178])
	by smtprelay1.cesmail.net (Postfix) with ESMTPSA id 4FDEA34C5D;
	Tue, 22 Oct 2013 10:32:45 -0400 (EDT)
User-Agent: StGit/0.17-2-gbe68-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236473>

Catch exceptions in default_repo().  Catch git.RepositoryException.
This suppresses stack trace in "stg pull" on detached head and outside
the repository.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---
 stgit/lib/log.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index dfadd51..d876ff6 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -359,10 +359,10 @@ class Fakestack(object):
 def compat_log_entry(msg):
     """Write a new log entry. (Convenience function intended for use by
     code not yet converted to the new infrastructure.)"""
-    repo = default_repo()
     try:
+        repo = default_repo()
         stack = repo.get_stack(repo.current_branch_name)
-    except libstack.StackException, e:
+    except (libstack.StackException, git.RepositoryException), e:
         out.warn(str(e), 'Could not write to stack log')
     else:
         if repo.default_index.conflicts() and stack.patchorder.applied:
