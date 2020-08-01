Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03461C433E3
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EB3206E9
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJeyeurI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHAR6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHAR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 13:58:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725CC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 10:58:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so31800241qke.13
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNHIjH15ennrTmZK7LlS2hDxNWdMUkaH+ru2IxG0Nac=;
        b=pJeyeurIL8kZpmVyHEi59cwZcE/vg2v2jqTGg48TJf9JH1flr5ghnSLKuKTRG+jidv
         /Zl1SARbdwH83Y2Gn613iAB2w8fHA8+bnSOOWQqOVmLzDozYnDnY1BNG84Xy4Hd/sUWc
         vRQ7tSyAt1n1TNqySfDhUrALxTph5nCsjWqbYTSFgKsIdmfJuBK5VKt5Hr/UUpVub4ER
         uDny9xEYFhJzwfm1dONLMjg4oWpIiKY8iQnuC8eFKHKfVBLUzr3XYrbsM5bLXsbFdUFc
         SB26FEBEgTidcquauPbpGEEbNg5TWofdXkJTm0aU+qOG28nCpFwc+I/T4hONJBtfcK4Z
         1/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNHIjH15ennrTmZK7LlS2hDxNWdMUkaH+ru2IxG0Nac=;
        b=buGYjiLUqVKZpyOW/cvE3V2fO0T19jedmTmPWM0mk1/YQeCp5k0kdP+cOo5MbQdvPc
         UZhXaMWt1ZNVMZy5mXY5o7tLt/tR1Gh0xHDRL9JEGBzMMQI6oNA7Q1RHQ583DELjAXJ5
         PAUQe8jFCcR952lWQTA8laNL1wKD9nV1XHMuZOXyZZMs+1uyxbUqnaPUBB7addZz+uyV
         tI/q8z/MPi/wgEzRZtDRbaj1acAc7JAHKInDZP7qcFtujaEd5mzw/4GwWHmEiaCG1/VQ
         5hxHYi0oJsL/yWE/46W+c8gk+cuRWHtJAsrZoBFrVVD+F3yO70Tp702DwJYedDABAwFd
         g9hg==
X-Gm-Message-State: AOAM5335EL5umS136F/ljz848ybxxiBHFH26ujJm0mwh4ADVsdOt8C/p
        Gg4Y2y0oqBacVr9mocOdPioXvF3ffXBY9Q==
X-Google-Smtp-Source: ABdhPJyBmc+aCh7RegNFp0oHqDamQKNYqGPRaRLV6zbjkSz2Ghh5hAakqTJmBVeBDcahBO37kM0Iyg==
X-Received: by 2002:a37:a851:: with SMTP id r78mr1249894qke.419.1596304731633;
        Sat, 01 Aug 2020 10:58:51 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id l13sm13517405qth.77.2020.08.01.10.58.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:58:51 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v3 4/4] bisect: consistent style for git bisect run tests
Date:   Sat,  1 Aug 2020 13:58:40 -0400
Message-Id: <20200801175840.1877-5-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200801175840.1877-1-alipman88@gmail.com>
References: <20200730002735.87655-1-alipman88@gmail.com>
 <20200801175840.1877-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enforce consistent styling for tests on "git bisect run":
- Use "write_script" to abstract away platform-specific details.
- Favor current whitespace conventions.
---
 t/t6030-bisect-porcelain.sh | 46 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 51f5eb6ea3..63661c5e3d 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -243,32 +243,30 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 '
 
 # We want to automatically find the commit that
-# introduced "Another" into hello.
-test_expect_success \
-    '"git bisect run" simple case' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Another hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start &&
-     git bisect good $HASH1 &&
-     git bisect bad $HASH4 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Another" into hello.
+test_expect_success '"git bisect run" simple case' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # We want to automatically find the commit that
-# introduced "Ciao" into hello.
-test_expect_success \
-    '"git bisect run" with more complex "git bisect start"' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Ciao hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start $HASH4 $HASH1 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Ciao" into hello.
+test_expect_success '"git bisect run" with more complex "git bisect start"' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Ciao hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH1 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
 # but $HASH4 is good,
-- 
2.24.3 (Apple Git-128)

