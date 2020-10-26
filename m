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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5508C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9AA20872
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjTacgKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793288AbgJZTde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43330 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793159AbgJZTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so14045749wrp.10
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EFatkJB9QgTUgoiX+nNGHEz4hKRjwImsfA2Cgf/edVw=;
        b=FjTacgKAHitaAMwts1JLNSMIOdly6jZlCNK77Rld5xHbsn9anZ3S3Fpxo5ODjZWjdr
         cRxUa/G5uMK3IGT/sw8L5XwO533S05n4HtTsm39iGp5sK7f6FeNX2AVjp/6+/8Tw6oCr
         uPrW4268TkEF+OjAf5/wyI09hoC0vgxaR4v5lcPDSjH5w7jE5KaIXNTT/enVfpDHo6n3
         Q+Rfs3/R21JjbzNSRSGpFEYskg8Xt3Tgb2X+lQ8+dyThugt3q+TImUf7JxIjP53rbkfD
         uKHFcwa99rbLL0F40GhDHYHmlAEwj4Hl4LZOWygkxb3iiAIv95/NZGpqVoktxIN5hvGI
         ge4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EFatkJB9QgTUgoiX+nNGHEz4hKRjwImsfA2Cgf/edVw=;
        b=Z+MaBl1kjVBwB2bbXCbLj9aBboWOV6FmN7mC38ft7BwYMua/LDJro6jLT6upFHTuXA
         5gq/FEJ8PrKYMxuprKCtzE+vWrwP+4Kzneiq20qq3ruCqmYIzs2rEuc7lxPLEzCyb90l
         Azkp4O60+MTa0cP5gIQ8csF/eU5s8dGph2xOBQKCdcbRT7NKvybQK+UdpRP7p48/uuZ+
         T1EaEYfNW2lHn+Td1xIU1mFWjscUmRUuadK4MJ3GfOv4fH31vAw9NWavsN3G8Jed1QCO
         Tr5xE/GllJYumzYDHFNjFkZrAAeA4v3nvYrtlCkXiFuhxZCmlnE/AhwmLuaSL6W+V8Ao
         ztOQ==
X-Gm-Message-State: AOAM530OdgSFbVt0nR23yl6ZGKQTaa1YUBLfUTdAtP9eSMsrtcHJf8/k
        Cm0dcVfK5i0tetEP4LxBLg2o0V0vQ10=
X-Google-Smtp-Source: ABdhPJz3FONSPhQxO5T6DyJxUgQRZmf7fYeBLgnEsyxJ2Tea78qjXneBmI2jL5Li86iWsOSo4dGSIQ==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr5244219wrh.205.1603740781692;
        Mon, 26 Oct 2020 12:33:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm25951126wrg.4.2020.10.26.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:33:01 -0700 (PDT)
Message-Id: <7ee7b4e9e67378539ddcd081f7967128f4e47350.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:52 +0000
Subject: [PATCH 09/10] t/perf/fsmonitor: perf comparison of multiple fsmonitor
 integrations
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

Allows for simple perf comparison of different integrations. I ran it
to compare our perl script w/ rs-git-fsmonitor and found 20-30ms of
overhead on every command.

Output looks like this (extra newlines added for readability)

Test                                                        this tree
---------------------------------------------------------------------------
7519.4: status (fsmonitor=query-watchman)                   0.42(0.37+0.05)
7519.5: status -uno (fsmonitor=query-watchman)              0.19(0.12+0.07)
7519.6: status -uall (fsmonitor=query-watchman)             1.36(0.73+0.62)
7519.7: diff (fsmonitor=query-watchman)                     0.14(0.09+0.05)
7519.8: diff -- 0_files (fsmonitor=query-watchman)          0.14(0.11+0.03)
7519.9: diff -- 10_files (fsmonitor=query-watchman)         0.14(0.10+0.04)
7519.10: diff -- 100_files (fsmonitor=query-watchman)       0.14(0.09+0.05)
7519.11: diff -- 1000_files (fsmonitor=query-watchman)      0.14(0.08+0.06)
7519.12: diff -- 10000_files (fsmonitor=query-watchman)     0.14(0.09+0.05)
7519.13: add (fsmonitor=query-watchman)                     2.04(1.32+0.66)

