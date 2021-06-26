Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D34C49EA6
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073D61C19
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFZRHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFZRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:07:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87ADC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r3so3727335wmq.1
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=P8zAV7DGKm3zrV/dEA6rypsddTe3alyJBAPT641lLZI=;
        b=VsxubP0RG0pb6SLSUZ7OYuDI85Hf8IqtH1RkSb7PsT5KBHIU97iKJNbeKuYJ1roNjv
         Hocdb4ALH0IPwHqMJcmjysujpwLtImQp5YThq8xwUcWuGZ87jXJpyGK4BWU2FQyaFKeH
         yqd+qc5x4NqvRHfaZw2VitbgnTQwt1evX9EeGQr8WIjv0lDjvSoqzD7F53X5+oIFZZC6
         H+cdETMKpv7R1zQb6Ux7fe/jN2opDSYrkz1Nf76VWLQJanaAt3sGu4r5v0aD8Jud7mRV
         es5VAYCg9Nzkkxoy60BWBlKruvt5Jyu3dOmMYlCVzb/64SEfgm8uiJ9JwObE3Oqi6d7B
         2oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P8zAV7DGKm3zrV/dEA6rypsddTe3alyJBAPT641lLZI=;
        b=VP8gHd4HxkSt3h8Pu+50X0C0sscbCKb3aTIJFwFUA91nSlrxO3Oac3lJyOQ/+k79Yt
         uGI3//FmPPrQoB0yZD5DtIDYkLuxOK1/t/sufC0n8+XI2LIQZDsGK1LJD3rGcxgTTW7S
         MNjeRzVRg7Idu6EdrYrEW7ROe9Brp/fYiweN8LkufpwDQs5MKJa8VAnuAcvhQtS39kP1
         Ns2J4Y6MYgujHfh6ttoZZlwnnoHncjpn012D6GOCrDEWkOMKJFU9GEOnFfV6wVGCF2Z1
         wgW4H00P8SXCCiEZ7UkxukVn0I5jZ1J38KoGoryxj0OP94jr25VH8mCLCPy3ZcFOkLuT
         Dadw==
X-Gm-Message-State: AOAM530IQjOzPeMs0ljAYG5mKVGxmf2WJGIHqKKiS5M/zL9uVTPUh7Ho
        gdKVUNgGrD0sH7VFf0kAErhW8CsqGLI=
X-Google-Smtp-Source: ABdhPJwp+WEdRGD1OFn4cRCRErlorFKFYJn1HNcUISsL3WsVzaMJwEOO0W5w1vicQ4JtyicYHjG5eg==
X-Received: by 2002:a1c:d1:: with SMTP id 200mr17672455wma.85.1624727123212;
        Sat, 26 Jun 2021 10:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm8994725wrq.10.2021.06.26.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 10:05:22 -0700 (PDT)
Message-Id: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Jun 2021 17:05:18 +0000
Subject: [PATCH 0/3] Fix bugs from interesting renaming pairs: one side renames A/file -> B/file,
 the other B/ -> A/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg recently reported a few issues in an interesting rename
case[1]. I was able to duplicate and find multiple bugs from it; two in
merge-recursive, and one in merge-ort. This series has some fixes.

[1]
https://lore.kernel.org/git/CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com/

Elijah Newren (3):
  t6423: test directory renames causing rename-to-self
  merge-ort: ensure we consult df_conflict and path_conflicts
  merge-recursive: handle rename-to-self case

 merge-ort.c                         |   6 +-
 merge-recursive.c                   |  19 +++--
 t/t6423-merge-rename-directories.sh | 117 ++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 7 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1039%2Fnewren%2Frename-plus-dir-rename-cancel-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1039/newren/rename-plus-dir-rename-cancel-v1
Pull-Request: https://github.com/git/git/pull/1039
-- 
gitgitgadget
