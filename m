Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC53C388F7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CC922247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBtRLEeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407575AbgJTNl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407570AbgJTNlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E17C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f21so1827205wml.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hXKOoN1rTfmjYc9bEHjZ5Kz6Fx+nBTv+DEl06unKn/Q=;
        b=iBtRLEeKfYvdc53CY9H4s5A1+bpt/WngINJsGX9nWu6hO7WqETkEUolnTztZeSEtwk
         uIL55JynrMw1bmXKsh+SEYiYe52CJvPzKj1Uiu3BUVmSsOK/51piwK2C9XTcshBlwiD3
         I3N/Ycn1zY9mxnYCA9sZtogNadeWHOKG/U+Ej2wox3fdgRc5We+rnDoqHWwFkSIfYKEj
         vEoiP0bo+JKnXq+RrSmw+EEPudniESG2Ae0uRsHS2PWqMfytH/+1Qxv1ax4HuBP1DCyC
         pKQVVOxvJ8L+ExQKhuF5sHswDszx7xzY/vYr4qrMqk+6qorOVQfNmvemeYoXzjCvK4JB
         Zduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hXKOoN1rTfmjYc9bEHjZ5Kz6Fx+nBTv+DEl06unKn/Q=;
        b=Idm8dHUlQXvEAsgqypig014a4JO8ae8SirjF3CXivSyelvJ+IvO6usdc7OHke1BYmr
         xCR9jQmBSwL1kBO4JFuWrJKdiB/ogTm16/oUlbF0wbS25Klpcoxte/oJHGVWrbpgggjO
         p7W4+ICjCzj8+ZeciC5MkxagIhNcVED46/4zqnlFscfpT3Tt5xj25Z13Za7nggz7IXyU
         pt7e9nQsyX7yXrW4HK/lkeXXFsAFstX6675FHMSq8u+uUpCCB6rN8fhw0MiQQMq78cxj
         M1TiISN2fbE70hYK5M2SPl72TRc465sVig65bZcPYJLWzgLn+EJyMRaHFzbWxLRIRfs9
         zekg==
X-Gm-Message-State: AOAM5328mcpjhWQ4ffErWv442CRIHoS1S1Rqg7R8owj80I9GLVL1RGZb
        301DKGTjQ4BEVV/CDpx4tAfwr150ZDQ=
X-Google-Smtp-Source: ABdhPJz0W0PjLiXXlLKTt1aVC2MFrm+XK/JGGlSrCOxn3w+ug1vvccuO4zPDIPngrWYMxocCTn7sXg==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr3153664wmi.175.1603201272912;
        Tue, 20 Oct 2020 06:41:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm2660262wmj.31.2020.10.20.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:12 -0700 (PDT)
Message-Id: <6f974399360ef38059dea65b4ffa5a17c615ade1.1603201265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:41:04 +0000
Subject: [PATCH v4 7/7] p7519-fsmonitor: add a git add benchmark
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Test                                                                     v2.29.0-rc1       this tree
-----------------------------------------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)                 1.48(0.79+0.67)   1.48(0.79+0.67) +0.0%
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)            0.16(0.11+0.05)   0.17(0.13+0.04) +6.3%
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)           1.36(0.77+0.58)   1.37(0.72+0.63) +0.7%
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)                   0.84(0.21+0.63)   0.14(0.11+0.03) -83.3%
7519.6: diff -- 0_files (fsmonitor=.git/hooks/fsmonitor-watchman)        0.12(0.07+0.05)   0.13(0.09+0.04) +8.3%
7519.7: diff -- 10_files (fsmonitor=.git/hooks/fsmonitor-watchman)       0.12(0.09+0.04)   0.13(0.07+0.06) +8.3%
7519.8: diff -- 100_files (fsmonitor=.git/hooks/fsmonitor-watchman)      0.12(0.08+0.05)   0.12(0.08+0.05) +0.0%
7519.9: diff -- 1000_files (fsmonitor=.git/hooks/fsmonitor-watchman)     0.12(0.08+0.05)   0.13(0.09+0.04) +8.3%
7519.10: diff -- 10000_files (fsmonitor=.git/hooks/fsmonitor-watchman)   0.14(0.08+0.06)   0.13(0.07+0.06) -7.1%
7519.11: add (fsmonitor=.git/hooks/fsmonitor-watchman)                   2.75(1.41+1.27)   2.03(1.26+0.70) -26.2%
7519.13: status (fsmonitor=)                                             1.38(1.03+1.04)   1.37(1.04+1.04) -0.7%
7519.14: status -uno (fsmonitor=)                                        1.11(0.83+0.98)   1.10(0.89+0.90) -0.9%
7519.15: status -uall (fsmonitor=)                                       2.30(1.57+1.42)   2.31(1.49+1.50) +0.4%
7519.16: diff (fsmonitor=)                                               1.43(1.13+1.76)   1.46(1.19+1.72) +2.1%
7519.17: diff -- 0_files (fsmonitor=)                                    0.10(0.08+0.04)   0.11(0.08+0.04) +10.0%
7519.18: diff -- 10_files (fsmonitor=)                                   0.10(0.07+0.05)   0.11(0.08+0.04) +10.0%
7519.19: diff -- 100_files (fsmonitor=)                                  0.10(0.07+0.04)   0.11(0.07+0.05) +10.0%
7519.20: diff -- 1000_files (fsmonitor=)                                 0.10(0.08+0.03)   0.11(0.08+0.04) +10.0%
7519.21: diff -- 10000_files (fsmonitor=)                                0.11(0.08+0.05)   0.12(0.07+0.06) +9.1%
7519.22: add (fsmonitor=)                                                2.26(1.46+1.49)   2.27(1.42+1.55) +0.4%

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 75a0cef01d..fb20fe0937 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -169,6 +169,10 @@ test_fsmonitor_suite() {
 	test_perf_w_drop_caches "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
 		git diff -- 10000_files
 	'
+
+	test_perf_w_drop_caches "add (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git add  --all
+	'
 }
 
 test_fsmonitor_suite
-- 
gitgitgadget
