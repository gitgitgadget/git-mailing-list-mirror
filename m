Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08302C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4BB60FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHQRuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhHQRuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF6C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn28so20784405edb.6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTOzSdXfaMNpy13J/Z0C6abhKDwlJKUMFqOlI+nAtzg=;
        b=E+i4xqnbVeo2oaGcrd3+LeGN/9L1H5D5bi2zuFGpfQFuygfJJVw52LSZJD6Mn90FFz
         RJipwMAHiqmnmyBOstUVw3jzgbnz1S45lrEYnztwutUbPzhDjcKRMkYZ6fsIpokVX+Xj
         Hil37/OUQ+FJGPI7sewxtpWqPls7JPEwzeZ91tyMwfeXLvCk14sATnCyFhiQGS4OGBaa
         A6CmXDTkC1nkA7F6CJyXN8qy87sgR+jGV54DliP1FU/ONWzv8oazizBdZCEBSriaSjMr
         p5M+4m2ylzjan0o8vVEkWdktzGQCaK0D38JRUlJtUBcv3z/qgDLImH1qyI3QxcxFSamw
         V+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTOzSdXfaMNpy13J/Z0C6abhKDwlJKUMFqOlI+nAtzg=;
        b=DJxD5d7mrB3T0aqniQgH4D3uCHtbaxLyL8BTy3bD0XoCMCuUT8art+92vNjqChHYqC
         H+VOihozwjc24aL/xreOJ5rYf539ZrOCzjjNEbZxMEdVHNuOVETv9xQMhH9xhtYC0TMi
         dL8GdJH35r6yLAW1G1Ovfve9EI+qzpXFJHInUVL4xlF9lBPx3JRaYsG1Z1oFh51Mi1jX
         A6CCSKvxTy996MKFvoLLJUknBFjpBzI5Ext1zPWwLXBy4GbnSO/VXsjpJyjqeuEVe9PS
         DbOmfecc1xRGDKIAEbRUCzVvbJ8a375Oy/F9F4YkiIoADCrZpimr866wy/tOI9wXqbef
         +dEg==
X-Gm-Message-State: AOAM532tHqBI0WTccTqp+dfEMFDV3WK/cxAAsZyR+EAoj+jvocOjpqyb
        MJD/rMNhveU7OkKU2A1VTg6tuZhsobo=
X-Google-Smtp-Source: ABdhPJzC8vkZYhiGyhAc2ZsF3ndoMKDyKTLgvMLsXQTZteGWoSm+OUQ2bXiwyzwo34csrHp+GMr1aA==
X-Received: by 2002:aa7:d681:: with SMTP id d1mr5590002edr.186.1629222588971;
        Tue, 17 Aug 2021 10:49:48 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:49:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/6] Fix GIT_TEST_SPLIT_INDEX
Date:   Tue, 17 Aug 2021 19:49:32 +0200
Message-Id: <20210817174938.3009923-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running tests with GIT_TEST_SPLIT_INDEX=1 is supposed to turn on the
split index feature and trigger index splitting (mostly) randomly.
Alas, this has been broken for ~2.5 years, and it hasn't triggered any
index splitting since then.

The last patch in this series makes GIT_TEST_SPLIT_INDEX=1 work again,
although it slightly changes its behavior; see its log message for all
the details.

Patches 3 and 4 fix old tests that started to fail because
of this slight behavior change.  Bsides the final fix, patch 4 is the
most interesting in this series.

Patch 5 fixes new tests that were introduced while
GIT_TEST_SPLIT_INDEX was broken.

The first two patches are just minor while-at-it test cleanups.

SZEDER Gábor (6):
  t1600-index: remove unnecessary redirection
  t1600-index: don't run git commands upstream of a pipe
  t1600-index: disable GIT_TEST_SPLIT_INDEX
  read-cache: look for shared index files next to the index, too
  tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
  read-cache: fix GIT_TEST_SPLIT_INDEX

 read-cache.c                       | 37 ++++++++++++++++------
 t/t1091-sparse-checkout-builtin.sh | 25 +++++++++------
 t/t1600-index.sh                   | 13 +++++---
 t/t1700-split-index.sh             | 34 ++++++++++++++++++++
 t/t7519-status-fsmonitor.sh        | 51 ++++++++++++++++--------------
 5 files changed, 113 insertions(+), 47 deletions(-)

-- 
2.33.0.453.gc5e41af357

