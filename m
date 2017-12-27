Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E001F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdL0Qgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:36:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37992 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdL0Qge (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:36:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so40071107wme.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IHh3cObr55XmedcPut0n26NjvyZkgPjyv2K4dtt/Qs=;
        b=baGU4ZfvgBfH3qr11yDa580pncVEdw28uhPxqOq0TzW9+PSTiMe2DJBcDJyJxI74ej
         6aZUB9UZSz8xw0vr7JNHhZdYPFDq+heuzlaof7DxJhhEZiw9brSVI5sSPueJi0O9jXA4
         yiPTm7S8XOswkYz2wTDQWx9ET80NE9llZYxzZiHu/3+9nW5xBkq7riQxeWHyh0q4Xj7q
         KhiLvmh8gMf0bTQ+5iM2m67bES09hrWSxAhtALA9SH9Nz7R8PwFyOBIuzfOxDA8GtSTh
         N7/xdwUejGuzLH5BBN0GgTDuNG8h5lUgXB/4xh987PO1gUjRmhyQkFx3Q3CDVWLSpgj+
         xIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IHh3cObr55XmedcPut0n26NjvyZkgPjyv2K4dtt/Qs=;
        b=KGGJ2pSnNVm4E+vfqPuVsUOJtUB2elcU/dr4TeKCJzARUU1NIdsSFb/VlaK/k69ERq
         PKNXPL6BjgHPFqtghzWb1op6ZJWUNN4TU/afTK/PLa5bki5k7iYR9orE8bLzMbsIO1Gb
         uc3Jcm/TsLjxx2IBUxM+sECodn3uaCwz8xSqBkAjAAwe39+DXm7MtxMgtWVZRf6vGx2f
         bP3kSnuwp7MrIlqcYmozwjPVqIdtK9m9UAXW5vKR6zRRvnVGwrLLbm87oslxCOjIQMKy
         j8v63GutB2/H5C0CFv4GTxEMBw/b0TiNjmhCxI3x9uPknzmJqwN/FVqmLYQdfzp8FPZ7
         mvZA==
X-Gm-Message-State: AKGB3mIPQ1A2olXG7x5UQBmpVMbymzpomCA290MlBZEO22sCShof5l9H
        kZSdBTOg0ZV4gOqHLR/E9MA=
X-Google-Smtp-Source: ACJfBouSiXSW/9Ncou84NBfLmww3ABDMyzakiBVqCyHuU5q8wwq/Drnxcu2oH1M6R5RlrJMQ7rrsAg==
X-Received: by 10.28.30.213 with SMTP id e204mr22537836wme.40.1514392593136;
        Wed, 27 Dec 2017 08:36:33 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id l1sm8400557wmh.13.2017.12.27.08.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:36:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/4] travis-ci: only print test failures if there are test results available
Date:   Wed, 27 Dec 2017 17:36:03 +0100
Message-Id: <20171227163603.13313-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171227163603.13313-1-szeder.dev@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com>
 <20171227163603.13313-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a build job running the test suite fails, our
'ci/print-test-failures.sh' script scans all 't/test-results/*.exit'
files to find failed tests and prints their verbose output.  However,
if a build job were to fail before it ever gets to run the test suite,
then there will be no files to match the above pattern and the shell
will take the pattern literally, resulting in errors like this in the
trace log:

  cat: t/test-results/*.exit: No such file or directory
  ------------------------------------------------------------------------
  t/test-results/*.out...
  ------------------------------------------------------------------------
  cat: t/test-results/*.out: No such file or directory

Check upfront and proceed only if there are any such files present.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/print-test-failures.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 97cc05901..4f261ddc0 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,6 +8,12 @@
 # Tracing executed commands would produce too much noise in the loop below.
 set +x
 
+if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
+then
+	echo "Build job failed before the tests could have been run"
+	exit
+fi
+
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
-- 
2.15.1.500.g54ea76cc4

