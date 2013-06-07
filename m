From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 4/7] add tests for rebasing root
Date: Thu,  6 Jun 2013 23:11:40 -0700
Message-ID: <1370585503-11374-5-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukpux-0003fH-GB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab3FGGMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:38 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:40166 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-vb0-f74.google.com with SMTP id 11so308916vbf.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Mq3FyYpwgn0p7M/T1hagmRKme7UvH8s/RqKcUzrLo+A=;
        b=lbYwfRlvGkrEv60ij3PuFo3AlDrOHmqU9uPtlnfRi6xW+g4W9fUIC+zCpy6Pjfy/sW
         80f/k5rm60xrH1ZIb7fsQYxkJ5AY1ct3m1gwyadewCy67gGX3uhfGE8/yUbres9Gu+er
         6QjFlbb/n3cRNBxLq2kdAZ3qjPr1kIQ1RLCw5RI056MjvKmaQC1shaY4JKv6ueKgqKnx
         SioFg0dCc5PvO+CQhlFO/6/ViiDCVa09BtVs8/sEUM1n93KeQ1pNLiqpL5fPrfWAvPih
         QxraA9WlTVaySHy/G22WWr7PhOx4CBv1arAwL28cK3WDORXcIc3GDdHiEZXFLV+d1D90
         +jjw==
X-Received: by 10.236.134.14 with SMTP id r14mr21009641yhi.39.1370585510709;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o42si7050446yhe.5.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 757C15A4208;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 157A6100DC3; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQk9rXwm9vJzYgUI/Ze205V92lLbN0k6EtohMQwWHJKjofESTJip7RpRjw7m5PVmWAHh62TD5NJsKj5WezCOkqJmU7rPfIi25dtq5Pr1tIv/tPsQwW+QGHNf1bi+/yB6a3Y6dzJywZZi85P9DSkkOxGBNJDGXtk8p19FrgkwVaYyZh90zdm67yE9jIpcfZCBRy/WipyV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226603>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t3421-rebase-topology-linear.sh | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index f19f0d0..e67add6 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
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
1.8.3.497.g83fddbe
