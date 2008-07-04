From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Discard stderr output from git apply
Date: Fri, 04 Jul 2008 08:35:18 +0200
Message-ID: <20080704063427.9515.68707.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEeuZ-0008N7-98
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbYGDGfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 02:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYGDGfx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:35:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1115 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYGDGfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:35:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEet3-0000LZ-00; Fri, 04 Jul 2008 07:35:17 +0100
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87362>

It prints error messages when it fails, and we don't need to see them
since we don't care exactly _why_ it failed.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

With the optimizations that make us start using apply a lot; I noticed
git apply was spamming on stderr.

 stgit/lib/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6ccdfa7..9208965 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -556,7 +556,7 @@ class Index(RunWithEnv):
         """In-index patch application, no worktree involved."""
         try:
             self.run(['git', 'apply', '--cached']
-                     ).raw_input(patch_text).no_output()
+                     ).raw_input(patch_text).discard_stderr().no_outpu=
t()
         except run.RunException:
             raise MergeException('Patch does not apply cleanly')
     def delete(self):
