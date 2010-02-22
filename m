From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 1/3] t9151: Fix a few commits in the SVN dump
Date: Mon, 22 Feb 2010 09:57:20 +0200
Message-ID: <1266825442-32107-2-git-send-email-tuomas.suutari@gmail.com>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:14:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTBJ-00051w-C6
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab0BVH6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:58:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:27134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab0BVH55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:57:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so243658fga.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 23:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0m8nQNhze4oiEAYkV4jiGN7huWyhJ+u29U+BxPkFI1Q=;
        b=wjoo6J9b3Cs+4k47Dek5RgPlp3cwgcQ8+irCLpeYxV+rEM9TzUWPF8gCVpu2BAIqaj
         ecZ0I5/s+BzYzI1QrDx+0pjOQxIUT4v+jVGmkD0XC5DksFWHF+eOvARP0JuWmivn6kko
         KyuHT5vRD5saFWna7PoCrZg7mxW7Fy6xUVuOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CQ1s4hxS6iB3liw91rM1+X5fjX1Erpp2hqlRVDL6iG8e9/KLyWP9Jt5Ncu0kHhqBvG
         JPJj47QRztDrlei4fgKqXjQUxXg9r16K55pY18URwQ1OnL3dkSjNq5xc3ZluPGfNtULp
         tbQg0g4PuvbW2Eski+nDpL3LZanf3wizWJi/M=
Received: by 10.86.233.20 with SMTP id f20mr3897340fgh.30.1266825475680;
        Sun, 21 Feb 2010 23:57:55 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id e3sm4952313fga.16.2010.02.21.23.57.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 23:57:55 -0800 (PST)
X-Mailer: git-send-email 1.7.0.86.g7501
In-Reply-To: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140646>

A few "svn cp" commands and commit commands were executed in incorrect
order. Therefore some of the desired commits were missing and some
were committed with wrong revision number in the commit message. This
made it hard to compare the produced git repository with the SVN
repository.

The dump file is updated too, but only the relevant parts and with
hand-edited timestamps to make history linear.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
 t/t9151/make-svnmerge-dump |    6 +-
 t/t9151/svn-mergeinfo.dump |  106 +++++++++++++++++++++++++++++--------------
 2 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
index 3d73f14..3168c7c 100644
--- a/t/t9151/make-svnmerge-dump
+++ b/t/t9151/make-svnmerge-dump
@@ -174,8 +174,8 @@ cd ..
 
 say "Make PARTIAL branch"
 svn update
-i=$(commit $i "make partial branch")
 svn cp trunk/subdir branches/partial
+i=$(commit $i "make partial branch")
 
 say "Make a commit to PARTIAL"
 svn update
@@ -194,13 +194,13 @@ cd ../../
 
 say "Tagging trunk"
 svn update
-i=$(commit $i "tagging v1.0")
 svn cp trunk tags/v1.0
+i=$(commit $i "tagging v1.0")
 
 say "Branching BUGFIX from v1.0"
 svn update
-i=$(commit $i "make bugfix branch from tag")
 svn cp tags/v1.0 branches/bugfix
+i=$(commit $i "make bugfix branch from tag")
 
 say "Make a commit to BUGFIX"
 svn update
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index ebf386e..f228958 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -1713,13 +1713,13 @@ Node-copyfrom-path: branches/left/subdir
 
 
 Revision-number: 27
-Prop-content-length: 118
-Content-length: 118
+Prop-content-length: 123
+Content-length: 123
 
 K 7
 svn:log
-V 20
-(r28) partial update
+V 25
+(r27) make partial branch
 K 10
 svn:author
 V 3
@@ -1737,6 +1737,24 @@ Node-copyfrom-rev: 26
 Node-copyfrom-path: trunk/subdir
 
 
+Revision-number: 28
+Prop-content-length: 118
+Content-length: 118
+
+K 7
+svn:log
+V 20
+(r28) partial update
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:14:54.000000Z
+PROPS-END
+
 Node-path: branches/partial/palindromes
 Node-kind: file
 Node-action: add
