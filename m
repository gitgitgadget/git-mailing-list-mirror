From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] WinGit: include html pages from official git.git's html branch
Date: Sat, 29 Sep 2007 18:05:53 +0200
Message-ID: <11910819542185-git-send-email-prohaska@zib.de>
References: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
 <11910819531200-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 18:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbepQ-0007q8-Rp
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbXI2QF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbXI2QF5
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:05:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:62293 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbXI2QFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:05:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8TG5swb009031
	for <git@vger.kernel.org>; Sat, 29 Sep 2007 18:05:54 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8TG5rQu010394;
	Sat, 29 Sep 2007 18:05:54 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11910819531200-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It is assumed that a matching version of the html documentation
is available as the HEAD of /doc/git/html/.git. If not an error
will be reported.

This patch doesn't include a mechanism to fetch the html pages
to /doc/git/html/.git. You should manually clone them. Maybe
this could handled as a submodule of msysgit?

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 share/WinGit/release.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/share/WinGit/release.sh b/share/WinGit/release.sh
index 5ab876a..8a3c197 100644
--- a/share/WinGit/release.sh
+++ b/share/WinGit/release.sh
@@ -5,6 +5,8 @@ test -z "$1" && {
 	exit 1
 }
 
+test -d /doc/git/html/.git || { echo "Error: html pages in /doc/git/html/.git missing"; exit 1; }
+
 TARGET="$HOME"/WinGit-$1.exe
 OPTS7="-m0=lzma -mx=9 -md=64M"
 TARGET7=tmp.7z
@@ -21,6 +23,9 @@ mkdir "$TMPDIR" &&
  cp uninstaller.exe "$TMPDIR"/bin) &&
 cd "$TMPDIR" &&
 echo "Copying files" &&
+(git --git-dir=/doc/git/html/.git log --pretty=format:%s -1 HEAD &&
+ mkdir -p doc/git/html && cd doc/git/html &&
+ git --git-dir=/doc/git/html/.git archive HEAD | tar xf -) &&
 (cd / && tar cf - bin/{git*,awk,basename.exe,bash.exe,bunzip2,bzip2.exe,\
 cat.exe,chmod.exe,clear,cmp.exe,cp.exe,cpio,cut.exe,cvs.exe,date.exe,diff.exe,\
 du.exe,echo,egrep,env.exe,expr.exe,false.exe,find.exe,gawk.exe,grep.exe,\
-- 
1.5.3.mingw.1.3.g195850
