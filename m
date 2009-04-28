From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 8/9] Add the log --clear option
Date: Tue, 28 Apr 2009 16:10:20 +0100
Message-ID: <20090428151020.27261.27456.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp07-0002lt-PV
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762156AbZD1PLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762147AbZD1PLU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:11:20 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48993 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762130AbZD1PLL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:11:11 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF7EZm027075;
	Tue, 28 Apr 2009 16:07:14 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:11:06 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:11:06.0579 (UTC) FILETIME=[8DCDFA30:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117783>

This option allows the clearing of the log history which sometimes may
get too large.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/log.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 3370e6c..92aaf0b 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -50,7 +50,9 @@ options = [
     opt('-f', '--full', action = 'store_true',
         short = 'Show the full commit ids'),
     opt('-g', '--graphical', action = 'store_true',
-        short = 'Run gitk instead of printing')]
+        short = 'Run gitk instead of printing'),
+    opt('--clear', action = 'store_true',
+        short = 'Clear the log history')]
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -76,6 +78,11 @@ def func(parser, options, args):
     except KeyError:
         out.info('Log is empty')
         return
+
+    if options.clear:
+        log.delete_log(stack.repository, stack.name)
+        return
+
     stacklog = log.get_log_entry(stack.repository, logref, logcommit)
     pathlim = [os.path.join('patches', pn) for pn in patches]
 
