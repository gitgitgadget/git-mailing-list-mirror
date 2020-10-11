Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE2C433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C32076E
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgM3NLOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgJKV1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgJKV1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 17:27:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D48C0613D0
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n6so16566146wrm.13
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cnAAHeN/K05lJWsBk7WdmoPF/FD7I+He6a+vcXh5/c8=;
        b=pgM3NLOraeJwVOywO/TzLZpfLHIw7SJx7PzM7Qucsh3d5X6EEhyh7N3xvWppgOY/VY
         GQuMMsRK3nrpI6b7wXMdjlf/EyHVAeHneE8wqacZiiRHaTbilFcGxicSLo8XwkGSIFgk
         bizkuC2bd3qM0ssyWgdVzBmSkdNQmomyDNdwJ2UB03MmO6XKF2Nb9flZfAaGAWRAQQ8y
         5Qs4WBhokSst4LECwFNczck4JP4E3R5k9ilZl1piS+x7Z271KDQxKRacPsURo76CZ5it
         il6nX1FdA+UByZMxCbNdbXydBD/imdFM2XLNHVAYAcMyvOlrLuDOk8MxXMjt8VQh3F7w
         Mpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cnAAHeN/K05lJWsBk7WdmoPF/FD7I+He6a+vcXh5/c8=;
        b=VcMlKfEyDbmpI1z+DxUE0MQrJwI+T0CuHkKNccRetT8/FKXov3ZOGnZM097/66HO7T
         3/eErxGjiqWaH/q+DNPgCYVs3JIIWI3/DNtbzQsKpM+xV/H0fQfuAMeg3pbAQNS09+mb
         eiX9fZW71n4Qv2sIl+GSnrTgubzQGVY7jc4vCML0VDAerP9eDqIqVtYEJ4trnL2idkqM
         cECb1oV5piwOcL6nSrTWx8rZFrOZeNTJ/axwNjXgDyPZaaLVuZPGI9BETJkh7FvQ6SZ7
         FmyJVzOb1SudgkLKKXc5tWPR4x2bfMH7CIZUfStw3+3Uhqh4I421k2rIFHhBf9IaUpDJ
         zwPw==
X-Gm-Message-State: AOAM533ylquKPenbEYQ0XIG7iVUPpvi7kYRtCqwmpSrfPDP6wWTR3cVm
        rA9hfx1qz94kTId3DI+oQgJulT27J28=
X-Google-Smtp-Source: ABdhPJwxcaGrWvmwN22pO53U+ofOSHSUr1VDWMKS2wZpGy45soXb4VcRO4xULYThtG5MrrhOKMvlfw==
X-Received: by 2002:a5d:5748:: with SMTP id q8mr26327648wrw.299.1602451633317;
        Sun, 11 Oct 2020 14:27:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm21862983wmb.17.2020.10.11.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:27:12 -0700 (PDT)
Message-Id: <6c0ba7ec05a41c38176571d675cc9d1ff298ecc5.1602451631.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.748.git.1602451631.gitgitgadget@gmail.com>
References: <pull.748.git.1602451631.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Oct 2020 21:27:10 +0000
Subject: [PATCH 1/2] ci: work around old records of GitHub runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Apparently older GitHub runs at least _sometimes_ lack information about
the `head_commit` (and therefore the `ci-config` check will fail with
"TypeError: Cannot read property 'tree_id' of null") in the check added
in 7d78d5fc1a9 (ci: skip GitHub workflow runs for already-tested
commits/trees, 2020-10-08).

Let's work around this by adding a defensive condition.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0a9acb6a19..d4298878f5 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -65,7 +65,7 @@ jobs:
                 core.setOutput('enabled', ' but skip');
                 break;
               }
-              if (tree_id === run.head_commit.tree_id) {
+              if (run.head_commit && tree_id === run.head_commit.tree_id) {
                 core.warning(`Successful run for the tree ${tree_id}: ${run.html_url}`);
                 core.setOutput('enabled', ' but skip');
                 break;
-- 
gitgitgadget

