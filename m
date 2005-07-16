From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 3/5] cogito: try harder to find gnu stat
Date: Sat, 16 Jul 2005 19:23:55 -0400
Message-ID: <20050716232341.7317.4962.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw1J-0007XZ-5W
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVGPXYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGPXYD
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:24:03 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:48057 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261882AbVGPXXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:23:55 -0400
Received: (qmail 62282 invoked from network); 16 Jul 2005 23:23:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=FTL7Tl9J2bfrXMy520VdqzF54tsli94vW/uxVPWU24eJsq2saJbgFwSUtOFtLuKWzbILz5Zaasw4uia9giBYNkKNmjsXef8bI9GIFqtNIsH2t+L13//hBJHbNpwFQXRjf3Igq42HnFuaBKU1NlNIlb2KMqQItLXH5DnFEyF2olk=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 16 Jul 2005 23:23:46 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Look harder for gnu stat.

Cogito has code to use awk if gnu stat is missing.  Look harder 
for gnu stat under alternate names such as gstat and gnustat, avoiding
the use of awk if possible.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -229,11 +229,11 @@ fi
 
 
 # Compatibility hacks:
-# Fortunately none as of now.
-
 
 export BROKEN_MKTEMP=1
 del=$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MKTEMP=; }
-has_stat=$(which stat 2>/dev/null)
+has_stat=$(which gnustat 2> /dev/null ||
+    which gstat 2> /dev/null ||
+    which stat 2>/dev/null)
 [ "$has_stat" ] && $has_stat -c %s / 2>/dev/null >&2 || has_stat=
 has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
