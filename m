Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BCC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiBYJFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiBYJFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EDB22B97A
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d3so3435185wrf.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqI8quXYWLmK2qrouZsAoBBEUl+pFc7o2mK4jMw6jZY=;
        b=VscmXYeqxzo4K2Yery2XJRx7YyN7FXJ2MqKEutV9cDBLF39m/FQ+tnnVxvfZb63eWT
         UXwBnpqMuG7CjyV5c20rIHSU+kzH1/+xavHCT3sHOxfDDbz+rGnZ8afVxPXuPWZY5hJx
         cdJX3ygq/aDMKayr0xy8YzhsptWCCKQ38x63Vnm6ge8X6AaTE6VAqGd5/KT2VW+wAGaU
         YwTCv3XlgkKSo4Jhm6xAQMOKf320X8WhdgQImsQdUCEA7iH+bSRNj+qQrZxZHAjoMtRK
         UEm0g9jSzk/nsx0k6Snp71R3R7/TsBl+k0NX5n5GFviW8qfmNQ/Re9T4EuvukJR5gLNN
         D+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqI8quXYWLmK2qrouZsAoBBEUl+pFc7o2mK4jMw6jZY=;
        b=seHXnzA+S1GbcHv6+Ne78GJ/Fl41MoNH9Y5CpRVJ4zuHcwCNxlsvahUA9Lai+3kX/0
         tNfslVRZlDYlXmZUvEkUTgALwmXDBtBeFp+2iZ9ci5O21FYN7ElKYya4MZXOSvI1ebXo
         NKVqvQY8JE1Xiy2qplWEjimQTFhdq/dGUpZQ3NZfFg2UPytEQrS2MAK6/kazDtdsqMpT
         M+Qv044ip3xDwKQAUhIzzbzrPk9q4cDke69IGhWw5Da7ITK0KPw4HFZEx94MSsrPYTb3
         Mni97Rur/cCGjOAbdDtwlRTaIpwtviLtEwLMkKWCBkA0tSK+uV4jcPsVsuckkTErI6vr
         s5EA==
X-Gm-Message-State: AOAM533bq7q3MMVMF4J+LDXcPE1NtGPii/By2xQ5pLMceL7/iAQwLFqI
        DIHTojlx112sC38YcNRu2BUmXf1gRm3jAw==
X-Google-Smtp-Source: ABdhPJyJfpWByM8CqSHHB/S664QpfjgATMmiMV3SSAhu5SS5Y/NylAbPC3fc3sIHzZ/DyJNNucNxow==
X-Received: by 2002:adf:e183:0:b0:1ed:e25f:afc3 with SMTP id az3-20020adfe183000000b001ede25fafc3mr5456376wrb.545.1645779878570;
        Fri, 25 Feb 2022 01:04:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] Makefile: optimize noop runs, add shared.mak
