From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 8/8] t7063: add tests for core.untrackedCache
Date: Tue,  8 Dec 2015 18:15:16 +0100
Message-ID: <1449594916-21167-9-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6LsN-0007P0-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbbLHRP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:58 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37283 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbLHRPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:55 -0500
Received: by wmww144 with SMTP id w144so38468293wmw.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/rs5Nma6z+arrZefmbM1gTCrPs0nUGEpZcRom5xnHAM=;
        b=VHYqzQ8h/Xa8ORz19kOAVPaAwbDW0Q3Bh+dvNHwYhHIub/FMGBMLefCkzhszyuEHZ1
         3LpG0pfhhFsCdt+KTnzafANlX4xJ7pJs6OLC2OnXdOb5yCTzGG/1aJHpQ7g5iQ8Y5d0q
         /xQedVhaInyu6W6AENq0V985NpyaboqPvwZkKRfKJ7GjvebHL0ui+b7pg3d3FBzzd081
         p4yzAujnyLHJxr+At60L6ES40Prq9XeM4+8fQFAOuZam6BvnmFlZxmfFkqLTobgEqBaq
         EVEQ9KaY6LwkT+0XyyUFJSv6cFSt4OmFsfPvg9bqvGufEiC6m4wGsJ9t9ME38kCKkNmL
         qgrA==
X-Received: by 10.194.59.108 with SMTP id y12mr706516wjq.33.1449594954648;
        Tue, 08 Dec 2015 09:15:54 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:53 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282166>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7063-status-untracked-cache.sh | 48 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 253160a..f0af41c 100755
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
@@ -28,6 +32,11 @@ test_expect_success 'setup' '
 	git update-index --untracked-cache
 '
 
+test_expect_success 'core.untrackedCache is true' '
+	UC=$(git config core.untrackedCache) &&
+	test "$UC" = "true"
+'
+
 test_expect_success 'untracked cache is empty' '
 	test-dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
@@ -506,7 +515,7 @@ EOF
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
@@ -525,7 +534,7 @@ file
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
 two
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-from-test-dump ../actual
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
@@ -569,4 +578,39 @@ EOF
 	test_cmp ../status.expect ../status.actual
 '
 
+test_expect_success '--no-untracked-cache removes the cache' '
+	git update-index --no-untracked-cache &&
+	UC=$(git config core.untrackedCache) &&
+	test "$UC" = "false" &&
+	test-dump-untracked-cache >../actual &&
+	echo "no untracked cache" >../expect &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'git status does not change anything' '
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	UC=$(git config core.untrackedCache) &&
+	test "$UC" = "false"
+'
+
+test_expect_success 'setting core.untrackedCache and using git status creates the cache' '
+	git config core.untrackedCache true &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'unsetting core.untrackedCache and using git status removes the cache' '
+	git config --unset core.untrackedCache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
 test_done
-- 
2.6.3.478.g9f95483.dirty
