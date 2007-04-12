From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Don't show gitlink directories when we want "other" files
Date: Thu, 12 Apr 2007 14:32:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121430580.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc6uE-0001MZ-WC
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbXDLVca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030782AbXDLVca
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:32:30 -0400
Received: from smtp.osdl.org ([65.172.181.24]:32904 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030780AbXDLVc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:32:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CLWMIs024932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 14:32:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CLWL4b017333;
	Thu, 12 Apr 2007 14:32:21 -0700
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44354>


When "show_other_directories" is set, that implies that we are looking
for untracked files, which obviously means that we should ignore
directories that are marked as gitlinks in the index.

This fixes "git status" in a superproject, that would otherwise always 
report that subprojects were "Untracked files:"

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 dir.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 7b91501..6564a92 100644
--- a/dir.c
+++ b/dir.c
@@ -375,6 +375,8 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 		return recurse_into_directory;
 
 	case index_gitdir:
+		if (dir->show_other_directories)
+			return ignore_directory;
 		return show_directory;
 
 	case index_nonexistent:
