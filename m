Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F9C0502C
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 09:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiHaJTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiHaJTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 05:19:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57EC32F7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:18:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so6355543wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EvGvmfoEUjMXv5Qn4YjH8vIjXfmZlDvKzJMTUON/AwY=;
        b=hOfRnO6SNBj6ZK50WwoIT1x5KHAh/Wiuo8jnotSFvPI/oCZomOCbWtMQ1UYQWEzbwN
         2R0ULTcYWLsmffJ9KuimBiTCIYgSY5hKgSHXNpZMU56k9rVLPnzP9Dsm30HzT96d7u8c
         GNfa2wIaxo+ROSrk2f2V9hXMO2gHP0UFTZsSDUqZLxduMgdfx4lyyH5AeOqs0ALiNRe3
         hAt/xwFsKgJ2OTC2f2zgIQQFJ10BXY9Qy7iJwdpcsXSVTJcfzKyJwoFZHrlzUomJMYpu
         KTYKErEBddc87kXZ6pqjdUfBapUGm7+rnFSbwiqXg/uT6qfDzvyWxPQfeTa94sXnvPRu
         aTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EvGvmfoEUjMXv5Qn4YjH8vIjXfmZlDvKzJMTUON/AwY=;
        b=OqgDdmiMCpQuWMyzDzcWjWGlXZzj86XYWF/YthTBvJlOIXWfCsKIgN0oYyw19FPVxB
         oJEpT7V6EKYlQPYdMWoJXhlJlkZiLuZMeLglVJZ26eXEkT19izalIN1jyiydd37xSef2
         nTnq7WPNgpdWrd3/UQvcdWlE88WQK3+TZqD60rVcdwgaUNP+znb5Sua2Z0HmeQvhH1hl
         cpZGps1so2tlSAswPnf3bo05IrvrwXJdOWeA9MChgtbdnHcLVEpBYZNfesr0N2f+Qddn
         FO1hDNhRbgnWuvdihXqoelqjCaK88ejbP1+51zjchkN0oC0nth8NhgBHrQlUrR17eaNZ
         o5Gw==
X-Gm-Message-State: ACgBeo1la1RpD0XknFOs8AJhkxY6x9sC9wtoR7ZK6MFiaqiSrp81cDZ1
        dQl2jTg6ute3afA0OU1mvyfIYJ0YcnUxoQ==
X-Google-Smtp-Source: AA6agR7inPBEwKUAaa9u1PBi+gRLHoRRRAkMQAvzf4Hvedv6yaSoWYBPlTjH7JBEfTqr8/o0A2CRag==
X-Received: by 2002:a05:600c:4f53:b0:3a8:3e30:83fd with SMTP id m19-20020a05600c4f5300b003a83e3083fdmr1326615wmq.143.1661937527879;
        Wed, 31 Aug 2022 02:18:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003a2e92edeccsm1558740wmq.46.2022.08.31.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 02:18:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] Makefile + hash.h: remove PPC_SHA1 implementation
Date:   Wed, 31 Aug 2022 11:18:42 +0200
Message-Id: <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
References: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] sent back in March. It removes the PPC_SHA1
implementation, which as noted in in 1/2 is likely completely unused
at this point, if anyone's using it we have other better tested (and
just as fast) SHA-1 implementations.

I then included this change in a larger series sent in late April[2],
which stalled for lack of feedback from the OSX crowd[3].

But this part should be uncontroversial, and is an obvious win in
terms of the diffstat, and in reducing our complexity surface in this
area.

Changes since v2:

 * Much rewritten commit message (see range-diff)
 * Rebased on upstream changes
 * More PPC_SHA1 removal of comments/docs that I missed the first time
   around.
 * The s/C_OBJS/OBJECTS/ Makefile change is now split into a new 2/2.
 * Added brian's Acked-by, per [4] (not explicitly an "Acked-by", but
   I thought adding amounted to a fair paraphrasing of the feedback
   there)

