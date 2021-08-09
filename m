Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EBC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C6360F4B
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhHIBjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhHIBjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 21:39:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA668C061757
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 18:38:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y130so4096081qkb.6
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3mamOcQt6XTALFKqv3Qy0G2fc7C/95iCAKvI0ZJlVg=;
        b=qhlUhSUFkrBZfVQ4+FceZNK6gAB1bSAjnr050q+dF93/pU5oKNKe7ohDjvzkMFFbTH
         sun2timq08VS9LXsDEMqJw8CMTZNB8e2OQBnT//fzpsa6CZPFdSlhWiUnWsPWWYx1zzJ
         7K1drBDVkosbXdSdat9lhBp0G/dzzVte6Fz5Zl7gXUnI0GdMYBlDpoTFkkMuTo1bZUZz
         wTLGC9mtaznEeKkMMDGqXVxKIiRmNbPdxhhXMyWhCsGtCcNS8ELQ2gAZ1Vp3P9B+x4aC
         syfw7KNpPU7Qomu7rggbDd2jZB+RySdxDOn6RbygvQFEq+WeBF/JCHRM/B1eMBfEpt1+
         XZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3mamOcQt6XTALFKqv3Qy0G2fc7C/95iCAKvI0ZJlVg=;
        b=rClqiorMGCGds9NOjdtwBtUDvyulcQwhn7ADA6rFq6gbx0+sBAHMDhxYwKVilmN1zq
         q1WlN9It04FlDuK0oWXiG9/89AIq4RUJuYORl7RYWtoYVJt3kvr0QgzT2GKyNMlzNeT0
         UPcMKgn8Pc2x8Y1DII5VlCwzGVJneITEVQVEbm1HjhhlHVFyQLhrEOGbWcKP0wPQhiRd
         Nr/3xHkYxsJApj78bWC6b+6hK+Xx9pnfmos2JZhwBVlmIgTORIm9urt5qz81VM1mC7gs
         gWJNI9ko9ZG/Kg3j+nZuRWhd8u+Y+UGWQYsTPnKpPNGW0YPyoKoKu6Urxq43XLEsbljb
         u79Q==
X-Gm-Message-State: AOAM530lUXguAJhqWRVHrY4xZ2aNs+h1eqjw9CEf+Fauac6jrTeqgLiE
        IhV4W2Zg+ubkG+FFgedQRI1ktYP7pZ0=
X-Google-Smtp-Source: ABdhPJyFrH2ThhkOFVUyAsjHkiPdbYl63yMccVAaYcfrMmEAugMJh7Ecc7s8qr6kDHajAvoC5icijg==
X-Received: by 2002:a05:620a:84e:: with SMTP id u14mr20758528qku.368.1628473128794;
        Sun, 08 Aug 2021 18:38:48 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o16sm1279492qtq.95.2021.08.08.18.38.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:38:48 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH/RFC 0/3] pedantic errors in next
Date:   Sun,  8 Aug 2021 18:38:30 -0700
Message-Id: <20210809013833.58110-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building next with pedantic enabled shows the following 2 issues that
were originally in ew/many-alternate-optim, apologies for not catching
them earlier.

the second one could be skipped, and has indeed another similar case
already in seen which will be send separately.

the third patch adds a CI job that could be used to detect this issues
early and that adds about 5m of computing time.

Carlo Marcelo Arenas Belón (3):
  oidtree: avoid nested struct oidtree_node
  object-store: avoid extra ';' from KHASH_INIT
  ci: run a pedantic build as part of the GitHub workflow

 .github/workflows/main.yml        |  2 ++
 ci/install-docker-dependencies.sh |  4 ++++
 ci/run-build-and-tests.sh         | 10 +++++++---
 object-store.h                    |  2 +-
 oidtree.c                         | 11 +++--------
 5 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.33.0.rc1.373.gc715f1a457

