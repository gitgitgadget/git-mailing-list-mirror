Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiBPK4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:56:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBPK4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:56:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E9644A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so2783770wrc.6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/xX/HAmlcwFLUjNxvCeU/yUkUxtwdfSe24/nopWFeY=;
        b=g5SuLnZY4AJ/qh+YXrqseCkoCHT8XJKA8PqQr8GmFGLVG306C5aML5sqxL1xvNJliv
         v4iMprEvzUsZGO05WudzwlKNMhzcsga3wOO3NNdrxcW9YgSwi6ehv5OawI4PPACuzzFw
         kqM+QrPGFrzuoqiXeSaeS+pEIfvPPYnR+v02QomBh/pg8cmz4xzNWk2nnbx6FN1O+g8C
         hN+lNpZJ+9vxv6dbpv4uPAM0jF+S02v+DG2Oi2G7uXjiBBd4RZL9JBqGyjUFNcOCL+7M
         UQ6ZPDz0y7FXmdc6oy8AyExCvv9H7yzuFCPkNPiZocI2SvUXPLSX1hN0tdhyO38q/VmF
         7P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/xX/HAmlcwFLUjNxvCeU/yUkUxtwdfSe24/nopWFeY=;
        b=XwdfLnyb0tx9p+yU5FhNwEqwxrR9ahT/n1K4WBWJWCnJ9aT5oNaWJzT5Ob/LVudhDy
         1nCmt5z8XIlhpy06t7BMP/KeSMVSJmtujGBkGXwHAG5J8PmKELRi3LQO927pIn8ND82w
         28DrMSJdmcD6kawID/m0AAH9KXB1Gd8dw/ziG79nhLu0phFlnQZgbos26CXE8lglD8WM
         P3WhIuOk0EFJoW5lHhbE7SmPGcMUhT+94N/+YnFLCBB2eKj9tq5+CpemQ8XCiJyvA1kq
         TDVg1TZOuEze8YruMhSBm7SKKLafuUQawD+CalV1V0ZbAh654oHLKBLkaZz9EuLI4Zd8
         iKdA==
X-Gm-Message-State: AOAM532nY1LwtkmQdX0v3jkQrrajPwC5U9QmE7KCyCmGznDYyMoLvI93
        jIWmsk87FydgazPHy0hauSmZbDMcH2I+Jg==
X-Google-Smtp-Source: ABdhPJwGRyFcNl7JN27eFGIKDaWuQA87mAunVJJcWM6mZW1zzqkezEs6dD3eQCUq9cRZKYv/mIJsOA==
X-Received: by 2002:a05:6000:10d2:b0:1e3:e061:1172 with SMTP id b18-20020a05600010d200b001e3e0611172mr1809715wrx.195.1645008993686;
        Wed, 16 Feb 2022 02:56:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u7sm27185370wrq.112.2022.02.16.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:56:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] diff_free(): free a bit more, fix leaks
Date:   Wed, 16 Feb 2022 11:56:27 +0100
Message-Id: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A short and simple two-part series to fix some leaks in after
diff_flush() and friends are called by making in diff_free() more
useful.

This series along with other small leak fixes I have outstanding
on-list now is the last step I have before the big one of submitting a
series to fix the "big one" across the test suite: the common leaks in
the revisions API.

Ævar Arnfjörð Bjarmason (2):
  diff.[ch]: have diff_free() call clear_pathspec(opts.pathspec)
  diff.[ch]: have diff_free() free options->parseopts

 add-interactive.c | 6 +++---
 blame.c           | 3 ---
 builtin/reset.c   | 1 -
 diff.c            | 2 ++
 notes-merge.c     | 2 --
 5 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.35.1.1028.g2d2d4be19de