1. https://lore.kernel.org/git/patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com/
3. https://lore.kernel.org/git/xmqqv8v17xrl.fsf@gitster.g/
4. https://lore.kernel.org/git/Yjjr9fkybVmB53M7@camp.crustytoothpaste.net/

Ævar Arnfjörð Bjarmason (2):
  Makefile + hash.h: remove PPC_SHA1 implementation
  Makefile: use $(OBJECTS) instead of $(C_OBJ)

 INSTALL           |   3 +-
 Makefile          |  22 ++---
 block-sha1/sha1.c |   4 -
 configure.ac      |   3 -
 hash.h            |   6 +-
 ppc/sha1.c        |  72 ---------------
 ppc/sha1.h        |  25 ------
 ppc/sha1ppc.S     | 224 ----------------------------------------------
 8 files changed, 9 insertions(+), 350 deletions(-)
 delete mode 100644 ppc/sha1.c
 delete mode 100644 ppc/sha1.h
 delete mode 100644 ppc/sha1ppc.S

Range-diff against v2:
1:  e77fd23a824 ! 1:  87a204b8937 ppc: remove custom SHA-1 implementation
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ppc: remove custom SHA-1 implementation
    +    Makefile + hash.h: remove PPC_SHA1 implementation
     
         Remove the PPC_SHA1 implementation added in a6ef3518f9a ([PATCH] PPC
         assembly implementation of SHA1, 2005-04-22). When this was added
         Apple consumer hardware used the PPC architecture, and the
         implementation was intended to improve SHA-1 speed there.
     
    -    Since it was added we've moved to DC_SHA1 by default, and anyone
    -    wanting hard-rolled non-DC SHA-1 implementation can use OpenSSL's via
    -    the OPENSSL_SHA1 knob.
    +    Since it was added we've moved to using sha1collisiondetection by
    +    default, and anyone wanting hard-rolled non-DC SHA-1 implementation
    +    can use OpenSSL's via the OPENSSL_SHA1 knob.
     
    -    I'm unsure if this was ever supposed to work on 64-bit PPC. It clearly
    -    originally targeted 32 bit PPC, but there's some mailing list
    -    references to this being tried on G5 (PPC 970). I can't get it to do
    -    anything but segfault on the BE POWER8 machine in the GCC compile
    -    farm. Anyone caring about speed on PPC these days is likely to be
    -    using IBM's POWER, not PPC 970.
    +    The PPC_SHA1 originally originally targeted 32 bit PPC, and later the
    +    64 bit PPC 970 (a.k.a. Apple PowerPC G5). See 926172c5e48 (block-sha1:
    +    improve code on large-register-set machines, 2009-08-10) for a
    +    reference about the performance on G5 (a comment in block-sha1/sha1.c
    +    being removed here).
     
    -    There have been proposals to entirely remove non-DC_SHA1
    -    implementations from the tree[1]. I think per [2] that would be a bit
    +    I can't get it to do anything but segfault on both the BE and LE POWER
    +    machines in the GCC compile farm[1]. Anyone who's concerned about
    +    performance on PPC these days is likely to be using the IBM POWER
    +    processors.
    +
    +    There have been proposals to entirely remove non-sha1collisiondetection
    +    implementations from the tree[2]. I think per [3] that would be a bit
         overzealous. I.e. there are various set-ups git's speed is going to be
         more important than the relatively implausible SHA-1 collision attack,
         or where such attacks are entirely mitigated by other means (e.g. by
         incoming objects being checked with DC_SHA1).
     
    -    The main reason for doing so at this point is to simplify follow-up
    -    Makefile change. Since PPC_SHA1 included the only in-tree *.S assembly
    -    file we needed to keep around special support for building objects
    -    from it. By getting rid of it we know we'll always build *.o from *.c
    -    files, which makes the build process simpler.
    +    But that really doesn't apply to PPC_SHA1 in particular, which seems
    +    to have outlived its usefulness.
    +
    +    As this gets rid of the only in-tree *.S assembly file we can remove
    +    the small bits of logic from the Makefile needed to build objects
    +    from *.S (as opposed to *.c)
     
    -    As an aside the code being removed here was also throwing warnings
    -    with the "-pedantic" flag, but let's remove it instead of fixing it,
    -    as 544d93bc3b4 (block-sha1: remove use of obsolete x86 assembly,
    -    2022-03-10) did for block-sha1/*.
    +    The code being removed here was also throwing warnings with the
    +    "-pedantic" flag, it could have been fixed as 544d93bc3b4 (block-sha1:
    +    remove use of obsolete x86 assembly, 2022-03-10) did for block-sha1/*,
    +    but as noted above let's remove it instead.
     
    -    1. https://lore.kernel.org/git/20200223223758.120941-1-mh@glandium.org/
    -    2. https://lore.kernel.org/git/20200224044732.GK1018190@coredump.intra.peff.net/
    +    1. https://cfarm.tetaneutral.net/machines/list/
    +       Tested on gcc{110,112,135,203}, a mixture of POWER [789] ppc64 and
    +       ppc64le. All segfault in anything needing object
    +       hashing (e.g. t/t1007-hash-object.sh) when compiled with
    +       PPC_SHA1=Y.
    +    2. https://lore.kernel.org/git/20200223223758.120941-1-mh@glandium.org/
    +    3. https://lore.kernel.org/git/20200224044732.GK1018190@coredump.intra.peff.net/
     
    +    Acked-by: brian m. carlson" <sandals@crustytoothpaste.net>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## INSTALL ##
    @@ Makefile: include shared.mak
      # Define DC_SHA1 to unconditionally enable the collision-detecting sha1
      # algorithm. This is slower, but may detect attempted collision attacks.
      # Takes priority over other *_SHA1 knobs.
    -@@ Makefile: ifdef OPENSSL_SHA1
    - 	EXTLIBS += $(LIB_4_CRYPTO)
    - 	BASIC_CFLAGS += -DSHA1_OPENSSL
    - else
    +@@ Makefile: ifdef APPLE_COMMON_CRYPTO
    + 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
    + endif
    + 
     +ifdef PPC_SHA1
    -+$(error PPC_SHA1 has been removed! Use DC_SHA1 instead, which is the default)
    ++$(error the PPC_SHA1 flag has been removed along with the PowerPC-specific SHA-1 implementation.)
     +endif
    - ifdef BLK_SHA1
    ++
    + ifdef OPENSSL_SHA1
    + 	EXTLIBS += $(LIB_4_CRYPTO)
    + 	BASIC_CFLAGS += -DSHA1_OPENSSL
    +@@ Makefile: ifdef BLK_SHA1
      	LIB_OBJS += block-sha1/sha1.o
      	BASIC_CFLAGS += -DSHA1_BLK
      else
    @@ Makefile: missing_compdb_dir =
     -ASM_SRC := $(wildcard $(OBJECTS:o=S))
     -ASM_OBJ := $(ASM_SRC:S=o)
     -C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
    -+C_OBJ = $(OBJECTS)
    ++C_OBJ := $(OBJECTS)
      
      $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
      	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
    @@ Makefile: missing_compdb_dir =
      %.s: %.c GIT-CFLAGS FORCE
      	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
     
    + ## block-sha1/sha1.c ##
    +@@
    +  * try to do the silly "optimize away loads" part because it won't
    +  * see what the value will be).
    +  *
    +- * Ben Herrenschmidt reports that on PPC, the C version comes close
    +- * to the optimized asm with this (ie on PPC you don't want that
    +- * 'volatile', since there are lots of registers).
    +- *
    +  * On ARM we get the best code generation by forcing a full memory barrier
    +  * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
    +  * the stack frame size simply explode and performance goes down the drain.
    +
      ## configure.ac ##
     @@ configure.ac: AC_MSG_NOTICE([CHECKS for site configuration])
      # tests.  These tests take up a significant amount of the total test time
-:  ----------- > 2:  cb3bc8b5029 Makefile: use $(OBJECTS) instead of $(C_OBJ)
-- 
2.37.3.1406.g184357183a6

