Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F4C43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A327D218AC
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGNJLYhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgIUNa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgIUNaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:30:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B4C0613D0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so12797537wrm.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nrzEGyk/IQsEX7tT1PW/cI2l5YyFqXkq2IZHqY66kVg=;
        b=YGNJLYhAQYUcBJv5mAdTBnElgMbDi5QeZ+KPos7VLuety1zzgylXfiqR8DkvoRF6dJ
         6t/4OhU4+o49s271vzHFMVDiXHin7btx8xRUM+NdTVs5lUlSzKKkzrmlro3IJrbMITtj
         5JfOrm0lqPTs6jFzFvVe5bJGuf1DlHxOrc4zUP8F7C3k6hVuNY+da8j5CsmSpnavmjaO
         xRCPtQPuXF6lvUKHp22w/lypeMXPgqOkU2hgIOQnLMAVxs4mu1qUz7DR2n9EOxOz7eKe
         rBhlnVBdhr5zCdJUcuMC/CwqYuv2GhoYUboPdnUVZvpgVZykm09RdutChpW64uBTQURr
         scbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nrzEGyk/IQsEX7tT1PW/cI2l5YyFqXkq2IZHqY66kVg=;
        b=R/fEdL5aWkr7DKBjsGA4saSesV0nX2cIv50w04rqJbaVbv2PqZL1S5FCa3IUZyRvLw
         C8zZNqITLMZlntfYTShs6fjDSc2tYessi2KxPVvv2b3OQlP/XLgncvFt02MGhPoq6wG8
         Q0coC6+rvhd++rOTgvXf7rkWFUO6AoiZsMaE4rL68A0eO/KlPdQ/gK0/ZDjGch1/TJmM
         GMCr9Nn5VE25PSSt99Ds+9WTq2d1jIPRZdVXRFuJtggwHxK8Wlqen4t3C8/ox8DsK0vb
         A0sXtuj0R1laPYG+766oFmVNku+c9j7m05U8Ts4IS1yQf0agQwaEkaaSDPUPUlYSYmbY
         yZEg==
X-Gm-Message-State: AOAM5319/ln9jJlJ8zIZAiU0252VwVRr0NUU6lnXGKb8W0N6Dmc/Dxas
        43enlsbhA+mfxUd10sseu3aBmH2Hq38=
X-Google-Smtp-Source: ABdhPJxDk2kz6gokmxf3zorjW5nft2B8f8Kt7T0htHsis1YUyGhr9Jt+gy5C1mYQt/nZM81JIRsx2w==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr51669925wrs.36.1600695053174;
        Mon, 21 Sep 2020 06:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm20995304wrt.80.2020.09.21.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:30:52 -0700 (PDT)
Message-Id: <80a69318b57348c59e45c0f8df1c342ef84388d4.1600695050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.736.git.1600695050.gitgitgadget@gmail.com>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 13:30:49 +0000
Subject: [PATCH 2/3] commit: reorder synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rearrange the synopsis for `git commit` to try and put options that
are used more often nearer the beginning.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-commit.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a1d1d1246f..9de4dc5d66 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,11 +8,11 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
-	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
-	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+'git commit' [-a | --interactive | --patch] [--amend]
+	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
+	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e]
+	   [--reset-author] [--author=<author>] [--date=<date>]
+	   [--cleanup=<mode>] [-v] [-u<mode>] [--dry-run] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [-S[<keyid>]] [--] [<pathspec>...]
 
-- 
gitgitgadget

