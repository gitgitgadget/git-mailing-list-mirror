Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB4F1F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756827AbdLPM6Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:58:24 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41156 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756500AbdLPM6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:58:23 -0500
Received: by mail-wr0-f173.google.com with SMTP id p69so1426263wrb.8
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68IgUlV5HQTEewhT/GfxuSW5yp06UykGqKM7fA4YDTs=;
        b=YdDllXvUKwBt16FpSeowoKioB9LSbrcEpKudgMtxoRD4rGPEWXaPtvxlFaAotH/ROm
         Uk0Gfqpip0I5sBfdBnCWEs4Cdz5vJ8tIDHhMD70Wo3DcmUHeCePy0vdzHbAPLencNAat
         SdfiBTufPOBbnCkykPTSE8nymaawbc1IoLH+3wf3nCEgChY7x1B1ECIY27a5JPo7Q0DY
         4gYQz+FD4U4ARPygnRMhcLV7gv24xd6KtUcXck9618ySMdYPXgo2a8B/LVB5pWNB8xtQ
         bB96uDCq3oCnUcIdvamzQa1IlXckNomJ1ptwfXcefZc+1jN8cwzKGc2qsHGUB2iwty84
         kUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68IgUlV5HQTEewhT/GfxuSW5yp06UykGqKM7fA4YDTs=;
        b=o8ukUrkHq/6GTBdNhJ3snTGCkCo7lmNDarB7rtpbaEH2UMiAVqIfgqgbFTyxs4Rmy6
         n0lVpPRf8BdpJ2uudvFk52TT4oLT7u4JtnHCkkv23jkiuwepp9/hOeCsoSOy+wqBomjD
         eaVMRwbv6nnDrEnwhb8U/AtRMqF0e+bNkqODeJUKzyIxfwRDC3t9CRZQ5PlEW1x3Ro/M
         Ym8UDfTITIQ6omZmOXgtntwEoC19gSxbBhMThzAxsNo914WhWgSBn0eXa6uuUV9oSp5N
         QZdWKzrA8aIm7gwh8MZ+p4dLhhmzUlBylqYXhsR+HYqaltKr4bpKjs9G0BUDDtG3Qca/
         7NFg==
X-Gm-Message-State: AKGB3mIYWb5kJ98l+9UTuF+08lzbBmLyKe0nsf+RFXZBsjo31ZUOeUHi
        g+AhH5QSdyCK1Jw0W0MeuUM=
X-Google-Smtp-Source: ACJfBouUMyrMLSaVHl6xflRcHOw7TKNw5x4UKl+rOeUee+fYtOdWlbJmc+TOBVBh8UpOPrlsW3t98w==
X-Received: by 10.223.150.108 with SMTP id c41mr1508738wra.119.1513429102557;
        Sat, 16 Dec 2017 04:58:22 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id j15sm3029157wra.60.2017.12.16.04.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:58:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 8/8] travis-ci: only print test failures if there are test results available
Date:   Sat, 16 Dec 2017 13:58:19 +0100
Message-Id: <20171216125819.11263-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
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
index f757e616c..1a3d74d47 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,6 +8,12 @@
 # Tracing executed commands would produce too much noise in this script.
 set +x
 
+if test t/test-results/*.exit = "t/test-results/*.exit"
+then
+	echo "Build job failed before the tests could have been run"
+	exit
+fi
+
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
-- 
2.15.1.429.ga000dd9c7

