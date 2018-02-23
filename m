Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79341F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBWXkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56135 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeBWXkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id q83so7504691wme.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPFse5Q7asBASvb0SXTgufs55KaCFshJ8+6ISNPq7Js=;
        b=q3PZJvEiud8ntN8qtyFLw6L234zJNBCsXFKavTjNYvOSYqaZ+etDFV8l+INrSTssPo
         0+ICps5sKX9JoPq6fcQR7U94F7hlHtcYOr7d1NApH8vgR3eu3mrWYtV2Lb9xfDIgl4f1
         Od/zcxTIasrJSFhQdXPZudZ9YoXB8WgZw2WqN3LuIVmzF9TLyP9vLpWdk3SNjUyw4sXK
         g4iTUmn1b5iHxSno3/L+irlLpfXO03JsrK5xR1ZkIz0EBE6HmjE60ST7daajvq5wxzGu
         T2sUPuPVLh93RJg5Af7O4KERg/GnTgafZuLa3+Y32Brrr4wBWfSjPaF1jYialFFWPBll
         nEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPFse5Q7asBASvb0SXTgufs55KaCFshJ8+6ISNPq7Js=;
        b=N7PsmqRsWZJvijdGEG8CWA1K+k8Fc859PHgT/0jFZKvp+pHQavJPSS3EZrhWZtrIp6
         nhNCMvd3QpcCI44etlIgtzRxS+duV0UZHS7teKq2q9/2hjyNQZolzS//dC63qIbRZT/3
         Qt77gVUcozjFYqk7zGfRzd0LQNmsLFJS21k14B1f7YTeejdihGeEMniH42Iikq79e1l0
         UtR5HT5DGaUtj+sBUll6Nv5BsIbaZWupjoMzU/AANLsJvlRafAt9xFhpEbgPp+HXFzod
         S1Jm/I8q4Mn4xDqg2FvTweEktgIkkXZy/uNHW2gwE7MILVWvMnv+UFeroC8uX5j+jlMq
         nmgw==
X-Gm-Message-State: APf1xPBicHRHbgHmOWgG/hqTsrWkGcCWsm4cDCvQZlbwXRcRg/SHkHI+
        nQ7ORt5l8jl87M9TQLpXIqBVHQ==
X-Google-Smtp-Source: AG47ELtrc7j8ExhGVHOyxp6eJJ9EZRrEQitt/LtqAQsARbO5jVB8UfV72Hw4zn3LyxqhZhYTBITW1w==
X-Received: by 10.28.54.220 with SMTP id y89mr3206395wmh.138.1519429213234;
        Fri, 23 Feb 2018 15:40:13 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:12 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/11] t5500-fetch-pack: don't check the stderr of a subshell
Date:   Sat, 24 Feb 2018 00:39:45 +0100
Message-Id: <20180223233951.11154-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three "missing reference" tests in 't5500-fetch-pack.sh' fail when the
test script is run with '-x' tracing (and using a shell other than a
Bash version supporting BASH_XTRACEFD).  The reason for those failures
is that the tests check a subshell's stderr, which includes the trace
of executing commands in that subshell as well, throwing off the
comparison with the expected output.

Save the stderr of 'git fetch-pack' only instead of the whole
subshell, so it remains free from tracing output.

After this change t5500 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5500-fetch-pack.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ec9ba9bf6e..0680dec808 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -482,24 +482,24 @@ test_expect_success 'set up tests of missing reference' '
 test_expect_success 'test lonely missing ref' '
 	(
 		cd client &&
-		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
-	) >/dev/null 2>error-m &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy 2>../error-m
+	) &&
 	test_i18ncmp expect-error error-m
 '
 
 test_expect_success 'test missing ref after existing' '
 	(
 		cd client &&
-		test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy
-	) >/dev/null 2>error-em &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy 2>../error-em
+	) &&
 	test_i18ncmp expect-error error-em
 '
 
 test_expect_success 'test missing ref before existing' '
 	(
 		cd client &&
-		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A
-	) >/dev/null 2>error-me &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A 2>../error-me
+	) &&
 	test_i18ncmp expect-error error-me
 '
 
-- 
2.16.2.400.g911b7cc0da

