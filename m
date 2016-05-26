From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v4 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Thu, 26 May 2016 07:19:15 -0400
Message-ID: <1464261556-89722-2-git-send-email-rappazzo@gmail.com>
References: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	mh@glandium.org, sunshine@sunshineco.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 13:19:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5tJy-0004oE-IL
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 13:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbcEZLTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 07:19:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35076 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcEZLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 07:19:12 -0400
Received: by mail-yw0-f196.google.com with SMTP id n16so1700342ywd.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6mNjeLCFqdUUSFf7oYHLqcwd1v+WfdmHQd7MRA+pQU=;
        b=XuGpIbU+uh7YEljjL2DCAvLQkbrjyK9hsT6QaM4Y0sMdQzgqci3XXxPURg/ivpvIuU
         0g4+tdiKdkiA90XwxcS2HMWKdA1/OWwcaYU+heSmq7IxOhRa26NGl4MDyUSx7E6ZBB5s
         QzuQVHVcUI7qyrlSewjerniAcfqbcd+QncDt9CBzN8HB4GuhuyuAkEg7sVvoHvRmGvGe
         S0N3E0SGFggEHdOex3S5L6Kit4wvCWoaWUqoJnR30aWJFdOMFxQuL221uWA8m4mIo1Ge
         0dyAv7LQZrQW1h+QFwSeSO3G9wtzzX4sFIWUXz2sZX4GcKyp+QP14DAkLimZBbSrJsbj
         Wpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6mNjeLCFqdUUSFf7oYHLqcwd1v+WfdmHQd7MRA+pQU=;
        b=FHobuixn1I9MKH827aJ+f9trNwySx2JbfpJI3EhZHaaUdsimlAUznZiTe+BAp18pfY
         Pux5HnZpX9ZKevHk2JF0IOCp6+ffSg6R4ssozhcT8bxZOZpun6TEPtUZfIhyMXEsy9bF
         PSd9bRzL3XWciXc1LfOp+WON5oxHIVvcO9sG0UNBZ+A5/fy9qMP3zm/eqy9UQ7zIjiOx
         yfsI0bQOMcVEvqciRF3+09jUkSsN/iq72zaNkSxNFYGwsZ3VB8HFozydFfELzlj4G8fh
         cPVPAYr5zFBZL7nmcLSJGePOchr6UDKyW4TEyksF3jg62jMlROwkcyqS7Kp0fTGFRBq3
         gfDg==
X-Gm-Message-State: ALyK8tKfCqbkReCqZ3ToGfGKMFXMf4lBzbjGQ5nwR/+AgYpTsZl0zfdwLOCE6y6HDMsNcQ==
X-Received: by 10.129.79.16 with SMTP id d16mr5836268ywb.194.1464261551395;
        Thu, 26 May 2016 04:19:11 -0700 (PDT)
Received: from localhost.localdomain (146.sub-70-208-87.myvzw.com. [70.208.87.146])
        by smtp.gmail.com with ESMTPSA id l200sm2095979ywe.40.2016.05.26.04.19.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 04:19:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295645>

t2027-worktree-list has an incorrect expectation for --git-common-dir
which has been adjusted and marked to expect failure.

Some of the tests added have been marked to expect failure.  These
demonstrate a problem with the way that some options to git rev-parse
behave when executed from a subdirectory of the main worktree.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 12 ++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 038e24c..f39f783 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -87,4 +87,32 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
 
 test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
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
