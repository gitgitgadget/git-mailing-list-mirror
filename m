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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E69C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8955D64E75
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhBEQno (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhBEQk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8EC061793
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id w4so6747780wmi.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l6FtnOpglT3mK3SEVJz/3kN9LAgIBU9mWvZcmxVv3ck=;
        b=EVhjuSDASBveU775niA0EpN7HnMVg7LkMv0M6NWCctC7CayY8PaBsKPgFGGewLKCde
         aVIEV+FMKJ2v5oiIYZtYQ5GpdjrWCs6o+PV0CaDG208Zdru13dk8gkju8qx4Aaaj/UmX
         C8MwqMBGCYkZ3dLYAZdigg/M1FF6Jy4PddvWjgOyKYT9Bzxxf3EaF1ZCTs1Us/2hvcyR
         dyX6dC2fsHB3yRcoBVdJ+UG1lujNtNMJXWe7zjrGo9Ef1cPjuvFt1YzsOhpjrD4Gcrll
         TW3pKzn4QuYTMP0l20LYDBpuFuZAZwLL6CiDwoueZufa/wiPOKQTTqF/30u7tWBeLfzG
         5Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l6FtnOpglT3mK3SEVJz/3kN9LAgIBU9mWvZcmxVv3ck=;
        b=L8ah97NuQOafPA/wu0E7EP46455RJiGY69267nxiTm3WpbaPBwR5xvU2oM3BHEyaGj
         31RxQgdpzl10Aqmc6GEYIweTehhHMFesj0bl5GcjI4ZEdZvN4ArCisMfPMGT+jbTqTOR
         azrGKLqEdtcZShvLAIg6RyJ4AwKfErp7DCgNFJXH0MMOMt0xTdJBrehRoCvuUKANbkiS
         BpCYF+tfSy/a0/5ejCKoovwNv7pRqb0rJtuHAimecfUoYr7WtaR8lkkhsk7Y4Kv4kc8I
         Bw9Fnwt3Z0wPN4hYOLuaFvSRNyLfGsqEhFsCDVsheok8OnuCNLDrkBQc23bxD9hDm7ck
         pAbw==
X-Gm-Message-State: AOAM533ymuQO9L9l4s6erAZiKDreg8kHF7VVdMTkWQtKn1t1eNL5hbAH
        AQettLiOUogsEglCBqPtN/7sQptBBks=
X-Google-Smtp-Source: ABdhPJxq/E12JfVxTkSEL7muewB7+1qbRrjWW8LF2I2gbyBimBeWvKea1PCDTSTs4oUi77/74FU4VA==
X-Received: by 2002:a1c:ab57:: with SMTP id u84mr4807717wme.115.1612549357092;
        Fri, 05 Feb 2021 10:22:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm9413286wmh.20.2021.02.05.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:36 -0800 (PST)
Message-Id: <ee0fa2ec1d0fb4875c6a10af26686d2d5b3cb489.1612549349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:28 +0000
Subject: [PATCH v3 5/6] doc hash-function-transition: move rationale upwards
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

Move rationale for new hash function to beginning of document
so that it appears before the concrete move to SHA-256 is described.

Remove some of the details about SHA-1 weaknesses and add references
to the details on how the new hash function was chosen instead.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 .../technical/hash-function-transition.txt    | 76 +++++++++----------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 5ff9ee027cff..0c4cb98cd4e9 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -33,16 +33,9 @@ researchers. On 23 February 2017 the SHAttered attack
 
 Git v2.13.0 and later subsequently moved to a hardened SHA-1
 implementation by default, which isn't vulnerable to the SHAttered
-attack.
+attack, but SHA-1 is still weak.
 
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
@@ -57,6 +50,38 @@ SHA-1 still possesses the other properties such as fast object lookup
 and safe error checking, but other hash functions are equally suitable
 that are believed to be cryptographically secure.
 
+Choice of Hash
+--------------
+The hash to replace the hardened SHA-1 should be stronger than SHA-1
+was: we would like it to be trustworthy and useful in practice for at
+least 10 years.
+
+Some other relevant properties:
+
+1. A 256-bit hash (long enough to match common security practice; not
+   excessively long to hurt performance and disk usage).
+
+2. High quality implementations should be widely available (e.g., in
+   OpenSSL and Apple CommonCrypto).
+
+3. The hash function's properties should match Git's needs (e.g. Git
+   requires collision and 2nd preimage resistance and does not require
+   length extension resistance).
+
+4. As a tiebreaker, the hash should be fast to compute (fortunately
+   many contenders are faster than SHA-1).
+
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
@@ -601,39 +626,6 @@ example:
 
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

