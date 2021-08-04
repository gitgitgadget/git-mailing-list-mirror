Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208DC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572A6608FC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhHDF3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhHDF3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BBC061798
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so801008wrv.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o04Rt5/DOWxKgRaMrh3sLG7nb/Yw9viAr/j9cV8uCBU=;
        b=RAYICOSLV7nlIpK9sEheF5vT0q929GKZPGPC1WgqhygNoo63ZHghb8Gi3KT8ng+mUi
         7zXngINdOhIVHgtdg6c5KRONFYotzeX8fGVplna9c/fdHtAJ9fTcb9cQxSwjz31CT7ly
         gK3aOwpBfspBWxc1D3dk56Xo1hUfgWMJ8qaBOAWDnhwEcThSB+s9ilHxzeJqx5reja/7
         Ax3LwU0ZZ6lQQTTPT6wQt19G02NuJsxhuxVcL4E/tEXe+rDGADhyzm27Nixm6CYqmMYh
         mmYJbnW4VK+FNzycaJA305ZLjHWr/A0VNwjqJEBISyi3FdkxW6yo9dvxqKS14Vf3jtZa
         BIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o04Rt5/DOWxKgRaMrh3sLG7nb/Yw9viAr/j9cV8uCBU=;
        b=a/xzPOAZhvM75m4jsuu+sZ/U5e9eQTyvE2wpA/aRr4c6GMmr9v4GWxaV4Ct/ahHQHA
         nXWVhSbbjYrcTnIYSCS9mR9dgXXhjWQkYPeE9anet4oHyJA2Xg8bOVcQEDIX4GVM16lo
         7Zt8MSuTCVPROYCMcc+AZTzQZr7Xue9FtPeUT8MjIYJ3N5wMBOo4ANkagklh3raJXxM5
         LaQi2QkYIwl4c5SLZFpkZ/bMlW1shN+afqaPAHZLgecvA6HQciwapWm/80+Vw/5mufqP
         /s3/CJ5moGChCWRs/QHP3Vta1jaQn/AKF4r8LpNrap+vfbAHiDaAeYAk1lfUpX4gjeIi
         jMBA==
X-Gm-Message-State: AOAM531ALk3/WXuOjlk9MWZkqPq9+ZKPsRGFseTa3KEdCx3/5iQuG5uL
        D2Rvjels46MY+I5l2+88Atk7W/Bf3Vs=
X-Google-Smtp-Source: ABdhPJwB59nlRfEK+hRXPGwgcvJqvzRg9v4Y15NkABo0aAQ/bO3m39tj7w5onF50T0P7MyPJqceJYw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr26502859wrv.77.1628054940339;
        Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm4593523wmb.35.2021.08.03.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
Message-Id: <e422a1bc7d431352c00c940ae87e1e013dcd8b9a.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:49 +0000
Subject: [PATCH v2 04/10] merge-strategies.txt: update wording for the resolve
 strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It is probably helpful to cover the default merge strategy first, so
move the text for the resolve strategy to later in the document.

Further, the wording for "resolve" claimed that it was "considered
generally safe and fast", which might imply in some readers minds that
the same is not true of other strategies.  Rather than adding this text
to all the strategies, just remove it from this one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 5d707e952aa..f100fad1e43 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,13 +6,6 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-resolve::
-	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using a 3-way merge
-	algorithm.  It tries to carefully detect criss-cross
-	merge ambiguities and is considered generally safe and
-	fast.
-
 recursive::
 	This can only resolve two heads using a 3-way merge
 	algorithm.  When there is more than one common
@@ -106,6 +99,12 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+resolve::
+	This can only resolve two heads (i.e. the current branch
+	and another branch you pulled from) using a 3-way merge
+	algorithm.  It tries to carefully detect criss-cross
+	merge ambiguities.  It does not handle renames.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
-- 
gitgitgadget

