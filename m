Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDFFC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E861B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhKPMJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhKPMFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EB7C0432C1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n29so37009307wra.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFT/DbJpzqPOAaYPdExqWjjX4T6Pif3T9PPaf7+1RWw=;
        b=VJmy8hka2W+BqzPnybfF0oGI2CuWUgEEwtW24d20PfGBtyQsBTvLtF5TIpl/hon3mg
         boFOl1XIOVyaMhYy13vNBIuCChjcW0AdWZ70d3AfeFQrcUDCdI25OBGbTn/Wb88LYmgE
         pziGi9u3mRLJUou7M23F+JxJEjPpLx3b+4MS+eWVfrf7PvQ7FmLrFhUVlT5LUcCJ4dAf
         REzkVQiv/YDISC1FelUm/D5vhAewQgZYL1XqxIS1JsKoTtUfhD1TnTJTfFDGmXglCN2Z
         tJzyMWyHdy6aijroZGAANuh0myHhf9ep1VwWH8u/qoWk4OGUGN4tJwFn0mzQRTLb9bqt
         Z8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFT/DbJpzqPOAaYPdExqWjjX4T6Pif3T9PPaf7+1RWw=;
        b=Hn0uGYDX21FXCVIQkehENBrAnCIEBpZJGnnLbbS8Jvk3ZPocIhCxoOBEvyKZYGI9/D
         A6vINAjosK50HoDwjozD/zdcA6Yj7hsOdaf6gaXGRU6IfXbpPKKulHh7mRW4LpXYlF2h
         TNl7ZTUn/Xz7WDa9iDtNF39JbfiU2cfzrI8ztV+LInDPGzn6uqsiHmkFv4PPjyl8Z2lk
         qlVtqJkv4uhIEWzXZtliHf4S8Ok7NVfsA/T99376t+5R36h2sOOZcdfW+sZ0izmYQXTF
         mmIhsyh3ou1X4ScFTkO5qhi764SchO+xZ5VrLwivtKeD/svx8L81fvPZaOJKmQLUy9nA
         1Ugw==
X-Gm-Message-State: AOAM533JvpXH8GSbIQiUufU7UfURBgH57gPeyz1Ht28JnIn/crJkFdSB
        ITxwrdeKAHfC1ebDCjmU2vAd7ew70magdA==
X-Google-Smtp-Source: ABdhPJxhn3smT/qnIS04iZVcx4qr6JKXAL+Tp3dB/x94cA7ZO/34QEOKxaCtODuCt1kTYxIcPJAfQg==
X-Received: by 2002:adf:f947:: with SMTP id q7mr8495421wrr.260.1637064054357;
        Tue, 16 Nov 2021 04:00:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 23/23] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Tue, 16 Nov 2021 13:00:23 +0100
Message-Id: <patch-v3-23.23-276e226f0a8-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
starts to benefit them. E.g. running the 'man" target is now ~1.3x
faster:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 -C Documentation man' 'make -C Documentation man' --warmup 10 -M 10
    Benchmark 1: make -C Documentation man' in 'HEAD~1
      Time (mean ± σ):      87.2 ms ±   1.0 ms    [User: 79.3 ms, System: 10.8 ms]
      Range (min … max):    86.3 ms …  89.7 ms    10 runs

    Benchmark 2: make -C Documentation man' in 'HEAD~0
      Time (mean ± σ):      64.5 ms ±   0.6 ms    [User: 54.5 ms, System: 13.0 ms]
      Range (min … max):    63.8 ms …  65.7 ms    10 runs

    Summary
      'make -C Documentation man' in 'HEAD~0' ran
        1.35 ± 0.02 times faster than 'make -C Documentation man' in 'HEAD~1'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 --
 shared.mak | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1041efb6e5e..d2cc6865a4e 100644
--- a/Makefile
+++ b/Makefile
@@ -2460,8 +2460,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
-.SUFFIXES:
-
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
diff --git a/shared.mak b/shared.mak
index 4862df1607a..a20193b0c8f 100644
--- a/shared.mak
+++ b/shared.mak
@@ -9,6 +9,11 @@
 %:: s.%
 %:: SCCS/s.%
 
+## Likewise delete default $(SUFFIXES). See:
+##
+##     info make --index-search=.DELETE_ON_ERROR
+.SUFFIXES:
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.34.0.795.g1e9501ab396

