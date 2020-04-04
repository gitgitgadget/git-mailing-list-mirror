Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D503C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1972064A
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNgDaEM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDDBaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:30:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDBaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:30:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so10578421wru.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5xlOEeaweIS0hX4ka57ZmUlUepFN/42qcj78btArVJQ=;
        b=mNgDaEM9FrQB/8D7zFZOR5Sti0HOt8Pd0EmdF2i5n2LGZ0wL2e3QWAgXISrw5zivX3
         QfyUHPBRHqv/zhuPREeHRAtiuvrXCxB5g+XeGX/NQqv283I1ScDCUQb+u9vtkWXtP3jY
         zVLq+gJBKokgbNxb4KMKK7Fa2Fg5EOKIBxUaLpc6c+oTCgasc4dgkjJKNoRwcUF/ZqZx
         O2hkKsHZEy4kD3uQ7biPAvOC8ri8SIq1oESYV1rJSxaKopPtpUoOEGtA4X+4CBJkSuNh
         h9aYyha7tgt/92x3bbnrJwHjnKXkvrsoBcYGHJcCR2kEl6Sh9/mUgqwNZca4gPmGsMDU
         LY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5xlOEeaweIS0hX4ka57ZmUlUepFN/42qcj78btArVJQ=;
        b=KoxYp3D9KTRS+wwfG6EqyW0SbjJfVo6Li78kX7klJNU3qYFVvtRsdbteEr/Jlwk5vf
         f34Y+RxEqO5uQjh5R1FsjbA5q9piHJ9kVqDPGF7hGfAhyVfaynPq2xPgmvK/Sgq1Rq3t
         3yTNMlwq2PwfJ39FFwj7qHOw+6QMNY3VVDPF9XgfoRePFyxgkAa2Nli8b8Gwwc84AWDp
         TvtdfYFN9BR6bl6mI1+Gg13Cpp06+Dq1sVgJ+O4uMS01G8YY4G1i8SjmjmGESWQERsNE
         lZEmMcdGylJdE0Ako2LjKJ0BeOm/PsFGpBIMSIhxoMvlzzPICBnAC7MXhVG2bO7zrlOU
         0e9g==
X-Gm-Message-State: AGi0PuZPvjRShpMMfCIcaOu6dYTVfxUMpB1Tacqsk39HfkEajOkf1AhI
        CP7q1y4JuGgcVsQpTLF/JqvsbZty
X-Google-Smtp-Source: APiQypKfzFF66MRP/95ofNfnIN+kAjWQzyg/HjwiCkGidZUWQjti4e6INxBd+tCDZxlaWwANOaeBvA==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr4909841wrt.326.1585963817531;
        Fri, 03 Apr 2020 18:30:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm14532650wrm.87.2020.04.03.18.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:30:17 -0700 (PDT)
Message-Id: <pull.749.v2.git.git.1585963816430.gitgitgadget@gmail.com>
In-Reply-To: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com>
References: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Apr 2020 01:30:16 +0000
Subject: [PATCH v2] git-rebase.txt: add another hook to the hooks section, and
 explain more
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, emilyshaffer@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For more discussion about these hooks, their history relative to rebase,
and logical consistency between different types of operations, see
  https://lore.kernel.org/git/CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com/
and the links to some threads referenced therein.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    git-rebase.txt: add another hook to the hooks section, and explain more
    
    Changes since v1:
    
     * Updated the wording of the last sentence as per Junio's suggestion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-749%2Fnewren%2Frebase-and-hooks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-749/newren/rebase-and-hooks-v2
Pull-Request: https://github.com/git/git/pull/749

Range-diff vs v1:

 1:  29a1ff520ba ! 1:  45a5c1c1ff9 git-rebase.txt: add another hook to the hooks section, and explain more
     @@ Documentation/git-rebase.txt: Hooks
      +originally implemented as shell scripts and happened to invoke other
      +commands like 'git checkout' or 'git commit' that would call the
      +hooks).  Both backends should have the same behavior, though it is not
     -+entirely clear which, if any, is correct.  We will likely remove both
     -+of these hooks in the future.
     ++entirely clear which, if any, is correct.  We will likely make rebase
     ++stop calling either of these hooks in the future.
       
       Interruptability
       ~~~~~~~~~~~~~~~~


 Documentation/git-rebase.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..5e0fcd4e9bd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -684,9 +684,15 @@ Hooks
 ~~~~~
 
 The apply backend has not traditionally called the post-commit hook,
-while the merge backend has.  However, this was by accident of
-implementation rather than by design.  Both backends should have the
-same behavior, though it is not clear which one is correct.
+while the merge backend has.  In contrast, the apply backend has
+traditionally called the post-checkout hook while the merge backend
+has not.  However, the calling of these hooks in both cases was by
+accident of implementation rather than by design (both backends were
+originally implemented as shell scripts and happened to invoke other
+commands like 'git checkout' or 'git commit' that would call the
+hooks).  Both backends should have the same behavior, though it is not
+entirely clear which, if any, is correct.  We will likely make rebase
+stop calling either of these hooks in the future.
 
 Interruptability
 ~~~~~~~~~~~~~~~~

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
