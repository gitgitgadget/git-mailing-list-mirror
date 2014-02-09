From: Sup Yut Sum <ch3cooli@gmail.com>
Subject: [PATCH] bash completion: Add --recurse-submodules
Date: Sun,  9 Feb 2014 22:35:31 +0800
Message-ID: <1391956531-6039-1-git-send-email-ch3cooli@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 15:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCVU4-0005kK-1G
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 15:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbaBIOfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 09:35:44 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61972 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaBIOfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 09:35:43 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so5041230pdj.17
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lOo6Qa5CmWhsIWdentEr6MUz+zqPV52cojhhtcz8U5Y=;
        b=s9pJyzU9Be5beRl80foz40sEd2KW680SDp9iZGqxMqKsT9ayPeG/nYESP44vKE0CIf
         ktLZ8FpozBpbStJraep5PU+xmf6znlw9HmOpZNP7GWBMvoZfXvXrisPM7UXpOvM9boe6
         nzQqHEoy78FUOhPKd4XsG2QkDuIML7+iWGuTHz8WSSS2pXuP9FxYxZmgUwcMF3ovhZXE
         VFx3Bom8gBz5mzTf0d0LjTByG1+gRfMmCy/Ne9IOQ2RHpMeqj6I/H27LXIz7GJBS8FdY
         RyxfXkPJsKyK4HTNNnUcadkbhNcDmkYxtbrMe+cyW+ipINk79TAoUFynTDQxB+V9r7FL
         nKxA==
X-Received: by 10.68.184.66 with SMTP id es2mr31985834pbc.19.1391956543005;
        Sun, 09 Feb 2014 06:35:43 -0800 (PST)
Received: from localhost.localdomain (n219073024012.netvigator.com. [219.73.24.12])
        by mx.google.com with ESMTPSA id fk4sm86198214pab.23.2014.02.09.06.35.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Feb 2014 06:35:42 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241879>

Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9525343..87de809 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1221,14 +1221,20 @@ _git_difftool ()
 	__git_complete_revlist_file
 }
 
+__git_fetch_recurse_submodules="yes on-demand no"
+
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
-	--tags --no-tags --all --prune --dry-run
+	--tags --no-tags --all --prune --dry-run --recurse-submodules=
 "
 
 _git_fetch ()
 {
 	case "$cur" in
+	--recurse-submodules=*)
+		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "$__git_fetch_options"
 		return
@@ -1583,6 +1589,10 @@ _git_pull ()
 	__git_complete_strategy && return
 
 	case "$cur" in
+	--recurse-submodules=*)
+		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--rebase --no-rebase
@@ -1595,6 +1605,8 @@ _git_pull ()
 	__git_complete_remote_or_refspec
 }
 
+__git_push_recurse_submodules="check on-demand"
+
 _git_push ()
 {
 	case "$prev" in
@@ -1607,10 +1619,15 @@ _git_push ()
 		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
 		return
 		;;
+	--recurse-submodules=*)
+		__gitcomp "$__git_push_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
 			--receive-pack= --repo= --set-upstream
+			--recurse-submodules=
 		"
 		return
 		;;
-- 
1.8.5.2.msysgit.0
