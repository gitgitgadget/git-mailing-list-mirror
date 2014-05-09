From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/17] contrib: remove 'remotes2config'
Date: Fri,  9 May 2014 14:11:40 -0500
Message-ID: <1399662703-355-15-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDv-0001jz-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320AbaEITMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:45 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:63945 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbaEITMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:44 -0400
Received: by mail-yk0-f174.google.com with SMTP id 9so3811477ykp.19
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l85znOrfyTdsSKoW0cyZCLSQUbehZdf2XxRQ/5VN0NQ=;
        b=s7ZK0RpiGcaWELRgTKnlXlA8IZN2F4qv1t5w2qUSjHo0YNr5Cz3lq9nAUlioLCOtsi
         yVMGRDZc2fXAHV331/hGuRTW6SMIc2KFHaelxb0xGl6W47b7zWZeR5U9t2SdX5igsA9E
         E8Z5p3oGOIy38By2gn0ACwZCSQEttQt4dLpGJAUyjtZ373DaWBTakaYp8K9agDZBvNeu
         aS54U7WkTEnzq2CFQwJx5hVzQuYYLk0Yug550vC/nFG/rk5POlVDgf+XuBhmve3JNJbr
         +7cNVAWNthu3e5N9fF7zUxJ9zJSk7v1cgRhqZys+Z5SeAtbrZCGFXC/Hd40AohSOxgKa
         hPxA==
X-Received: by 10.236.53.69 with SMTP id f45mr18022889yhc.53.1399662764009;
        Fri, 09 May 2014 12:12:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f62sm7425828yhq.6.2014.05.09.12.12.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248626>

No activity since 2007. No documentation, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remotes2config.sh | 33 ---------------------------------
 1 file changed, 33 deletions(-)
 delete mode 100755 contrib/remotes2config.sh

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
deleted file mode 100755
index 1cda19f..0000000
--- a/contrib/remotes2config.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-
-# Use this tool to rewrite your .git/remotes/ files into the config.
-
-. git-sh-setup
-
-if [ -d "$GIT_DIR"/remotes ]; then
-	echo "Rewriting $GIT_DIR/remotes" >&2
-	error=0
-	# rewrite into config
-	{
-		cd "$GIT_DIR"/remotes
-		ls | while read f; do
-			name=$(printf "$f" | tr -c "A-Za-z0-9-" ".")
-			sed -n \
-			-e "s/^URL:[ 	]*\(.*\)$/remote.$name.url \1 ./p" \
-			-e "s/^Pull:[ 	]*\(.*\)$/remote.$name.fetch \1 ^$ /p" \
-			-e "s/^Push:[ 	]*\(.*\)$/remote.$name.push \1 ^$ /p" \
-			< "$f"
-		done
-		echo done
-	} | while read key value regex; do
-		case $key in
-		done)
-			if [ $error = 0 ]; then
-				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
-			fi ;;
-		*)
-			echo "git config $key "$value" $regex"
-			git config $key "$value" $regex || error=1 ;;
-		esac
-	done
-fi
-- 
1.9.2+fc1.28.g12374c0
