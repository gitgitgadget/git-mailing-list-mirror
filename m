Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934D01F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeBWXkV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39290 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeBWXkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id 191so7341334wmm.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3RBcWOZIBLYRN7s6JSPfMQydFgE7qIoDykqs/U6yc0=;
        b=CisJpYYW4xWbtuTKk6JQW1amKZvFvOM0CL0K91+gwB+f1ZZLZXzg53w9sweTSpDftz
         RuwhCeNGK9433tCl5ocqGuUgEBDdsNBwNlIU9My+uHzJufLQz+A1c/7vX8KjH+D6p8Cc
         GWpv9fOmGYrEs0OC3P3+wmniEV8bsHeWaA96T8bYYBdot6WicxNrEt4HCxn3WjAg3P3h
         WDFkE1KA2EMVW7mrDgwMl06F/ZFAuiXgwbu131cnwXmQO/OueK/JTDGZncxfiuqB1j0e
         F+/ztj0FthpogpCy06I2Rdz5WK9FYE4Lt7jAMhX+Z298B36bDtj+qnvdk3UgagtciOpT
         jq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3RBcWOZIBLYRN7s6JSPfMQydFgE7qIoDykqs/U6yc0=;
        b=eCHhIdZfUoyFm8Ekcx8VMURXpujjNLdeAPKcZg1VvwxcWzpHCwG3WEgzkX/n0nWp6U
         zMM36+dWUYr3qBsmCf1iYokL9qtuptHvbvIjx0t8bFcSbdCS1kwGKxmp/ZE+A3izwfQf
         zvYUoAD5i5Wm34rM/LrhGQ6QRMKdnRHm5OdH07oU3HFPCFiAXSQfykRO3331LHaWTgES
         3r+nwKvYvMEZhFLz4/JDpPSINQoV2fnw024GlakHBO6ydbebQXFLWNP3iqp00U9w8/4B
         6+FBZbDWH7AHspwLI7EwEtIPb9srrn+am2Lk+GMs7jwtnYj9Bf/5vthylpm4+n3isQWq
         QeAA==
X-Gm-Message-State: APf1xPCEwyw2FM66/X0C/UDsLVQUlmyxMLYyuHTHT7/++DaOnNzW1vUJ
        aKNNJWI6cQVS8wtvbJKRF0M6mw==
X-Google-Smtp-Source: AG47ELtre5nxinMzPN+9Tg8Dvv/iEPmhkXQQD5WxvNoXDQwM23gzd8fw0F5t/FEdbvHdSj9X3hMjaA==
X-Received: by 10.28.92.201 with SMTP id q192mr3216758wmb.33.1519429214985;
        Fri, 23 Feb 2018 15:40:14 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/11] t5570-git-daemon: don't check the stderr of a subshell
Date:   Sat, 24 Feb 2018 00:39:47 +0100
Message-Id: <20180223233951.11154-8-szeder.dev@gmail.com>
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

The test 'no-op fetch without "-v" is quiet' in 't5570-git-daemon.sh'
fails when the test script is run with '-x' tracing (and using a shell
other than a Bash version supporting BASH_XTRACEFD).  The reason for
the failure is that the test checks the emptiness of a subshell's
stderr, which includes the trace of commands executed in that subshell
as well, throwing off the emptiness check.

Save the stderr of 'git fetch' only instead of the whole subshell's, so
it remains free from tracing output.

After this change t5570 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5570-git-daemon.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 755b05a8ae..0d4c52016b 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -50,7 +50,7 @@ test_expect_success 'no-op fetch -v stderr is as expected' '
 '
 
 test_expect_success 'no-op fetch without "-v" is quiet' '
-	(cd clone && git fetch) 2>stderr &&
+	(cd clone && git fetch 2>../stderr) &&
 	! test -s stderr
 '
 
-- 
2.16.2.400.g911b7cc0da

