Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B314F1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHP5O (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43737 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBHP5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id b52so5213566wrd.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3HtMZRyjAG9O2gdcK+e5A1mLingoxlPsIt6ga6a1cg=;
        b=ggy9QJL1Ly5BHyeNCaa3OqEFeZ/qpPsV4nAJgF/2piGEYe8gnKu9P0JJTfmbXf05XC
         a2lsMcMT4Y0vzMsBOGAVofZfcdxLlbVRsOYQGI4YpCsqESCa/2M+63cswkX7lbZ1+cXh
         Ubu0cGBsTM6sV44usKnUXiNTDoIy/anplCuCAegWgj/xsvd7PGslGbK8hZqhFk0Japwg
         Jdvi+OZyzulHuWE1q9tDOGqYe0eqt0GFgWYmkMT51BrpNbwaotC/gb10A43tBAnB8as+
         b0xFH+0uw/v3gb0JpQTfQ3RhKwwE5Kwxmrw4WLIHblbIlqvpvxcSidDGWIHZ72LpkDp0
         9g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3HtMZRyjAG9O2gdcK+e5A1mLingoxlPsIt6ga6a1cg=;
        b=SRM9WPw8pMENY6sJPq8plPBRpJbvcsg98rncMPVWoFatnZVySOqXK04sJ9CglBnsUf
         +/Lkc7kilo+N2jxROltQvhLE/qNQ0nuSu4MW7u2LeF++LXbR74RRYjDQdrZEuOFUAw5a
         LRJOQA+ECNRt5FsZHDmpmzX5qMmQwR5ubRXiQiBUVX3JOOQ+h3MvVMk4MvPkD0YNBHNt
         WqNMuw5zKUonRG6rm1H1Pf5DrW1yC/f/cL8y/6ngVCAWsO+crlgaDI2AxsvdGhXroxSE
         T/LaBcHO1tMR35KZp/YG2yt6u2ekTPDjoi7fYrQM7G8Ams8YwQw4jvAIuOSaDuBXQcQa
         NPzg==
X-Gm-Message-State: APf1xPDdLmhtdKX+TZX+vq5vFY6Df4hybEKUNTdWoemXJPmhAilYHK1e
        dvT+p5CglBDqvi+37iZuFC0=
X-Google-Smtp-Source: AH8x224Pu2fyX4ZFIuC3zglbyHu0+1SFdFpKHmFKoqAT2Jw1CPAY0eMfM02RkX1x3qyAzW81GKJMPw==
X-Received: by 10.223.195.92 with SMTP id e28mr1347182wrg.8.1518105431325;
        Thu, 08 Feb 2018 07:57:11 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/9] t4001: don't run 'git status' upstream of a pipe
Date:   Thu,  8 Feb 2018 16:56:51 +0100
Message-Id: <20180208155656.9831-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary purpose of three tests in 't4001-diff-rename.sh' is to
check rename detection in 'git status', but all three do so by running
'git status' upstream of a pipe, hiding its exit code.  Consequently,
the test could continue even if 'git status' exited with error.

Use an intermediate file between 'git status' and 'test_i18ngrep' to
catch a potential failure of the former.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4001-diff-rename.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index eadf4f6244..a07816d560 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -134,11 +134,15 @@ test_expect_success 'favour same basenames over different ones' '
 	git rm path1 &&
 	mkdir subdir &&
 	git mv another-path subdir/path1 &&
-	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
+	git status >out &&
+	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+'
 
 test_expect_success 'favour same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
-	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
+	git status >out &&
+	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+'
 
 test_expect_success 'two files with same basename and same content' '
 	git reset --hard &&
@@ -148,7 +152,8 @@ test_expect_success 'two files with same basename and same content' '
 	git add dir &&
 	git commit -m 2 &&
 	git mv dir other-dir &&
-	git status | test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file"
+	git status >out &&
+	test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
 
 test_expect_success 'setup for many rename source candidates' '
-- 
2.16.1.158.ge6451079d

