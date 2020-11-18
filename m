Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E329CC56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED22225B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKL5P1TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgKRT0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKRT0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:26:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336CC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:26:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so3353224wrt.4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Pb1g0labPd9S8JYkIOuVXI/tu3oUpuX/P2m7OmA4wHc=;
        b=IKL5P1TClhZXaePfzq/ONfibg+FLQFCZ5R7uilUjsbUsh8a690kHzh8V/aBVBsv4yZ
         rTXaEOJdl4WYwGQn0mtI60/sTL0ek+nKBQzzmzFFTRzOJOrJvTS1rMhbMFRuA3CiH1Qu
         mhYKQ4QI2dfZ8e0STcYAE/HV1yNn9c3tIQXU1i+NzKY+Vliu9Awf2VqXSzDtcTaePdGF
         8M1xXlWoQp5XTrkVLRqrgmnsljVLHK4nz4zQdqxfxUMfspGwr5Wqrbtk+OoNVxNkAkwI
         VGsHsH9zAIzZVuPRLWkg0YA3LR8UEX7pB6YUktA/CMsBT0BzxXsvT/N1jgAkEUppG4dj
         jrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pb1g0labPd9S8JYkIOuVXI/tu3oUpuX/P2m7OmA4wHc=;
        b=TSD8m0sdYqiQ/AaaSaKQNrrZD4+Zr+GUMoxhlKKFda7zIYY82zbgIUeblqUe4yld6d
         0oP/p9Si4R6WApmL943Q6y4/ocD6+KHXP2fZkQDMyQjirAebecyBksj08qn90u1hJa7Q
         2Q3Az2jcgos94IEKl08IH5sviSI4zbELbd44nGNtU+If2gjPh9pvN5LrBKSkaVdhwP8t
         +ATvvJ6wm56APlKsDe35FxKA61Xq0kdM9+ixj++SVbF3QTkitW9n57qbT+QTT8ANTrAV
         mg2LaFpCxy4TTp1QYvB+/4pw/WtyMN52/Tkzu1uDYGTkSnDosWUxA+q/kijtVo9mrXn/
         3qeg==
X-Gm-Message-State: AOAM531qq6s2G36WhWFE0MsFZFo/sgTKvAcD1plC87hGLGzQuGBfCNYr
        wTaFpJvHzPR0by77e3YKWYH9AP7dfQo=
X-Google-Smtp-Source: ABdhPJwKYkB3iQZttIVjOF1v+5naFYuKNgSOfTLoNW9tLU1YveI8gWVJ9kJIZX6kyqqhFfx9z8uDNw==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr6743043wrk.71.1605727594937;
        Wed, 18 Nov 2020 11:26:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w186sm5143019wmb.26.2020.11.18.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:26:34 -0800 (PST)
Message-Id: <pull.794.git.1605727594021.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 19:26:33 +0000
Subject: [PATCH] t4015: let the test pass with any default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not need to hard-code the actual branch name, as we have access to
the reflog and can be a lot more precise at what we want.

Strangely enough, this test case would have succeeded even with an
overridden default branch name, obviously for the wrong reason. Let's
verify that it passes for the expected reason, by looking for a
tell-tale in Git's output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t4015: let the test pass with any default branch name
    
    Aaaaand another issue, also found while working on 
    https://github.com/gitgitgadget/git/pull/762.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-794%2Fdscho%2Ft4015-and-default-branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-794/dscho/t4015-and-default-branch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/794

 t/t4015-diff-whitespace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8bdaa0a693..c9dd62b70e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -883,7 +883,8 @@ test_expect_success 'combined diff with autocrlf conversion' '
 	echo >x goodbye &&
 	git commit -m "the other side" x &&
 	git config core.autocrlf true &&
-	test_must_fail git merge master &&
+	test_must_fail git merge @{2} >actual &&
+	test_i18ngrep "Automatic merge failed" actual &&
 
 	git diff >actual.raw &&
 	sed -e "1,/^@@@/d" actual.raw >actual &&

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
