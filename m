From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] version-gen: cleanup
Date: Mon,  9 Sep 2013 00:01:28 -0500
Message-ID: <1378702889-21638-2-git-send-email-felipe.contreras@gmail.com>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 07:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VItgS-00037b-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 07:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab3IIFGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 01:06:39 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35697 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3IIFGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 01:06:38 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so5601761obb.15
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YARWdvOZSCFnJYgxBuxtzpE2VgkeIP5nG/Wrjg7Wscw=;
        b=SBd4vbJ5IMGjJBXEN4JYpfpqUVOllr40GOYbt3Dl894GrT4Rt8by/K7jPCMUTjQxZA
         BmQpZeVRbAeE1AwsMIzE7rDxR02AksLmge0TWWa9a2D201Ur5hS5D/KQuU1T1b3dxChG
         n7ymsB421jt3Z3nIO6CYZG4LRSWi7qUv+DzNURDdfnmGz9lwKi2UFYGKnV51cyUHPv3Z
         4uvK7I/lJAh/3tQksM+po4b0FHqYS/h+oZ3tLqzttRsMK4TQqFpAFYbsy2JNjKc7YVBk
         ro87ld95r4vdRfwefcccfuZLvQ0OU0kNgQOnAbfMDy62aqoO2ItpGzd4riNlU8GUJBm1
         kcQw==
X-Received: by 10.60.33.74 with SMTP id p10mr10067772oei.18.1378703198325;
        Sun, 08 Sep 2013 22:06:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm3131501obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 22:06:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234309>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 06026ea..b0db139 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -7,21 +7,24 @@ LF='
 '
 
 # First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
+# then try 'git describe', then default.
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null)
+then
 	case "$VN" in
-	*$LF*) (exit 1) ;;
+	*$LF*)
+		exit 1
+		;;
 	v[0-9]*)
 		git update-index -q --refresh
 		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
+		VN="$VN-dirty"
+		;;
 	esac
-then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
@@ -34,9 +37,6 @@ then
 else
 	VC=unset
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
-
-
+test "$VN" = "$VC" && exit
+echo >&2 "GIT_VERSION = $VN"
+echo "GIT_VERSION = $VN" >$GVF
-- 
1.8.4-338-gefd7fa6
