From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/4] Don't special-case the "master" branch during
	branch delete
Date: Sat, 22 Sep 2007 10:46:19 +0200
Message-ID: <20070922084619.29884.94401.stgit@yoghurt>
References: <20070922084334.29884.60506.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0dU-0005ZG-0r
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXIVIqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXIVIqe
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:46:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4110 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXIVIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:46:33 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZ0d2-0001ml-00; Sat, 22 Sep 2007 09:46:20 +0100
In-Reply-To: <20070922084334.29884.60506.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58924>

It's unintuitive, unsymmetric and doesn't work if there is no
"master". Instead, prohibit deletion of the current branch.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 2d491d5..8c99936 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -96,17 +96,10 @@ def __delete_branch(doomed_name, force =3D False):
     out.start('Deleting branch "%s"' % doomed_name)
=20
     if __is_current_branch(doomed_name):
-        check_local_changes()
-        check_conflicts()
-        check_head_top_equal()
-
-        if doomed_name !=3D 'master':
-            git.switch_branch('master')
+        raise CmdException('Cannot delete the current branch')
=20
     doomed.delete(force)
-
-    if doomed_name !=3D 'master':
-        git.delete_branch(doomed_name)
+    git.delete_branch(doomed_name)
=20
     out.done()
=20
