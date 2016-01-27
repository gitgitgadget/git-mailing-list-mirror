From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 11/11] t7063: add tests for core.untrackedCache
Date: Wed, 27 Jan 2016 07:58:07 +0100
Message-ID: <1453877887-11586-12-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKAb-0003in-KN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbcA0HEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:32 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34482 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbcA0HD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:59 -0500
Received: by mail-wm0-f51.google.com with SMTP id n5so13142631wmn.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5YfGBkyrXiqn8nhUP3HMJzCoCVXlcsf7s1Wvnj2/q0=;
        b=Rs61O2ebwN1TtDCJyrLv+UwP3+vJKr00ufj1bsFV+iM+b47jCDw6OXqbl5HouEBvpq
         J3aJVnSdFvYcv66UtUurhjLWbo4A6CCdTw3h/0Z77/Q2W8KrrpFEz4WYcdLa64w+6+bc
         GGjqvf7F9jOMtBCn2LN8c2MZJy264FC4qmwKiQmv4j+X2ma9Hb2+uWzY9qf0rpjfPytq
         NGdSbUWIiXbdzdnsX40g4rX2PFP3MXslXVQT11JjQXoZsSjwJHGl/GuYWagEgqbWRzSm
         mII5RhDTY1al2hDPQipOncsV0g8X6oeEvWEITTEYbi3+zaFICJ9uLLulxmvPSK+O3E8W
         5Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5YfGBkyrXiqn8nhUP3HMJzCoCVXlcsf7s1Wvnj2/q0=;
        b=SomeGftydo6Ctm1PeK2fIqK2iiE3EYUSCOC/G60M7XjZ5vjz6PGMS7U/Lae7sBmQ7f
         6jWOfwHG9U7Np6U1wJ3Va2Z2d4XH2dPWJIqCH77YMpNvHg77wl+kWX2tgH4KUpjbUzu5
         3t9XCP7OV9zox5jXgKZZoV8U070jOksuLGoqRBAl5r8XHruILBvHvimJ/k5QPc9VjxVU
         wEMi5KQtjonhRPRseYRojNSSXS5AD57SujZGtH52ooRaMQlUMTC+6ZizK9OZllmj0n3I
         +4ycIhD6wBdAR1AQhvVs76MMlNl7mF1bIYJ3ceVsf4yFzKJEq9nAeCz8BfvaHdUxQF7r
         tyJA==
X-Gm-Message-State: AG10YORSrufyngodJc21i5Oupoo2fGD6pNzv3HUzdIrnEGkE967m1JdIMQrdlZ3xXMODig==
X-Received: by 10.28.195.212 with SMTP id t203mr30526190wmf.46.1453878238523;
        Tue, 26 Jan 2016 23:03:58 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:57 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284887>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7063-status-untracked-cache.sh | 85 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 253160a..a971884 100755
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
+	echo "no untracked cache" >../expect-no-uc &&
+	test_cmp ../expect-no-uc ../actual
+'
+
+test_expect_success 'git status does not change anything' '
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
+	git config core.untrackedCache true &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'using --no-untracked-cache does not fail when core.untrackedCache is true' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual &&
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
+	test_cmp ../expect-no-uc ../actual
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
+	test_cmp ../expect-no-uc ../actual &&
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
2.7.0.181.g07d31f8
