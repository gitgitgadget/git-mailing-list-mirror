From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 16 Jan 2008 21:58:26 +0100
Message-ID: <200801162158.26450.kumbayo84@arcor.de>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFFTo-0005Vd-ML
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 22:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbYAPVGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 16:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYAPVGz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 16:06:55 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:38212 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbYAPVGy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 16:06:54 -0500
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 8EE6D32EC31;
	Wed, 16 Jan 2008 22:06:53 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 7A35FABE95;
	Wed, 16 Jan 2008 22:06:53 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 4B25B27ECB;
	Wed, 16 Jan 2008 22:06:53 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200801162147.33448.kumbayo84@arcor.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5487/Wed Jan 16 19:21:33 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70747>

"git repo-config" will be removed soon

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
since i am not good at creating log messages, feel free to change it :-)
built on top of kha experimental patch
passes all testcases for me
 stgit/config.py               |   14 +++++++-------
 t/t1900-mail.sh               |    2 +-
 t/t2100-pull-policy-fetch.sh  |    4 ++--
 t/t2101-pull-policy-pull.sh   |    4 ++--
 t/t2102-pull-policy-rebase.sh |    4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index 1d71cd2..9bfdd52 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -47,7 +47,7 @@ class GitConfig:
         if self.__cache.has_key(name):
             return self.__cache[name]
         try:
-            value = Run('git', 'repo-config', '--get', name).output_one_line()
+            value = Run('git', 'config', '--get', name).output_one_line()
         except RunException:
             value = self.__defaults.get(name, None)
         self.__cache[name] = value
@@ -56,7 +56,7 @@ class GitConfig:
     def getall(self, name):
         if self.__cache.has_key(name):
             return self.__cache[name]
-        values = Run('git', 'repo-config', '--get-all', name
+        values = Run('git', 'config', '--get-all', name
                      ).returns([0, 1]).output_lines()
         self.__cache[name] = values
         return values
@@ -71,23 +71,23 @@ class GitConfig:
     def rename_section(self, from_name, to_name):
         """Rename a section in the config file. Silently do nothing if
         the section doesn't exist."""
-        Run('git', 'repo-config', '--rename-section', from_name, to_name
+        Run('git', 'config', '--rename-section', from_name, to_name
             ).returns([0, 1]).run()
         self.__cache.clear()
 
     def remove_section(self, name):
         """Remove a section in the config file. Silently do nothing if
         the section doesn't exist."""
-        Run('git', 'repo-config', '--remove-section', name
+        Run('git', 'config', '--remove-section', name
             ).returns([0, 1]).discard_stderr().discard_output()
         self.__cache.clear()
 
     def set(self, name, value):
-        Run('git', 'repo-config', name, value).run()
+        Run('git', 'config', name, value).run()
         self.__cache[name] = value
 
     def unset(self, name):
-        Run('git', 'repo-config', '--unset', name)
+        Run('git', 'config', '--unset', name)
         self.__cache[name] = None
 
     def sections_matching(self, regexp):
@@ -96,7 +96,7 @@ class GitConfig:
         group contents, for all variable names matching the regexp.
         """
         result = []
-        for line in Run('git', 'repo-config', '--get-regexp', '"^%s$"' % regexp
+        for line in Run('git', 'config', '--get-regexp', '"^%s$"' % regexp
                         ).returns([0, 1]).output_lines():
             m = re.match('^%s ' % regexp, line)
             if m:
diff --git a/t/t1900-mail.sh b/t/t1900-mail.sh
index e83b2d3..cfdc6f3 100755
--- a/t/t1900-mail.sh
+++ b/t/t1900-mail.sh
@@ -6,7 +6,7 @@ test_description='Test the mail command'
 test_expect_success \
     'Initialize the StGIT repository' \
     '
-    git repo-config stgit.sender "A U Thor <author@example.com>" &&
+    git config stgit.sender "A U Thor <author@example.com>" &&
     for i in 1 2 3 4 5; do
       touch foo.txt &&
       echo "line $i" >> foo.txt &&
diff --git a/t/t2100-pull-policy-fetch.sh b/t/t2100-pull-policy-fetch.sh
index 9e4bc31..670c7c6 100755
--- a/t/t2100-pull-policy-fetch.sh
+++ b/t/t2100-pull-policy-fetch.sh
@@ -19,8 +19,8 @@ test_expect_success \
     (cd upstream && stg init) &&
     stg clone upstream clone &&
     (cd clone &&
-     git repo-config branch.master.stgit.pull-policy fetch-rebase &&
-     git repo-config --list &&
+     git config branch.master.stgit.pull-policy fetch-rebase &&
+     git config --list &&
      stg new c1 -m c1 &&
      echo a > file && git add file && stg refresh
     )
diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
index b4521f0..ce4b5c8 100755
--- a/t/t2101-pull-policy-pull.sh
+++ b/t/t2101-pull-policy-pull.sh
@@ -19,8 +19,8 @@ test_expect_success \
     (cd upstream && stg init) &&
     stg clone upstream clone &&
     (cd clone &&
-     git repo-config branch.master.stgit.pull-policy pull &&
-     git repo-config --list &&
+     git config branch.master.stgit.pull-policy pull &&
+     git config --list &&
      stg new c1 -m c1 &&
      echo a > file && git add file && stg refresh
     )
diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase.sh
index 135b48c..5619bda 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -13,8 +13,8 @@ test_expect_success \
     git branch -m master parent &&
     stg init &&
     stg branch --create stack &&
-    git repo-config branch.stack.stgit.pull-policy rebase &&
-    git repo-config --list &&
+    git config branch.stack.stgit.pull-policy rebase &&
+    git config --list &&
     stg new c1 -m c1 &&
     echo a > file && git add file && stg refresh
     '
-- 
1.5.4.rc3
