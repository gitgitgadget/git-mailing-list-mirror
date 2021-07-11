Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9581FC07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4EC61186
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGKAtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhGKAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:49:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230FC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so11573652wmb.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFJqnwULCVukTlrrWyfeZvm14/BArFR/3W8qUDIQFHg=;
        b=VasLHMdklBoKydGAtLnyLfNLQFJ7vHc/tp4s8WvRvk1/cPoFxIqZQy2GIwcjY8KWgd
         +b7HxKyvsvFSmfTu9/gYNyg/IXnsgyGzQwqg7KOM1XLoocX4xIjxezqvREnqVeKQmF2U
         FVEgyiyaHfVc7pVRoaGeiK60wIyFeAvTrZkj0ZXvtKKUJbhP8E8WJsejCANxQsb0ppDA
         soYnKa8dKibbr1fXdXZg2SHycnQ4cI0oIx/GCDyjJj9xy+vc/J06vLK42Kpr8ReaTrrs
         sO/ryffNRXbuVdLcGp8Dits6QZMmlO6xOXPTphgP7g+WXTpdqJLBI9XSy6nDheDUxYRU
         02Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFJqnwULCVukTlrrWyfeZvm14/BArFR/3W8qUDIQFHg=;
        b=RO8Z3n0wcT5s1jJHOnmSJslCPBpe/RQ9JWjSKHQ4tjS5yrNgsHwjSKQUBbqP3jyrl+
         Q40abM2MntZBy8Sn7tLJFxZCBwDsm6eWXXGGuUnxGIiQFg0OP8jl6sMUzQiYFuRagjtI
         p+98zwUr/M0iY4x7zB8xUuqfd0HFXSHbQOXNL0y9v6Ig0pEnAg3PhqsiBUX4BF24By8s
         UOxvY7dkLGmN40ZcEv07rLXgMQ4DXF1or5KqKZ+8iu9CV+hTrnSi6SyDEzJR8umu4mEB
         SllF9wJIhFzPHPCQ2eStajTaBqcGP0LUiXlrNWDIkDOAs5RLwxg00V/i5wKvNZ7Hzrfb
         x48Q==
X-Gm-Message-State: AOAM533zkYtZQrhCB4BpCE73C9hgPhgp1lx1JsWFyYipTzWuBCL8QMv+
        T0XIsPjLIoLhiIxoX/MdZUJAQHWnrtQ=
X-Google-Smtp-Source: ABdhPJwSS0NLBlF6tM+cDLYhskqsUtW6Jl2z1es59nz0q9d/6evSXeSO+eFrommndNxtm4NW4PkcCw==
X-Received: by 2002:a1c:7411:: with SMTP id p17mr6759616wmc.116.1625964401638;
        Sat, 10 Jul 2021 17:46:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm8562859wmm.17.2021.07.10.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:46:41 -0700 (PDT)
Message-Id: <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:46:38 +0000
Subject: [PATCH 3/3] diff: correct warning message when renameLimit exceeded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The warning when quadratic rename detection was skipped referred to
"inexact rename detection".  For years, the only linear portion of
rename detection was looking for exact renames, so "inexact rename
detection" was an accurate way to refer to the quadratic portion of
rename detection.  However, that changed with commit bd24aa2f97a0
(diffcore-rename: guide inexact rename detection based on basenames,
2021-02-14), so now the correct way to refer to quadratic rename
detection is "quadratic rename detection".  Fix the warning accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 52c791574b7..343f391edf8 100644
--- a/diff.c
+++ b/diff.c
@@ -6284,7 +6284,7 @@ static int is_summary_empty(const struct diff_queue_struct *q)
 }
 
 static const char rename_limit_warning[] =
-N_("inexact rename detection was skipped due to too many files.");
+N_("quadratic rename detection was skipped due to too many files.");
 
 static const char degrade_cc_to_c_warning[] =
 N_("only found copies from modified paths due to too many files.");
-- 
gitgitgadget
