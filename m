Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D88C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJSBDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJSBDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:03:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB6DEF24
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r13so26353686wrj.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/TPME5QvLtPBnDOZhck3MTPXEpufqWe17cEhECy1y8=;
        b=aUuxkryjXfXtHQPUNLPSG3bqgnucwwYvkHwO2pxNrs1he+Ox0OVt5zi/Nt9C0nQhXq
         CzFHuqLd/5tNRuKCQMU2GNZE+7giGVPufltB6lmlKr6YZ0dhAkgAdJItoMffkWBp3U9H
         oeACou6G7wtbsIGIamjwNxzLFriXDFU1I3C6G4t6xA3aqP31woY+UdPyc9rnB0hYKfX2
         W+7oPBjk3jr3C1i03PwVC2Tg+sKla84wLYsuMult1O+avVEWD9RdF1H6S5jN6sIbycsI
         QVjzmgx19cQebwK/hapCrOxeaO8/rggA7EOu7+RLH0lVqGf1NUc3yesoBByFO2+UKdKn
         aMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/TPME5QvLtPBnDOZhck3MTPXEpufqWe17cEhECy1y8=;
        b=wWpiaeTgcLYpWO4KdES71MOfb5mT5h55Hj3N/dCHQ68WhR0je/kI23GhIYSh24rWBP
         vydkNXX56DplaCG7NIYZykDcbRwzhS2AAh1JGE4QViz6ant4N64LfxxMQ0P5Hu7XRCmD
         SMY6sLg6uMRSxs2FSD195rMFT7nIQuxJsSLkhkL9jFwH9aJK1R1or6+sAKhiB4jqNGhn
         V8PdnqQWqdPhWTursMrIy28wwZYnH6vfcvZ75v8wQZPULEC92bq/wN1SAYyZCAkpF5Uc
         Jp+fM0c9ehaIo/BVbpnX3cxitUdVMDdgyda1fj8P1UiMg2SBTo9EW44DMLNkQ4KtYh0i
         cS9A==
X-Gm-Message-State: ACrzQf0yHZBR4zdAZB8zqFFmEnGaVkfkU6mZVaW2q5VLuKT9A+xU1O9+
        d0J03fIdwnmd/h5Ryb3FCN7+mN50t0H9cw==
X-Google-Smtp-Source: AMsMyM7kUu4SwAY2OHDU5qzGe02a6qUjTksHexKod4TVl1bP9Ek/Jcz79drZbFXy3IC3Bk5tYMiBvA==
X-Received: by 2002:a5d:668e:0:b0:22f:d914:80ed with SMTP id l14-20020a5d668e000000b0022fd91480edmr3382728wru.45.1666141414479;
        Tue, 18 Oct 2022 18:03:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0022e3cba367fsm12161315wrz.100.2022.10.18.18.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:03:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] Makefile: rephrase the discussion of *_SHA1 knobs
Date:   Wed, 19 Oct 2022 03:03:22 +0200
Message-Id: <patch-v2-4.4-f1fb9775b33-20221019T010222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcd4a685f0b1
In-Reply-To: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the discussion of the *_SHA1 knobs was left
as-is to benefit from a smaller diff, but since we're changing these
let's use the same phrasing we use for most other knobs. E.g. "define
X", not "define X environment variable", and get rid of the "when
running make to link with" entirely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7a7411df8c3..16367c72ba8 100644
--- a/Makefile
+++ b/Makefile
@@ -517,11 +517,11 @@ include shared.mak
 # To use them you must define NO_DC_SHA1 and one of the *_SHA1
 # variables below:
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
 #
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
+# Define OPENSSL_SHA1 to link to the the SHA-1 routines from
+# the OpenSSL library.
 #
 # Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
 # Darwin/Mac OS X.
-- 
2.38.0.1093.gcd4a685f0b1

