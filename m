Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FCC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiK2OJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiK2OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 09:09:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A45D5FB94
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so34133103ejh.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwH4/6NwQWWSsPjtqoIcS7LKf3MBF4D2MdfVYtdQ8mA=;
        b=H+C+QDTDL2bxXZCen6LZp5XqvdSxE20pPjhhiTJdtl+iBInLWgkOTLsnLtnUaxa2qT
         2Mqo+WtWRwhk1sLwDBH8s6MDKoMX/4qwmXS9So18rkAikxeIw7qmLKVAbsm1be21Xm8x
         65FS3m7co+lntHTOGb8BG5ivSaOvnXZbM7spkNVADzF/t2u0CaQztue0YgB2pFUi2k9O
         2mlnY5BhEfPr0JbGT+gYZqCeHUslB4K90YMoSaadq+Z2M+QlSLEXsdZIlNLazutcfE3s
         BC6sBHZMT5wCm2cEM4nmLfApbz11M7eyxAApdoP/8E2nEtyH5fl0sCCixcTjHVG8/khD
         UHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwH4/6NwQWWSsPjtqoIcS7LKf3MBF4D2MdfVYtdQ8mA=;
        b=g8XMs4asuNHEyBc2unjX7gn060dcFJUILI4L5r//bIxr9yAmWlg2OgWh5U70HlL1Qt
         CO7eaVxuIRZfvWlKZf3AuPZ7/cI1AxMHyxSZR2BdBYihKAug7fVxbn15KQWmu7Vpdp2b
         lj8XvxkMG1IyO4qe+tpgjvHuwpMlnyv2fJI4W2hVMN5D2bCNfPIIMfVm0qR3mmkwGa/C
         cC0FpxuQPdmZLJbpXiuQ4LC7Yc5ZrWWWrn/HUuo4d4VfYXh+FrcjFUdCWTSPesmVzwOw
         web8L96Qwqq++mGtRNE+cHG0d4xAnrrQiZSJrU5kESlgAIQEHoEt4ghezpwSEBMNvQjc
         Xagg==
X-Gm-Message-State: ANoB5pnX6Vfk6G5tJAMJwvNRxQ3YYuW53VZKRfLdZb0zRE60z+YIAUKc
        7dUCR+KwQrDbLUsDEw99efsoaghOCYsyqw==
X-Google-Smtp-Source: AA0mqf5SC9oOhSzl8wdlVdOuDa7BgR1YF5vVcWPkhqOAoku1b2c0eWh9A4cC9csTkEo437SOMUp3YA==
X-Received: by 2002:a17:906:6dd7:b0:7a1:1c24:e564 with SMTP id j23-20020a1709066dd700b007a11c24e564mr36315867ejt.629.1669730962266;
        Tue, 29 Nov 2022 06:09:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id be14-20020a0564021a2e00b00463597d2c25sm6307907edb.74.2022.11.29.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:09:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
Date:   Tue, 29 Nov 2022 15:09:16 +0100
Message-Id: <patch-v2-3.4-6db7dd74e52-20221129T140159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.993.g0c499e58e3b
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
References: <20221127224251.2508200-1-psmith@gnu.org> <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
changed in a backward-incompatible way, as its "NEWS" file notes:

  Previously only simple (one-letter) options were added to the MAKEFLAGS
  variable that was visible while parsing makefiles.  Now, all options are
  available in MAKEFLAGS.  If you want to check MAKEFLAGS for a one-letter
  option, expanding "$(firstword -$(MAKEFLAGS))" is a reliable way to return
  the set of one-letter options which can be examined via findstring, etc.

This upstream change meant that e.g.:

	make man

Would become very noisy, because in shared.mak we rely on extracting
"s" from the $(MAKEFLAGS), which now contains long options like
"--jobserver-auth=fifo:<path>", which we'll conflate with the "-s"
option.

So, let's change this idiom we've been carrying since [1], [2] and [3]
as the "NEWS" suggests.

Note that the "-" in "-$(MAKEFLAGS)" is critical here, as the variable
will always contain leading whitespace if there are no short options,
but long options are present. Without it e.g. "make --debug=all" would
yield "--debug=all" as the first word, but with it we'll get "-" as
intended. Then "-s" for "-s", "-Bs" for "-s -B" etc.

1. 0c3b4aac8ec (git-gui: Support of "make -s" in: do not output
   anything of the build itself, 2007-03-07)
2. b777434383b (Support of "make -s": do not output anything of the
   build itself, 2007-03-07)
3. bb2300976ba (Documentation/Makefile: make most operations "quiet",
   2009-03-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-gui/Makefile | 2 +-
 shared.mak       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 56c85a85c1e..a0d5a4b28e1 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -116,7 +116,7 @@ ifeq ($(uname_S),Darwin)
 	TKEXECUTABLE = $(shell basename "$(TKFRAMEWORK)" .app)
 endif
 
-ifeq ($(findstring $(MAKEFLAGS),s),s)
+ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
 QUIET_GEN =
 endif
 
diff --git a/shared.mak b/shared.mak
index be1f30ff206..aeb80fc4d5a 100644
--- a/shared.mak
+++ b/shared.mak
@@ -37,13 +37,13 @@ space := $(empty) $(empty)
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-ifneq ($(findstring w,$(MAKEFLAGS)),w)
+ifneq ($(findstring w,$(firstword -$(MAKEFLAGS))),w)
 PRINT_DIR = --no-print-directory
 else # "make -w"
 NO_SUBDIR = :
 endif
 
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 ## common
 	QUIET_SUBDIR0  = +@subdir=
-- 
2.39.0.rc0.993.g0c499e58e3b

