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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2580C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6EA64E75
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhBEQo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhBEQkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA42C06178B
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so8682809wru.9
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8+g1/GHHS722X/SiBgQQpJwcszLIHLP4uLMT0hi6i/c=;
        b=NnAZM7MVK19a6QTyg0uDYQOhLK+2DdozsvlkEmcpCVQ5aqZ9iEv19f4B/MYT2ktZWh
         s+nlYfWy+n4T/Zj3mB4yjcXXNjcdk3+qfpKhVptXTAp8mcWMAM8eekjSyy1Uj9pUW8IO
         1ALKL+QyAk2h8umGNHVf/iUvaEfKwxKs4NKZ07qNGkis99yh55F52Y0Wi4wvAwmmA5Zd
         NDLjOZe9HdFMx+PDiWypDpB7tIcgQUTcs3u3hkUpZL8OMQMI1mEUAUQhjKXN1iI3SnvW
         op5ur43AZzKBp4q6n7F4YjIp8ywi9xN9UZ/Gb6xnGkm+ucsMpFQsqsV0gwD8/yQ9BQnp
         75pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8+g1/GHHS722X/SiBgQQpJwcszLIHLP4uLMT0hi6i/c=;
        b=HoobnCbsrPYWlGuUodT4NLBOFKcMvv+lLPsDf4L9VJBhG8N3Gnyg0aFKKJZGjOpnjz
         5FnRHeSPi+lAJ1D4Y0/7ec7nZpa992/dzFcHzCNLAgFh2tJV08tUnJrIXcqLmEmSlr8o
         42q4F9UCvKYVoH0Sx2d+O0kt4pFgflhpU9UgZ4Lu5xATRkyI+YjRvtk7XtfabnExWXTc
         M6j3RIo6wc/WwEAXgxk33DOwiF7AIRvOzK4zAjoIrlLs/DR1kpeOICf6zUiMyrT2um6F
         91/bUHkc2VBsbbFJWveVhljN55v/NBtuFx/XlHe7gCkpMNd0jD7HyM8OYz/DnRzBdfaP
         0Dpg==
X-Gm-Message-State: AOAM532ueupjST8XCahjykD6Up59SCOhY7i0UQIpG6pYn9Xzxji/8Nlb
        esk7zYXHgzSgVJd5UBRgj+mdq/xNNVY=
X-Google-Smtp-Source: ABdhPJy3URAV1IEj2pETpkddni16Lz5JuvFYofy5i+3lMKhOgLqUcwHBaJE4XDggH+77/+YitALPKA==
X-Received: by 2002:adf:e381:: with SMTP id e1mr6316066wrm.22.1612549354874;
        Fri, 05 Feb 2021 10:22:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm13022702wrt.35.2021.02.05.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:33 -0800 (PST)
Message-Id: <06b781206e4cd5cfe23747f77d9228e5dc7e42c4.1612549349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:26 +0000
Subject: [PATCH v3 3/6] doc hash-function-transition: use upper case
 consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>,
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
index 8c01608cbfa0..9e13919a0e5b 100644
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

