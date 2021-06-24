Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71321C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518FD61057
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhFXScg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhFXSc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146ACC06175F
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5271710wmc.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vIVVzv70zjngXywdsD2YTNY+SoqVPvIjSyVb4sXFJzA=;
        b=bd+BCbt2g5TJ4Nlly0Q8LPz2L5IgZwnTrBWTNhQLXCTaIHHJ/U01UU4QYissiUV4T4
         sA2jEP5IMIVO9TF5BlFtLb2pa/I79oYDqv3opr/LN8W6uznhaX+Csmx6D/reQyk+H/qB
         ZUXuKr1ebychjrnioC6MqCOw99Is3nOKekAeye0fpMST7eKKyikndztxkPUkITP8SrSA
         OhQVAvFooFMknPkKhGUSem16eL6P2pBvZN3OfYdrWedkpGaVV8SHfN/tANiDa+L/YKAn
         PMg+UNh29e4A5sDguDkPzH6b2LdTRbqZGbq+VrXDKtNep7tnSBBSDD/z+/Zq26lroDP3
         HjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vIVVzv70zjngXywdsD2YTNY+SoqVPvIjSyVb4sXFJzA=;
        b=fjQpYz0KfeIzo2uvhso8BpFPTg9msHXDn9bc0EifJi+YqyUhR1m5ykglUyxSKW4dIz
         kr+2dHsPgxtAwWK+0SYNQyViaUk9cEnLXwlGNFtKUo6NNEjbhjUfPQWwNqjzn6ruJhXK
         DFHHZh/iM9moi0JiPGT68lLJbiGwDNjf46xK/MtYQ1PB6HrUaW3ET+qkQ04x2BfwwkD3
         QMP/6reGcuS8SLCvpqOMo6NpDebpDYolTWwaSVgUjN6KBzg/G/oxn7WYG+2ryagtuRQe
         DjeUEkN8GFsP4hO0AwvDqI9fYkjkljVJe51p5FXUkvtJBq1cFKzFQkAzydkJthCoH3G2
         8MGw==
X-Gm-Message-State: AOAM5330YUPkMVpQHNTkYsidg0MCCqtujtI0pO/uRPKKje1ANmkIsfKq
        FvqnKkbWwZg+zKAUu07/Xz2nvIvWt4Q=
X-Google-Smtp-Source: ABdhPJy0480RFAtVZCyqHz4jIvBVcHb+EGAHy1bfEau+aTWTcdlJ4bNJK2eLBFK8u6kmqRvJFkohTA==
X-Received: by 2002:a05:600c:1d23:: with SMTP id l35mr4059712wms.134.1624559404767;
        Thu, 24 Jun 2021 11:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22sm8879531wmh.1.2021.06.24.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:30:04 -0700 (PDT)
Message-Id: <d63faad03a4bc41ea778bc4dd61c320e09424cd9.1624559402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.git.1624559401.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Jun 2021 18:30:00 +0000
Subject: [PATCH 2/3] In t7519, populate untracked cache before test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In its current state, the t7519 test dealing with untracked
cache assumes that
"git update-index --untracked-cache" will *populate*
the untracked cache. This is not correct - it will only add
an empty untracked cache structure to the index.

If we're going to compare two git status runs with
something interesting happening in-between, we
need to ensure that the index is in a stable/steady
state *before* that first run.

We achieve this by adding another prior "git status"
run.

At this stage this change does nothing, because there
is a bug, addressed in the next patch. whereby once
the empty untracked cache structure is added by the
update-index invocation, the untracked cache gets
updated in every subsequent "git status" call, but the
index with these updates does not get written down.

That bug actually invalidates this entire test case -
but we're fixing that next.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 1209fa93499..ef75c548d90 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -339,6 +339,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		avoid_racy &&
 		git update-index --untracked-cache &&
 		git update-index --fsmonitor &&
+		git status &&
 		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
 		git status &&
 		test-tool dump-untracked-cache >../before
-- 
gitgitgadget

