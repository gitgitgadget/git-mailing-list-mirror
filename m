Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B314C43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiKGVX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKGVXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2F2BF5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q9so33750918ejd.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9+1J/QDRiVITN/js1yREk0+EcLg5iMbAd5IRE6nEf8=;
        b=BFzq0DIauhq23rc+4Oq+5LJfzxap4rVJcrHmYV68uVVydt+uRSiIqwU6xHUdFGJPzk
         PhBZiLe8VnQVBOZGkVvW9CZBJvHvC6VALg878UEL4knISrXjgQhuLG9V4SeszKU/bNm3
         dZbWORpkszoTnXiK6unmwf8IyfXAhQAo4BAXyfjSHAiiGa13s6380a1zdDqyGX0Qskop
         aymB+1SIhyeOZ07Xpnlg3qL539pCqxR5YUvyS9TdYGqZWj++ETnwpEO5qRlxG8eHMGXH
         OkgRNm02uMPHSAJxhULFRRxOA2AkF0NSuenhISFrdRbfa6QbWc2QMSucAxrAaka/2v08
         jAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9+1J/QDRiVITN/js1yREk0+EcLg5iMbAd5IRE6nEf8=;
        b=EFfFF803OXy3SviCnC7qIlQ3krqJlYMDaXdzGP9g0huv2+UsDJBNj0GcixAmGuiYiP
         Rl6Zv8kSPIXHhbgre+gqHWOQNfg5cO9+DOAaTwxuUODSb5dmD7BGTY9c+QmybnKCCDw7
         gkobmEAnCt9CUuJu6qouChjQbMhWkS8nxlc8Sm60+tVRoCp+gjjEKl8x+2/EJfQ883eN
         m9PEsHYVdDLIsbtNfX/ztvlIAfYLRZvPortctgClUAPx3jN2wJUs3pQVMOlIk3aI3i3V
         i/r6M7NJdtUkG5CyFGNa75ENGC+IJjcbL53Jkt9VNn4KQPYuKxb+nx7fqBkQX12MCv41
         duQA==
X-Gm-Message-State: ACrzQf2zbchuUUksQkHbIkmv8K14acLdgVGGGPmfkpTR8szSfrYUDGyP
        6yCZKN1XRle+tSdEFV8EmIOTgx+V/c5ozQ==
X-Google-Smtp-Source: AMsMyM7r0KdQxpUeOpgA15GEix0piI6KdVhk/7W4CBq7G2YdydhNfT/5rg79QYS5sWpPKY9MoMNgfQ==
X-Received: by 2002:a17:907:3e20:b0:7ad:b54a:442f with SMTP id hp32-20020a1709073e2000b007adb54a442fmr47616736ejc.636.1667856195309;
        Mon, 07 Nov 2022 13:23:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:14 -0800 (PST)
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
Subject: [PATCH v5 00/10] Makefile, docs & code: document & fix SHA-{1,256} selection behavior
Date:   Mon,  7 Nov 2022 22:23:02 +0100
Message-Id: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is mostly a documentation update to get to the eventual goal of
making DC_SHA1 the default on OSX. First we need to stop claiming that
OpenSSL is still our default everywhere, etc.

For v4, see:
https://lore.kernel.org/git/cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com/

For v4 Junio pointed out that it wasn't very clear what the "default"
is. The root cause of that (which I was hoping to avoid, but bit the
bullet here) is that DC_SHA1=Y on master doesn't actually do anything
at all.

Instead, whether we use DC_SHA1 or not depends on whether or not we
asked for any *other* backend, it's just our default fallback.

The documentation now reflects this, and to reinforce that a new 8/10
here gets rid of the Makefile flag entirely.

The only thing it was actually used for was to tell the test suite
that it should be running the SHA1DC tests. Instead we just have a
trivial test helper that we can ask whether that's the case. It picks
up a macro that we define in sha1dc_git.h.

Ævar Arnfjörð Bjarmason (10):
  Makefile: always (re)set DC_SHA1 on fallback
  INSTALL: remove discussion of SHA-1 backends
  Makefile: correct DC_SHA1 documentation
  Makefile: create and use sections for "define" flag listing
  Makefile: rephrase the discussion of *_SHA1 knobs
  Makefile: document default SHA-256 backend
  Makefile: document SHA-1 and SHA-256 default and selection order
  Makefile & test-tool: replace "DC_SHA1" variable with a "define"
  Makefile: document default SHA-1 backend on OSX
  Makefile: discuss SHAttered in *_SHA{1,256} discussion

 INSTALL                             |   4 -
 Makefile                            | 252 +++++++++++++++++-----------
 ci/lib.sh                           |   2 +-
 contrib/buildsystems/CMakeLists.txt |   2 -
 sha1dc_git.h                        |   1 +
 t/helper/test-sha1.c                |   8 +
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0013-sha1dc.sh                   |   6 +-
 9 files changed, 173 insertions(+), 104 deletions(-)

