Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D940C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJTWnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTWna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69271222F32
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so1779471wrb.13
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm5q1jcdJziv/G19WHP0yRRqMDhKlBvN3dqT1T8Y+7w=;
        b=Pcoji11GAgnlMuclhOj4fxYV7g1uRgUtouRCiaO06YYkX+dMO4iN+qgo6lXpFzjzGD
         wHSUAZtYDLyU6CcZLPk/4NOweh0NPXHwq7tQJtb03Xzg+mCuT0c2eajUM/ec+hrGLnWp
         ayV6tMO1A16+xhum29n16+0UWKR+x6JDh77EKQcJktwKvz7RfBaAyaNCOpIiwfW3gjND
         epAFg8h8C3VwU0FMe/fWjAT236+pdAmr/12X8EGdsvKPEVsnZk2j/gvNgeI2nZ/b/VRJ
         +dzCNpb9ioAlmjKNxCHHSmah5lBHjst89/mIX94uq1s+U6YEwwa6rj8UPs8TvbL/WcKp
         Nt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm5q1jcdJziv/G19WHP0yRRqMDhKlBvN3dqT1T8Y+7w=;
        b=zb9plmz8e4ARBa+Pc8k285QWz8paMd1CezaEt5HQTAssGaElDtIGY1CuvNsYHcgptj
         HKWv1704cU/cJLIHzh73GU3+FPj1WiTAkvlrcIy/vP1gEtzF08bWXCMliY2Q+BcaUJYB
         kxfGqpT7gi5gl/N8pgB3WNkRKfQr58p7pB7uvzHU45Gj2CoChV6dfoNfrzqediEPxfQg
         WigvOPz7JXTBtKdpTccN8Ozbd71OiXxK4Ts+MJdMyZARSHzRLVTIskLiNZUsN5e6eOQw
         pnM0SBBHUlYVUIj8co1hql2jrbKU+LZNKR3ztYLaBIAd43Tyo6S7K0KmcaAg4oV09osG
         /qzg==
X-Gm-Message-State: ACrzQf05R9ry7u3XHo3S7Lmy1X0PLDBfNC1EWO5NS2DJUiLf/JpIubsj
        nxUnRpZFOW7In886tVGSR0Gx6HkneCA=
X-Google-Smtp-Source: AMsMyM7hajaBApNG/glrgJM2adiE6/SghCbf5xctzr6JdRtszfNctZyQJJzS5uk1jX/xhvhzdXGBRQ==
X-Received: by 2002:a5d:47a6:0:b0:22e:7c73:feb2 with SMTP id 6-20020a5d47a6000000b0022e7c73feb2mr10442047wrb.715.1666305807404;
        Thu, 20 Oct 2022 15:43:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:26 -0700 (PDT)
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
Subject: [PATCH v3 0/9] Makefile & docs: document SHA-{1,256} behavior, fix bug
Date:   Fri, 21 Oct 2022 00:43:01 +0200
Message-Id: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 is a rewrite of the larger-in-scope v2[2] to only fix the
current Makefile & INSTALL documentation do to do with our SHA-1 and
SHA-256 knobs.

The only behavior change here is in 1/8, where I fix what's obviously
a bug in the current behavior (so that we don't need to document that
edge case). I'll submit a patch to change the behavior on OSX to use
sha1collisiondetection by default on top of this series.

1. https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  Makefile: always (re)set DC_SHA1 on fallback
  INSTALL: remove discussion of SHA-1 backends
  Makefile: correct DC_SHA1 documentation
  Makefile: create and use sections for "define" flag listing
  Makefile: rephrase the discussion of *_SHA1 knobs
  Makefile: document default SHA-256 backend
  Makefile: document SHA-1 and SHA-256 default and selection order
  Makefile: document default SHA-1 backend on OSX
  Makefile: discuss SHAttered in *_SHA{1,256} discussion

 INSTALL  |   4 -
 Makefile | 260 +++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 166 insertions(+), 98 deletions(-)

Range-diff against v2:
 1:  392fabdb456 <  -:  ----------- fsmonitor OSX: compile with DC_SHA1=YesPlease
 -:  ----------- >  1:  ef3c5be11e0 Makefile: always (re)set DC_SHA1 on fallback
 -:  ----------- >  2:  017a0a9791c INSTALL: remove discussion of SHA-1 backends
 -:  ----------- >  3:  62dd2d5708d Makefile: correct DC_SHA1 documentation
 2:  7ae22276aa7 !  4:  933bef576b3 Makefile: create and use sections for "define" flag listing
    @@ Makefile: include shared.mak
     -# Define BLK_SHA1 environment variable to make use of the bundled
     -# optimized C SHA1 routine.
     -#
    --# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
    +-# Define DC_SHA1 to enable the collision-detecting sha1
     -# algorithm. This is slower, but may detect attempted collision attacks.
    --# Takes priority over other *_SHA1 knobs.
     -#
     -# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
     -# git with the external SHA1 collision-detect library.
    @@ Makefile: include shared.mak
     +#
     +# == SHA-1 and SHA-256 defines ==
     +#
    -+# Define BLK_SHA1 environment variable to make use of the bundled
    -+# optimized C SHA1 routine.
    ++# === SHA-1 backend ===
    ++#
    ++# ==== Options common to all SHA-1 implementations ====
    ++#
    ++# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
    ++# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
    ++# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
    ++#
    ++# ==== Options for the sha1collisiondetection implementation ====
     +#
    -+# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
    ++# Define DC_SHA1 to enable the collision-detecting sha1
     +# algorithm. This is slower, but may detect attempted collision attacks.
    -+# Takes priority over other *_SHA1 knobs.
     +#
     +# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
     +# git with the external SHA1 collision-detect library.
    @@ Makefile: include shared.mak
     +# by the git project to migrate to using sha1collisiondetection as a
     +# submodule.
     +#
    ++# ==== Other SHA-1 implementations ====
    ++#
    ++# Define BLK_SHA1 environment variable to make use of the bundled
    ++# optimized C SHA1 routine.
    ++#
     +# Define OPENSSL_SHA1 environment variable when running make to link
     +# with the SHA1 routine from openssl library.
     +#
    -+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
    -+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
    -+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
    ++# === SHA-256 backend ===
     +#
     +# Define BLK_SHA256 to use the built-in SHA-256 routines.
     +#
 3:  78ef8636c57 <  -:  ----------- Makefile: really use and document sha1collisiondetection by default
 4:  f1fb9775b33 <  -:  ----------- Makefile: rephrase the discussion of *_SHA1 knobs
 -:  ----------- >  5:  5b18198c477 Makefile: rephrase the discussion of *_SHA1 knobs
 -:  ----------- >  6:  73685592aba Makefile: document default SHA-256 backend
 -:  ----------- >  7:  05edcfb9cd9 Makefile: document SHA-1 and SHA-256 default and selection order
 -:  ----------- >  8:  859e69fbe9f Makefile: document default SHA-1 backend on OSX
 -:  ----------- >  9:  c1f27255d3e Makefile: discuss SHAttered in *_SHA{1,256} discussion
-- 
2.38.0.1178.g509f5fa8ce0

