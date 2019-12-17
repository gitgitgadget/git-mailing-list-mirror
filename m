Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE83BC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8C207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsGaO4Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLQMB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35491 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfLQMBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so5566432pgk.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OzdOyb95QcnDOwcg5SuGULBKy8d/XRonQyY8fjL4CS4=;
        b=BsGaO4NlTAHJlm14Gc2FKFhmZX+bXSOvmOGyWLTmmr7zgm7MZH3cC93cqpe0D5jMuQ
         Y3m1m5YyelRRQeblPP6WUxTvv9AdlCwuJuir02icsxV4zfqLy0URnlyQ9fky+PqXGHfP
         gp3aYFYDRj2Wd0oKzmWs0eWD5Tv1k81GRdXMRt/hmIv2X+4NgH2jwx2K2VNaBXPut/YU
         L2Myu2SWZSSTWyTttbBYpI1vMVpi/MmHiYs+A+SQG2615ZN676ud4cF2A9JWSvwjOeG8
         +9vU+0b2rNVKd+UbJNURlmdbmYbod6Bq/uHVR/+Tn5+cDYI/DtCLjKeFGzQufXOhoWhA
         0QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzdOyb95QcnDOwcg5SuGULBKy8d/XRonQyY8fjL4CS4=;
        b=HaRfgF/puuVAM4ISA28HGrN7iho5xKYb58QLo83qVGwaZUan1hvGFHFgOBA/ve/eCr
         UHYs1zz+y6HxIOeGWBoEvq3uKMAM9qacTkajYObK0i80qHyltG4Vh8waQnoV5UiM2+01
         IOmey0S7j4iq4K5V4HAZry0FfEpm43mPFmd5XyiZfj5asDySjqWvZDKRyuUW6bfgI8G3
         L1xhyBgXNCLTBRJzxZW6PlrrziVZHmZTG5KesQTqYYLViDCLWea1xMG5etgQQ8VYnAVV
         ZZKoKPJIr9Ngm+6wBYRBzXwvOz/ElyWNma4U0RKW+HgJhNem2lc6XYclk2Wc1E5kqO2K
         2Vtg==
X-Gm-Message-State: APjAAAWchEn4ylR5Sv+iFmdGNBBB8mwYUvDAfqqkerzwTbgrFGyGYMjW
        WsBIk2shtvXj9DOy7GuastwiJBDX
X-Google-Smtp-Source: APXvYqwHX9XHvc7NrNIV/sB8z/MLY6gVYAub+xCCYCVoDs6EUK33UH3zOpPCisoqugaJuqFbW2cCYw==
X-Received: by 2002:a63:215d:: with SMTP id s29mr22758634pgm.200.1576584113808;
        Tue, 17 Dec 2019 04:01:53 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:53 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 15/15] t1507: teach full_name() to accept `!` arg
Date:   Tue, 17 Dec 2019 04:01:40 -0800
Message-Id: <cd392a74acb1bc7f3b09f167278afd5959a21fca.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, we were running `test_must_fail full_name`. However,
`test_must_fail` should only be used on git commands. Teach full_name()
to accept `!` as a potential first argument which will prepend
`test_must_fail` to the enclosed git command. This increases the
granularity of test_must_fail since it no longer runs on the `cd` as
well.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 8b4cf8a6e3..9a941d68d8 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -29,8 +29,14 @@ test_expect_success 'setup' '
 '
 
 full_name () {
+	fail= &&
+	if test "x$1" = 'x!'
+	then
+		fail=test_must_fail &&
+		shift
+	fi &&
 	(cd clone &&
-	 git rev-parse --symbolic-full-name "$@")
+	 $fail git rev-parse --symbolic-full-name "$@")
 }
 
 commit_subject () {
@@ -79,7 +85,7 @@ test_expect_success 'upstream of branch with @ at end' '
 '
 
 test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
-	test_must_fail full_name refs/heads/my-side@{upstream}
+	full_name ! refs/heads/my-side@{upstream}
 '
 
 test_expect_success 'my-side@{u} resolves to correct commit' '
@@ -91,9 +97,9 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
 '
 
 test_expect_success 'not-tracking@{u} fails' '
-	test_must_fail full_name non-tracking@{u} &&
+	full_name ! non-tracking@{u} &&
 	(cd clone && git checkout --no-track -b non-tracking) &&
-	test_must_fail full_name non-tracking@{u}
+	full_name ! non-tracking@{u}
 '
 
 test_expect_success '<branch>@{u}@{1} resolves correctly' '
-- 
2.24.0.627.geba02921db