@@ -1750,7 +1768,7 @@ PROPS-END
 racecar
 
 
-Revision-number: 28
+Revision-number: 29
 Prop-content-length: 126
 Content-length: 126
 
@@ -1771,15 +1789,15 @@ PROPS-END
 Node-path: trunk/subdir
 Node-kind: dir
 Node-action: change
-Prop-content-length: 142
-Content-length: 142
+Prop-content-length: 145
+Content-length: 145
 
 K 13
 svn:mergeinfo
-V 106
+V 109
 /branches/left/subdir:2-25
 /branches/left-sub/subdir:4-19
-/branches/partial:27
+/branches/partial:27-28
 /branches/right/subdir:2-22
 PROPS-END
 
@@ -1787,20 +1805,20 @@ PROPS-END
 Node-path: trunk/subdir/palindromes
 Node-kind: file
 Node-action: add
-Node-copyfrom-rev: 27
+Node-copyfrom-rev: 28
 Node-copyfrom-path: branches/partial/palindromes
 Text-copy-source-md5: 5d1c2024fb5efc4eef812856df1b080c
 Text-copy-source-sha1: 5f8509ddd14c91a52864dd1447344e706f9bbc69
 
 
-Revision-number: 29
-Prop-content-length: 131
-Content-length: 131
+Revision-number: 30
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
-V 33
-(r31) make bugfix branch from tag
+V 18
+(r30) tagging v1.0
 K 10
 svn:author
 V 3
@@ -1814,18 +1832,18 @@ PROPS-END
 Node-path: tags/v1.0
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 28
+Node-copyfrom-rev: 29
 Node-copyfrom-path: trunk
 
 
-Revision-number: 30
-Prop-content-length: 120
-Content-length: 120
+Revision-number: 31
+Prop-content-length: 131
+Content-length: 131
 
 K 7
 svn:log
-V 22
-(r32) commit to bugfix
+V 33
+(r31) make bugfix branch from tag
 K 10
 svn:author
 V 3
@@ -1833,16 +1851,34 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:15:03.043218Z
+2010-01-19T04:15:01.000000Z
 PROPS-END
 
 Node-path: branches/bugfix
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 29
+Node-copyfrom-rev: 30
 Node-copyfrom-path: tags/v1.0
 
 
+Revision-number: 32
+Prop-content-length: 120
+Content-length: 120
+
+K 7
+svn:log
+V 22
+(r32) commit to bugfix
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:15:02.000000Z
+PROPS-END
+
 Node-path: branches/bugfix/subdir/palindromes
 Node-kind: file
 Node-action: change
@@ -1855,7 +1891,7 @@ racecar
 kayak
 
 
-Revision-number: 31
+Revision-number: 33
 Prop-content-length: 125
 Content-length: 125
 
@@ -1876,35 +1912,35 @@ PROPS-END
 Node-path: trunk
 Node-kind: dir
 Node-action: change
-Prop-content-length: 133
-Content-length: 133
+Prop-content-length: 137
+Content-length: 137
 
 K 13
 svn:mergeinfo
-V 98
-/branches/bugfix:30
+V 101
+/branches/bugfix:31-32
 /branches/left:2-25
 /branches/left-sub:4-19
 /branches/right:2-22
-/tags/v1.0:29
+/tags/v1.0:30
 PROPS-END
 
 
 Node-path: trunk/subdir
 Node-kind: dir
 Node-action: change
-Prop-content-length: 190
-Content-length: 190
+Prop-content-length: 196
+Content-length: 196
 
 K 13
 svn:mergeinfo
-V 154
-/branches/bugfix/subdir:30
+V 160
+/branches/bugfix/subdir:31-32
 /branches/left/subdir:2-25
 /branches/left-sub/subdir:4-19
-/branches/partial:27
+/branches/partial:27-28
 /branches/right/subdir:2-22
-/tags/v1.0/subdir:29
+/tags/v1.0/subdir:30
 PROPS-END
 
 
-- 
1.7.0.86.g7501
