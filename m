From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Change GIT-VERSION-GEN to call git commands with "git" not
 "git-".
Date: Mon, 22 May 2006 00:39:52 -0400
Message-ID: <BAYC1-PASMTP09B22AA86724B4F2C01F7FAE9A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 22 06:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi2Ig-0001Eq-R4
	for gcvg-git@gmane.org; Mon, 22 May 2006 06:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWEVEpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 00:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEVEpr
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 00:45:47 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:40279 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751223AbWEVEpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 00:45:46 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 21 May 2006 21:47:29 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id A9B4E644C28
	for <git@vger.kernel.org>; Mon, 22 May 2006 00:45:44 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060522003952.038fc6d6.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 May 2006 04:47:29.0265 (UTC) FILETIME=[D484F610:01C67D5A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


GIT-VERSION-GEN can incorrectly return a default version of
"v1.3.GIT" because it tries to execute git commands using the
"git-cmd" format that expects all git commands to be in the $PATH.
Convert these to  "git cmd" format so that a proper answer is
returned even when the git commands have been moved out of the
$PATH and into a $gitexecdir.
---
 GIT-VERSION-GEN |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 7fcefcd..a461518 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,7 +5,7 @@ DEF_VER=v1.3.GIT
 
 # First try git-describe, then see if there is a version file
 # (included in release tarballs), then default
-if VN=$(git-describe --abbrev=4 HEAD 2>/dev/null); then
+if VN=$(git describe --abbrev=4 HEAD 2>/dev/null); then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
 elif test -f version
 then
@@ -16,7 +16,7 @@ fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-dirty=$(sh -c 'git-diff-index --name-only HEAD' 2>/dev/null) || dirty=
+dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=
 case "$dirty" in
 '')
 	;;
-- 
1.3.3.ge95c
