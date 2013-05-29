From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 3/7] add tests for rebasing of empty commits
Date: Tue, 28 May 2013 23:39:28 -0700
Message-ID: <1369809572-24431-4-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:41:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha49-000378-CM
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935047Ab3E2GkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:40:13 -0400
Received: from mail-ye0-f202.google.com ([209.85.213.202]:40805 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935039Ab3E2GkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:40:09 -0400
Received: by mail-ye0-f202.google.com with SMTP id m13so565768yen.3
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=wmIJ1UivXOJ/OQbdz602x/vpaNcWlfE3pNMfApTNm8A=;
        b=XdXSuP34igVASmyU7br/YZGkOuZqJp7X3DUA4Ch7PQdVtUeij33vS1s8o2wsLDIFPy
         9F0aMfIzAA9gCTs1r7EGwqCfX/bDgD9rUHO668UUofKpmGdoXyxZ0YEMvvizK9oz8a2O
         OW8P2VPOWi7r3Vw0zK5H8OqbHjKMWnU2xe6zF76Q8+oaXUkz/oP4os+Vrp7pPRjJksHr
         F5gBxXCCDZOYNcT8uZm6tfmw6xxF6YOm6X1t2luPP7Py/Q431BaFNZj3ZEoTOZOl23Tl
         zGCQKtJt0QtQ0vEjlGzqiiQrhPzegt2HOGBGQBVrayJZgafuCD7QQZH9oTVvqWn9KfM9
         sNZQ==
X-Received: by 10.236.141.37 with SMTP id f25mr658438yhj.50.1369809608627;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id b23si2630028yhj.4.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 797FA5A4022;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2DC28100A20; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkRAjmmqJnHnk1+dg/+SEMJ/kYsGefZNKBvS3S27wIPKKZQqYD1r3B4mdq20byLKx2wWr5ZqPtNtWzzx7moqSO0d5SBipWnYEGQf51Gy9Wke+ugXDB35Jq29USm+J7ktcbumBvdL4eaJ1eKJeXJAIhPQrAEHGNQFZuONMlwJ4DRqfbc4AvfN66aBgXkb/EXE1Ve3/nm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225758>

---
 t/t3401-rebase-partial.sh         | 24 ----------------
 t/t3420-rebase-topology-linear.sh | 58 +++++++++++++++++++++++++++++++++++++++
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
diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
index 1152491..40fe264 100755
--- a/t/t3420-rebase-topology-linear.sh
+++ b/t/t3420-rebase-topology-linear.sh
@@ -160,4 +160,62 @@ test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
 
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
1.8.2.674.gd17d3d2
