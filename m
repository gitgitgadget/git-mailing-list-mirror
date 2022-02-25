Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B708C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiBYJFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbiBYJFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F773235317
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x15so3381671wrg.8
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UU5X4Bs1MY/YcD4ci+q2xLF+X5pDV4/L1exKw+sSyI=;
        b=g6+0+bXOI1uM15GVOx4gB3WKietrMlLeMreI+WHUlADRg/ILYYYu4yVB7MSYTNy+ou
         DijSM01a3DFfygOYXt4l40z/SrTkRLeLQdBK0iUmq9Ib6zfeJZNsr8LdjYwiTa/ueMEf
         orAtNc2tG+lQrRJtgJLET74bMvx6ierv3SKAbgrJqgs+6iVKNacjdOy9qkKlMp1VUmkD
         lFGtu2r7wjbe/hnCM1k519SpcIqnnaNSFkLq5baL0YpjCm8Jgn8mIO/sF/HvVaaLl1Tq
         pX9DadACy3zfe0gnjaW5YzRoKxYnubkDE/YwY/9EiO4aOdtsWA0D1DS6Y1OHPiiHlMuA
         XAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UU5X4Bs1MY/YcD4ci+q2xLF+X5pDV4/L1exKw+sSyI=;
        b=h26SaugnmEesdjY+bwTFHroNH+2QgApsmJYIlOsT2RAr1THsBpTw6jVDaL4evhMhTs
         o3pkiFYXZ4vdSvFZIBDUqe2uy1KIuD+7jTqKHvPeFmneOU1cbtHB9qMBkzFQYBbQ+i0j
         5L3ZDE6d7gJ3o3fw1bS83qyqAdKMTnU+/GKAppuAfqQ91gAxB4CrZXClVsIKMAkO96Ch
         eMcZbjbaOCy/AUJbFBWTkSE68vqRDBSLwaKWIqCwwi0f/WdIEA5Pwo5/NMTeiJAtiEya
         yGY7a1laM8HGli7fxoK3eO+QTsLpJnfv2nnKokuv9DNQF40DguAKvzmsO7CpJLfjUgqC
         oeGA==
X-Gm-Message-State: AOAM531WFAiNyHMg/Ase+nh5gqkiLUbSG9uMhl3cRGww00iShltb/BFd
        er0NVBPA7zbNXBClgD+Ej6MJqTplyUe2hQ==
X-Google-Smtp-Source: ABdhPJwnCpEz4H8RB8vAMsEpEJlKsMUFKZCRfk+uChj2cVyWmCd4iHEhezFRjDLTIv9Sa2JvQ8qOew==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id p17-20020a5d48d1000000b001e32401f229mr5294588wrs.694.1645779884313;
        Fri, 25 Feb 2022 01:04:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:43 -0800 (PST)
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
Subject: [PATCH v3 5/9] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Fri, 25 Feb 2022 10:04:31 +0100
Message-Id: <patch-v3-5.9-16f2e3ff35b-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added in 30248886ce8 (Makefile: disable default implicit
rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
apply to all our Makefiles.

This doesn't benefit the main Makefile at all, since it already had
the rule, but since we're including shared.mak in other Makefiles
starts to benefit them. E.g. running the 'man" target is now faster:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation man' 'make -C Documentation -j1 man'
    Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
      Time (mean ± σ):     121.7 ms ±   8.8 ms    [User: 105.8 ms, System: 18.6 ms]
      Range (min … max):   112.8 ms … 148.4 ms    26 runs

    Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
      Time (mean ± σ):      97.5 ms ±   8.0 ms    [User: 80.1 ms, System: 20.1 ms]
      Range (min … max):    89.8 ms … 111.8 ms    32 runs

    Summary
      'make -C Documentation -j1 man' in 'HEAD~0' ran
        1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'

The reason for that can be seen when comparing that run with
"--debug=a". Without this change making a target like "git-status.1"
will cause "make" to consider not only "git-status.txt", but
"git-status.txt.o", as well as numerous other implicit suffixes such
as ".c", ".cc", ".cpp" etc. See [1] for a more detailed before/after
example.

So this is causing us to omit a bunch of work we didn't need to
do. For making "git-status.1" the "--debug=a" output is reduced from
~140k lines to ~6k.

1. https://lore.kernel.org/git/220222.86bkyz875k.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 --
 shared.mak | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 185bfa71df3..1462016a3f4 100644
--- a/Makefile
+++ b/Makefile
@@ -2580,8 +2580,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
-.SUFFIXES:
-
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
diff --git a/shared.mak b/shared.mak
index 29f0e69ecb9..1dda948df09 100644
--- a/shared.mak
+++ b/shared.mak
@@ -9,6 +9,11 @@
 %:: s.%
 %:: SCCS/s.%
 
+## Likewise delete default $(SUFFIXES). See:
+##
+##     info make --index-search=.SUFFIXES
+.SUFFIXES:
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.35.1.1175.gf9e1b23ea35

