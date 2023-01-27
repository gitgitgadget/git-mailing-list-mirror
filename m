Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE91C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjA0UHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjA0UH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D767AE5C
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m15so4195986wms.4
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XxN02w0/IF7oCFbjMx960nk04Vp5DVvVD+oad5mmNZY=;
        b=kJ3W9dkO+BsgUZtHby+tsfYWH29Le/32C9t2h9c7kW32h99kkLXrola5BN1NzVxyjs
         3GzT+xa85mSj1GJqCdns06v86YuUBhdlKWBmxmgrs658Br2YTsfuShyxWhX0W23UlQHb
         JULppiDX1fnEy00zTfcYNjynHKnXSWham0UIS+AqDoEdXxYCCGRuC6QkxywVUjqFSEII
         86H8t245xi6iXkYY5ksPjc7XwWb+QW2vjNsnNbsf5ilr01UaeunODNHe+OnXLKQBUio1
         B/GXL6nMgHRTeFeN9qzsUFN9biVD0EFXmNm0H6DQ64wVlSE+DYv7I4zdq0t/nIkNAPbz
         ukog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxN02w0/IF7oCFbjMx960nk04Vp5DVvVD+oad5mmNZY=;
        b=ITsCsP0/OwCJQ7sqxG9RpOrdGteyNv6+xOl0JmiRPrUixpbFZglm0UCkU8MuthDwwC
         zkBgM2cVo2sWQjuM4Skhubo1GwIQkfJ6N73Ua/fjet1L8hSDkjIwgsO293UBQlJj4FKg
         v3dPbKrK9QHselc95Q2F88rbnrHefTWC0slYqWO65cw83r1c/2vEmOWoRDbiOIS1uCr9
         j+oCVvcnrsCt3BmXz19v7t+j2RL9bxnUmiIyFIAyl4Y8JzbMALNuMGXte6UhN5WxsShH
         qeZ4+J7zPYkJ9m4wny7dnCmYlY3rhRyxu1SRu9jUzi4ZdK042u25GLySlE0gNYAQ26bB
         TANQ==
X-Gm-Message-State: AFqh2krvsR7CFTaobqZf2lA6SNs6mjHYetxwAevZOJfrvE0wgEBX/TOJ
        XgucKyvcYfaco4MDfdrH35jYIbz50I0=
X-Google-Smtp-Source: AMrXdXt6zPAbBdq9FO83UxKUVgs7kPzFpOIYgn3idCPR5SZYiuxpuH7stPKWIYyJ+x7MGWWPTP4cCw==
X-Received: by 2002:a05:600c:3ac8:b0:3da:270b:ba6b with SMTP id d8-20020a05600c3ac800b003da270bba6bmr42179818wms.41.1674849964238;
        Fri, 27 Jan 2023 12:06:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b003daffc2ecdesm8620036wmb.13.2023.01.27.12.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:06:03 -0800 (PST)
Message-Id: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Jan 2023 20:06:00 +0000
Subject: [PATCH 0/3] Allow scalar to succeed despite maintenance failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB we received a report of issues with scalar clone and scalar
register in a protected environment. Specifically, they couldn't run crontab
or systemctl, which causes git maintenance start to fail. That failure was
percolating through scalar clone and scalar register, even though the rest
of their repository was properly set up.

Convert these hard failures into soft warnings.

This change could probably be done in a single commit, but I wanted to
demonstrate the existing behavior before changing it. The first patch was
also a related necessary step that will be helpful for future scalar tests.

Thanks,

 * Stolee

Derrick Stolee (3):
  t: allow 'scalar' in test_must_fail
  t921*: test scalar behavior starting maintenance
  scalar: only warn when background maintenance fails

 scalar.c                | 2 +-
 t/t9210-scalar.sh       | 7 +++++++
 t/t9211-scalar-clone.sh | 6 ++++++
 t/test-lib-functions.sh | 2 +-
 4 files changed, 15 insertions(+), 2 deletions(-)


base-commit: 5cc9858f1b470844dea5c5d3e936af183fdf2c68
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1473%2Fderrickstolee%2Fscalar-register-warn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1473/derrickstolee/scalar-register-warn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1473
-- 
gitgitgadget
