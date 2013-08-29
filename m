From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/9] stash: add --stage option to save
Date: Thu, 29 Aug 2013 13:14:35 -0500
Message-ID: <1377800080-5309-5-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:20:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6pS-0004t7-87
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab3H2SUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:20:14 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:47485 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271Ab3H2SUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:13 -0400
Received: by mail-oa0-f42.google.com with SMTP id j10so854964oah.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3LKQoqt6c9wcyKwxavDlNf6Zs5ainVLBM9c7zQ+Jw0M=;
        b=DlK7pTrRjyWQxT8MQDOnofA3E1oz1JmC8tQ39x09mNDicJpzdFXKOwi1D013Rk/riD
         S1FRbon42mxoSDo5II9PEfIzuAfA8nPt+4GK/9qaiC0/SWqCY45SR6MBQNG+RP7wY2Q8
         BUCULgc2dgv7NXf7H4K4FkmgOlxsjl1KiZWPPgiJKV/HDSxa9cweWeNVYuMdEbJCpPDX
         /PUqlhsEMuEgkTtq9khlGaiKgHUSFpvhopQYiIXUi+QfrUzyipEXPyl8z767rxsiMv0M
         d5E6wRtKkw50dbwmvEL0ybgyY2uv+l/y3VPZM4UdDxAuoHh52nHh2SJLAVaR3N2nA7RV
         mrzg==
X-Received: by 10.60.52.244 with SMTP id w20mr3560121oeo.30.1377800412501;
        Thu, 29 Aug 2013 11:20:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm32692526obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233313>

--no-stage is synonym for --keep-index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 git-stash.sh                | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..75b4cc6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
@@ -44,7 +44,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index|--[no-]stage] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -54,7 +54,7 @@ save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--
 	subcommand from making an unwanted stash.
 +
 If the `--keep-index` option is used, all changes already added to the
-index are left intact.
+index are left intact. Same with `--no-stage`, which is a snynonym.
 +
 If the `--include-untracked` option is used, all untracked files are also
 stashed and then cleaned up with `git clean`, leaving the working directory
diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..47220d0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+   or: $dashless [save [--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless clear"
 
@@ -204,6 +204,12 @@ save_stash () {
 		--no-keep-index)
 			keep_index=n
 			;;
+		--stage)
+			keep_index=n
+			;;
+		--no-stage)
+			keep_index=t
+			;;
 		-p|--patch)
 			patch_mode=t
 			# only default to keep if we don't already have an override
-- 
1.8.4-fc
