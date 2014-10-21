From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/8] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 21 Oct 2014 13:46:37 -0700
Message-ID: <1413924400-15418-6-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKe-00058Q-B4
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933516AbaJUUqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:51 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:53691 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933488AbaJUUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:44 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so374199pdj.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kV+zSqDS6pJhqOIWsHDcB/UufmqPOAFcZy/grgl4Q/0=;
        b=FmIghYo/Y9R0kka2FjzurZGTW7iPqZHsHX1TxNkrjHrU3t36O0qaO51sx+XGvmDeTO
         fXMw/e9izbSNePE6opldL6eVp63ZczMh0E7mHv3n/fEjCwLQfhOAINXwhutKejXN20lb
         l6argrNvJ7KZNSNV4fiGhkQyhXFcyJZkysNePZAQUuv3K9K8MS00RijHBNrskSWuWsTL
         X51BFJWJrz7X4dD+4Bs1FmUTLDp4iwpH+kyE8CnfiERCnQfHbBFzyUgd5G/fiAQ7wIcn
         mdce7jPGr7tsB17JG6GwYFJDS+w4qd6+COtstS9ofYi6vOpQeIoplkB0KzlPi5A8L0VS
         W2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kV+zSqDS6pJhqOIWsHDcB/UufmqPOAFcZy/grgl4Q/0=;
        b=VFII6Cu0O53jvvY24VsHeq7lpnIOVQVafq77oHbo8HgysisHypDD2RtXA66OViIVs1
         Unp5JPZwAwytu71OnJtWHbzN7eFrzlabVhp4yelJRG/J5MjQXWL6m/RqmhjYyzuU867U
         Mty8VVtdFuyUYsEEJy2kcPuQ02CNztfhoLIuFRCOUX/wBk6wQZn+pjhuCSm2m61p6U/A
         aC2luQwrEAPJr+zN4oVizWAT6BPlPN6pJYcUPJdDLVHmhsEKIkyNWBzhHB5TfYCFMFbJ
         8hmqdeKLW7oDVfs6lIhf/l1K3uL0JZbBQDKlmSMziKuOHXIX806VuNB3H7I0xR735gVF
         Vr0A==
X-Gm-Message-State: ALoCoQkBEJ34oQKRBQIEZTu//DRPZ638PoN57XIH3Xj3pm8Shm3eInXv/ON3g72vm61hChqLEbU6
X-Received: by 10.70.54.37 with SMTP id g5mr23825415pdp.3.1413924404573;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si596838yhe.3.2014.10.21.13.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id gfuEBs7j.1; Tue, 21 Oct 2014 13:46:44 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 91465E10B8; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: I3a6491515b78b564d1cc0892826a4bc77f9bffb0
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t5543-atomic-push.sh | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..4903227
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='pushing to a mirror repository'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+invert () {
+	if "$@"; then
+		return 1
+	else
+		return 0
+	fi
+}
+
+mk_repo_pair () {
+	rm -rf master mirror &&
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	mkdir master &&
+	(
+		cd master &&
+		git init &&
+		git remote add $1 up ../mirror
+	)
+}
+
+
+test_expect_success 'atomic push works for a single branch' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'atomic push works for two branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git checkout second &&
+		echo three >foo && git add foo && git commit -m three &&
+		git checkout master &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" = "$mirror_second"
+'
+
+# set up two branches where master can be pushed but second can not
+# (non-fast-forward). Since second can not be pushed the whole operation
+# will fail and leave master untouched.
+test_expect_success 'atomic push fails if one branch fails' '
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git checkout second &&
+		echo two >foo && git add foo && git commit -m two &&
+		echo three >foo && git add foo && git commit -m three &&
+		echo four >foo && git add foo && git commit -m four &&
+		git push --mirror up
+		git reset --hard HEAD~2 &&
+		git checkout master
+		echo five >foo && git add foo && git commit -m five &&
+		! git push --atomic-push --all up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" != "$mirror_master" &&
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" != "$mirror_second"
+'
+
+test_done
-- 
2.1.0.rc2.206.gedb03e5
