From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 5/7] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Mon, 17 Nov 2014 18:00:38 -0800
Message-ID: <1416276040-5303-6-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY6M-0000v6-1X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbaKRCAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:52 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46915 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbaKRCAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:50 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so3109933iec.38
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RgXP/VSYGg1W/0E+bnZw+JRjkSJTDy8jUttr7bcxVk0=;
        b=b2ZL2fAs2rnEQ+gGWj3q4MMwotrcIVnAEBuuiNFwHrLKuZZ+ksE89pogR0ZegPrbpr
         8492tvj75KY7JIbiV+CABZN2PftvyuogDuE/lK8KPU9Lpagk6EiocRKXd4DuKbAubj/f
         k5wzec1QfzSdaW5ijgrUwlx5pXBbodS6i91N9CKAdpRo/7cFMiG9b8IbUJui88bVEIXW
         CcgFr4a3EG/FadNJCanpO4QbL9VGNDQj83BxyGU3KcPC/QcowXeRrihL/kaea6fMe9yh
         pnhWRNlMAzvEAMy983qdwV0uqAnpZyYsFQMjoFiOTJ78gWtf9N0RgjHO91yb62ShRcjm
         vdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RgXP/VSYGg1W/0E+bnZw+JRjkSJTDy8jUttr7bcxVk0=;
        b=msoba0Q8aSAm5OOU2GMM0cDXVkB+7k6tMy0JXCe+gtWcr6efm9z2+k/BYAHIxs0aA2
         bLepA5vbdA7gjevQcwao4dMqL/IZ2LhP4XOR+yg5YxS7RvG34aKiNlGUkloioZ0Pwhqm
         buPJIMMmTeUkO71eI6AbDJbg9+zcGdPIU1Mv471mAWTQO9Q8BdbFfw/0fkyyK4P7ykBr
         7XOrKa5+i9QdZR8aCaa8NADlg9H2TC0u3lULCETFRVUK2wXhI0UJ6/q7+fDqBjijFPjY
         XBkyeNdzMV1xtYORdlXEuwbPcHxWseNtAcYPliIbJsGno9dGrQp0KNE7120WjVAg6XyD
         3j6A==
X-Gm-Message-State: ALoCoQnh9B9U7n3cpUSFoYoMf+XMyq+QlYIC7IQJNaeOH6U89AzoYIxapA+VJar8r1Sf57bTxp8u
X-Received: by 10.107.149.203 with SMTP id x194mr33702193iod.22.1416276049662;
        Mon, 17 Nov 2014 18:00:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id fy5sm6901372igd.3.2014.11.17.18.00.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:49 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.2.0.rc2.5.gf7b9fb2
