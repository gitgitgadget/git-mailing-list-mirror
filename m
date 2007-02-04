From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/4] Rename branch section in config when the branch is renamed
Date: Sun, 04 Feb 2007 00:32:21 -0500
Message-ID: <20070204053221.15035.88015.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDZzP-0003HP-Nc
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbXBDFcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbXBDFcY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:32:24 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48770 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbXBDFcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:32:23 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDZy9-0008Fv-UC
	for git@vger.kernel.org; Sun, 04 Feb 2007 00:31:18 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDZzB-0003un-Mi; Sun, 04 Feb 2007 00:32:21 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38649>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/config.py |    3 +++
 stgit/stack.py  |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index 48b4e2d..fb38932 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -96,6 +96,9 @@ class GitConfig:
         else:
             raise GitConfigException, 'Value for "%s" is not an integer: "%s"' % (name, value)
 
+    def rename_section(self, from_name, to_name):
+        self.__run('git-repo-config --rename-section', [from_name, to_name])
+
     def set(self, name, value):
         self.__run('git-repo-config', [name, value])
 
diff --git a/stgit/stack.py b/stgit/stack.py
index 96863c6..c3bf3c6 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -590,6 +590,10 @@ class Series(StgitObject):
             rename(os.path.join(self.__base_dir, 'refs', 'patches'),
                    self.__name, to_stack.__name)
 
+        # Rename the config section
+        config.rename_section("branch.%s" % self.__name,
+                              "branch.%s" % to_name)
+
         self.__init__(to_name)
 
     def clone(self, target_series):
