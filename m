From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] wt-status: lift the artificual "at least 20 columns" floor
Date: Wed, 12 Mar 2014 14:19:34 -0700
Message-ID: <1394659174-9143-5-git-send-email-gitster@pobox.com>
References: <1394659174-9143-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqZD-00023o-0e
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbaCLVTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:19:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbaCLVTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:19:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB77574985;
	Wed, 12 Mar 2014 17:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=w/j1
	zy3rRGafxOCtxFW49hEC+PI=; b=MSOsntK8PmGd2zyfOG2yV5nXoKFULTMxSKXl
	wF7Dy5mHGCPon9yeZ4jevNaks97g0TGhWCtWZ5AxUtM1bDHarAKQ5fBS7X2aQhQ4
	3XIKSwzW5ea0Qmt8RxsZm75h01OCQn/WjETTfTJfXm0i6bVfISA/c45iQdNnEEKG
	XFjRczI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vgDccY
	32gMW89u5r4bJK9FbwBsCc4vUDi7yQ/VWSWibkRw5dR7urRyyPuo+gyq5q9r6h3i
	Kc+7KOKP/LPsVVdlybFTe1XqqF5UhZA5wa/1onSpwxg9QUafiqqf+rGuP9FVWHCA
	gIOAK/QVtN++thD0muUbARU2SUUjtMvcj6tuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD0574984;
	Wed, 12 Mar 2014 17:19:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0E9A74980;
	Wed, 12 Mar 2014 17:19:44 -0400 (EDT)
X-Mailer: git-send-email 1.9.0-293-gd838d6f
In-Reply-To: <1394659174-9143-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0864A1CC-AA2C-11E3-87D8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243999>

When we show unmerged paths, we had an artificial 20 columns floor
for the width of labels (e.g. "both deleted:") shown next to the
pathnames.  Depending on the locale, this may result in a label that
is too wide when all the label strings are way shorter than 20
columns, or no-op when a label string is longer than 20 columns.

Just drop the artificial floor.  The screen real estate is better
utilized this way when all the strings are shorter.

Adjust the tests to this change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7060-wtstatus.sh    | 14 +++++++-------
 t/t7512-status-help.sh | 12 ++++++------
 wt-status.c            |  2 --
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 7d467c0..741ec08 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -38,7 +38,7 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
 
-	deleted by us:      foo
+	deleted by us:   foo
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -142,8 +142,8 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
 
-	both added:         conflict.txt
-	deleted by them:    main.txt
+	both added:      conflict.txt
+	deleted by them: main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -175,9 +175,9 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
 
-	both deleted:       main.txt
-	added by them:      sub_master.txt
-	added by us:        sub_second.txt
+	both deleted:    main.txt
+	added by them:   sub_master.txt
+	added by us:     sub_second.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -203,7 +203,7 @@ Changes to be committed:
 Unmerged paths:
   (use "git rm <file>..." to mark resolution)
 
-	both deleted:       main.txt
+	both deleted:    main.txt
 
 Untracked files not listed (use -u option to show untracked files)
 EOF
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 3cec57a..68ad2d7 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -33,7 +33,7 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
 
-	both modified:      main.txt
+	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -87,7 +87,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
-	both modified:      main.txt
+	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -146,7 +146,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
-	both modified:      main.txt
+	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -602,7 +602,7 @@ rebase in progress; onto $ONTO
 You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
 
 Unmerged paths:
-	both modified:      main.txt
+	both modified:   main.txt
 
 no changes added to commit
 EOF
@@ -636,7 +636,7 @@ You are currently cherry-picking commit $TO_CHERRY_PICK.
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
 
-	both modified:      main.txt
+	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -707,7 +707,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
-	both modified:      to-revert.txt
+	both modified:   to-revert.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
diff --git a/wt-status.c b/wt-status.c
index b1b018e..6f3ed67 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -318,8 +318,6 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	if (!padding) {
 		label_width = maxwidth(wt_status_unmerged_status_string, 1, 7);
 		label_width += strlen(" ");
-		if (label_width < 20)
-			label_width = 20;
 		padding = xmallocz(label_width);
 		memset(padding, ' ', label_width);
 	}
-- 
1.9.0-293-gd838d6f
