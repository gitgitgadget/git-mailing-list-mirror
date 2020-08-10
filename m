Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B4C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D50020768
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJAghY6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgHJW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgHJW31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03FBC061788
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so9603465wrh.10
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v/YrnIQx0Qjh+uN3OIOcV92pi53pOcv0u9rwLWldDJs=;
        b=QJAghY6+I2/AQFzdXrgRorukLIJ4hZ3UdOPnCBXbPVjnlLlUgzSLQZzzYFcJ9ivXyL
         R3VxOKhXpFI+Vi+SH1sVE5B4t6JmPGeN6/qZM4gDcOX3kXoohKJRqUjPYaKwjgWmY8qO
         em8mdKgCARZ//WgYBBbXXBAgy3le61Ur0GEK1pVz4mZHfADYO9hE72NYHh5S+8+wz/Rz
         xMDZ8o5PyMhYm+L/GWyJ7YgoqNoq1mdDdGh5jLSLx8fLquA3RwYUcm8cgfdc2G/TSD1F
         a8Bhvl+gkZlbebvu4V68J2DEl5mGRyvNSPnB55klU/01eCFnaA/PbhS6oHbjQmF7Yjx9
         shjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v/YrnIQx0Qjh+uN3OIOcV92pi53pOcv0u9rwLWldDJs=;
        b=I0qfIs74a6IGxM7TGsanBfP4ReobqChJuqN+458lCaL1Grb/hYA2TCDhmIocE7PpJv
         jhZzPwILPwm9mRjn2hD3CqKCjizAWCFDZJXzyQ49VrCNV2q+mfLwzeCLrqkB5Ng6TyCJ
         zxLNTPCRHH2TCAuCi+5irdEntmgVZ0JDcab6O9qu0pTLBaMjgEEsyvLc6gX7YXjLnefs
         RQwkwa/OrxXr0q7DLZn6nxzX3tzIyhsz0uEPjjC9XAZ279ym2ZXaPc6rK0B+ob/v75Kl
         zZCJJk6rE+GPGWjyjFhSsxPZJwhD2eMWXTZZhbrci/sZc0BMOOzNv+82joJB4TQYbz7N
         KMkw==
X-Gm-Message-State: AOAM5329n/hxeo/NVUuyQp+MwfDn+wghP35wVkAw1O1CMC1FsrswthNm
        HzIep+iMj0bEIs3VjWeIv5M9nZs4
X-Google-Smtp-Source: ABdhPJy4DSUEfjIZ8ozA5tXj84Kd7vKBPmocAqoRSwu361Rxhbh+6fIk24CpftA3STI6Oja8+fZA8A==
X-Received: by 2002:adf:e411:: with SMTP id g17mr28274005wrm.77.1597098565391;
        Mon, 10 Aug 2020 15:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 126sm1611886wme.42.2020.08.10.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:24 -0700 (PDT)
Message-Id: <8ac78dc71be0bc25c61e3bef929872354684648a.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:13 +0000
Subject: [PATCH v3 05/11] t6423: fix test setup for a couple tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit da1e295e00 ("t604[236]: do not run setup in separate tests",
2019-10-22) removed approximately half the tests (which were setup-only
tests) in t6043 by turning them into functions that the subsequent test
would call as their first step.  This ensured that any test from this
file could be run entirely independently of all the other tests in the
file.  Unfortunately, the call to the new setup function was missed in
two of the test_expect_failure cases.  Add them in.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 83792c5ef1..d227e15944 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2880,6 +2880,7 @@ test_setup_9g () {
 }
 
 test_expect_failure '9g: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	test_setup_9g &&
 	(
 		cd 9g &&
 
@@ -3362,6 +3363,7 @@ test_setup_10e () {
 }
 
 test_expect_failure '10e: Does git complain about untracked file that is not really in the way?' '
+	test_setup_10e &&
 	(
 		cd 10e &&
 
-- 
gitgitgadget

