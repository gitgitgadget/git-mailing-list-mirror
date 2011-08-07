From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 5/5] submodule: take advantage of gettextln and eval_gettextln.
Date: Sun,  7 Aug 2011 21:58:17 +1000
Message-ID: <1312718297-10999-6-git-send-email-jon.seymour@gmail.com>
References: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:59:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq20O-00080M-N4
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab1HGL6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 07:58:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53879 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab1HGL6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:44 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6636287pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=duNJcu7BsuJ0SOghZNTvGUo1HDV9UxC/yPbu7JpW4I0=;
        b=x1a4skM1pjDgrjdWBkjhRPGxlKEEpYffBp2Zj21wHK5GWcMGT5LU57UmM1fkSJeo7w
         uS449x4yzaB41sizmyVPbXi4ZWZ9F/v0cRauoQCTJ2x4CmXo5IY+0oiq4MuoiZM/AXVo
         LU8Hk1iVQfp00EuuAvYQnkXX9RKFeCAk6uMt0=
Received: by 10.142.136.10 with SMTP id j10mr3800486wfd.448.1312718324496;
        Sun, 07 Aug 2011 04:58:44 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178907>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc1d3fa..986c5d6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -223,12 +223,9 @@ cmd_add()
 
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
 	then
-		(
-			eval_gettext "The following path is ignored by one of your .gitignore files:
+		eval_gettextln "The following path is ignored by one of your .gitignore files:
 \$path
-Use -f if you really want to add it." &&
-			echo
-		) >&2
+Use -f if you really want to add it." >&2
 		exit 1
 	fi
 
@@ -237,7 +234,7 @@ Use -f if you really want to add it." &&
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			eval_gettext "Adding existing repo at '\$path' to the index"; echo
+			eval_gettextln "Adding existing repo at '\$path' to the index"
 		else
 			die "$(eval_gettext "'\$path' already exists and is not a valid git repo")"
 		fi
@@ -696,10 +693,7 @@ cmd_summary() {
 				;; # removed
 			*)
 				# unexpected type
-				(
-					eval_gettext "unexpected mode \$mod_dst" &&
-					echo
-				) >&2
+				eval_gettextln "unexpected mode \$mod_dst" >&2
 				continue ;;
 			esac
 		fi
@@ -786,9 +780,9 @@ cmd_summary() {
 	done |
 	if test -n "$for_status"; then
 		if [ -n "$files" ]; then
-			gettext "# Submodules changed but not updated:"; echo
+			gettextln "# Submodules changed but not updated:"
 		else
-			gettext "# Submodule changes to be committed:"; echo
+			gettextln "# Submodule changes to be committed:"
 		fi
 		echo "#"
 		sed -e 's|^|# |' -e 's|^# $|#|'
-- 
1.7.6.363.g9b380.dirty
