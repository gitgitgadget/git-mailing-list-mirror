Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8166C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFA0221F7
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOp77Hwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506933AbgJ0W6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:58:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38524 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503167AbgJ0W6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:58:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id n18so3685781wrs.5
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUSS4zQbWA+7M1jgYiEHtvUwHq895rVzDjb+OZxPUy8=;
        b=iOp77HwdBvra8RoNuXgxApMqBGdjAHlEszOoz40diotcJ28m6ojRtOF21inUx+3Kdu
         W1E6BpWnrEvf+Qpaztyp7JLW97mizYNOncL6yWZvOByrrNqqQT15xLKyWp9S6oVWD/6R
         UHtkYQdaPU/CzIOZgpgt0j0TL2AmDEIfp63aM5LrYFjZ6V4e3HKmuiRpfe0uOF/CBqVV
         YkVCj17dsXOnZsChboPC5FDNNlkbNnTbj+/sYvCyRqH9EMcZHmJP8j+NyhwlNRE9G7cU
         CZjb2woVpMRIPijDbpBGTlKvoYViNNVteGphVz7aRS5Aw+v0+k5LVsdcTKt8UiOAWJM+
         +g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUSS4zQbWA+7M1jgYiEHtvUwHq895rVzDjb+OZxPUy8=;
        b=UEDuhjvYprHu8KF6oUDwedRdNInvb5KFmhedf9WO9LgsxZQVJcjwXGn1JdX2D2bzSz
         W/n8la73P0RZZpNqqiVlOfAZgGZbmLSdd99ng7qGAB4U8oo0ZJj6fVaLCIokjiim1OSs
         GDd0loj2agkGB58oEtmq4zPfxcwRpsPfZhVmKx5A+RzXW3GKMFDXRp8mqQdDAYIPna5L
         adt13dDov9RTNHkhx3kh+YviZS0KlIUPpDyTl34x1hEOkfDTT2vqV3YT2eqRF9UcP9mJ
         MoRJGZMqEltza0lJfyy/95yNwhG5447uvzF7TmtOqaCYqCL3V40xc8o0Tlin1ALpvd2g
         YnKw==
X-Gm-Message-State: AOAM532Q507Lzw342tl9lMak8CkiTCfM+gl+0Ys+PYhH3jn/ivRQ6bAH
        tkXilh5xN/DQ0AlUNj6B2c6TYbKDfLs=
X-Google-Smtp-Source: ABdhPJwTQjfBbcP3dS52bdS1qVgmX+iSLH1PSNCVEorjbp7FSj8rlOu2/cdweRak4ucivv6LDSNrew==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr5168677wrt.137.1603839492391;
        Tue, 27 Oct 2020 15:58:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15sm4152672wrr.36.2020.10.27.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:58:12 -0700 (PDT)
Message-Id: <ac2173cce7c91e6398d17a1b65e3c5e7c7ac3b10.1603839487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.1603839487.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 22:58:07 +0000
Subject: [PATCH 4/4] t5411: finish preparing for `main` being the default
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In addition to the trivial search-and-replace performed over the course
of the previous three commits, there is one test in t5411 that depends
on the length of the default branch name.

Adjust it and use `main` as the default branch name in this test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411-proc-receive-hook.sh          | 8 +++-----
 t/t5411/once-0010-report-status-v1.sh | 6 +++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 06bbb02ed2..98b0e81208 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -5,12 +5,10 @@
 
 test_description='Test proc-receive hook'
 
-. ./test-lib.sh
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
-	test_skip="In transit for the default branch name 'main'"
-	test_done
-}
+. ./test-lib.sh
 
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
 
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 6005ee0ecb..cb431a9c91 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -69,11 +69,11 @@ test_expect_success "proc-receive: report status v1" '
 	proc-receive> option forced-update
 	proc-receive> ng refs/for/next/topic target branch not exist
 	000eunpack ok
-	0019ok refs/heads/main
-	001eok refs/for/main/topic1
+	0017ok refs/heads/main
+	001cok refs/for/main/topic1
 	0016ok refs/heads/foo
 	0033ng refs/for/next/topic target branch not exist
-	001eok refs/for/main/topic2
+	001cok refs/for/main/topic2
 	0000# post-receive hook
 	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic1
-- 
gitgitgadget
