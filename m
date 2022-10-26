Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9215C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiJZO46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiJZO4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:56:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC9104D21
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so18572068wrq.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmAYxpnO5NIxJiHfHXn492PTt3rtZjgNMJO4mNOAsY8=;
        b=nKDHRNZvfCF/3pLP45K2g3Pe5+F6Mx/dLdBZKVlMkHO1aDBZZrWz9LcfYILPcBpnX7
         3Z80ny+7XrudeLP5Pr/NQHxwb5RM9rZziOCSDG2JLuGiGX+ZEbCCBFt79wDfOej/uIfS
         2jkJHa2jQLjkPpp2xtaohtGl2yvk7rzkNGxyiwJV7spQs1MRzDLdPRHlcAwVxHcVS25z
         9vnBtP6wHHsmn1M/Cgk0ia7sRh4N0Zzfk3PZYmFM5qcQmdPYGpddHisGvBQ+DL0/g4YI
         dLONSwglBST9vjHX2RwnhP+6bxEGdFks3N+ztub8Y9jM7rPlzjyhNPVU/f3t2ZuXemq4
         qhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmAYxpnO5NIxJiHfHXn492PTt3rtZjgNMJO4mNOAsY8=;
        b=NXyyOPleq2Lrwgs3zSwMn4zekLHivwD76f8E4phm0uL4ZOusOFAcncBsZbjP6CYeZX
         0Pqtl/1FbSYdI21NDQ+BVfeTnZj55t50CG7hR+MFNd1eolq1zv3ffSrkd2vtzl/CRt8Q
         YsUTp345aF2damj5M8gTc06ARK4sLPO/GY2hKNqsFQwBWSho3QA3feZmfwskYUg5eVIb
         A6rTpqUiZTYegtp94b+GRTX1yItVEFL/KfWfZnfnhXG6g5KrfiavEBhkglPkvBVYpwnP
         C46X5esjTCpwIyIyJff7bDAqgJFP2JUa43qHQ/aXClCyDLAdg3W0ejXWAa3s2jJo9J3I
         Fs9Q==
X-Gm-Message-State: ACrzQf2qGcgvQmw+PawLvaEheqyk6YShYdaRddA6ZGjOqKIx3hfwHON8
        CUu+EJK51IimTn5TnJ2OOcCFYaOfHMygEw==
X-Google-Smtp-Source: AMsMyM7j5gyLH6Lmeh4kPc+2OYQL+N0XGNPip5B1G62E2yx/AmabCgS+yyMIh2XzdJdndgxXRfuBCw==
X-Received: by 2002:adf:e446:0:b0:236:773b:c6f0 with SMTP id t6-20020adfe446000000b00236773bc6f0mr9833159wrm.55.1666796210148;
        Wed, 26 Oct 2022 07:56:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:49 -0700 (PDT)
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
Subject: [PATCH v4 0/9] Makefile & docs: document SHA-{1,256} behavior, fix bug
Date:   Wed, 26 Oct 2022 16:56:38 +0200
Message-Id: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a documentation update to get to the eventual goal of making
DC_SHA1 the defaul on OSX. First we need to stop claiming that OpenSSL
is still our default everywhere, etc.

For v3 see:
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com/;
The updates here are all typos/grammar etc. issues spotted by Eric
Sunshine, thanks!

Junio: This v4 introduces a minor conflict with the subsequent DC_SHA1
topic[1], but you haven't picked that one up either, so I'm assuming
if you're interested in this at all it's better to cook this first.

In case you want both It's easily solved (just keep the other topic's
post-image). I.e. Eric pointed out a better wording for a paragraph,
but it's the one we're mostly removing/rewriting in [1].

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
 Makefile | 259 +++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 165 insertions(+), 98 deletions(-)

Range-diff against v3:
 1:  ef3c5be11e0 =  1:  11e92d15616 Makefile: always (re)set DC_SHA1 on fallback
 2:  017a0a9791c =  2:  abbe25f56b3 INSTALL: remove discussion of SHA-1 backends
 3:  62dd2d5708d =  3:  b0bd35987c0 Makefile: correct DC_SHA1 documentation
 4:  933bef576b3 =  4:  d0451d6c3a3 Makefile: create and use sections for "define" flag listing
 5:  5b18198c477 !  5:  b956d1c2640 Makefile: rephrase the discussion of *_SHA1 knobs
    @@ Makefile: include shared.mak
      #
     -# Define OPENSSL_SHA1 environment variable when running make to link
     -# with the SHA1 routine from openssl library.
    -+# Define OPENSSL_SHA1 to link to the the SHA-1 routines from
    -+# the OpenSSL library.
    ++# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
    ++# library.
      #
      # === SHA-256 backend ===
      #
 6:  73685592aba =  6:  1e4695d0ba0 Makefile: document default SHA-256 backend
 7:  05edcfb9cd9 !  7:  847be3d32e2 Makefile: document SHA-1 and SHA-256 default and selection order
    @@ Commit message
         we'd error out if conflicting flags were provided, but per the
         discussion downhtread of[1] the consensus was to keep theses semantics.
     
    -    This behavior make it easier to e.g. integrate with autoconf-like
    +    This behavior makes it easier to e.g. integrate with autoconf-like
         systems, where the configuration can provide everything it can
         support, and Git is tasked with picking the first one it prefers.
     
    @@ Makefile: include shared.mak
      #
     +# ==== Default SHA-1 backend ====
     +#
    -+# If no *_SHA1 backend is picked we'll fall fall back on using the
    -+# default.
    ++# If no *_SHA1 backend is picked we'll fall back on using the default.
     +#
     +# Multiple *_SHA1 backends can be selected, the first supported one
     +# listed in "Other SHA-1 implementations" will be picked.
    @@ Makefile: include shared.mak
     -# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
     -# with git (in the block-sha1/ directory).
     -#
    - # Define OPENSSL_SHA1 to link to the the SHA-1 routines from
    - # the OpenSSL library.
    + # Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
    + # library.
      #
     +# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
     +# with git (in the block-sha1/ directory).
 8:  859e69fbe9f !  8:  0af3ea78eaf Makefile: document default SHA-1 backend on OSX
    @@ Makefile: include shared.mak
      #
     +# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
     +# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
    -+# default on that OS. We'll define NO_APPLE_COMMON_CRYPTO on Mac OS
    -+# 10.4 or older ("Tiger", released in early 2005).
    ++# default on that OS. On macOS 01.4 (Tiger) or older,
    ++# NO_APPLE_COMMON_CRYPTO is defined by default.
     +#
      # === SHA-256 backend ===
      #
 9:  c1f27255d3e !  9:  9045ff9c4ed Makefile: discuss SHAttered in *_SHA{1,256} discussion
    @@ Makefile: include shared.mak
     +#
      # ==== Default SHA-1 backend ====
      #
    - # If no *_SHA1 backend is picked we'll fall fall back on using the
    + # If no *_SHA1 backend is picked we'll fall back on using the default.
     @@ Makefile: include shared.mak
      #
      # === SHA-256 backend ===
-- 
2.38.0.1251.g3eefdfb5e7a

