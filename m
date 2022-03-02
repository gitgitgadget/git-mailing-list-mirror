Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A187C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbiCBR2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiCBR2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0B1AF2B
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so3874538wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1p5+p1u0AcH72vQeXXs+MqrUu9P2J0RxH4azzN4H7U=;
        b=Act4WTJqutRQ5k+l29MOBNeogzvnq7JKy83o1sFqFl1FXzci+BsUXEc/iMh5tOPSLR
         5uxkwRXZPIH+cMEraVojwxKHaDX4vagTwCcZAAFbICb7+A5XO25tXQxQ3Ai3boqbKxAh
         QB99TpeoLqDBvT3M+kQL8qBmzBShsamGDF6k9vK0Mqo1NuM0tVtw3z9geTmzyza36tT5
         RkT6BDJTzXenSgtzP9h8U7H59nXnDXIiDaLvFkDdO7LM87QaaOmsXFdkxr5zX6C0R+Dh
         B/0MAfSXtNXN7+SjbHAVmdr/TwjAKJomcoLUT783bh8SimmbwQG2XoBzwWjOqVKRftvI
         c3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1p5+p1u0AcH72vQeXXs+MqrUu9P2J0RxH4azzN4H7U=;
        b=ZON3nWaOYPKcqDvlpTQGov7ZUZJoMbwXjJGjoSXvuPlVsvdmZQEJUEzVDILgoTcSdf
         D5qDoFFnKWYC0nol0ch4cABVt57TID7jxOSjUHICHyk14RDgeEgLsRwBkaX5UEclsiEy
         sidhtysfxjxnrNzJX1KFFLorjxjwVuDxL9LOiwMfXiyD9uXl1XHQfZ/KsLetQbyDG3Lx
         n8qRrZj5EFGeB2nvKk9SCbNoEXisfvJdCcIhj4fXh/HiuYc0nR8CZZ61/ORbbzMvasap
         pxHoJanaf0JfVdIioY46HSLF9budGeCuCCeaIBR28kihqxpm76eQCW1Ty3IHxkO+6dxM
         zemQ==
X-Gm-Message-State: AOAM533OBiXoc18g3ffQNqpsb7BE6QH9BmPn6Mm3fWZAMNB4osfk3SFO
        8IbMLWaD+xbp3ZNRvNLLaDYxsioz2Onm4A==
X-Google-Smtp-Source: ABdhPJyJ2YgxB7yz7yfR7mC+tJRwQMmi39wklKjaeEfNwj9ek8T8N4XZxL0otFsz1RQ0yyW63/pFFQ==
X-Received: by 2002:a5d:4a8f:0:b0:1f0:4af2:4e29 with SMTP id o15-20020a5d4a8f000000b001f04af24e29mr236865wrq.519.1646242063415;
        Wed, 02 Mar 2022 09:27:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/15] rev-list simplify tests: don't ignore "git" exit code
Date:   Wed,  2 Mar 2022 18:27:24 +0100
Message-Id: <patch-15.15-4ee216711cf-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile test pattern introduced in 65347030590 (Topo-sort
before --simplify-merges, 2008-08-03) to check the exit code of both
"git name-rev" and "git log".

This test as a whole would fail under SANITIZE=leak, but we'd pass
several "failing" tests due to hiding these exit codes before we'd
spot git dying with abort(). Now we'll instead spot all of the
failures.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6012-rev-list-simplify.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 63fcccec32e..de1e87f1621 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -12,7 +12,9 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
+	test_when_finished "rm -f tmp" &&
+	git name-rev --tags --annotate-stdin >tmp &&
+	sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g" <tmp
 }
 
 #
@@ -111,8 +113,8 @@ check_outcome () {
 	shift &&
 	param="$*" &&
 	test_expect_$outcome "log $param" '
-		git log --pretty="$FMT" --parents $param |
-		unnote >actual &&
+		git log --pretty="$FMT" --parents $param >out &&
+		unnote >actual <out &&
 		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
 		test_cmp expect check
 	'
@@ -151,8 +153,8 @@ check_result 'L K I H G B' --exclude-first-parent-only --first-parent L ^F
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
 	printf "%s\n" E C B A >expect &&
-	git log --pretty="$FMT" --full-history E -- lost |
-	unnote >actual &&
+	git log --pretty="$FMT" --full-history E -- lost >out &&
+	unnote >actual <out &&
 	sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
 	test_cmp expect check
 '
-- 
2.35.1.1226.g8b497615d32