Date:   Fri, 25 Feb 2022 10:04:26 +0100
Message-Id: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the v1 notes (among other things):
https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com/

    This speeds up noop runs of "make" by a lot. After a "make" running a
    "make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
    as fast with "make -j1 NO_TCLTK=Y" (the TCL part takes a lot of time,
    but that's another matter).

This v3 re-roll:

 * Addresses a minor comment/documentation issue pointed out by Taylor
   Blau.

 * Adjusts the ".SUFFIXES" commit message to note the source of the
   speed-up from that change, in response to a question from Taylor.

 * Changes the contrib/scalar/Makefile to make use of the new
   shared.mak, which allows for deleting some copy/pasted code in it
   in favor of the same shared logic.

   The original version of these patches was written before that file
   landed in-tree.

For v2, see: https://lore.kernel.org/git/cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  scalar Makefile: set the default target after the includes
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 Documentation/Makefile    |  63 ++------------------
 Makefile                  | 118 ++++++++++++--------------------------
 config.mak.uname          |   1 -
 contrib/scalar/Makefile   |  19 ++----
 contrib/scalar/t/Makefile |   3 +
 shared.mak                | 109 +++++++++++++++++++++++++++++++++++
 t/Makefile                |   3 +
 t/interop/Makefile        |   3 +
 t/perf/Makefile           |   3 +
 templates/Makefile        |   8 +--
 10 files changed, 170 insertions(+), 160 deletions(-)
 create mode 100644 shared.mak

Range-diff against v2:
 -:  ----------- >  1:  2404c4d8b96 scalar Makefile: set the default target after the includes
 1:  97dccacce20 !  2:  96a490bec54 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
    @@ Makefile: shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
      
      # The generic compilation pattern rule and automatically
     
    + ## contrib/scalar/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../../shared.mak
    ++
    + QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    + QUIET_SUBDIR1  =
    + 
    +
    + ## contrib/scalar/t/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../../../shared.mak
    ++
    + # Run scalar tests
    + #
    + # Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
    +
      ## shared.mak (new) ##
     @@
     +### Flags affecting all rules
    @@ t/interop/Makefile
      export GIT_TEST_OPTIONS
      
     
    + ## t/perf/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../../shared.mak
    ++
    + -include ../../config.mak
    + export GIT_TEST_OPTIONS
    + 
    +
      ## templates/Makefile ##
     @@
     +# Import tree-wide shared Makefile behavior and libraries
 2:  b2bf32ab071 =  3:  9392e3c3e97 Makefile: disable GNU make built-in wildcard rules
 3:  275aba624fa =  4:  07cf9daa9d6 Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
 4:  7103c40de64 !  5:  16f2e3ff35b Makefile: move ".SUFFIXES" rule to shared.mak
    @@ Commit message
               'make -C Documentation -j1 man' in 'HEAD~0' ran
                 1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'
     
    +    The reason for that can be seen when comparing that run with
    +    "--debug=a". Without this change making a target like "git-status.1"
    +    will cause "make" to consider not only "git-status.txt", but
    +    "git-status.txt.o", as well as numerous other implicit suffixes such
    +    as ".c", ".cc", ".cpp" etc. See [1] for a more detailed before/after
    +    example.
    +
    +    So this is causing us to omit a bunch of work we didn't need to
    +    do. For making "git-status.1" the "--debug=a" output is reduced from
    +    ~140k lines to ~6k.
    +
    +    1. https://lore.kernel.org/git/220222.86bkyz875k.gmgdl@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ shared.mak
      
     +## Likewise delete default $(SUFFIXES). See:
     +##
    -+##     info make --index-search=.DELETE_ON_ERROR
    ++##     info make --index-search=.SUFFIXES
     +.SUFFIXES:
     +
      ### Flags affecting all rules
 5:  4a5c647b5e7 =  6:  1b6ecb27f02 Makefile: move $(comma), $(empty) and $(space) to shared.mak
 6:  940299d2a03 !  7:  471067deefc Makefile: add "$(QUIET)" boilerplate to shared.mak
    @@ config.mak.uname: vcxproj:
      	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
      
     
    + ## contrib/scalar/Makefile ##
    +@@
    + # Import tree-wide shared Makefile behavior and libraries
    + include ../../shared.mak
    + 
    +-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    +-QUIET_SUBDIR1  =
    +-
    +-ifneq ($(findstring s,$(MAKEFLAGS)),s)
    +-ifndef V
    +-	QUIET_GEN      = @echo '   ' GEN $@;
    +-	QUIET_SUBDIR0  = +@subdir=
    +-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
    +-			 $(MAKE) $(PRINT_DIR) -C $$subdir
    +-else
    +-	export V
    +-endif
    +-endif
    +-
    + include ../../config.mak.uname
    + -include ../../config.mak.autogen
    + -include ../../config.mak
    +
      ## shared.mak ##
     @@
      comma = ,
 7:  1e13fee526d =  8:  510306d2219 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
 8:  250b32540d9 =  9:  85bb74aa32f Makefiles: add and use wildcard "mkdir -p" template
-- 
2.35.1.1175.gf9e1b23ea35

