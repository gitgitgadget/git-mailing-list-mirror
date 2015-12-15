From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 09/10] t7063: add tests for core.untrackedCache
Date: Tue, 15 Dec 2015 17:28:26 +0100
Message-ID: <1450196907-17805-10-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTs-0004al-1N
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbbLOQ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:22 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34819 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151AbbLOQ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:20 -0500
Received: by mail-wm0-f46.google.com with SMTP id l126so1689606wml.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LuAUZV9RBuOdP+kvgzTAOdq1lie5dQCnNNvgZxaP7Hg=;
        b=aq2hcqN9BDe9yu0vsmRpeuZR0VcqknvfxXAulxbrBvFPNrk6dOMnOXYb9wxBmGOnwd
         +/bfHwFOtOREBt6vjgMhXN4XiKQ5vxl0dzYp0e8eusbHtg+JYPf6vazvch2qUhEmbwoz
         /6joFQvuaQzviNOP2krzqnNUT4Hpj81dvN2du4OYAcmY9E0cbTEPCUIK+F/qYZD0REmP
         js/vjYkTo1L/RqPulX1LsdBv6GObJzZoWisiO0YDl9EzDjeoDIq/vZ1d6LGHpIp7ECgj
         obJG8OD4DQEo8fKDEH2HekVqd1i9kLZhNNPqRBsutPL75dJDeZ9f+lEaeriWkdI4sWHj
         9NYA==
X-Received: by 10.28.15.132 with SMTP id 126mr289355wmp.80.1450196959413;
        Tue, 15 Dec 2015 08:29:19 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:18 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282490>

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
2.6.3.479.g8eb29d4