Range-diff against v4:
 1:  11e92d15616 =  1:  24d503e5a2b Makefile: always (re)set DC_SHA1 on fallback
 2:  abbe25f56b3 =  2:  2f6c37b90cd INSTALL: remove discussion of SHA-1 backends
 3:  b0bd35987c0 !  3:  d05fbf8c6d8 Makefile: correct DC_SHA1 documentation
    @@ Commit message
         Let's also remove the "unconditionally enable" wording, per the above
         the enabling of "DC_SHA1" is conditional on these other flags.
     
    +    The "Define DC_SHA1" here is also a lie, actually it's "we don't care
    +    if you define DC_SHA1, just don't define anything else", but that's a
    +    more general issue that'll be addressed in a subsequent commit. Let's
    +    first stop pretending that this setting (which we actually don't even
    +    use) takes priority over anything else.
    +
         1. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
         2. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
     
 4:  d0451d6c3a3 !  4:  9ab55314296 Makefile: create and use sections for "define" flag listing
    @@ Makefile: include shared.mak
     +# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
     +# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
     +#
    -+# ==== Options for the sha1collisiondetection implementation ====
    ++# ==== SHA-1 implementations ====
     +#
     +# Define DC_SHA1 to enable the collision-detecting sha1
     +# algorithm. This is slower, but may detect attempted collision attacks.
     +#
    ++# Define BLK_SHA1 environment variable to make use of the bundled
    ++# optimized C SHA1 routine.
    ++#
    ++# Define OPENSSL_SHA1 environment variable when running make to link
    ++# with the SHA1 routine from openssl library.
    ++#
    ++# ==== Options for the sha1collisiondetection library ====
    ++#
     +# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
     +# git with the external SHA1 collision-detect library.
     +# Without this option, i.e. the default behavior is to build git with its
    @@ Makefile: include shared.mak
     +# by the git project to migrate to using sha1collisiondetection as a
     +# submodule.
     +#
    -+# ==== Other SHA-1 implementations ====
    -+#
    -+# Define BLK_SHA1 environment variable to make use of the bundled
    -+# optimized C SHA1 routine.
    -+#
    -+# Define OPENSSL_SHA1 environment variable when running make to link
    -+# with the SHA1 routine from openssl library.
    -+#
     +# === SHA-256 backend ===
     +#
    ++# ==== SHA-256 implementations ====
    ++#
     +# Define BLK_SHA256 to use the built-in SHA-256 routines.
     +#
     +# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 5:  b956d1c2640 !  5:  5f1da5d7dc4 Makefile: rephrase the discussion of *_SHA1 knobs
    @@ Makefile: include shared.mak
      # Define DC_SHA1 to enable the collision-detecting sha1
      # algorithm. This is slower, but may detect attempted collision attacks.
      #
    --# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
    -+# Define DC_SHA1_EXTERNAL if you want to build / link
    - # git with the external SHA1 collision-detect library.
    - # Without this option, i.e. the default behavior is to build git with its
    - # own built-in code (or submodule).
    - #
    --# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
    -+# Define DC_SHA1_SUBMODULE to use the
    - # sha1collisiondetection shipped as a submodule instead of the
    - # non-submodule copy in sha1dc/. This is an experimental option used
    - # by the git project to migrate to using sha1collisiondetection as a
    -@@ Makefile: include shared.mak
    - #
    - # ==== Other SHA-1 implementations ====
    - #
     -# Define BLK_SHA1 environment variable to make use of the bundled
     -# optimized C SHA1 routine.
     +# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
    @@ Makefile: include shared.mak
     +# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
     +# library.
      #
    - # === SHA-256 backend ===
    + # ==== Options for the sha1collisiondetection library ====
    + #
    +-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
    ++# Define DC_SHA1_EXTERNAL if you want to build / link
    + # git with the external SHA1 collision-detect library.
    + # Without this option, i.e. the default behavior is to build git with its
    + # own built-in code (or submodule).
      #
    +-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
    ++# Define DC_SHA1_SUBMODULE to use the
    + # sha1collisiondetection shipped as a submodule instead of the
    + # non-submodule copy in sha1dc/. This is an experimental option used
    + # by the git project to migrate to using sha1collisiondetection as a
 6:  1e4695d0ba0 <  -:  ----------- Makefile: document default SHA-256 backend
 -:  ----------- >  6:  2cadbddcc04 Makefile: document default SHA-256 backend
 7:  847be3d32e2 !  7:  0d62359649f Makefile: document SHA-1 and SHA-256 default and selection order
    @@ Makefile: include shared.mak
      #
     +# ==== Default SHA-1 backend ====
     +#
    -+# If no *_SHA1 backend is picked we'll fall back on using the default.
    -+#
    -+# Multiple *_SHA1 backends can be selected, the first supported one
    -+# listed in "Other SHA-1 implementations" will be picked.
    ++# If no *_SHA1 backend is picked, the first supported one listed in
    ++# "SHA-1 implementations" will be picked.
     +#
      # ==== Options common to all SHA-1 implementations ====
      #
      # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
     @@ Makefile: include shared.mak
      #
    - # ==== Other SHA-1 implementations ====
    + # ==== SHA-1 implementations ====
      #
    --# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
    --# with git (in the block-sha1/ directory).
    --#
    - # Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
    - # library.
    +-# Define DC_SHA1 to enable the collision-detecting sha1
    +-# algorithm. This is slower, but may detect attempted collision attacks.
    ++# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
    ++# library.
      #
    -+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
    -+# with git (in the block-sha1/ directory).
    -+#
    - # === SHA-256 backend ===
    + # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
    + # with git (in the block-sha1/ directory).
    + #
    +-# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
    +-# library.
    ++# Define DC_SHA1 to enable the collision-detecting sha1
    ++# algorithm. This is slower, but may detect attempted collision attacks.
    + #
    + # ==== Options for the sha1collisiondetection library ====
      #
    - # ==== Default SHA-256 backend ====
     @@ Makefile: include shared.mak
    - # The default SHA-256 backend is shipped with Git. No flag is required
    - # to enable it. To select it don't define any other *_SHA256 flag.
      #
    -+# Multiple *_SHA256 backends can be selected, the first supported one
    -+# listed in "Other SHA-256 implementations" below will be picked.
    -+#
    - # ==== Other SHA-256 implementations ====
    + # ==== SHA-256 implementations ====
      #
     +# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
     +#
    @@ Makefile: include shared.mak
      #
     -# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
     -#
    - # == DEVELOPER defines ==
    + # If don't enable any of the *_SHA256 settings in this section, Git
    + # will default to its built-in sha256 implementation.
      #
    - # Define DEVELOPER to enable more compiler warnings. Compiler version
 -:  ----------- >  8:  6daac578fd0 Makefile & test-tool: replace "DC_SHA1" variable with a "define"
 8:  0af3ea78eaf !  9:  8d3dddf88a4 Makefile: document default SHA-1 backend on OSX
    @@ Makefile: include shared.mak
     +# default on that OS. On macOS 01.4 (Tiger) or older,
     +# NO_APPLE_COMMON_CRYPTO is defined by default.
     +#
    - # === SHA-256 backend ===
    - #
    - # ==== Default SHA-256 backend ====
    + # If don't enable any of the *_SHA1 settings in this section, Git will
    + # default to its built-in sha1collisiondetection library, which is a
    + # collision-detecting sha1 This is slower, but may detect attempted
 9:  9045ff9c4ed ! 10:  55d3751faea Makefile: discuss SHAttered in *_SHA{1,256} discussion
    @@ Makefile: include shared.mak
     +#
     +# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
     +# it's strongly recommended to use the sha1collisiondetection
    -+# counter-cryptanalysis library for SHA-1 hashing (DC_SHA1).
    ++# counter-cryptanalysis library for SHA-1 hashing.
     +#
     +# If you know that you can trust the repository contents, or where
    -+# potential SHA-1 attacks are otherwise mitigated the backends listed
    -+# in "Other SHA-1 implementations" are faster than DC_SHA1.
    ++# potential SHA-1 attacks are otherwise mitigated the other backends
    ++# listed in "SHA-1 implementations" are faster than
    ++# sha1collisiondetection.
     +#
      # ==== Default SHA-1 backend ====
      #
    - # If no *_SHA1 backend is picked we'll fall back on using the default.
    + # If no *_SHA1 backend is picked, the first supported one listed in
     @@ Makefile: include shared.mak
      #
      # === SHA-256 backend ===
    @@ Makefile: include shared.mak
     +# Unlike SHA-1 the SHA-256 algorithm does not suffer from any known
     +# vulnerabilities, so any implementation will do.
     +#
    - # ==== Default SHA-256 backend ====
    + # ==== SHA-256 implementations ====
      #
    - # If no *_SHA256 backend is picked we'll fall fall back on using the
    + # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
-- 
2.38.0.1464.gea6794aacbc

