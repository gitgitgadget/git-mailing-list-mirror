Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E22DC41603
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3A261106
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhELRoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbhELR3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535EC061763
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z17so5364483wrq.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4KsZA2I7CfIgjH08T88TsFhRmAHld7iU15QGXlFPnMM=;
        b=i3ame8EZYBfAyroAGudHDkfBG72X0fhylp63LuxOwRBcyK0OIuCUSV7RO75aaWOZ3X
         7EGo9OIymOovJYCnlE0HaJXHdVMv9J2G76s2CQuoiMoW47Djryh4eLlGG4oPx/wI7Udi
         CtWm1vu8PzlXyykbOIIFIW4FcE0gNji9YuBd+6Ruum8phHIpcdS9DXv3uSXZ9JyNqRY6
         uoTJOS/HLE+3o48fiIG4bRZgGLREWQuwwG76QukO1w2SLrCnJy9bGkVBk2+oFG2wSFot
         64jOb5jgXXJXMdA2eULYNGOtIn+sk98MlN2e6V5J20FLCflgbCuVmfw11nGt7ltRbz1O
         05UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4KsZA2I7CfIgjH08T88TsFhRmAHld7iU15QGXlFPnMM=;
        b=lbA4hjL3F4irIntXTnYbDyyyCPWLwvWLbOm2K5Vhrtv+s/qwGVpL+oAfYB7I5jhCAg
         zko4fjC6SCX9MqY0DfQfJvvKx/Uo6hL0hz3J4YQl1h0EWmacoZDRTU+a+9L+saEPQPE4
         ZlXfsIyj3u75PM0/PxPM4nBsX0Vucv66bVXwNInN+XcpGTvBExSsfdr1e3xF59XAeNyB
         T8yaRNmbgqGMmFbVrVa9WHvzTY8X/7imFh4/gPShf5TKgiPn2UIEWYAP6OTR9KJ5Lq4r
         xW+nNNtph7mFZf/la7P5kYMI/yKLbnoRtjb3XfHk3ny68u+pNYVF1VeUxwU0A3x94w1A
         VOvg==
X-Gm-Message-State: AOAM532hhUEJOuQuoovolfd6mmdcTRFL71bUOtbBDKsZBMkB6iBIsESL
        Ig/tldiVCOEujhKNalvLYFnaYIQkhaM=
X-Google-Smtp-Source: ABdhPJxi/jZejIzaDkWxWX8u51ddkH6CX6jhPwSaMkXdHAA5sagmKLWrcca8/06at962/7Q+mp3zLg==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr39792137wrp.94.1620840508858;
        Wed, 12 May 2021 10:28:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm398602wrr.27.2021.05.12.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:28 -0700 (PDT)
Message-Id: <5a8807a1992cd012a8271fd157a757c07254b27a.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:17 +0000
Subject: [PATCH v5 4/9] t7300: add testcase showing unnecessary traversal into
 ignored directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The PNPM package manager is apparently creating deeply nested (but
ignored) directory structures; traversing them is costly
performance-wise, unnecessary, and in some cases is even throwing
warnings/errors because the paths are too long to handle on various
platforms.  Add a testcase that checks for such unnecessary directory
traversal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a74816ca8b46..07e8ba2d4b85 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -746,4 +746,27 @@ test_expect_success 'clean untracked paths by pathspec' '
 	test_must_be_empty actual
 '
 
+test_expect_failure 'avoid traversing into ignored directories' '
+	test_when_finished rm -f output error trace.* &&
+	test_create_repo avoid-traversing-deep-hierarchy &&
+	(
+		cd avoid-traversing-deep-hierarchy &&
+
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdxn -e untracked
+	) &&
+
+	# Make sure we only visited into the top-level directory, and did
+	# not traverse into the "untracked" subdirectory since it was excluded
+	grep data.*read_directo.*directories-visited trace.output |
+		cut -d "|" -f 9 >trace.relevant &&
+	cat >trace.expect <<-EOF &&
+	 ..directories-visited:1
+	EOF
+	test_cmp trace.expect trace.relevant
+'
+
 test_done
-- 
gitgitgadget

