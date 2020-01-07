Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9288CC33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A822075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCWgeXIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgAGExt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46088 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgAGExi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so41581629qke.13
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1VJMwScl7Uk2kNG44Oe0XCc3aJ6N+HOl+OvzYjuncU=;
        b=PCWgeXINZ6FNVSWOELEokb+E1h2jJvW6RpvNPwNzjMX5b0Ya4lIxbwH3JodjMF2ANI
         eYwlz2mGt4czvD4r+Ikm3ioxlgr6ea+swnlHlLGwgJFqHmFkAL5G64RqSiN/EIA1TwB4
         IqyrCxOYfbMBqYwq44y1/f+QlGv8Gyrkbl+DxBhZWRBD5iqnM84OdylKNoXnpKrhhs98
         bbDlQiybNZoS2w13bhPQ+0TjT6dER0V6gmJmNSctnYebOF7KjiyEkN9eHCp9pSPYOd1b
         Nie5yLzWf3olufsMOibkAn07mpsaJcs0IKknrE4vZptgXdQLqYd8Li0VPTcGoU0MZ9m7
         igVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1VJMwScl7Uk2kNG44Oe0XCc3aJ6N+HOl+OvzYjuncU=;
        b=I2IS02WUW1y170JD+hYJzJdpVsqTrr6d4/stJpzbLLcV1mHKqv0IyiulPVM9//jomH
         wtZb6Fs16Zc1GjzbIRIcUNaTxAgGbomZPvJ0p829uaIQSRuZzyBzCmj/xs9QgLwQAKm4
         +T6ygQVWgN3p/ebVE3IRm+eXA+1muKz7Nbyo9lY6Cwk1fWfHkOlzp5p+WYdTUxK3qj9T
         9PAsw8MEHt6O0bFxgtfxaxVDqLSbC+eg6x8smwtnzBhGbBbsjYGU28DLJI2p5tmUS8NJ
         tRby9BUGeCVRWGCvpdkYJ238ChXa+LuFMRF16SkgxFekIK/2ObjhI4N0bZg7c/qxuKIb
         aleQ==
X-Gm-Message-State: APjAAAVKv+TNgpZxwAGCl+piH0FXY3HBtM4iioY/jf3nZH5UxXpgylbL
        KkCrhiLOZ+B64Z/XMk18Hat+MDlx
X-Google-Smtp-Source: APXvYqw/7v+6RRhDzgpdXE9lAwzUt5dGE8upjIOuRhH3jWNXd/034rQneZkoukWBRqYTX/PFWBdMvg==
X-Received: by 2002:a05:620a:1005:: with SMTP id z5mr85550853qkj.26.1578372817024;
        Mon, 06 Jan 2020 20:53:37 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:36 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/16] t3415: increase granularity of test_auto_{fixup,squash}()
Date:   Mon,  6 Jan 2020 23:53:08 -0500
Message-Id: <8b716c6a8198edb6a7f060cff797cb1085fdceab.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are using `test_must_fail test_auto_{fixup,squash}` which would
ensure that the function failed. However, this is a little ham-fisted as
there is no way of ensuring that the expected part of the function
actually fails.

Increase the granularity by accepting an optional `!` first argument
which will check that the rebase does not squash in any commits by
ensuring that there are still 4 commits. If `!` is not provided, the old
logic is run.

This patch may be better reviewed with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 64 +++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b0add36f82..093de9005b 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -25,6 +25,13 @@ test_expect_success setup '
 '
 
 test_auto_fixup () {
+	no_squash= &&
+	if test "x$1" = 'x!'
+	then
+		no_squash=true
+		shift
+	fi &&
+
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -35,14 +42,19 @@ test_auto_fixup () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual &&
-	git diff --exit-code $1 &&
-	echo 1 >expect &&
-	git cat-file blob HEAD^:file1 >actual &&
-	test_cmp expect actual &&
-	git cat-file commit HEAD^ >commit &&
-	grep first commit >actual &&
-	test_line_count = 1 actual
+	if test -n "$no_squash"
+	then
+		test_line_count = 4 actual
+	else
+		test_line_count = 3 actual &&
+		git diff --exit-code $1 &&
+		echo 1 >expect &&
+		git cat-file blob HEAD^:file1 >actual &&
+		test_cmp expect actual &&
+		git cat-file commit HEAD^ >commit &&
+		grep first commit >actual &&
+		test_line_count = 1 actual
+	fi
 }
 
 test_expect_success 'auto fixup (option)' '
@@ -52,12 +64,19 @@ test_expect_success 'auto fixup (option)' '
 test_expect_success 'auto fixup (config)' '
 	git config rebase.autosquash true &&
 	test_auto_fixup final-fixup-config-true &&
-	test_must_fail test_auto_fixup fixup-config-true-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
 	git config rebase.autosquash false &&
-	test_must_fail test_auto_fixup final-fixup-config-false
+	test_auto_fixup ! final-fixup-config-false
 '
 
 test_auto_squash () {
+	no_squash= &&
+	if test "x$1" = 'x!'
+	then
+		no_squash=true
+		shift
+	fi &&
+
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -68,14 +87,19 @@ test_auto_squash () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual &&
-	git diff --exit-code $1 &&
-	echo 1 >expect &&
-	git cat-file blob HEAD^:file1 >actual &&
-	test_cmp expect actual &&
-	git cat-file commit HEAD^ >commit &&
-	grep first commit >actual &&
-	test_line_count = 2 actual
+	if test -n "$no_squash"
+	then
+		test_line_count = 4 actual
+	else
+		test_line_count = 3 actual &&
+		git diff --exit-code $1 &&
+		echo 1 >expect &&
+		git cat-file blob HEAD^:file1 >actual &&
+		test_cmp expect actual &&
+		git cat-file commit HEAD^ >commit &&
+		grep first commit >actual &&
+		test_line_count = 2 actual
+	fi
 }
 
 test_expect_success 'auto squash (option)' '
@@ -85,9 +109,9 @@ test_expect_success 'auto squash (option)' '
 test_expect_success 'auto squash (config)' '
 	git config rebase.autosquash true &&
 	test_auto_squash final-squash-config-true &&
-	test_must_fail test_auto_squash squash-config-true-no --no-autosquash &&
+	test_auto_squash ! squash-config-true-no --no-autosquash &&
 	git config rebase.autosquash false &&
-	test_must_fail test_auto_squash final-squash-config-false
+	test_auto_squash ! final-squash-config-false
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
2.25.0.rc1.180.g49a268d3eb

