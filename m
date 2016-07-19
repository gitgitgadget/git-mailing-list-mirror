Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BBE82018B
	for <e@80x24.org>; Tue, 19 Jul 2016 03:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcGSD6E (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 23:58:04 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34778 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbcGSD6C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 23:58:02 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so491837pac.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 20:58:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQBQFP9LDp7tgMOF4U8Al4WXvPyRsuOs7EnXtzjceuA=;
        b=fAQz6/fJRbP3bbE5pgUgQSORH/OQM1+kAmw4/yfkGwWwLlXgZQTSfn4XOh64BlQyDm
         94Bk/X4U1YqZ5Mkq8UM2/tuB5aOUQpc0kTgiizK99DBKuab3hz9u6HXIW2Y8SyackRgI
         erWJTAFjOjKGoacqwWvTXx1FhQuP1w0b438YXhIcCbRTedH+fMl5WL2geZnwng3lKJfD
         lN3WXwlBQD2pf7VMawkXXVFy1sp6N/j266USuHMWXb5BWdmr7I/cF1mqDRMdE9DF+6FH
         TJBDRxIYeevdiFJbx8d1cd1pw2KUHV/RGS63j6ecenvXuqOxVd/C2V/WDj7RP2ulmpUX
         WT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gQBQFP9LDp7tgMOF4U8Al4WXvPyRsuOs7EnXtzjceuA=;
        b=KuqVT57+3vi+umQCQZlN6D2XXeZ0tqmMUd7k8CwgOpEGo6Vjr6xbnBNT4OQDT0WU1y
         3/99aaEggw4BXS6qBhaic+Xk8uz8gj6nrg8h6iEYRSSNerQWoLslZpARkW+tFVoEyPXm
         Bo1y8dYR4KF/EhAP9vn023s8qPcUH+nJj8tmzB/uO9YQll8oxcAZmifsi/PT3/rBcMoF
         GuZlBUY+5/aGIJljkjqfJ3m3dWtLaBZZgTohFzjp8UYl7jsxMFReYD+zFAaLm/7fQ89H
         UVyvscGCgwq1o+bUVDnorXQT+QqexoWaHkJlBp3x3WjCWCEXLf050VwMIuwQhgmhwmSD
         lS8w==
X-Gm-Message-State: ALyK8tI+yIzgntoDdcSZLVYP0j6Vg6AlFtrMWSVwKhV5b0AdiKzyUNp/bYYCcWrZ2swg6A==
X-Received: by 10.66.81.3 with SMTP id v3mr61454526pax.121.1468900681319;
        Mon, 18 Jul 2016 20:58:01 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id xs12sm172523pac.7.2016.07.18.20.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 20:58:00 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] difftool: avoid $GIT_DIR and $GIT_WORK_TREE
Date:	Mon, 18 Jul 2016 20:57:55 -0700
Message-Id: <20160719035756.24961-2-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.280.g385e27a
In-Reply-To: <20160719035756.24961-1-davvid@gmail.com>
References: <20160719035756.24961-1-davvid@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Environment variables are global and hard to reason about.
Use the `--git-dir` and `--work-tree` arguments when invoking `git`
instead of relying on the environment.

Add a test to ensure that difftool's dir-diff feature works when these
variables are present in the environment.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl   | 27 ++++++---------------------
 t/t7800-difftool.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index c9d3ef8..bc2267f 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -83,20 +83,17 @@ sub changed_files
 {
 	my ($repo_path, $index, $worktree) = @_;
 	$ENV{GIT_INDEX_FILE} = $index;
-	$ENV{GIT_WORK_TREE} = $worktree;
-	my $must_unset_git_dir = 0;
-	if (not defined($ENV{GIT_DIR})) {
-		$must_unset_git_dir = 1;
-		$ENV{GIT_DIR} = $repo_path;
-	}
 
-	my @refreshargs = qw/update-index --really-refresh -q --unmerged/;
-	my @gitargs = qw/diff-files --name-only -z/;
+	my @gitargs = ('--git-dir', $repo_path, '--work-tree', $worktree);
+	my @refreshargs = (
+		@gitargs, 'update-index',
+		'--really-refresh', '-q', '--unmerged');
+	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
 	try {
 		Git::command_oneline(@refreshargs);
 	} catch Git::Error::Command with {};
 
-	my $line = Git::command_oneline(@gitargs);
+	my $line = Git::command_oneline(@diffargs);
 	my @files;
 	if (defined $line) {
 		@files = split('\0', $line);
@@ -105,8 +102,6 @@ sub changed_files
 	}
 
 	delete($ENV{GIT_INDEX_FILE});
-	delete($ENV{GIT_WORK_TREE});
-	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
 
 	return map { $_ => 1 } @files;
 }
@@ -204,15 +199,6 @@ EOF
 	mkpath($ldir) or exit_cleanup($tmpdir, 1);
 	mkpath($rdir) or exit_cleanup($tmpdir, 1);
 
-	# If $GIT_DIR is not set prior to calling 'git update-index' and
-	# 'git checkout-index', then those commands will fail if difftool
-	# is called from a directory other than the repo root.
-	my $must_unset_git_dir = 0;
-	if (not defined($ENV{GIT_DIR})) {
-		$must_unset_git_dir = 1;
-		$ENV{GIT_DIR} = $repo_path;
-	}
-
 	# Populate the left and right directories based on each index file
 	my ($inpipe, $ctx);
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
@@ -241,7 +227,6 @@ EOF
 
 	# If $GIT_DIR was explicitly set just for the update/checkout
 	# commands, then it should be unset before continuing.
-	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
 	delete($ENV{GIT_INDEX_FILE});
 
 	# Changes in the working tree need special treatment since they are
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 42a2929..fa43c24 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -412,6 +412,22 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	)
 '
 
+run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
+	(
+		GIT_DIR=$(pwd)/.git &&
+		export GIT_DIR &&
+		GIT_WORK_TREE=$(pwd) &&
+		export GIT_WORK_TREE &&
+		cd sub &&
+		git difftool --dir-diff $symlinks --extcmd ls \
+			branch -- sub >output &&
+		sane_unset GIT_WORK_TREE &&
+		sane_unset GIT_DIR &&
+		grep sub output &&
+		! grep file output
+	)
+'
+
 run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
 	test_when_finished git reset --hard &&
 	rm file2 &&
-- 
2.9.2.280.g385e27a

