Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7991EC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3046B2085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG20Fxi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793222AbgJZTdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793196AbgJZTdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id y12so14027600wrp.6
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7FAHzSHfC89YxDPrGqQj5H6PV+sO03eCWpJprbtTXaI=;
        b=HG20Fxi0xv/b1/U0T8ipPuckWUL53VM2PNExTsb8bYgAnAd2KrSvE6c5QbMpfY06c8
         0zRF3VQexy3n/ynNdbtP4sqlli9Shqr2SjPZ3yXLjWjA9Oba3gQfuAAsk3f0KQ3g8IAJ
         iNSaqmXgwyTsRuTSug1aRemNrVBEE7RxOKvSJUIOQrTq/6Ab2Gn+YroWz7VCTpYg9yZ1
         nBWoLZoSODltAYQqpKtiz5S7oTEM00k9D2k6oaS1hmtTcg24zrcW5SvfFwXFjAYLUK+s
         a6ocfATGr/mVCOg/cvYwbT/1XoPle1rZdyufuHmARcelufKCCylibrMbumETrhQbTDPw
         Lu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7FAHzSHfC89YxDPrGqQj5H6PV+sO03eCWpJprbtTXaI=;
        b=hVI5Rqx+cTmDzl0QKrZS5AFLQeQLwowasvffNicpbr2kZNXuOsCjHkBqZ5kYdRFEX1
         ppzBXeBVld9f45mqdlQBxcRcPbDpH5KHGo3aoLLcAQMF5wIR7RwxUzyr6x7H/epeFVSd
         7o/N7TjBqQ2dmR4k0UYbbrxgW2/Tw84UlK1FqcTIyKp/a7Jz5GiZpw1ZKK+QTueoZw5K
         3v/ugi9X4/EbiE+xzSouB2G7nGg2UUjsWX4AWA1AfQwCfHvSgHvLCeQByCCRAHmNd5/z
         PrLd0OFQgAio9V03PmELMnPcl0XXMjagIlKn6Ll2hdsJfDx2/OUVfgHnrziRBYGTKs4v
         jW5Q==
X-Gm-Message-State: AOAM533E2+vAoS0KgdR6vJTMXLz8SG88zpZBL3rHcUiksyPAf7wBY4aH
        eHK+AUNBd2XfhxQqoYekP2kUIEqa6PY=
X-Google-Smtp-Source: ABdhPJyFe/U+mjdepfvtswzds0c0wE6EdZYr/xfnE5DC5TjIjpXjyxOHYX/+r+K461IC8nWIHnFLlA==
X-Received: by 2002:a5d:6143:: with SMTP id y3mr20640192wrt.277.1603740780951;
        Mon, 26 Oct 2020 12:33:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm26282528wrp.90.2020.10.26.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:33:00 -0700 (PDT)
Message-Id: <055896284083aa0607404ffe82f6d44df61fcf59.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:51 +0000
Subject: [PATCH 08/10] t/perf/fsmonitor: initialize test with git reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Previously, the git add of the previous suiterun would
pollute the numbers in the second run

