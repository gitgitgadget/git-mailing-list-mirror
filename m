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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D7FC4332E
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3266964F77
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhBBQ1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbhBBQWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B9C061226
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e15so2830479wme.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/DncVgEztJPVuz6mC6hrgF0RNBiotUg00UdzjEdkN0g=;
        b=qVU73IJf3q0MEpeVwMcjWqb87R7llM2c/MUGmIl0kcd2ZvcH2hhY8aZxkPO6qxiqQh
         jTj5usLBLZPezO1OhZ+EVPb3Zmye956BsSEJJAGEhIFIW01BgU/zlTOc8y+DqWFB4R4P
         DZb7QpMXDuy1tyyv5XrNKVjCEL+ZOAlVJuLixtkjFBBqQS3SfM8u1xrP9Zyyi3cUqlpu
         g06366NE6AJFvoBvEgE7xxvvZx1QWfgRW8gIdrAdlGdsQPb2SnXqFIga1QwYpoik00EB
         64/V7Y+pEE9W6+679Hlb3DCABkG3aajFExrGxgoR9yqOsRBWvrE9tw8oq2R6uAiHewE0
         oPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/DncVgEztJPVuz6mC6hrgF0RNBiotUg00UdzjEdkN0g=;
        b=s86h7POJtLjSgccl1LB6LkD2o9+8zXHJ0Xl+ECs1uR9Hvj1BOQBIPhJu+Bb5EHe65M
         zcgH9TPjddqt+L5fzHUp7h9WqpE6BmFY1QnXVsux7lzXCjBIIZVvlKVnVkWRHNI/SikI
         ZRB7EmDL16y5oiozrftqHhoXEUo5n2MkKkLjVehMW+h8UqOAMpQv3OrBNrzV3R/ZeV9o
         vA16xgJzT6htSJPUiGdS/I4T/01xMGZA/51vjOnulopvb59H5JjkYIr4TrGGx6qGlRdq
         rB63dBFYmymbPSE9NtGVRta34KYoGgx9QSIfq9sjvPmEb1XflsgOGtJZKEKuNyXZfxmT
         hd5g==
X-Gm-Message-State: AOAM5306zAoHMBSRLNJvte/S2Twz2AWUwdd7PH/sMEGXL+uimQRtzFaS
        qSDTOhAC0pvUOa/eYSXwhiG51n+9sdk=
X-Google-Smtp-Source: ABdhPJxmUkvuAF0CJwUAM5LCuwXWSsDh+Ev0/P5nVDn1v2TJcHFmIK4iPiVGC5eXvcz89tFUP5POsQ==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr4301804wmd.40.1612282755725;
        Tue, 02 Feb 2021 08:19:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm3526269wmq.36.2021.02.02.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:15 -0800 (PST)
Message-Id: <4f622fffcc5d42ff202c7de530a7805d41cd32bb.1612282749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:06 +0000
Subject: [PATCH v2 3/6] doc hash-function-transition: use upper case
 consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Use upper case consistently in Document History.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 .../technical/hash-function-transition.txt         | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 51acf2c10b7..2eba25cf87c 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -794,8 +794,8 @@ sbeller@google.com
 2017-03-03 jrnieder@gmail.com
 Incorporated suggestions from jonathantanmy and sbeller:
 
-* describe purpose of signed objects with each hash type
-* redefine signed object verification using object content under the
+* Describe purpose of signed objects with each hash type
+* Redefine signed object verification using object content under the
   first hash function
 
 2017-03-06 jrnieder@gmail.com
@@ -814,13 +814,13 @@ Incorporated suggestions from jonathantanmy and sbeller:
 
 2017-09-27 jrnieder@gmail.com, sbeller@google.com
 
-* use placeholder NewHash instead of SHA3-256
-* describe criteria for picking a hash function.
-* include a transition plan (thanks especially to Brandon Williams
+* Use placeholder NewHash instead of SHA3-256
+* Describe criteria for picking a hash function.
+* Include a transition plan (thanks especially to Brandon Williams
   for fleshing these ideas out)
-* define the translation table (thanks, Shawn Pearce[5], Jonathan
+* Define the translation table (thanks, Shawn Pearce[5], Jonathan
   Tan, and Masaya Suzuki)
-* avoid loose object overhead by packing more aggressively in
+* Avoid loose object overhead by packing more aggressively in
   "git gc --auto"
 
 Later history:
-- 
gitgitgadget

