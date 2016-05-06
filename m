From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Fri,  6 May 2016 09:35:19 -0400
Message-ID: <1462541720-79553-2-git-send-email-rappazzo@gmail.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 15:35:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfud-00054H-W2
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336AbcEFNfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:35:17 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34246 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515AbcEFNfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:35:08 -0400
Received: by mail-qg0-f67.google.com with SMTP id e35so6890411qge.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aomJ9h9e8zpJJy4+ydtquIImWqMdWs0/ZqnsmEO1Yv4=;
        b=KNTYapvXTeT0gooTsJ0ULSTs1RI2PuF1Z3bnigVOJi6Nh8B32Z7rQXaHKDU+3t/aM3
         pdRHsjGN2ZR/KM2lzyyIvOSJ43iWyBONVQuWMeAcQe1rV4GqdBvASeONHU+vdeotFzUC
         HXKhcQODEHdw/dl9M0W4d4kaOoSniVFcYLoY2RxVxuvstJNP6Q+1Y7nI+MKVDKEQwWE4
         WFlZWJFPAc/Jpnm8qfcfZrqTxi9C3CR4Zl1zzzq4uxC+6Wf4K/qFHRA8ElGxWuZbFzLG
         UGxVE4MF/Xh6EP6SRrMwoNvZaGGp/foa/PRAuFBvaOXZuSLsgPhcwacuHSRD3ZLG381U
         R9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aomJ9h9e8zpJJy4+ydtquIImWqMdWs0/ZqnsmEO1Yv4=;
        b=DrqpRsmf8e+UHIP9/CRJWXIcZyOCRzIObIZfg5xcccaipYDDUwjOyIKrxEAR9nZ7Qq
         fHTzWRqb7vDMwkVLxfFrmiHRIKZM5e7BFS6uwX4/UHp2NqPjMKJAmVoNzj+QoSZKWLkD
         j1/ZsblaKyPumO0eoenTagFv9uynLzs4TbRdf5GUMJD5VBzc1LZNhBZ7fUdaovbIcJhw
         boMrkthGOao2eF3DeSaUyEzN/OM0X8A/TJJD6r6B2hrP/QkMtTWcnOOLkeKmwi22GjDG
         8DXCHu2X9wvvjzEmRYX5izauBJR0lCtun1gyvwLy7x3tt1xBpOjfrJtGqhpheBlpAg+M
         lWCg==
X-Gm-Message-State: AOPr4FVJlgaOCa7e/D0yxgQ9/6CU6WwYtqYXL8SaKQ2w1NOqaRNhJfIlG9QTh6BLzVOIsA==
X-Received: by 10.141.46.71 with SMTP id x68mr21290705qhe.70.1462541707558;
        Fri, 06 May 2016 06:35:07 -0700 (PDT)
Received: from mrappazzo-8.infor.com (rrcs-198-179-75-179.nyc.biz.rr.com. [198.179.75.179])
        by smtp.gmail.com with ESMTPSA id w17sm5702457qha.23.2016.05.06.06.35.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 06:35:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293780>

t1500-rev-parse contains envrionment leaks (changing dir without
changing back, setting config variables, etc).  Add a test to clean this
up up so that future tests can be added without worry of any setting
from a previous test.

t2027-worktree-list has an incorrect expectation for --git-common-dir
which has been adjusted and marked to expect failure.

Some of the tests added have been marked to expect failure.  These
demonstrate a problem with the way that some options to git rev-parse
behave when executed from a subdirectory of the main worktree.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1500-rev-parse.sh     | 38 ++++++++++++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 12 ++++++++++--
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..442ca46 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -36,6 +36,7 @@ test_rev_parse() {
 # label is-bare is-inside-git is-inside-work prefix git-dir
 
 ROOT=$(pwd)
+original_core_bare=$(git config core.bare)
 
 test_rev_parse toplevel false false true '' .git
 
@@ -84,4 +85,41 @@ test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 git config --unset core.bare
 test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
+test_expect_success 'cleanup from the previous tests' '
+	cd .. &&
+	rm -r work &&
+	mv repo.git .git &&
+	unset GIT_DIR &&
+	unset GIT_CONFIG &&
+	git config core.bare $original_core_bare
+'
+
+test_expect_success 'git-common-dir from worktree root' '
+	echo .git >expect &&
+	git rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-common-dir inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
+	git -C path/to/child rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path from worktree root' '
+	echo .git/objects >expect &&
+	git rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-path inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
+	git -C path/to/child rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8aef49f..8ca21bd 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,21 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure 'rev-parse --shared-index-path' '
+	rm -rf .git &&
+	test_create_repo . &&
+	git update-index --split-index &&
+	ls -t .git/sharedindex* | tail -n 1 >expect &&
+	git rev-parse --shared-index-path >actual &&
+	test_cmp expect actual &&
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	(
+		cd work &&
+		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 1b1b65a..53cc5d3 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,16 +8,24 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_success 'rev-parse --git-common-dir on main worktree' '
+test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
 	mkdir sub &&
 	git -C sub rev-parse --git-common-dir >actual2 &&
-	echo sub/.git >expected2 &&
+	echo ../.git >expected2 &&
 	test_cmp expected2 actual2
 '
 
+test_expect_failure 'rev-parse --git-path objects linked worktree' '
+	echo "$(git rev-parse --show-toplevel)/.git/worktrees/linked-tree/objects" >expect &&
+	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	git worktree add --detach linked-tree master &&
+	git -C linked-tree rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here && git worktree prune" &&
-- 
2.8.0
