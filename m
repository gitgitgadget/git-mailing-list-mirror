From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/4] Teach new infrastructure to diff two trees
Date: Tue, 29 Jan 2008 04:16:19 +0100
Message-ID: <20080129031558.1177.80102.stgit@yoghurt>
References: <20080129031310.1177.83290.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgyY-0006tF-6l
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbYA2DQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbYA2DQX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:16:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4653 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758650AbYA2DQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:16:21 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgxN-0000fH-00; Tue, 29 Jan 2008 03:16:17 +0000
In-Reply-To: <20080129031310.1177.83290.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71942>

Nothing uses this yet, but "stg edit" will soon.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 9cb2521..d75f724 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -1,5 +1,6 @@
 import os, os.path, re
 from stgit import exception, run, utils
+from stgit.config import config
=20
 class RepositoryException(exception.StgException):
     pass
@@ -355,6 +356,11 @@ class Repository(RunWithEnv):
                 return None
         finally:
             index.delete()
+    def diff_tree(self, t1, t2, diff_opts):
+        assert isinstance(t1, Tree)
+        assert isinstance(t2, Tree)
+        return self.run(['git', 'diff-tree', '-p'] + list(diff_opts)
+                        + [t1.sha1, t2.sha1]).raw_output()
=20
 class MergeException(exception.StgException):
     pass
