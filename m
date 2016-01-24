From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 11/11] t7063: add tests for core.untrackedCache
Date: Sun, 24 Jan 2016 16:28:24 +0100
Message-ID: <1453649304-18121-12-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:30:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbw-0001A9-53
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbcAXP3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33052 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbcAXP3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:29:00 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so6828936wmu.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8ETtH4h21opmkGrX/NMSs8bGGg+75dYx2SfcT0HhIw=;
        b=M9th1wl+8wYNABr7VJ7SSPRNf+mzDH5svviW7Oex6KNVR/MW36EW2Ez8fu1QJGfh1O
         pshbvjRwqOVjwiJLrUgngu/WXj9n9UOJgNWCTPCCHvexfsd4KJD3hYeklXyZNGoKaRVx
         7Y+9gNs51ozczV65nPPyOUsLWJ1E3H3qILJhnqbywedNTLlhHjU9HCwMOItn1/+v/E8v
         rjmemqBmjIP7Z3RenyLWdJa0CrpV/tp/s4jrZ12hTkFB7rEbGaTypgWek5Yw2UYm9TQK
         GRW6qDG0PBbYEeR7itFfLMVSPscko+McHKwxi52E9iEVkPBraXF77D6XXm81jkrJ+Sn2
         E+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8ETtH4h21opmkGrX/NMSs8bGGg+75dYx2SfcT0HhIw=;
        b=g0E/nWjV/Gld8XkqchTQsXoZJ7WhmL0bWc4d8qISWwQt1SmxY79vyAly2S2fFobyNf
         0R0M0InVodf/Mt+WsBG7s4EeoWg54s2W7bEvWOOA0jXxo2LZJVMK1WvFdbpwDoqTf+sp
         picT1MPswvr+idNo5pgPCrFG0RhJRUFQSWpGn02XJsCuhyIKQpxXBFVBR3NqCi5qS1IU
         bSKksJC8hZ5uXq0IxZafFyuuTk/ntY1zx3H8qS/eb2IacfDKEacpo4j5iXhgaPJtbTVZ
         gzKgJqGrUw+HI2QOADqFmHoimJBKASsYkkNht1Q9EgnfRWURHTTDrJC820H+xwMwLyWc
         JeXA==
X-Gm-Message-State: AG10YOR9iTewz/5F4sqp/si4clz4a3gwANi6mJqAdRDaE+Qdhw+AvoC4FVWk4pWOif+wKg==
X-Received: by 10.194.171.66 with SMTP id as2mr12860552wjc.73.1453649339041;
        Sun, 24 Jan 2016 07:28:59 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:58 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284662>

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
2.7.0.181.gd7ef666.dirty
