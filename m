From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] git-submodule: respect -q for add/update
Date: Tue,  4 Sep 2012 10:31:20 +0300
Message-ID: <1346743880-11379-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 09:31:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8nbr-0005Qa-SL
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 09:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab2IDHbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 03:31:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:32876 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab2IDHba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 03:31:30 -0400
Received: by weyx8 with SMTP id x8so3337575wey.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ieCjECrHfgEYIFVM8R4Vh1n++CU1A1Uh1HGbnI4RkB4=;
        b=VP7Liunpz/muAxF5VnmSV/EsWJLDze2LY/8m++MW335qa9VzYEhuZ1ZC1btsvTB8Bh
         1md4ZMCoOYDgauKCHbIB3ab0h2baLBNRUwNm4RLmiRV7qdprGCCCM5bGa/qTLQRmNzzg
         upc0xhP8lbddGwO3P5ucB29pB2UuqI73xjfG8lwWTe9P+OH3AiTeg9ZrbZyyo/Yy9AYW
         R5BbklCGSWWor1eoCaXNc67QlfJqB5aP7Df4ieJdeNi+d7d7IPIM5nRfjqL5sPHkfVSN
         O1wm7oMSfILRwY43Rt80i+Y6UxBC2g03LpWS5nndo3VTyRyM9lWhdaaxgPPe8rOVMehC
         ZE7g==
Received: by 10.180.77.34 with SMTP id p2mr28805181wiw.0.1346743889609;
        Tue, 04 Sep 2012 00:31:29 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-229-111-212.inter.net.il. [84.229.111.212])
        by mx.google.com with ESMTPS id k2sm34330535wiz.7.2012.09.04.00.31.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 00:31:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204720>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 git-submodule.sh |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index aac575e..dd57abb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -266,6 +266,11 @@ cmd_add()
 
 	repo=$1
 	sm_path=$2
+	quiet=
+	if test -n "$GIT_QUIET"
+	then
+		quiet=-q
+	fi
 
 	if test -z "$sm_path"; then
 		sm_path=$(echo "$repo" |
@@ -332,8 +337,8 @@ Use -f if you really want to add it." >&2
 			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
+			'') git checkout -f $quiet ;;
+			?*) git checkout -f $quiet -B "$branch" "origin/$branch" ;;
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
@@ -527,6 +532,12 @@ cmd_update()
 		shift
 	done
 
+	quiet=
+	if test -n "$GIT_QUIET"
+	then
+		quiet=-q
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
@@ -619,7 +630,7 @@ Maybe you want to use 'update --init'?")"
 				must_die_on_failure=yes
 				;;
 			*)
-				command="git checkout $subforce -q"
+				command="git checkout $subforce $quiet"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$sm_path'")"
 				say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
 				;;
-- 
1.7.10.4
