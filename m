From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 4/7] add tests for rebasing root
Date: Mon,  3 Jun 2013 13:42:12 -0700
Message-ID: <1370292135-1236-5-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaL-0000d8-4V
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126Ab3FCUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:31 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:50331 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab3FCUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:27 -0400
Received: by mail-qa0-f74.google.com with SMTP id bs12so362691qab.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=X27evhip37wzm+9RMlXVjExmmj1F2JVsUpkaCjE37rg=;
        b=XlvC3efW9xK5TYnPhdvt7GTdZbFN753HUN6vVKZye1RyJq3vjY1/Q6PyRXpu0n+Olk
         aePAyZto96oy6g+23Pw6WiftRAx8C5zwJb7kzUKo6J0RK5GhMGkJ7dxcObEX6rv81Sbh
         3EmEGudHYkGi4fTcGW2tMasr9La5/hGa8UM/bayEDfXMYB/DcxMCJ3LSHCk/v9kUdRHz
         OX/5gSstN0/tLfEd0ywg6IYU0io0zmdOXl99h8eDYW/D0b8VuLEfGP9fXAKY20XguNgU
         2l6Q9Y+7ztoN+C0dXhxDi9HNNCKJ16cDZOh9MJanqNuqBc9ed/phAR/LVoQgXVua9Xa4
         N/9A==
X-Received: by 10.236.230.72 with SMTP id i68mr13581393yhq.23.1370292146293;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o42si5782838yhe.5.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 078695A429D;
	Mon,  3 Jun 2013 13:42:26 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 84E4F1014CF; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmfgtb/Fz6hEhH+n7+/dlUTxPDpXPfFZlV+z4lfZfw+F1314n4j3VTcJAPJYVxIddR0eJI/alxn5TkXw/xPqXuUcqKSUoPkC/hXFX3IE9Tzb+h4xXvn8ApjGLMNPp8AZTx0peo0TgOf6le4BvGI6r/eUhsATP8pl1dlcYddTNnzNDpn2a/wVCruNBDIgd9h26M+0cU6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226280>

---
 t/t3421-rebase-topology-linear.sh | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 81e3d59..659a7b3 100755
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
