Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B14C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DE3206F5
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 00:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3PstvP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDEAAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 20:00:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDEAAV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 20:00:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so13038561wrx.9
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f5IBpfD9Dc75+tINU8UByTh87uUynzM6nnGf9/9Xhzs=;
        b=k3PstvP1vzz48EMUkqUb7yRm2vcFT3ZFvHHF6GW0/PtzGqsZpkr6sWia+YMfMIAy53
         rYBcLr2vcHYIw4/zE182eYm/tL+cYFIlilDNAUy3NI1u7JygFrIKsxoe/6k7gcGv7dqk
         sVc+7mycYmgv2zCBfvFOH3Dt7GtNtC2XeV3QFL64uwrX8Tty4UpSDYy9RG6hPO+TGWM+
         x+js00J1JNaNVsjAKyO1LAB+biPx/pmYiTWU+tEEyc2koi6NY4+vtYrmEY2EPMCmBIoH
         PW2Do2EQgx/cBSlwMO2Jp2xDUS3A3BSsqXEl/knIfPgcTXdk/9SNq92er3EzMx54lo/J
         dcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f5IBpfD9Dc75+tINU8UByTh87uUynzM6nnGf9/9Xhzs=;
        b=IzTXQF6QRy9jv11PnyNY5Xa4MDv4r4H9pV4pjlPnmzw4u/HhTTBNYMVvbgY3ewlBxh
         C4ilDeJw3AQsLgjWmuEwv4BzQud54nHt1O+zl9h9QvnukN0aoOlqSPw8rCKetIXbEu52
         S9w1OM0s5rGqO79hKqe2zK0Yxrz58sZz0Vp6qNCCv/1Ku4k3Vk8DGUBnbIzBSY9USo1r
         jN+n6zS8X1NHX5x9hbf4iBEPwv6YrB+sMaXA5ZitN3lc7A8oWTq59b7iN22n3mWReOBk
         SuBmZEQYJ/yK5rfdPSAhCaZIGjDCQjNzlW1XfLf6SFjLB6cNa8gFB2Bcea8dUlXS9O2/
         IkLQ==
X-Gm-Message-State: AGi0PubHsKiBftrkRGzdkna3Q8lPOWcWC56X6NoxKSrGrBKOWEjKofd/
        Fb/H6zixgwTdFZfCXBMZiE5CrCEJ
X-Google-Smtp-Source: APiQypIJZo6qvbKCEbw1XjBLIBe6sxOtImTXFZAilJ8Pf3QPV95aehTccrPPuf4Q7IFbKBgw+guaXA==
X-Received: by 2002:adf:e703:: with SMTP id c3mr16030272wrm.112.1586044819202;
        Sat, 04 Apr 2020 17:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y33sm2873804wrd.84.2020.04.04.17.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 17:00:18 -0700 (PDT)
Message-Id: <pull.749.v3.git.git.1586044818132.gitgitgadget@gmail.com>
In-Reply-To: <pull.749.v2.git.git.1585963816430.gitgitgadget@gmail.com>
References: <pull.749.v2.git.git.1585963816430.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 00:00:17 +0000
Subject: [PATCH v3] git-rebase.txt: add another hook to the hooks section, and
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
    
    Changes since v2:
    
     * Corrections to the text pointed out by Phillip.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-749%2Fnewren%2Frebase-and-hooks-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-749/newren/rebase-and-hooks-v3
Pull-Request: https://github.com/git/git/pull/749

Range-diff vs v2:

 1:  45a5c1c1ff9 ! 1:  22fb6ff7080 git-rebase.txt: add another hook to the hooks section, and explain more
     @@ Documentation/git-rebase.txt: Hooks
      -while the merge backend has.  However, this was by accident of
      -implementation rather than by design.  Both backends should have the
      -same behavior, though it is not clear which one is correct.
     -+while the merge backend has.  In contrast, the apply backend has
     -+traditionally called the post-checkout hook while the merge backend
     -+has not.  However, the calling of these hooks in both cases was by
     -+accident of implementation rather than by design (both backends were
     -+originally implemented as shell scripts and happened to invoke other
     -+commands like 'git checkout' or 'git commit' that would call the
     -+hooks).  Both backends should have the same behavior, though it is not
     -+entirely clear which, if any, is correct.  We will likely make rebase
     -+stop calling either of these hooks in the future.
     ++while the merge backend has.  Both have called the post-checkout hook,
     ++though the merge backend has squelched its output.  Further, both
     ++backends only call the post-checkout hook with the starting point
     ++commit of the rebase, not the intermediate commits nor the final
     ++commit.  In each case, the calling of these hooks was by accident of
     ++implementation rather than by design (both backends were originally
     ++implemented as shell scripts and happened to invoke other commands
     ++like 'git checkout' or 'git commit' that would call the hooks).  Both
     ++backends should have the same behavior, though it is not entirely
     ++clear which, if any, is correct.  We will likely make rebase stop
     ++calling either of these hooks in the future.
       
       Interruptability
       ~~~~~~~~~~~~~~~~


 Documentation/git-rebase.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..5a756b5b3a6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -684,9 +684,17 @@ Hooks
 ~~~~~
 
 The apply backend has not traditionally called the post-commit hook,
-while the merge backend has.  However, this was by accident of
-implementation rather than by design.  Both backends should have the
-same behavior, though it is not clear which one is correct.
+while the merge backend has.  Both have called the post-checkout hook,
+though the merge backend has squelched its output.  Further, both
+backends only call the post-checkout hook with the starting point
+commit of the rebase, not the intermediate commits nor the final
+commit.  In each case, the calling of these hooks was by accident of
+implementation rather than by design (both backends were originally
+implemented as shell scripts and happened to invoke other commands
+like 'git checkout' or 'git commit' that would call the hooks).  Both
+backends should have the same behavior, though it is not entirely
+clear which, if any, is correct.  We will likely make rebase stop
+calling either of these hooks in the future.
 
 Interruptability
 ~~~~~~~~~~~~~~~~

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
