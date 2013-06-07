From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 1/7] add simple tests of consistency across rebase types
Date: Thu,  6 Jun 2013 23:11:37 -0700
Message-ID: <1370585503-11374-2-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkpuO-0003G5-HS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab3FGGMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:16 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:32994 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-vb0-f74.google.com with SMTP id 11so308916vbf.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=pWBoNmJzpsRVuKI7G1pogAaTVWhAdQ8iNFXahmfjpqA=;
        b=TcKEUUXeMBodkGW746R6FDqqNCKaySXeUd8p4/jK7W2iBFNOODS30r2h01Uedn04yB
         EqeHP9FmFtWLUudZzmTtKDY+fquGf18lienFSR215f3OD5xWjxRRrLWno+catBsd0k7F
         nK/2QMAlLZtUASE0ObZSfyhNYc0obDs3bMm9i1xOIFZZSTiitXayBK+wRBPLo7qPxfCl
         okmQW6p/CT3bwGYW5XsFWWDdL4RXjC/0Xlt7qWeRWK0MMLkVkLy2q0j8xmKEbNWprrY+
         mXvwJobvIxACUKm1+exWMBwf4eF1x6fhNToYPtaPFOvfDk5oCcTAfuSWrsPe5Q16uk7Z
         VFIw==
X-Received: by 10.236.226.6 with SMTP id a6mr11871381yhq.35.1370585510299;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g80si522972yhj.7.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 273DA31C1EF;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id CABF1100CD7; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmeI6Gz8P5QMEkpZEAVjmsAQxAg/4oPYyKN0WVo3x1I2qhwJ/nUWJhPXRkNbHuhHifzK2TmfICw6Q1BOXPjdDSVgybrA0xoXiLXkLF0tQaYAcOmfRkFHuCqLZmnH07ucfHIMYspardfYl0WoeY1hhcF2CC7ie8XZf5I2dxMQ4X9sJymkI5ivwS3Niq32sQz/2Zq6UHJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226599>

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/lib-rebase.sh                   | 16 ++++++++
 t/t3421-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100755 t/t3421-rebase-topology-linear.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..1e0ff28 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,19 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+# checks that the revisions in "$2" represent a linear range with the
+# subjects in "$1"
+test_linear_range () {
+	revlist_merges=$(git rev-list --merges "$2") &&
+	test -z "$revlist_merges" &&
+	expected=$1
+	set -- $(git log --reverse --format=%s "$2")
+	test "$expected" = "$*"
+}
+
+reset_rebase () {
+	test_might_fail git rebase --abort &&
+	git reset --hard &&
+	git clean -f
+}
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
new file mode 100755
index 0000000..60365d1
--- /dev/null
+++ b/t/t3421-rebase-topology-linear.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='basic rebase topology tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# a---b---c
+#      \
+#       d---e
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git checkout b &&
+	test_commit d &&
+	test_commit e
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "simple rebase $*" "
+		reset_rebase &&
+		git rebase $* c e &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd e' c..
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
+	test_expect_$result "rebase $* is no-op if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* b e &&
+		test_cmp_rev e HEAD
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
+	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* -f b e &&
+		! test_cmp_rev e HEAD &&
+		test_cmp_rev b HEAD~2 &&
+		test_linear_range 'd e' b..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* fast-forwards from ancestor of upstream" "
+		reset_rebase &&
+		git rebase $* e b &&
+		test_cmp_rev e HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_done
-- 
1.8.3.497.g83fddbe
