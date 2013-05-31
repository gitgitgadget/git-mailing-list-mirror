From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 4/7] add tests for rebasing root
Date: Thu, 30 May 2013 23:49:44 -0700
Message-ID: <1369982987-18954-5-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAP-0000gk-M8
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3EaGuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:19 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:33212 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so113128qcz.5
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=8Wxc1X+257buhx/9dp+DUF6nM7UHK+hKuapeUr21tmE=;
        b=K9C2gzvP7HIVGHDgqohn28AQGmqL63gN4bhVVL9MuUk2DZq5ZW83BbA3+C6FblenT8
         xWduAa5+M/soKr4Utm8Rb8HNFAa2n+bvovMjDjYH6NAM5jOIZ0W1O/f7ht5Nf7z9rL5R
         luqHpayl9UKutq46RA9JkAYyzgmQe4ZKt6yOQBzddzm41Btl13COYnbyAunwQt7ZAMcs
         g0A0QNjnaOo46EsGNn3gsaGb5leUj9+4Zw1oPxoKv7oZyzCHWHrtxVSMs+M1g9uvqSoq
         NTO2a6uesyHTJqL838hPJBxIy+J2CvtV4rd4k6TzQgYj04WVWPhz3stQZv1WrmjRL2yI
         iNQw==
X-Received: by 10.236.141.37 with SMTP id f25mr5778940yhj.50.1369983003754;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b23si3620966yhj.4.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7D3C931C22F;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 1549B100E13; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnVJlGoVnmZCoYRN64mmSONYMCNfePy4Azkyek//C1KtluMquC4wdiDZFDPi5zGydxI2oF6dOEsEOGgaySZVDupFC7NmQppgVG4SJwOJeUZq9CZjeXwuY05+LR1RzL+EwP0pIGO7XA/SjQxii4fYL9Omd/NhMaH4Aq1D2N0wa1YYRKzAaYnZWOhuHhbViLcKNGmyz+D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226055>

---
 t/t3420-rebase-topology-linear.sh | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
index 81e3d59..659a7b3 100755
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
