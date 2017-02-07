Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25BB1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdBGJRM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 04:17:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34825 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbdBGJRI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 04:17:08 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so8904069pfa.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQvUvOUouH6eeQbVocU/fselsQfhubDWT+J2WRlMMmk=;
        b=ppsypDNkTc+zzYjyQP3tuNewl1VsewARhbz3Ga2/fbzuBBb8eDMpFpPgvvjuzURzuz
         pTJun4v466sJhdbr4ljLT1zoVizep9JN2MvTbGPR8IM/BHtutgr/i7RqLjWRK46VzGyL
         KJksZs7Tg3vW3NQmGnhXM++ex4CEW/KcRTaxbjSCtPMho3HsOrclqyLMgDZxi0bIMM2D
         LY4195WN3dA/c29kBPI5w2XlGs6BrBHrpCZeiG6fLLNHxS4jwZIDFEDonjxjUTiLrL5R
         ao+bO2nwimfupotaUAgtAWtdZ6XLpURUGdMdxrmuq6w4q6MEhRStoo76SX7OIOaaucve
         NUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQvUvOUouH6eeQbVocU/fselsQfhubDWT+J2WRlMMmk=;
        b=jGPp3XaGL9fwUNISO5IViYrCD8uk85J4KnkRjUs1HJ8Fx0ScLuXkPiJzp5UmCTkAA0
         SALUkCbjYEheRgd++zYFWpyvoT9iemdoFVFXC9U17R1SSq6U8SODZ2hRurfeJ6mdC+XC
         DFRGn78/op0hUjxs4tGGltftBwC1NtORXLv0WhOMgw8RaYIvXWh7+7gDuFQYjgLUzm6B
         82bncY8AahNk+PFn2BKFujMxos+NC59522Kmt1pWBSfMtvozaQor69THPR1C++HZqS5j
         1vy/H63iFNuPg6kKxAK+di/xT2eBx4fGgF7D4O0Q+oV2VefYdTq4Xei0zPluwEvFkk8Z
         dG0w==
X-Gm-Message-State: AIkVDXJ/ZMHDJ1GczchmYKx5X+gY/hTMOhebJ48oFsDILjcT2igajK73JcTqKwZXWO5YeA==
X-Received: by 10.99.102.134 with SMTP id a128mr18798873pgc.215.1486459028159;
        Tue, 07 Feb 2017 01:17:08 -0800 (PST)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id w123sm1320102pfb.44.2017.02.07.01.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 01:17:06 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] t7800: replace "wc -l" with test_line_count
Date:   Tue,  7 Feb 2017 01:17:00 -0800
Message-Id: <20170207091700.20156-2-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.228.g6c028b8e94
In-Reply-To: <20170207091700.20156-1-davvid@gmail.com>
References: <20170207091700.20156-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make t7800 easier to debug by capturing output into temporary files and
using test_line_count to make assertions on those files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 97bae54d83..25241f4096 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -290,8 +290,8 @@ test_expect_success 'difftool + mergetool config variables' '
 test_expect_success 'difftool.<tool>.path' '
 	test_config difftool.tkdiff.path echo &&
 	git difftool --tool=tkdiff --no-prompt branch >output &&
-	lines=$(grep file output | wc -l) &&
-	test "$lines" -eq 1
+	grep file output >grep-output &&
+	test_line_count = 1 grep-output
 '
 
 test_expect_success 'difftool --extcmd=cat' '
@@ -428,9 +428,12 @@ run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
 		# "sub" must only exist in "right"
 		# "file" and "file2" must be listed in both "left" and "right"
-		test "1" = $(grep sub output | wc -l) &&
-		test "2" = $(grep file"$" output | wc -l) &&
-		test "2" = $(grep file2 output | wc -l)
+		grep sub output > sub-output &&
+		test_line_count = 1 sub-output &&
+		grep file"$" output >file-output &&
+		test_line_count = 2 file-output &&
+		grep file2 output >file2-output &&
+		test_line_count = 2 file2-output
 	)
 '
 
@@ -440,9 +443,11 @@ run_dir_diff_test 'difftool --dir-diff v1 from subdirectory' '
 		git difftool --dir-diff $symlinks --extcmd ls v1 >output &&
 		# "sub" and "file" exist in both v1 and HEAD.
 		# "file2" is unchanged.
-		test "2" = $(grep sub output | wc -l) &&
-		test "2" = $(grep file output | wc -l) &&
-		test "0" = $(grep file2 output | wc -l)
+		grep sub output >sub-output &&
+		test_line_count = 2 sub-output &&
+		grep file output >file-output &&
+		test_line_count = 2 file-output &&
+		! grep file2 output
 	)
 '
 
@@ -452,8 +457,9 @@ run_dir_diff_test 'difftool --dir-diff branch from subdirectory w/ pathspec' '
 		git difftool --dir-diff $symlinks --extcmd ls branch -- .>output &&
 		# "sub" only exists in "right"
 		# "file" and "file2" must not be listed
-		test "1" = $(grep sub output | wc -l) &&
-		test "0" = $(grep file output | wc -l)
+		grep sub output >sub-output &&
+		test_line_count = 1 sub-output &&
+		! grep file output
 	)
 '
 
@@ -463,8 +469,9 @@ run_dir_diff_test 'difftool --dir-diff v1 from subdirectory w/ pathspec' '
 		git difftool --dir-diff $symlinks --extcmd ls v1 -- .>output &&
 		# "sub" exists in v1 and HEAD
 		# "file" is filtered out by the pathspec
-		test "2" = $(grep sub output | wc -l) &&
-		test "0" = $(grep file output | wc -l)
+		grep sub output >sub-output &&
+		test_line_count = 2 sub-output &&
+		! grep file output
 	)
 '
 
-- 
2.12.0.rc0.228.g6c028b8e94

