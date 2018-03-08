Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A00A1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755027AbeCHMiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:38:55 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34166 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCHMix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:38:53 -0500
Received: by mail-wr0-f194.google.com with SMTP id o8so5544507wra.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 04:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0BMLcvPRC05oDdkjgN4TnHHdDd0Dmw+gd3oQGr4tp4=;
        b=PNm3HdCFxAiujQQF1cWrmWWjnbP3bmYk/5Jb8RmTcgWoHQIVCBNFKuJoRRLVQTyZWv
         gko90Xj5mnSM/pIUQioiNVOo6w8aWL26g4pDTEyLGO7P4ss2eOm3pza5c9gxM+WoHfid
         MaZ6sqLA31ceugt8QYcSZmxd+edD5prmPQR8P0pXAHo/Z0aMdxw3SvLEx8pWwN97fn7q
         glD46jX2HwgR1ZMFE5Uf93ulU0LpieNayW7xd7kcFYGsDE6H6fTdBLaQaK8N66LiatTX
         TwRPt9kl6aEcDhgfATWYrElTKi4Nvm+tl4jAA2hQZNNS6W9/vhJRL2HrVadElnO/L6BQ
         /scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0BMLcvPRC05oDdkjgN4TnHHdDd0Dmw+gd3oQGr4tp4=;
        b=LIy9l9nMlHfIeOymRf58MdwxA3hpB/2YjX+7TC2yuEBLreysS7Ydqbyh04f4Kl/Y+v
         fpVTeQma6tyr/X65eeiBaT60zBRdywnLt3aSND+2VxC4nJbNSWDg/ZersvrnRR6RUzcK
         qf5ZYZgUax8s3cJa3jltHCA4HZESEW7Gt8JkyYMJeuKBDPQ1q9LWeJG7QDxuW1Cmfd3f
         nLCASpl3QRQxdo7/0hlWqCNGKgaTrWyvLAcBBl8dRWLM2dTG3VdhgTAjC9yNCJP70axy
         ujYwap4trJV7/tDffxmeZheyXD/W6E//QeWpkgWOJV4aXKs7qJ+ivNnfV2kDblnm15tf
         gY2w==
X-Gm-Message-State: APf1xPBZljk3cs3GjX4vZAudog74tKz9bU6poI7Pb0qQxS8ypi2jCMOS
        PGM9kkQMnYGG4hf15N9Buyc=
X-Google-Smtp-Source: AG47ELs6vIKooKeRpv9PsZXbd/PzX7TqsdAZYo/P8IAXEzXhB9l/Kvc7fZE5Ry4Cyaq/gM4Dm+GZPw==
X-Received: by 10.223.129.163 with SMTP id 32mr22115152wra.124.1520512732623;
        Thu, 08 Mar 2018 04:38:52 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id l11sm16721809wrg.71.2018.03.08.04.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 04:38:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t9402-git-cvsserver-refs: don't check the stderr of a subshell
Date:   Thu,  8 Mar 2018 13:38:44 +0100
Message-Id: <20180308123844.15163-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
In-Reply-To: <20180308123844.15163-1-szeder.dev@gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Four 'cvs diff' related tests in 't9402-git-cvsserver-refs.sh' fail
when the test script is run with '-x' tracing (and using a shell other
than a Bash version supporting BASH_XTRACEFD).  The reason for those
failures is that the tests check the emptiness of a subshell's stderr,
which includes the trace of commands executed in that subshell as
well, throwing off the emptiness check.

Save the stdout and stderr of the invoked 'cvs' command instead of the
whole subshell, so the latter remains free from tracing output.  (Note
that changing how stdout is saved is only done for the sake of
consistency, it's not necessary for correctness.)

After this change t9402 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9402-git-cvsserver-refs.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 6d2d3c8739..cf31ace667 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -455,20 +455,20 @@ test_expect_success 'cvs up -r $(git rev-parse v1)' '
 '
 
 test_expect_success 'cvs diff -r v1 -u' '
-	( cd cvswork && cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
+	( cd cvswork && cvs -f diff -r v1 -u >../cvsDiff.out 2>../cvs.log ) &&
 	test_must_be_empty cvsDiff.out &&
 	test_must_be_empty cvs.log
 '
 
 test_expect_success 'cvs diff -N -r v2 -u' '
-	( cd cvswork && ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
+	( cd cvswork && ! cvs -f diff -N -r v2 -u >../cvsDiff.out 2>../cvs.log ) &&
 	test_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	check_diff cvsDiff.out v2 v1 >check_diff.out 2>&1
 '
 
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
-	( cd cvswork && ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
+	( cd cvswork && ! cvs -f diff -N -r v2 -r v1.2 -u >../cvsDiff.out 2>../cvs.log ) &&
 	test_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	check_diff cvsDiff.out v2 v1.2 >check_diff.out 2>&1
@@ -487,7 +487,7 @@ test_expect_success 'apply early [cvswork3] diff to b3' '
 '
 
 test_expect_success 'check [cvswork3] diff' '
-	( cd cvswork3 && ! cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.log &&
+	( cd cvswork3 && ! cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" 2>../cvs.log ) &&
 	test_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	test $(grep Index: cvsDiff.out | wc -l) = 3 &&
-- 
2.16.2.603.g180c1428f0

