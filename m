From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for git-rebase
Date: Sat, 12 Mar 2016 18:46:21 +0800
Message-ID: <1457779597-6918-2-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4c-0005bI-Fa
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcCLKrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:00 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34019 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbcCLKq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:46:58 -0500
Received: by mail-pa0-f48.google.com with SMTP id fe3so103219704pab.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J+IikcyuMpFY+Tgzg2d+R8D15Cr2o7+DYCzim8fTxKM=;
        b=MkEcu379MgcfK20Qpc9YyFXgmDK80PR0jqzZHB+pzzOK1/q0BgJM9I49p550PD9Ozw
         iUodtp2S5Na+if2KSvYZOkIsykwv+ySi8WuSC2ZpxlHEusNHS1osx0spOK8+9hIpLGrj
         cSH5Kq48buHbPHOgisjVRCAu3763HahMb10MGGBcagR5lXidzWnoada0c9YjQ+6nynS+
         Bu5/1yC49hKwh7MpGB39A6/d2CEVtxkB09IR8qPYiCk5oTMCHhb9EWSqaWLS17FPq/aj
         i9m7I3PX65WHSJhIgS7GRx8tN+hUJWuuI6+caLZ2FbG71APlkTJzTyQFaFmwQE7K4He3
         AVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J+IikcyuMpFY+Tgzg2d+R8D15Cr2o7+DYCzim8fTxKM=;
        b=JdUyaKcg3WA3INQqCBMfLyRZwQE0ScLHRwWfRF86ogfOyhA8cDUDS90bK43tg4D6xm
         dhsdValbCGVWsCsMv5nabYVTEusAayZe37AtTv76EShC3qc06ycggYeFSFnrsMpSMz+S
         wZcCheJaH5fdAzR0tYcSJno5x1oQSXIqaA8LvS/et7frMuKRG6z2b9ycsAym9zLD7dCh
         ht7b9aT+xfhkQCJ9JLowvvCm7vuo4ehqAv/43IXQj1q4xZ62ZJ5Zo16Dz7qUyP1XCbLg
         jww4my2Flass4b21NtAm+N7nc/kAaqEwRICTfJjoOnQ6L0bigqMs8svV7jPc1t2P3T5C
         S9vA==
X-Gm-Message-State: AD7BkJKaj7n97cbRjecYHvQWgva86NE38eD5lo5i3Hnw3tVhIgKpNO5lS133x9oHwzqRAA==
X-Received: by 10.66.97.8 with SMTP id dw8mr22928426pab.28.1457779617813;
        Sat, 12 Mar 2016 02:46:57 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:46:56 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288731>

To determine the speedup (or slowdown) of the upcoming git-rebase
rewrite to C, add a simple performance test for each of the 3 git-rebase
backends (am, merge and interactive).

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/perf/p3400-rebase.sh             | 25 +++++++++++++++++++++++++
 t/perf/p3402-rebase-merge.sh       | 25 +++++++++++++++++++++++++
 t/perf/p3404-rebase-interactive.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100755 t/perf/p3400-rebase.sh
 create mode 100755 t/perf/p3402-rebase-merge.sh
 create mode 100755 t/perf/p3404-rebase-interactive.sh

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
new file mode 100755
index 0000000..f172a64
--- /dev/null
+++ b/t/perf/p3400-rebase.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Tests rebase performance with am backend"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+# Setup a topic branch with 50 commits
+test_expect_success 'setup topic branch' '
+	git checkout -b perf-topic-branch master &&
+	for i in $(test_seq 50); do
+		test_commit perf-$i file
+	done &&
+	git tag perf-topic-branch-initial
+'
+
+test_perf 'rebase --onto master^' '
+	git checkout perf-topic-branch &&
+	git reset --hard perf-topic-branch-initial &&
+	git rebase --onto master^ master
+'
+
+test_done
diff --git a/t/perf/p3402-rebase-merge.sh b/t/perf/p3402-rebase-merge.sh
new file mode 100755
index 0000000..b71ce12
--- /dev/null
+++ b/t/perf/p3402-rebase-merge.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Tests rebase performance with merge backend"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+# Setup a topic branch with 50 commits
+test_expect_success 'setup topic branch' '
+	git checkout -b perf-topic-branch master &&
+	for i in $(test_seq 50); do
+		test_commit perf-$i file
+	done &&
+	git tag perf-topic-branch-initial
+'
+
+test_perf 'rebase -m --onto master^' '
+	git checkout perf-topic-branch &&
+	git reset --hard perf-topic-branch-initial &&
+	git rebase -m --onto master^ master
+'
+
+test_done
diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
new file mode 100755
index 0000000..aaca105
--- /dev/null
+++ b/t/perf/p3404-rebase-interactive.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description="Tests interactive rebase performance"
+
+. ./perf-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+# Setup a topic branch with 50 commits
+test_expect_success 'setup topic branch' '
+	git checkout -b perf-topic-branch master &&
+	for i in $(test_seq 50); do
+		test_commit perf-$i file
+	done &&
+	git tag perf-topic-branch-initial
+'
+
+test_perf 'rebase -i --onto master^' '
+	git checkout perf-topic-branch &&
+	git reset --hard perf-topic-branch-initial &&
+	GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
+'
+
+test_done
-- 
2.7.0
