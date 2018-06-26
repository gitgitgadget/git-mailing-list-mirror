Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525C11F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeFZHaw (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:30:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37474 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeFZHau (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:50 -0400
Received: by mail-it0-f67.google.com with SMTP id j129-v6so868959ita.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRZxrHUH3KO7DQx4LpSqbXPeb2CPMDErXWf8/ZZjpt8=;
        b=q2IrJkyWwFHXwzchZ2JGsAkp5FDfqxAU5W3DzKtZ97M7QI/nVx0SDNefD3G9eVwem+
         dtlfDqYRLZTQbakaLhZIqMpaJjvIxerh6FjcKzfyZIVopMoh8QKNgEVBC4t3EIFuRxEL
         MepEzVHiQgMpVnaiMA9HH5ElzGetXK9Tm82L6Fpf+HjiUTxLt5tVIGNW4SX1fBChaBwQ
         r7Ru3zFWSoabsvA3pYerF0TQQLKCZPp7pBQUbiFnAuHaKTRjn6iC7dzieAFnoX6e+44P
         lF5X5D55nM3khKIq6uLRET7cH8nf8xXE0DaTXsT71AllCA5myorCu8fBYY29kbDYDGeD
         s6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nRZxrHUH3KO7DQx4LpSqbXPeb2CPMDErXWf8/ZZjpt8=;
        b=KMpemawYH0fNTntKdWj0VgwY6jEL1AcvV73x3nFvigVCgmbz9j8UfpNiGS1Y9wZtjH
         5Z+UQMCSR0qg9vV0fmYxwFKNWv3CyMk62oP/Ql8KSnTzwaK0WejIRXOpqwl24F6G73+z
         x+aOCUpRMUG5CfLads8FIHoKnmBFESRTxhRjJdQQnPQuRandsAmBta9MIeK35JfNdUkR
         ++J/M/eo6jGDc2YQ4Qz2lCTwDkgJBomIZBYYwsxjw5fXOsyuOHQdzf3FfXVS8IDcVnMv
         HRMzpUcnlzbbM6sRv/imnPnoF9/o4ZJez4yMb1zm9xVIOB3fMSJbavJPcGM3v331AlDT
         hTjw==
X-Gm-Message-State: APt69E3qC/6+oELy3hYxRyYuqEDFLIW884eTSbApeN7bJo7mp7TAF5/T
        kGAf/t+EbdospS0jw19hedfUpQ==
X-Google-Smtp-Source: AAOMgpemcDSWpZmEbjDOWppa5Dp49XKcGUwwH0phsOf0BrsYyXzFrE7Iy86DaWsTp19+Da75hke4YQ==
X-Received: by 2002:a24:7a4b:: with SMTP id a72-v6mr495625itc.123.1529998249791;
        Tue, 26 Jun 2018 00:30:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:49 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/29] t7508: use test_when_finished() instead of managing exit code manually
Date:   Tue, 26 Jun 2018 03:29:33 -0400
Message-Id: <20180626073001.6555-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test manages its own exit code in order to perform a cleanup action
unconditionally, whether the test succeeds or fails overall. In doing
so, it intentionally breaks the &&-chain. Such manual exit code
management to ensure cleanup predates the invention of
test_when_finished().

An upcoming change will teach --chain-lint to detect &&-chain breakage
inside subshells, so this manual exit code management with intentional
&&-chain breakage will run afoul of --chain-lint. Therefore, replace
the manual exit code handling with test_when_finished() and a normal
&&-chain. While at it, drop the now-unnecessary subshell.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    This series is built atop 'master'. If the series is queued there,
    this patch is needed to avoid test-suite breakage. However, the
    issue fixed by this patch is already also fixed by
    'jc/clean-after-sanity-tests' in 'next' (although, that patch
    doesn't bother dropping the now-unnecessary subshell, like this
    patch does.)

 t/t7508-status.sh | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 18a40257fb..67bf4393bb 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1099,18 +1099,14 @@ EOF
 '
 
 test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository' '
-	(
-		chmod a-w .git &&
-		# make dir1/tracked stat-dirty
-		>dir1/tracked1 && mv -f dir1/tracked1 dir1/tracked &&
-		git status -s >output &&
-		! grep dir1/tracked output &&
-		# make sure "status" succeeded without writing index out
-		git diff-files | grep dir1/tracked
-	)
-	status=$?
-	chmod 775 .git
-	(exit $status)
+	chmod a-w .git &&
+	test_when_finished "chmod 775 .git" &&
+	# make dir1/tracked stat-dirty
+	>dir1/tracked1 && mv -f dir1/tracked1 dir1/tracked &&
+	git status -s >output &&
+	! grep dir1/tracked output &&
+	# make sure "status" succeeded without writing index out
+	git diff-files | grep dir1/tracked
 '
 
 (cd sm && echo > bar && git add bar && git commit -q -m 'Add bar') && git add sm
-- 
2.18.0.419.gfe4b301394

