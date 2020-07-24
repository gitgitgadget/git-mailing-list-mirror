Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35AC433E3
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CF720656
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2XAtqiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXN6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXN6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 09:58:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0225AC0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:58:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so8426203wrw.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UmW4ga3QaXp6kA1e4Jimqdqjy/6x7wNK7e3iu56KKCM=;
        b=t2XAtqiSowbzN4oF/3AKCc7Ycf7Cv4sjGRQ9ti9U/YY9kly3oFSwKUkT19x5LEdAmr
         nutXgME63F7dVGM3nhCoCrdKxloBbLWffffqSUjTqZWY5qIpyBseJcbTq6fPcd54A7CX
         ZV3o/8g9wpeRXU/+P8rjjyA9x2MVuX6oxQKIBEdjvnmfy456fQFBdehQM45z6hpEPRL0
         y8+1DXldhBRBdItVXMvrU2gqbIH2I+PAu3pHBGFBRAPzfRdnszh17aYr2paQAq4+i9AY
         mZREq4rOJozp2njmccumPCSPWK4MiOTq0kSx1vi6H0d01hC/npjWpd8EhoDlQVCnlxTE
         hZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UmW4ga3QaXp6kA1e4Jimqdqjy/6x7wNK7e3iu56KKCM=;
        b=HPeoE1RReohE1BQTvJCgVvfvYowl9DIJPO+A5dr49LdwjWzHHrCZP8tGTnECWvujNz
         7Y9ZE9AoasvBL+CFsTl1x+tDYs3vrzglz/k4sNyrJJaLP8Lia7fCI3F4gjnNI1Xr/w2G
         CMB2CMjBFOQXabCH65jFlXArJq5OWFaNi2hbTkWo+uOy4N+l+erK3x0XsJfmSkUIb7i7
         3M+UjrZaeOWJOYQOP6tmYbK85inr3bjKIV1yFj7iBhASdC7KkSbMJtcrMltXcUoUGM6s
         3HOOjVsXKg6oCi3epYrwhZJ3CeHz3NPG/pnYmFrVhpi0KvVzFPxt86gbCP7dHYaW6NvB
         kpww==
X-Gm-Message-State: AOAM531j2KKQK/+2AOcYK0kGLGHcK2cVrzK0gNrwh0yuqk6Fen5U+06O
        U0Fnzt1M2V0kMCrQtCUSlFPvKVRi
X-Google-Smtp-Source: ABdhPJxhL4n1TxaUSXs3fyuaiCUw8tNfwckTE0IPVNbngxwQpqtpvik6ZCuTbLFY0ZiXR2QKHG/3Iw==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr8810722wrv.208.1595599078635;
        Fri, 24 Jul 2020 06:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm1388270wrv.24.2020.07.24.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:57:58 -0700 (PDT)
Message-Id: <pull.681.git.1595599077623.gitgitgadget@gmail.com>
From:   "starlord via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jul 2020 13:57:57 +0000
Subject: [PATCH] githooks.txt: use correct "reference-transaction" hook name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        starlord <bojun.cbj@gmail.com>,
        Bojun Chen <bojun.cbj@alibaba-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bojun Chen <bojun.cbj@alibaba-inc.com>

The "reference transaction" hook was introduced in commit 6754159767
(refs: implement reference transaction hook, 2020-06-19). The name of
the hook is declared as "reference-transaction" in "refs.c" and
testcases, but the name declared in "githooks.txt" is different.

Signed-off-by: Bojun Chen <bojun.cbj@alibaba-inc.com>
---
    githooks.txt: use correct "reference-transaction" hook name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-681%2FBerger7%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-681/Berger7/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/681

 Documentation/githooks.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 642471109f..31b601e4bc 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -404,8 +404,8 @@ Both standard output and standard error output are forwarded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
-ref-transaction
-~~~~~~~~~~~~~~~
+reference-transaction
+~~~~~~~~~~~~~~~~~~~~~
 
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,

base-commit: 3d20111cbd42c9ef3116bb629838bcbfea508cda
-- 
gitgitgadget