Before:
Test                                                          this tree
-----------------------------------------------------------------------------
7519.4: status (fsmonitor=fsmonitor-watchman)                 0.40(0.36+0.04)
7519.5: status -uno (fsmonitor=fsmonitor-watchman)            0.19(0.12+0.07)
7519.6: status -uall (fsmonitor=fsmonitor-watchman)           1.36(0.74+0.61)
7519.7: diff (fsmonitor=fsmonitor-watchman)                   0.14(0.10+0.04)
7519.8: diff -- 0_files (fsmonitor=fsmonitor-watchman)        0.14(0.10+0.04)
7519.9: diff -- 10_files (fsmonitor=fsmonitor-watchman)       0.14(0.09+0.05)
7519.10: diff -- 100_files (fsmonitor=fsmonitor-watchman)     0.14(0.10+0.04)
7519.11: diff -- 1000_files (fsmonitor=fsmonitor-watchman)    0.14(0.08+0.06)
7519.12: diff -- 10000_files (fsmonitor=fsmonitor-watchman)   0.14(0.10+0.04)
7519.13: add (fsmonitor=fsmonitor-watchman)                   2.03(1.28+0.69)
7519.16: status (fsmonitor=disabled)                          0.64(0.49+0.90)
7519.17: status -uno (fsmonitor=disabled)                     1.15(0.92+1.00)
7519.18: status -uall (fsmonitor=disabled)                    2.32(1.46+1.55)
7519.19: diff (fsmonitor=disabled)                            1.44(1.12+1.76)
7519.20: diff -- 0_files (fsmonitor=disabled)                 0.11(0.07+0.05)
7519.21: diff -- 10_files (fsmonitor=disabled)                0.11(0.06+0.05)
7519.22: diff -- 100_files (fsmonitor=disabled)               0.11(0.08+0.03)
7519.23: diff -- 1000_files (fsmonitor=disabled)              0.11(0.08+0.04)
7519.24: diff -- 10000_files (fsmonitor=disabled)             0.12(0.06+0.07)
7519.25: add (fsmonitor=disabled)                             2.25(1.47+1.47)

After:
Test                                                          this tree
-----------------------------------------------------------------------------
7519.4: status (fsmonitor=fsmonitor-watchman)                 0.41(0.33+0.09)
7519.5: status -uno (fsmonitor=fsmonitor-watchman)            0.20(0.14+0.07)
7519.6: status -uall (fsmonitor=fsmonitor-watchman)           1.37(0.78+0.58)
7519.7: diff (fsmonitor=fsmonitor-watchman)                   0.14(0.10+0.04)
7519.8: diff -- 0_files (fsmonitor=fsmonitor-watchman)        0.14(0.08+0.06)
7519.9: diff -- 10_files (fsmonitor=fsmonitor-watchman)       0.14(0.09+0.05)
7519.10: diff -- 100_files (fsmonitor=fsmonitor-watchman)     0.14(0.10+0.05)
7519.11: diff -- 1000_files (fsmonitor=fsmonitor-watchman)    0.14(0.11+0.04)
7519.12: diff -- 10000_files (fsmonitor=fsmonitor-watchman)   0.14(0.09+0.05)
7519.13: add (fsmonitor=fsmonitor-watchman)                   2.04(1.27+0.71)
7519.16: status (fsmonitor=disabled)                          0.78(0.59+0.99)
7519.17: status -uno (fsmonitor=disabled)                     0.43(0.32+0.88)
7519.18: status -uall (fsmonitor=disabled)                    1.58(0.96+1.38)
7519.19: diff (fsmonitor=disabled)                            0.36(0.31+0.79)
7519.20: diff -- 0_files (fsmonitor=disabled)                 0.11(0.08+0.03)
7519.21: diff -- 10_files (fsmonitor=disabled)                0.11(0.07+0.04)
7519.22: diff -- 100_files (fsmonitor=disabled)               0.11(0.08+0.04)
7519.23: diff -- 1000_files (fsmonitor=disabled)              0.11(0.07+0.05)
7519.24: diff -- 10000_files (fsmonitor=disabled)             0.12(0.08+0.05)
7519.25: add (fsmonitor=disabled)                             2.25(1.48+1.47)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 087f66ecc2..51c03a2596 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -128,8 +128,7 @@ setup_for_fsmonitor() {
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
 	git update-index --fsmonitor 2>error &&
 	cat error &&
-	[ ! -s error ] && # ensure no silent error
-	git status  # Warm caches
+	[ ! -s error ] # ensure no silent error
 }
 
 test_perf_w_drop_caches () {
@@ -147,6 +146,11 @@ test_fsmonitor_suite() {
 		DESC="fsmonitor=disabled"
 	fi
 
+	test_expect_success "test_initialization" '
+		git reset --hard &&
+		git status  # Warm caches
+	'
+
 	test_perf_w_drop_caches "status ($DESC)" '
 		git status
 	'
-- 
gitgitgadget