7519.16: status (fsmonitor=rs-git-fsmonitor)                0.39(0.32+0.08)
7519.17: status -uno (fsmonitor=rs-git-fsmonitor)           0.17(0.11+0.06)
7519.18: status -uall (fsmonitor=rs-git-fsmonitor)          1.33(0.71+0.61)
7519.19: diff (fsmonitor=rs-git-fsmonitor)                  0.11(0.07+0.04)
7519.20: diff -- 0_files (fsmonitor=rs-git-fsmonitor)       0.11(0.09+0.03)
7519.21: diff -- 10_files (fsmonitor=rs-git-fsmonitor)      0.11(0.09+0.03)
7519.22: diff -- 100_files (fsmonitor=rs-git-fsmonitor)     0.11(0.07+0.04)
7519.23: diff -- 1000_files (fsmonitor=rs-git-fsmonitor)    0.11(0.06+0.06)
7519.24: diff -- 10000_files (fsmonitor=rs-git-fsmonitor)   0.11(0.06+0.06)
7519.25: add (fsmonitor=rs-git-fsmonitor)                   2.03(1.28+0.69)

7519.28: status (fsmonitor=disabled)                        0.77(0.59+0.99)
7519.29: status -uno (fsmonitor=disabled)                   0.42(0.33+0.85)
7519.30: status -uall (fsmonitor=disabled)                  1.59(1.02+1.34)
7519.31: diff (fsmonitor=disabled)                          0.35(0.30+0.81)
7519.32: diff -- 0_files (fsmonitor=disabled)               0.11(0.08+0.04)
7519.33: diff -- 10_files (fsmonitor=disabled)              0.11(0.07+0.04)
7519.34: diff -- 100_files (fsmonitor=disabled)             0.11(0.08+0.03)
7519.35: diff -- 1000_files (fsmonitor=disabled)            0.11(0.10+0.02)
7519.36: diff -- 10000_files (fsmonitor=disabled)           0.12(0.07+0.06)
7519.37: add (fsmonitor=disabled)                           2.24(1.48+1.44)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 51c03a2596..577f79d455 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -22,7 +22,9 @@ test_description="Test core.fsmonitor"
 #
 # GIT_PERF_7519_UNTRACKED_CACHE: used to configure core.untrackedCache
 # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
-# GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor
+# GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
+#   absolute path to an integration. May be a space delimited list of
+#   absolute paths to integrations.
 #
 # The big win for using fsmonitor is the elimination of the need to scan the
 # working directory looking for changed and untracked files. If the file
@@ -105,9 +107,9 @@ test_expect_success "one time repo setup" '
 
 setup_for_fsmonitor() {
 	# set INTEGRATION_SCRIPT depending on the environment
-	if test -n "$GIT_PERF_7519_FSMONITOR"
+	if test -n "$INTEGRATION_PATH"
 	then
-		INTEGRATION_SCRIPT="$GIT_PERF_7519_FSMONITOR"
+		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
 	else
 		#
 		# Choose integration script based on existence of Watchman.
@@ -192,11 +194,15 @@ test_fsmonitor_suite() {
 	'
 }
 
-test_expect_success "setup for fsmonitor" '
-	setup_for_fsmonitor
-'
-
-test_fsmonitor_suite
+if test -n "$GIT_PERF_7519_FSMONITOR"; then
+	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
+		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
+		test_fsmonitor_suite
+	done
+else
+	test_expect_success "setup for fsmonitor" 'setup_for_fsmonitor'
+	test_fsmonitor_suite
+fi
 
 test_expect_success "setup without fsmonitor" '
 	unset INTEGRATION_SCRIPT &&
-- 
gitgitgadget

