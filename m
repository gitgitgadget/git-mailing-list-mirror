From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Sat, 29 Sep 2012 19:13:15 +0530
Message-ID: <1348926195-4788-2-git-send-email-artagnon@gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 15:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THxLC-0008Eh-80
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab2I2NoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 09:44:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55051 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2I2NoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 09:44:12 -0400
Received: by padhz1 with SMTP id hz1so3024196pad.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m9bjL0fbOjmu70IWin6hjyRbODNyJG/S7FuUH+H4Jpc=;
        b=ScyQxCdb2l6YiZhkIHN6QSOt06bgsEw0y113iGBf5bJM0DVL7U0nNbk22a8NwAwpU+
         i1kVELrO83UK2EyB/J4OOvHgSONDtd64y90LOVd5YqnYs98fFc8Y1jjoqOa5OrZdu97J
         lWhomOkmJHTTN0g6dRbzNuVkLiyWyG8VlD/FoS9xw3if0lDVVeR6UvMThmf2Ynsp8o4/
         LrlPXtfFz13xIZYax+uXxnVoQrh72O9nSYFiRnKK7lilxfWTrR+H9i6+jLLKHy5YKUm+
         4m+t8J4cICgviuBWHrjd0vCC2cM6Z1elVJiF5YPhGNFkeBp4VQMkj+364s08vHaK8Fx5
         qSMw==
Received: by 10.68.229.228 with SMTP id st4mr27831731pbc.106.1348926252259;
        Sat, 29 Sep 2012 06:44:12 -0700 (PDT)
Received: from localhost.localdomain ([122.174.75.44])
        by mx.google.com with ESMTPS id qq9sm7248569pbb.24.2012.09.29.06.44.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Sep 2012 06:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206646>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-submodule.sh |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1d61ebd..f8efc52 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -942,27 +942,28 @@ cmd_status()
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$sm_path"
+		sha1_abbr=$(git rev-parse --short "$sha1")
 		if test "$stage" = U
 		then
-			say "U$sha1 $displaypath"
+			say "U$sha1_abbr $displaypath"
 			continue
 		fi
 		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			say "-$sha1 $displaypath"
+			say "-$sha1_abbr $displaypath"
 			continue;
 		fi
-		set_name_rev "$sm_path" "$sha1"
+		set_name_rev "$sm_path" "$sha1_abbr"
 		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
 		then
-			say " $sha1 $displaypath$revname"
+			say " $sha1_abbr $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
-				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
-				set_name_rev "$sm_path" "$sha1"
+				sha1_abbr=$(clear_local_git_env; cd "$sm_path" && git rev-parse --short --verify HEAD)
+				set_name_rev "$sm_path" "$sha1_abbr"
 			fi
-			say "+$sha1 $displaypath$revname"
+			say "+$sha1_abbr $displaypath$revname"
 		fi
 
 		if test -n "$recursive"
-- 
1.7.10.4
