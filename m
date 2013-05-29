From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 4/7] add tests for rebasing root
Date: Tue, 28 May 2013 23:39:29 -0700
Message-ID: <1369809572-24431-5-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha3o-0002mG-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935054Ab3E2GkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:40:18 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:59082 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935041Ab3E2GkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:40:10 -0400
Received: by mail-yh0-f74.google.com with SMTP id t59so555499yho.3
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=VUZyDjUBbFGOBBKZyARcqt9eT1FSzDPGjppyw1Xe+QU=;
        b=YUW3UJT7L4EOaqosD+JnTZxoAFtb9yfFTnk9946/4v+is7vnmhzWrGpa99JNlcX4eP
         kQvP4GdbBXOw2K4yjZis3LPhfkRA1kH0QiSRNVDCqaQNQ8/Jgg+/nsxCtHDoshtY8IH5
         44AK7JLVw+abCUa6lU5wkjCKk1isAbecsa+IX5RJq6/0fCgykyOkncy+q6TYLx6Cv9TA
         Wl4Zwu1J9XzpK6MfisUNVlF01EKcntTyoalp7PIh4UgHQMHPNsjHkyNCM/fJ+9ma1Qkw
         s24JzIWmfzIilEmFz2xQj66fOxZZuqdOG6g/rJ+Q9oJD0haqjjbBzkDoMlfzYWstr5VJ
         BNWg==
X-Received: by 10.236.109.227 with SMTP id s63mr729170yhg.24.1369809608792;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id u47si2634587yhe.0.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 850EC31C04E;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 3A248100BAD; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkV4qfbAVqUN3oG7FlPEdMEa8gzbcdFxlZKnImVay7KPRZDl6+fcM0u+mLF69PunAACUnQ3bjd81aCKAYCAPv164lUkHvbu9QAlCCQusB5NOUnMjY2rPs/2ygy2/FjHaueJoBae/xRvV9mLMCRR2xjBmwB6SZbw190xXyWsXO9JpyC4yeq+5buTA0qIjRIlazmzCoNZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225757>

---
 t/t3420-rebase-topology-linear.sh | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
index 40fe264..2429aa8 100755
--- a/t/t3420-rebase-topology-linear.sh
+++ b/t/t3420-rebase-topology-linear.sh
@@ -218,4 +218,133 @@ test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
 
+#       m
+#      /
+# a---b---c---g
+#
+# x---y---B
+#
+# uppercase = cherry-picked
+# m = reverted b
+#
+# Reverted patches are there for tests to be able to check if a commit
+# that introduced the same change as another commit is
+# dropped. Without reverted commits, we could get false positives
+# because applying the patch succeeds, but simply results in no
+# changes.
+test_expect_success 'setup of linear history for test involving root' '
+	git checkout b &&
+	revert m b &&
+	git checkout --orphan disjoint &&
+	git rm -rf . &&
+	test_commit x &&
+	test_commit y &&
+	cherry_pick B b
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto --root" "
+		reset_rebase &&
+		git rebase $* --onto c --root y &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'x y' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* without --onto --root with disjoint history" "
+		reset_rebase &&
+		git rebase $* c y &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'x y' c..
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
+	test_expect_$result "rebase $* --onto --root drops patch in onto" "
+		reset_rebase &&
+		git rebase $* --onto m --root B &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'x y' m..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto --root with merge-base does not go to root" "
+		reset_rebase &&
+		git rebase $* --onto m --root g &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'c g' m..
+	"
+}
+
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* without --onto --root with disjoint history drops patch in onto" "
+		reset_rebase &&
+		git rebase $* m B &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'x y' m..
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
+	test_expect_$result "rebase $* --root on linear history is a no-op" "
+		reset_rebase &&
+		git rebase $* --root c &&
+		test_cmp_rev c HEAD
+	"
+}
+test_run_rebase failure ''
+test_run_rebase failure -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f --root on linear history causes re-write" "
+		reset_rebase &&
+		git rebase $* -f --root c &&
+		! test_cmp_rev a HEAD~2 &&
+		test_linear_range 'a b c' HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
 test_done
-- 
1.8.2.674.gd17d3d2
