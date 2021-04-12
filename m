Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC8C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6FF61353
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbhDLRQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbhDLRQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBCC06134B
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a6so13748937wrw.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PEXjuWsuVll7qs/VYR2FsmSiJrsJAjUtPvW8e2AvYI=;
        b=rM84Ptx5eXpM/wKDBJ/05Yt7SztSM3RUY3aUJC6Kky4Ue0TdUmffYg9cEy7dFh4xYX
         ybaRozPPrw1r3bcn/jn+ypUHQDQ9Qem5Cgb5pQ4Yzxc/ky5CE3kx3uhJGUcFngjqaF1O
         Y1f+WfxWEGEM+yzTfMQaE5W5mmyXNOdd8edcyVu0hBw594+4QT2tAx0n8yZE5PBU0Ul5
         35Vkx9qIZC+lSysgTBkAiZBBSHiuqPml2dFkBSoFv3ysYnFSsyPy5bpFq7MXNNxiJ3V0
         A6uhUhHuKnrHq8fl32WEBdAW05p3Y21oU4oHcw4Z/AaupurbSXvy3906xpVT9QcyGwx8
         J0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PEXjuWsuVll7qs/VYR2FsmSiJrsJAjUtPvW8e2AvYI=;
        b=Kd8owzsWpBc4H1HUFCK2/UrhZ98IQLqX49LsAWO9KBgQ44QEAYzD560dpoCHj+k2E6
         lxs04UlcGnnqZM8iJOkM/VdnB59zWYI9/GdLgddNuqbD5UFFjws5T7qy7BegIjHrxFnu
         Sw7fU+M6Y4fL1FBzpLgA4Y+4sI6+YLZslxIPlXldvM1zOJZojMTkbeeFADgsEUdVT2iX
         N3SipscNHifcb8gHtXAzAkBAWtJ7yuDoxWMMz9bhPZHsxPhi//In6ZzqLXni06aZcsqe
         lnd0dFga+eKXXmmrFbPuWZD32ymx7kzNgBLOkeqZJMP8y0wxMporT93DxnA7v8HCpxq8
         a6Lw==
X-Gm-Message-State: AOAM5332swmotF2yWMYskmKtrPFIoTH7gsNEx+Cc4PRlDqXx2jbiBPng
        qcsYPTD3bRjmvaWJoZ5Vm0xbHeHMKUhy0w==
X-Google-Smtp-Source: ABdhPJy8nyT0d97mwzZaq8B+zxFbTl8/tEEEqf+tREicCtK235zjJGJs+92nKS0M0k7S7CQYYWlIAg==
X-Received: by 2002:adf:e901:: with SMTP id f1mr1577157wrm.44.1618247749538;
        Mon, 12 Apr 2021 10:15:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/22] pickaxe: rename variables in has_changes() for brevity
Date:   Mon, 12 Apr 2021 19:15:22 +0200
Message-Id: <patch-15.22-10f85edcff7-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the {one,two}_contains variables to c{1,2}. This will make a
follow-up change easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index be0dd683b63..23362a23597 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -108,9 +108,9 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
-	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
-	return one_contains != two_contains;
+	unsigned int c1 = one ? contains(one, regexp, kws) : 0;
+	unsigned int c2 = two ? contains(two, regexp, kws) : 0;
+	return c1 != c2;
 }
 
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-- 
2.31.1.639.g3d04783866f

