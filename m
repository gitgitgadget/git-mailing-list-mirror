From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Allow .git/branches and .git/remotes to be missing
Date: Thu, 01 Feb 2007 19:33:05 -0500
Message-ID: <1170376385.28867.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 01:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCmMf-0005jp-6R
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 01:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423031AbXBBAdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 19:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbXBBAdK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 19:33:10 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:49735 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423031AbXBBAdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 19:33:09 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HCmLW-0008T1-5p
	for git@vger.kernel.org; Thu, 01 Feb 2007 19:32:06 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HCmMU-0004wa-2q; Thu, 01 Feb 2007 19:33:06 -0500
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38440>

From: Pavel Roskin <proski@gnu.org>

Both directories are now obsoleted by .git/config file.  This fixes
"make test" in StGIT with git 1.5.0-rc3.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/git.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index c7cc6a7..553a6bf 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -908,7 +908,11 @@ def __remotes_from_config():
     return config.sections_matching(r'remote\.(.*)\.url')
 
 def __remotes_from_dir(dir):
-    return os.listdir(os.path.join(basedir.get(), dir))
+    d = os.path.join(basedir.get(), dir)
+    if os.path.exists(d):
+        return os.listdir(d)
+    else:
+        return None
 
 def remotes_list():
     """Return the list of remotes in the repository

-- 
Regards,
Pavel Roskin
