Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00481F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKLMYp (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 07:24:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40070 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLMYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 07:24:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so2732476wmc.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkmtECdb58NVVZWQ19FrOwC1FLmU2p2t050ilhIfJiM=;
        b=jiOwaXKjcwuEym+SXBlGslZLcAusFlnjfJcElS4zweksbuu75iQvT+/vPu/7GFHMRi
         pCcz2e9TI3chgpYRD/8Q+G9UcqCcmd+h1FJhGQ9UEPWgb/tBcVW6p4q7Y4EF8ZB591xz
         +/DXmexred5oKh2fpJofF7UyPKgigK39XSVzt3B4L4qekkf0X5B6wkv1IjWEECbfB4XW
         oB8Q6//DOVWdoaBK9zb5AOu08TQvpn4ZFJMwhNjST1Epai1qqEeOkl/2P0Qjtscb3W9k
         7hp3jdROFDF5sOsHXeNhOb5BApWhaMao5fxjwgIe135XWn1feBN7Goy8tasD8TCMPCx/
         zSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkmtECdb58NVVZWQ19FrOwC1FLmU2p2t050ilhIfJiM=;
        b=iEQ1aFRO/mjLkLc9e0LktsuL5PqhWEKpEGM0PADNkOpqO18KcF5vXAeQjGY2Lcx+w1
         cGXpcO2T6SidEkr+9PviupwwKg7nSKCXP/dOo1cbLEQCxSSw5R0EOZD+tI3fIKLo7Ql8
         nTFzCPK0veZOHgO4vuO0/APV8YfKbx6LQW5gyy89JiSR+ZCXfMVl/u4gNswaY0w1PmaO
         JFxd8nTsJoMjm/xHAyoo0qMaaEGqF6GJtrPvVHuTOtxJjIZdk6n6wDIincd5kL/3CYhw
         ngpJhxwEbdRO1hTQ0xJKzGHgaVMCniXHMEZ6XQ7fdRnhN3gC7ETWZtix9O+Q+dIAkndd
         wAAA==
X-Gm-Message-State: APjAAAWW+TpWnjm4yogxP39eNsl+e7BJ/AYH65aCBfpeiwjNkTeneS5t
        kLfjO8VrLI3u7kvzFkTubWw=
X-Google-Smtp-Source: APXvYqx3QWJtG4mxPJb4XeIKExarJHCVBoGznk2Z2aIphHQp0FZ6ToQpcwyYa4g2dxx4ZWP2SIsr4w==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr3571597wmd.63.1573561481435;
        Tue, 12 Nov 2019 04:24:41 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id a16sm3216076wmd.11.2019.11.12.04.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 04:24:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: don't check prereqs of test cases that won't be run anyway
Date:   Tue, 12 Nov 2019 13:24:38 +0100
Message-Id: <20191112122438.17057-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With './t1234-foo.sh -r 5,6' we can run only specific test cases in a
test script, but our test framwork still evaluates all lazy prereqs
that the excluded test cases might depend on.  This is unnecessary and
produces verbose and trace output that can be distracting.  This has
been an issue ever since the '-r|--run=' options were introduced in
0445e6f0a1 (test-lib: '--run' to run only specific tests, 2014-04-30),
because that commit added the check of the list of test cases
specified with '-r' after evaluating the prereqs.

Avoid this unnecessary prereq evaluation by checking the list of test
cases specified with '-r' before looking at the prereqs.

Note that GIT_SKIP_TESTS has always been checked before the prereqs,
so prereqs necessary for tests skipped that way were not evaluated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Following up on:

  https://public-inbox.org/git/20190923165828.GA27068@szeder.dev/

 t/test-lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e06fa02a0e..24b541f494 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1000,6 +1000,12 @@ test_skip () {
 		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
 	fi
+	if test -z "$to_skip" && test -n "$run_list" &&
+	   ! match_test_selector_list '--run' $test_count "$run_list"
+	then
+		to_skip=t
+		skipped_reason="--run"
+	fi
 	if test -z "$to_skip" && test -n "$test_prereq" &&
 	   ! test_have_prereq "$test_prereq"
 	then
@@ -1012,12 +1018,6 @@ test_skip () {
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
 	fi
-	if test -z "$to_skip" && test -n "$run_list" &&
-		! match_test_selector_list '--run' $test_count "$run_list"
-	then
-		to_skip=t
-		skipped_reason="--run"
-	fi
 
 	case "$to_skip" in
 	t)
-- 
2.24.0.388.gde53c094ea

