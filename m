From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 3/7] add tests for rebasing of empty commits
Date: Thu,  6 Jun 2013 23:11:39 -0700
Message-ID: <1370585503-11374-4-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukpua-0003Q4-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab3FGGMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:13 -0400
Received: from mail-gg0-f201.google.com ([209.85.161.201]:54703 "EHLO
	mail-gg0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-gg0-f201.google.com with SMTP id 21so42385ggh.4
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=ZqRT5Z1xr3xtAAWBdPM7wox8l1u95pEtwGQs7GAK0So=;
        b=dEbsumtPgJp21McnGL/n8yhjjQFEsV1oRx1ICifk+a/OwmuXHDkQ26m4mbXdUjlVYm
         2/mJRWgKAGojP1peVUb73KM6yrtm47jAyJshIuKHUFHOncVve7ebWJCS0z0vXPWvBxkA
         PAvJbIfYD/jEdSJRj2W90eSO83Z7JiJ2RCnfOwq+jGTsfi1/lRh3wWTWwCSXg741XvEQ
         fRXExbRiEde49VOvITA4Bt6qUOBRQyd8N+Np9P/8DIGtOEm6XFDU03O4TFNSwelihmvD
         stQTrTg/V+4zej1Jp1GKiXQlekd53qBasxVKNPaRJDp0ILWC0rM+KbJqQF6Pk7ka9kHU
         q+Qw==
X-Received: by 10.236.229.201 with SMTP id h69mr19644652yhq.49.1370585510251;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r76si5305439yhe.2.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 17CC25A416A;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id BF3DA1003C1; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmKXCX+lHcWj7KizlGH8mjOJfLtVSnL3vG6swgkct5Fc6WG0vwWmE12SUMvd/pnWCe0zaidPAOFw3DRhQuN8+HKl+7l2t2yB1uiYDXtIKXLvya0he6E2VY0KGGmWjt35UGUgO79gMOnyWJ/NbO4UALpSE/6MYUjBVjC4t8HLASTJydgrxLL29p2IrwSp7+zGhO9CwNq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226601>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t3401-rebase-partial.sh         | 24 ----------------
 t/t3421-rebase-topology-linear.sh | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 58f4823..7ba1797 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -42,28 +42,4 @@ test_expect_success 'rebase --merge topic branch that was partially merged upstr
 	test_path_is_missing .git/rebase-merge
 '
 
-test_expect_success 'rebase ignores empty commit' '
-	git reset --hard A &&
-	git commit --allow-empty -m empty &&
-	test_commit D &&
-	git rebase C &&
-	test "$(git log --format=%s C..)" = "D"
-'
-
-test_expect_success 'rebase --keep-empty' '
-	git reset --hard D &&
-	git rebase --keep-empty C &&
-	test "$(git log --format=%s C..)" = "D
-empty"
-'
-
-test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' '
-	git reset --hard A &&
-	git commit --allow-empty -m also-empty &&
-	git rebase --keep-empty D &&
-	test "$(git log --format=%s A..)" = "also-empty
-D
-empty"
-'
-
 test_done
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index ddcbfc6..f19f0d0 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -160,4 +160,62 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
+# a---b---c---j!
+#      \
+#       d---k!--l
+#
+# ! = empty
+test_expect_success 'setup of linear history for empty commit tests' '
+	git checkout c &&
+	make_empty j &&
+	git checkout d &&
+	make_empty k &&
+	test_commit l
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* drops empty commit" "
+		reset_rebase &&
+		git rebase $* c l &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd l' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --keep-empty" "
+		reset_rebase &&
+		git rebase $* --keep-empty c l &&
+		test_cmp_rev c HEAD~3 &&
+		test_linear_range 'd k l' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --keep-empty keeps empty even if already in upstream" "
+		reset_rebase &&
+		git rebase $* --keep-empty j l &&
+		test_cmp_rev j HEAD~3 &&
+		test_linear_range 'd k l' j..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
 test_done
-- 
1.8.3.497.g83fddbe
