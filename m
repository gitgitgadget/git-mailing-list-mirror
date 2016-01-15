From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 11/11] t7063: add tests for core.untrackedCache
Date: Fri, 15 Jan 2016 07:59:52 +0100
Message-ID: <1452841192-620-12-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:01:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNb-0005DP-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbcAOHAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:55 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35565 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723AbcAOHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:54 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so8323661wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cE4sd6xbtza6IqkFJgg/D0Hjp4H7mqHpAAFmYuZ8bu8=;
        b=UdxKHQot4ADmhs+im1MxD8bLhp7bIl0NnRbGpWAEkYo3YjYNAQBN2hsGK5mgoYRETm
         Xjd9iY7Z78WShmfsNhDMydqhAA4eGwPqlq5kxjV8IeTi70ZFjAxMdr03cx1eW7pPGIiG
         QA3HmvtWS3FB61YdrX5aH6hXwotMku32sHT7xPA+vf9ALBJ+6RvO71izZfKCQaI7dcrE
         W6GSrnRBW4yHY9kbFtPk58o1lyxDe4mb2bssQ06BNrYwOxUrzY3urI9Gzc3wNMg1ep6Y
         vuwLN+3V5TetQ4T7cL1beDsqpMXcklKS5vxJw+ylUzKg3Z0yIpydCx2spmMXZ/DyLKMa
         pfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cE4sd6xbtza6IqkFJgg/D0Hjp4H7mqHpAAFmYuZ8bu8=;
        b=eVP+DyWPXj4BpPYWTiG1mEsYqW0PDCK5ilXpzv3pzp934ZBH870cThoLJZ/+nN3j3/
         oEX6Z+G5e81ytOIuzkuDBbhW8BXLFRGI2Ge5q1AFGi1GprqPUC48WeuLpWT+TeriSwVr
         B5k+0R8MY3BXVGzLWzwVVElWKWJRx+ZrblPqEo7nrpeSNf211pajIXOwU8V4yUtmWqj4
         KX0aqgrXsemKDma8k8rGPdB9IYe+oyPJOFRRnS2fPzFMajgQff6v/cQYPeWsXg4SPUYC
         GmdCNldKbZ7OJPayQ0f+2hUOobupyhcP1DGshMQRBTFCmoEEYabfK2AYPgCyFiMgppEA
         fs2w==
X-Gm-Message-State: AG10YOQGW5S5WrHhzhE2dPnL01O1BxMn2Ip+BXx6OGf1Mr7mdVIh9+AGod+hdneNopuStg==
X-Received: by 10.28.15.210 with SMTP id 201mr1395076wmp.79.1452841252902;
        Thu, 14 Jan 2016 23:00:52 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:52 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284150>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7063-status-untracked-cache.sh | 85 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 253160a..b1dc860 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,6 +18,10 @@ if ! test_have_prereq UNTRACKED_CACHE; then
 	test_done
 fi
 
+test_expect_success 'core.untrackedCache is unset' '
+	test_must_fail git config --get core.untrackedCache
+'
+
 test_expect_success 'setup' '
 	git init worktree &&
 	cd worktree &&
@@ -30,13 +34,13 @@ test_expect_success 'setup' '
 
 test_expect_success 'untracked cache is empty' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-empty <<EOF &&
 info/exclude 0000000000000000000000000000000000000000
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-empty ../actual
 '
 
 cat >../status.expect <<EOF &&
@@ -506,7 +510,7 @@ EOF
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
@@ -525,7 +529,7 @@ file
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
 two
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-from-test-dump ../actual
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
@@ -569,4 +573,77 @@ EOF
 	test_cmp ../status.expect ../status.actual
 '
 
+test_expect_success '--no-untracked-cache removes the cache' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	echo "no untracked cache" >../expect &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'git status does not change anything' '
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
+	git config core.untrackedCache true &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'using --no-untracked-cache does not fail when core.untrackedCache is true' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to false and using git status removes the cache' '
+	git config core.untrackedCache false &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'using --untracked-cache does not fail when core.untrackedCache is false' '
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to keep' '
+	git config core.untrackedCache keep &&
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual &&
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git update-index --force-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'test ident field is working' '
+	mkdir ../other_worktree &&
+	cp -R done dthree dtwo four three ../other_worktree &&
+	GIT_WORK_TREE=../other_worktree git status 2>../err &&
+	echo "warning: Untracked cache is disabled on this system or location." >../expect &&
+	test_cmp ../expect ../err
+'
+
 test_done
-- 
2.7.0.36.g20612a7
