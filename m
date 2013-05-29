From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 1/7] add simple tests of consistency across rebase types
Date: Tue, 28 May 2013 23:39:26 -0700
Message-ID: <1369809572-24431-2-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha3a-0002ah-97
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935051Ab3E2GkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:40:16 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:53928 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935005Ab3E2GkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:40:09 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so906880qcz.3
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=bKNN+QHV3zJpwue1lQgFL44Un1BX05o0Z6aDJKXwNQY=;
        b=l1dDNdYCIcL0OfHlzfsigk5ZAbJWcUGtHububhAO8NaugZvjyuoDe+NmbRkTGdE3AI
         0OuEMo3VEIHX0pgl+zkVlr7fU9sRLjO1j+P6tuopg9UQ875vFupsz3aXlJQuVBbDAkKj
         oN+pByMY5V3g/ai5W6Thzu2q0DLwtBNCISuWeY8zkTSRdAT2Q/u73UaF1EVPImxD+j3P
         TXQsKRV6rYFAvDyVsS5YbcSfsNt39KSsvZSbKwa3BGytkOdVpXv9QIJ0aD2LTFC5K65o
         2q/3JJQGwgutCLWYyTCIq8oyWLWpcyWk3GAR6VgdI66LTDsMuP9y6Cyunpvl6mM0AZFl
         Bv0A==
X-Received: by 10.236.84.52 with SMTP id r40mr693604yhe.25.1369809608483;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id u22si583860yhh.7.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 54C7D31C04E;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 1517E1007B4; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnMZtbuPdQaNVOFPDyFv8S/dUIFIAccogqcCuAsbYdEuWX2eiNmd45pTBxVTcwh/jZYHtvaj5KDVKzE/cvNWYkQ4vHXXJ+raWlqfyLLIha9JTwJVjV2XO7xI4JgqoLuYrmE/MoAUswKd2I3YiVFnMSImNl9yPV1VqdljjqZz5X3ocBnItFhWOVvLeEhz685BZNJ+IZR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225756>

Helped-by: Johannes Sixt <j6t@kdbg.org>
---
 t/lib-rebase.sh                   | 15 ++++++++
 t/t3420-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100755 t/t3420-rebase-topology-linear.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..62b3887 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,18 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+# checks that the revisions in "$2" represent a linear range with the
+# subjects in "$1"
+test_linear_range () {
+	! { git log --format=%p "$2" | sane_grep " " ;} &&
+	expected=$1
+	set -- $(git log --reverse --format=%s "$2")
+	test "$expected" = "$*"
+}
+
+reset_rebase () {
+	git rebase --abort # may fail; ignore exit code
+	git reset --hard &&
+	git clean -f
+}
diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
new file mode 100755
index 0000000..c4b32db
--- /dev/null
+++ b/t/t3420-rebase-topology-linear.sh
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
+	test_expect_$result "rebase $* fast-forwards if an ancestor of upstream" "
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
1.8.2.674.gd17d3d2
