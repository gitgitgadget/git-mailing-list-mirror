Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3EDC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTWnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJTWni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860022C801
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i9so1862086wrv.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLvfq75bcJgO+5p9QBSwgi5LIxNyYVPeGtgU5dgp/Aw=;
        b=JOOR0jLj80BpgGzTEYpoeiJAm1RkSbbDcdBWbt+XrYblnh+Ga/mLG6llkqxa98Op7s
         5xMuLDLeVcoS68VIcDnsA9N/f0P665jYHYZIkHO2v/o49XFPIqSN3nkzMtX7W34H+9bT
         V1xsJb7g7HYBt8Vx9Sp9Xdhtka2+IfUlpiVIhpVu1DoztiCAhwBENyWg39nT7cumJGnH
         XWzN+biPgn3eFatKDiPebg8DwrVUrZWyts2+IbQUCG8WXLqwbJ1d2xYRwi/YPgSFYEx7
         BpTPj8OC9RCGe2dn60x4L1R/GQDnLXaQFyPzvk+yUcnNs3KysJQfk7FlCdUFKrUpR8pU
         gvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLvfq75bcJgO+5p9QBSwgi5LIxNyYVPeGtgU5dgp/Aw=;
        b=0xqeRS2LH/VE5sr8atUwOEO/YojVHl//Y8I53mVPLpIl339FLRbDirxwC+52x6Qjst
         AH2WDXrAjjbKze4+0jxxe0eTKqWQz9Rhfi+V0I+7WOdH8BmdyPwZp50IheYjkCpsQYCt
         7udkZJ6Nb+wriL3AWceVIbj3SUaDE2/Rnw9QZikWT0C/UUL5SEkCDHBgeebMwjxWOpBh
         OEDcZ+IM0fUPe5xlhCZSQNlvPaDThhp3sRo9r4t3hzu63sAH23aeAsUCarutdKD3o6GA
         X++9IQ65Qgy1H3svLz6UjaYBikYWIkSHux3Bq20rs2q2XBG3dY3/F7XMkL+5I2qW2lXz
         UMBw==
X-Gm-Message-State: ACrzQf2opcmQQUvGP2PHvcwpjT1JoLiWprFmsB6gk+rHlZRtDCzjvfB9
        OR2jU5l0cFeE7yTewHcba8oVL1pmC8tOaA==
X-Google-Smtp-Source: AMsMyM4nM7jAWCsajhljytGFkV79e1GrGDBSVkyZssgdrDBfIWgR5WhsQGM0/jQHqdHjs3vO+/KMYQ==
X-Received: by 2002:a5d:59a2:0:b0:22f:f2eb:ea86 with SMTP id p2-20020a5d59a2000000b0022ff2ebea86mr9990344wrr.635.1666305813972;
        Thu, 20 Oct 2022 15:43:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:32 -0700 (PDT)
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
Subject: [PATCH v3 5/9] Makefile: rephrase the discussion of *_SHA1 knobs
Date:   Fri, 21 Oct 2022 00:43:06 +0200
Message-Id: <patch-v3-5.9-5b18198c477-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
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

Furthermore the discussion of DC_SHA1* options is now under a "Options
for the sha1collisiondetection implementation" heading, so we don't
need to clarify that these options go along with DC_SHA1=Y, so let's
rephrase them accordingly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index b3a717792cf..61358f16acc 100644
--- a/Makefile
+++ b/Makefile
@@ -492,12 +492,12 @@ include shared.mak
 # Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
 #
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# Define DC_SHA1_EXTERNAL if you want to build / link
 # git with the external SHA1 collision-detect library.
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# Define DC_SHA1_SUBMODULE to use the
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
 # by the git project to migrate to using sha1collisiondetection as a
@@ -505,11 +505,11 @@ include shared.mak
 #
 # ==== Other SHA-1 implementations ====
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
 # === SHA-256 backend ===
 #
-- 
2.38.0.1178.g509f5fa8ce0

