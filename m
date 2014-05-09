From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 15/25] contrib: remove 'remotes2config'
Date: Thu,  8 May 2014 19:58:26 -0500
Message-ID: <1399597116-1851-16-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:10:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZKp-0000jt-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbaEIBKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:41 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:55477 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbaEIBKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:39 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so3139669yhl.37
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryvOleHAcJ/TAMIUXfl6um5eJ6jQau/Om6PiIc16a/g=;
        b=k9MvbHASSC52kbP889LW8KBA+6LahbcJ5e3lOav86lfqbxxeOjlV7dtrU53NeYpSRN
         G28DPr/Bv2I7EbfWr5JpVvnoLTjVdLLoJz3TyBTkaWLALGpANOIcE7fXAG9wOKZjKrEd
         9Mt+1uAntgnOuM+XFA3chhJkjqOrhSGOG69X0l5NOVY0UYFnvle2e52Zc1uuD2YfjF01
         YZ4eElgTJpFdHWcykusJVSee0rikBt/gHpwTYaL6+YpWspRwBycZXRhsTYsY7Ge18E/H
         3oEt6JynBZzNH8wJ/HaK6B0CcEQfdSJWviUYGPdQOY9yWjBDRxxzFv4r1EaKa5oizF4w
         4Glw==
X-Received: by 10.236.55.40 with SMTP id j28mr9979138yhc.85.1399597839156;
        Thu, 08 May 2014 18:10:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k70sm3915453yhm.38.2014.05.08.18.10.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248480>

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
1.9.2+fc1.27.gbce2056
