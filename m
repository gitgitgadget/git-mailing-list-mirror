From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: Handle 'A' flag for new files
Date: Thu, 28 Jul 2005 13:20:32 +0100
Message-ID: <tnxwtnbunov.fsf@arm.com>
References: <m3d5p3kuv1.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 14:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy7S8-0002O2-FR
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 14:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVG1MYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 08:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVG1MWq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 08:22:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23765 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261418AbVG1MVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 08:21:07 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6SCKKs4020861;
	Thu, 28 Jul 2005 13:20:20 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id NAA04425;
	Thu, 28 Jul 2005 13:21:04 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 28 Jul 2005 13:21:03 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3d5p3kuv1.fsf@telia.com> (Peter Osterlund's message of "28
 Jul 2005 13:55:46 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 28 Jul 2005 12:21:03.0203 (UTC) FILETIME=[D230DB30:01C5936E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
> Patches that add new files don't work correctly if git reports them
> with the 'A' flag. StGIT claims there are unresolved conflicts. This
> patch fixes it.

Thanks. Applied (together with the one below).

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -292,7 +292,7 @@ def commit(message, files = [], parents
         rm_files=[]
         m_files=[]
         for f in cache_files:
-            if f[0] == 'N':
+            if f[0] in ['N', 'A']:
                 add_files.append(f[1])
             elif f[0] == 'D':
                 rm_files.append(f[1])
@@ -437,7 +437,8 @@ def checkout(files = [], force = False):
 def switch(tree_id):
     """Switch the tree to the given id
     """
-    to_delete = filter(lambda x: x[0] == 'N', __tree_status(tree_id = tree_id))+    to_delete = filter(lambda x: x[0] in ['N', 'A'],
+                       __tree_status(tree_id = tree_id))

     if __run('git-read-tree -m', [tree_id]) != 0:
         raise GitException, 'Failed git-read-tree -m %s' % tree_id

-- 
Catalin
