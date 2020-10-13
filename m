Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABEC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F232488C
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhgOFEaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgJMOp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbgJMOp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1356C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 07:45:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so24356620wru.12
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yzCY+/KaZ4eGqn5hBF0emRHlX69a4Tebw9q7aJQ7JGk=;
        b=PhgOFEaERISfbsu2KZu0SoXT3Sz2X0R5Qxrnls4pt97PJWiQgK1f97jhcNVgHqrg1d
         zKFJ8+94nYPkbaz70xBBq+hOiIFS5GwejFzRNwpQR4QVno/8WC3vrJSnK3bPkQcHh8ez
         cbP5lAx/zCaTGZEWx2bzJkhSeiVC+qscZopStxLcywDW+XrgLCbrkQOGrEJnZRvJ/Uaa
         6rf8aigsBJqCPmeuWn4vuR2C2n16Mx/KrOyAzxXl7wv6UGrny363yetBw8UJMzp3DB3j
         eGHM5DvEXDGxF6CZBCQmN3z6gfZlTk2yqXbjcSw6umb37KDVqw+DCvjnKKaSrxfQwp2X
         eVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yzCY+/KaZ4eGqn5hBF0emRHlX69a4Tebw9q7aJQ7JGk=;
        b=d7mcCdR24TWZ/Qfj03lEEBW7pTPohyCmKxRvVjo3aHPuFY511XMAJJuN9JRMSFTUk1
         YwP3t2TJClgrfJmMhOpbNhq85hBMZLAOZ9nLBNnKQC9zxZeI2AzMtbe5YbLXSbWqA0QH
         wMwcNpzz14/8PudY6sntMZBvH1LYclT01u0rAwcTrQ0nn2fKCBK0y7Kq3Ous78pzIjI8
         RZlY01pj95u8k+iiwo4nsZZQVbQKkkvVP/jyMzNJXm26oqkZ+5ohci0yLeKpkp8C3zpu
         BxVgfQr6yWtuEeJnbpsTqDpKLHiC8iJVfdQg+OWmLIaddDTjr//QXqnb3d5/54vfO2y5
         +vpg==
X-Gm-Message-State: AOAM532iCC/TvPwYsKWcXZAu6ufSqLySnBXiSF3syc/StfMc2NEP/Y18
        BiUZQHosXrmBsEv9+do4JgHwhJ4McD8=
X-Google-Smtp-Source: ABdhPJygb3XCJCzMVbqCT49owA+SpdBOeJMwr0ZHJ2ANQcYwa2+NBMvE+MBG8b04x4OivHxlcXny3Q==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr35580987wru.316.1602600325266;
        Tue, 13 Oct 2020 07:45:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18sm10968608wrx.96.2020.10.13.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:24 -0700 (PDT)
Message-Id: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 14:45:23 +0000
Subject: [PATCH] t5500.43: make the check a bit more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 2b695ecd74d (t5500: count objects through stderr, not trace,
2020-05-06) we tried to ensure that the "Total 3" message could be
grepped in Git's output, even if it sometimes got chopped up into
multiple lines in the trace machinery.

However, the first instance where this mattered now goes through the
sideband machinery, where it is _still_ possible for messages to get
chopped up.

Note: we have code in `demultiplex_sideband()` _specifically_ to stitch
back together lines that were delivered in separate sideband packets.
However, this stitching fails when a primary packet is delivered in
between the two sideband packets: since a primary packet was received,
`demultiplex_sideband()` has to return that (and cannot wait for other
sideband packets, and therefore has to flush any incomplete line it
received).

This seems only to happen occasionally in the `vs-test` part of our CI
builds, i.e. with binaries built using Visual C, but not when building
with GCC or clang; The symptom is that t5500.43 fails to find a line
matching `remote: Total 3` in the `log` file, which ends in something
along these lines:

	remote: Tota
	remote: l 3 (delta 0), reused 0 (delta 0), pack-reused 0

To work around that, use some `sed` magic to re-stitch together those
split lines, after the fact.

The other test case touched by 2b695ecd74d (t5500: count objects through
stderr, not trace, 2020-05-06) is not affected by this issue because the
sideband machinery is not involved there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Work around flakiness in t5500.43
    
    It seems that this test became flaky only recently, although I have to
    admit that I have no idea why: the involved code does not seem to have
    changed recently at all. It should have been fixed by 
    https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
    , but apparently wasn't completely fixed, despite what I said in that
    thread.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-753%2Fdscho%2Funflake-t5500.43-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-753/dscho/unflake-t5500.43-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/753

 t/t5500-fetch-pack.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3557374312..5e556313af 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -400,7 +400,20 @@ test_expect_success 'in_vain not triggered before first ACK' '
 	test_commit -C myserver bar &&
 
 	git -C myclient fetch --progress origin 2>log &&
-	test_i18ngrep "remote: Total 3 " log
+	if ! test_i18ngrep "remote: Total 3 " log
+	then
+		# It is possible that the "Total 3" line is delivered in
+		# multiple sideband packets, and that a primary packet is
+		# delivered in between. When that happens, the line will be
+		# presented on multiple "remote:" lines.
+		sed "/^remote: T/{
+			:a
+			N
+			s/\nremote: //
+			ba
+		}" log >log.unsplit &&
+		test_i18ngrep "remote: Total 3 " log.unsplit
+	fi
 '
 
 test_expect_success 'in_vain resetted upon ACK' '

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
