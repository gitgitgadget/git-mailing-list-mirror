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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E6C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173F664F72
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhBBQZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhBBQWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF3C0611C1
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so21105745wry.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ykrjwuOhfmXvFJgFxOpKYuTOaMIy6qr02qTqRxa/ZC0=;
        b=Y8aAs5TD/CvDKETkZDH72OkOWW4NMb+ejbhFeVpRkDGlGazpn4iAEdwL7ZitzeslgC
         9GWVLPfO9iUEdrRTmBOE5gOhb3d24+PLyC2dhLc932Ao84TGGfAvFENAxlJBYhXOqriw
         NUS0G+h15KNjvW03pjh2aLTTHqsYY1f1BQ5xAyW6B6KHNbD/tsVFQZB3eKtqkxZg+qkO
         DO0giV0s2lJoKEnjhaYUgxr0zf3G/YQ6CgrfmLO+WKYcpAk2/qMqCoDadc+Jzkmk6iIg
         uaH2QRqH+qTWsISSEAEXW3ncARDgiwVJTSnxwtj16tBiNd9fV2vHkj61po8WrXD2r7ve
         Q4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ykrjwuOhfmXvFJgFxOpKYuTOaMIy6qr02qTqRxa/ZC0=;
        b=c1W/2GaTT1ENvveql47tzJapzeaZJ2yyZ5dkdi3L2wViXVelrav1x4RH54AVVDZ02G
         A+uGcJafjTq1oxtsA8LQ8w3ObnF4+fwz7oHLt5a+G5bcuyfpX2rd60I9DZwBjzd3Br8E
         V5FkzN2Pvc6Eg8eI9LCWrJPweWfEgyCER2axiLqwP2nQokD4p9WAwOljgTPxOkDE4gdV
         bCiieQjO9O97tk8XftuzhYRWVhWI+nPB4TxzI6t8xUiS7Ev09iqnPJlz1NHyFg5gqIJD
         oHSs9KFPkOSHjDzag2BIwcxZJ5+L0X8v92ytX+0XBYAwog3NlLqSf8fJHiR77HLmZoyA
         Lt4g==
X-Gm-Message-State: AOAM533+oFexgjDAuLnZ4krwWZxia3NpxG+A4KnBuuvD2zVEI7iiu3fB
        jdh13XTUTFZwTHt9C1dtdk6DSjuojaQ=
X-Google-Smtp-Source: ABdhPJzpOGu0FMr26T16KL1wFKKKDtEo49HYXs0+LiqtJNGrd/UH0Sz7aqs4BmiTejVEKHcxffhh5A==
X-Received: by 2002:a5d:6546:: with SMTP id z6mr24980514wrv.125.1612282757988;
        Tue, 02 Feb 2021 08:19:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm3661869wmi.23.2021.02.02.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:17 -0800 (PST)
Message-Id: <711a37969b6f51922c12555534d9c4634cde6021.1612282749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:08 +0000
Subject: [PATCH v2 5/6] doc hash-function-transition: move rationale upwards
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

Move rationale for new hash function to beginning of document
so that it appears before the concrete move to SHA-256 is described.

Remove details about SHA-1 weaknesses. Instead add references
to the details of how the new hash function was chosen.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 .../technical/hash-function-transition.txt    | 62 +++++--------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 86b09ea0f21..475f2f501a6 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -27,22 +27,12 @@ advantages:
   methods have a short reliable string that can be used to reliably
   address stored content.
 
-Over time some flaws in SHA-1 have been discovered by security
-researchers. On 23 February 2017 the SHAttered attack
-(https://shattered.io) demonstrated a practical SHA-1 hash collision.
+Over time some flaws in SHA-1 have been discovered by security researchers.
 
 Git v2.13.0 and later subsequently moved to a hardened SHA-1
-implementation by default, which isn't vulnerable to the SHAttered
-attack.
+implementation by default, but SHA-1 is still believed to be weak.
 
-Thus Git has in effect already migrated to a new hash that isn't SHA-1
-and doesn't share its vulnerabilities, its new hash function just
-happens to produce exactly the same output for all known inputs,
-except two PDFs published by the SHAttered researchers, and the new
-implementation (written by those researchers) claims to detect future
-cryptanalytic collision attacks.
-
-Regardless, it's considered prudent to move past any variant of SHA-1
+Thus it's considered prudent to move past any variant of SHA-1
 to a new hash. There's no guarantee that future attacks on SHA-1 won't
 be published in the future, and those attacks may not have viable
 mitigations.
@@ -57,6 +47,19 @@ SHA-1 still possesses the other properties such as fast object lookup
 and safe error checking, but other hash functions are equally suitable
 that are believed to be cryptographically secure.
 
+Choice of Hash
+--------------
+There were several contenders for a successor hash to SHA-1, including
+SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
+
+In late 2018 the project picked SHA-256 as its successor hash.
+
+See 0ed8d8da374 (doc hash-function-transition: pick SHA-256 as
+NewHash, 2018-08-04) and numerous mailing list threads at the time,
+particularly the one starting at
+https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/
+for more information.
+
 Goals
 -----
 1. The transition to SHA-256 can be done one local repository at a time.
@@ -601,39 +604,6 @@ example:
 
     git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
 
-Choice of Hash
---------------
-In early 2005, around the time that Git was written, Xiaoyun Wang,
-Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
-collisions in 2^69 operations. In August they published details.
-Luckily, no practical demonstrations of a collision in full SHA-1 were
-published until 10 years later, in 2017.
-
-Git v2.13.0 and later subsequently moved to a hardened SHA-1
-implementation by default that mitigates the SHAttered attack, but
-SHA-1 is still believed to be weak.
-
-The hash to replace this hardened SHA-1 should be stronger than SHA-1
-was: we would like it to be trustworthy and useful in practice for at
-least 10 years.
-
-Some other relevant properties:
-
-1. A 256-bit hash (long enough to match common security practice; not
-   excessively long to hurt performance and disk usage).
-
-2. High quality implementations should be widely available (e.g., in
-   OpenSSL and Apple CommonCrypto).
-
-3. The hash function's properties should match Git's needs (e.g. Git
-   requires collision and 2nd preimage resistance and does not require
-   length extension resistance).
-
-4. As a tiebreaker, the hash should be fast to compute (fortunately
-   many contenders are faster than SHA-1).
-
-We choose SHA-256.
-
 Transition plan
 ---------------
 Some initial steps can be implemented independently of one another:
-- 
gitgitgadget

