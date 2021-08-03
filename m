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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3401DC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1613960EC0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhHCPfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhHCPfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C9C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so25755217wrv.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u3dqx4snabxia0SNBq9ULD2bPtVSCdZATA+JzXm0OFw=;
        b=hYovjg2ybpQcmcjO3e0iZ1c5NR0cAPPYBDBmvW3uJTEQn5Jls7OvOTgcOsYjXRci5l
         cy7/9E/s9PjptRR+Yplt/MAsOiAq6XB0xXTKH2zEBzpSQkTHADnii6+0hrobSldDzct/
         viDP2MCvz0inBgTh6jT5CoG8C5iiKnT0COkdqOG21uSMLe15hDFZLR5TJoyKi5GwgYBL
         q+0t5tN/g2gK/0hr9HZMZM10HDhTCStM+YhO4yopH4C/R8LLRxmTVKvLyWUzfkwmsSFy
         TkBYrZs4pm41Pk2pyZFjECOSm4U5y/LpGUVgB2Tkp7X+8TECc0nZlOeLdB+DhsuDwery
         XlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u3dqx4snabxia0SNBq9ULD2bPtVSCdZATA+JzXm0OFw=;
        b=T/nxLckezyJ9ZtT3tLkvJSFtc7jB2Yha4k6KnK5NWtsXfj0UVKNTjeniRo4A/K1mQW
         3ZiRSQ8VLKEtxjPf/MYg8mvuLzmhHHAgWJzLXLzCj5WCeoEcxcoiXiAie1/Py0Wc2ByP
         r8qtiOmNBF7NDK0oa0lpIOfUWAF+PRJwREwbxM6Tn1h7e6n3FhEqFqqteY9FODl4g5OT
         otpYSALzR/d9rP4v19CbOpaZf1xrMYfaMPWR7u+eFwjZpm2nXLxGY4fbx5x4VUQcBQPq
         ObU2w60I9ku3sxriteB+/JX5+diclsVXadIZJNzmf2RHUGpBpeTzkleOtLD37tLt4jHh
         7hzA==
X-Gm-Message-State: AOAM533etikl/CckiZ1GdfVktHSyXaoat8uwdLUpwmByFk+JdOvJrs7V
        YIKIN1XLHjvZZeZCSmdEM7kZ2ysZ46I=
X-Google-Smtp-Source: ABdhPJwLb1pxUf63/NaUWRcHqv/sWabOkP2Qu0D7bkKPSMSYJjTOzBcLQkYqDpNWmqHyiEs7pwcGIA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr23178621wru.85.1628004928490;
        Tue, 03 Aug 2021 08:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm15563065wre.64.2021.08.03.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:27 -0700 (PDT)
Message-Id: <6116f4750fd228b96ee293033f867a964b87eb5f.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:16 +0000
Subject: [PATCH 06/10] merge-strategies.txt: avoid giving special preference
 to patience algorithm
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

We already have diff-algorithm that explains why there are special diff
algorithms, so we do not need to re-explain patience.  patience exists
as its own toplevel option for historical reasons, but there's no reason
to give it special preference or document it again and suggest it's more
important than other diff algorithms, so just refer to it as a
deprecated shorthand for `diff-algorithm=patience`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index bc82799365a..eb43befac7b 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -37,11 +37,7 @@ theirs;;
 	no 'theirs' merge strategy to confuse this merge option with.
 
 patience;;
-	With this option, 'merge-recursive' spends a little extra time
-	to avoid mismerges that sometimes occur due to unimportant
-	matching lines (e.g., braces from distinct functions).  Use
-	this when the branches to be merged have diverged wildly.
-	See also linkgit:git-diff[1] `--patience`.
+	Deprecated shorthand for diff-algorithm=patience.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
 	Use a different diff algorithm while merging, which can help
-- 
gitgitgadget

