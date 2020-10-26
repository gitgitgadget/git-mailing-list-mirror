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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22339C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C4F20872
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XljQkb72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793307AbgJZTdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:40 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38678 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793172AbgJZTc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:59 -0400
Received: by mail-wr1-f43.google.com with SMTP id n18so14047498wrs.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8UBShdbdG3tTDDgUqILjKjphuN567JPoBWZWePiOMQ4=;
        b=XljQkb72bfUt71mGLPaRbZ6eKs7NhUBTICVizr/WxzOBslX+wNSm5oSBQ3nkT0tYdw
         LPnnU8Vgt4soU7UefuQEZsR0l0qDtdQvMyhK44IzhVBhcR3l8J2mkVMhgtK0NKohRtkZ
         eTKOEBdqgioe10XBlsMorIH1vvrkRuaHo4J9RYNNh9MFDkLTVWEW97hXOkpv9Tsls3IT
         7NrVNVPt13H+0OqNzr5dOB5to/ZvlNz3cGd6ne2T8w10wwltxpQh/uLDB0+ozrztHw8x
         MSQD1yfCsy8FCHc+LK2DSmpKrAONGrjr2jZ6BBWdmkOuTD9p42Uy3GSDJ8jIOi1YzQzk
         KqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8UBShdbdG3tTDDgUqILjKjphuN567JPoBWZWePiOMQ4=;
        b=QjoV2C8UFilEjfy/CtwVuzygizkqNridn57gKgk74cyLK07DG0HYxiYlCyGwFMuWGs
         NaOGO50LQGEyMxsmIxiWY96h7i14sZxirNf1gLygphqD9uYCiq5GUZ11w7JtTAMqys/H
         X6LYZb9jRc71VBEnniZjdXNCHcFIwfnnlGTxfH9NTaZB1OcmCgSQ5of98DzWwA9LHjs5
         m6c+CGy+wp46JFFR8mT0e6jQ04dZBNPAThDCyw4udduGF1iQ+FYPJj9XEhj6evB1tlBk
         jxTKAn3c1pqDgvdXGpbrgpZXSxMjN0WygwkFFRoP1i3Nvx4QGKYswXv9lG6iN0N1hWf8
         jquQ==
X-Gm-Message-State: AOAM531QCj4p35wRmkXHNV/cgroS+y2ojgWzHfk6B0Q9sL3MSaiYNULW
        whl887wtkPVGK6hS4mIBaYhDwZAUrd8=
X-Google-Smtp-Source: ABdhPJxMK8d+5NdFjuMo/+Jb54d/XXGGqGYu0MKc83rrf/KvTVyTDLtpZwgIkM55dnH9xGf6qlUtbQ==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr18875986wrt.23.1603740777950;
        Mon, 26 Oct 2020 12:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm8794308wmb.20.2020.10.26.12.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:57 -0700 (PDT)
Message-Id: <60b5354a35faeb98d11f7f742c708ccc7cb38536.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:47 +0000
Subject: [PATCH 04/10] t/perf/fsmonitor: factor description out for
 readability
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

There was much duplication here. Prepares for making
changes to the description.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 88b3717e2a..aa6b82d756 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -141,43 +141,45 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite() {
-	test_perf_w_drop_caches "status (fsmonitor=$INTEGRATION_SCRIPT)" '
+	DESC="fsmonitor=$INTEGRATION_SCRIPT"
+
+	test_perf_w_drop_caches "status ($DESC)" '
 		git status
 	'
 
-	test_perf_w_drop_caches "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "status -uno ($DESC)" '
 		git status -uno
 	'
 
-	test_perf_w_drop_caches "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "status -uall ($DESC)" '
 		git status -uall
 	'
 
-	test_perf_w_drop_caches "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff ($DESC)" '
 		git diff
 	'
 
-	test_perf_w_drop_caches "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff -- 0_files ($DESC)" '
 		git diff -- 1_file
 	'
 
-	test_perf_w_drop_caches "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff -- 10_files ($DESC)" '
 		git diff -- 10_files
 	'
 
-	test_perf_w_drop_caches "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff -- 100_files ($DESC)" '
 		git diff -- 100_files
 	'
 
-	test_perf_w_drop_caches "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff -- 1000_files ($DESC)" '
 		git diff -- 1000_files
 	'
 
-	test_perf_w_drop_caches "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "diff -- 10000_files ($DESC)" '
 		git diff -- 10000_files
 	'
 
-	test_perf_w_drop_caches "add (fsmonitor=$INTEGRATION_SCRIPT)" '
+	test_perf_w_drop_caches "add ($DESC)" '
 		git add  --all
 	'
 }
-- 
gitgitgadget

