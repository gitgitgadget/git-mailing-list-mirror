Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1260C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhLQBjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhLQBjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D1C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so621134wmd.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0OSJRQobVDPPh2nkhVhyctXBdpo95aFHvDe8JEvrlI=;
        b=HvAqKh8LmdrnULse3MTcgd5lnUA5huJtgV/NKNaobVk3OE3BV4a6kpmnlZ2+lgzPSX
         XJpWCXY2YCV5QrMXwcsPyGMzkhNsrbGTlLVrzGfI3fA/ecplf60BwnmK/O8ILK55y1Cv
         LGF489GxBb0i3fv717qqbDfMOBlvDZFTWHrIDVzjJGn+LRsKPhSfs8QZCTh1AI8p1vz5
         5O/hEoNxenp2RxikZcAsPgHndGB06vAffe4hEQ84WYeBNE50gpWPKO6jFgp+KjL0BSJP
         TwiNh5nuY52uL/tR8FtYT/BhWebX229nUEJCxwHIw3jv9GrHhyKnx5VIlwmR8JAWTQiv
         LW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0OSJRQobVDPPh2nkhVhyctXBdpo95aFHvDe8JEvrlI=;
        b=lndRsJA5UyV3gyrwOQq9B9M31BoIGMQ5n7+Q5X4P7tdi0uLW8NbUNgr+1x7EwNoacd
         Rj/e8omSayQ5Zs5osFS9G5lPAyszyZgZmat6V4Ptbtz/fExo/MYvmf7sEhF5ADeJqg0j
         Ad5ZtF6it0xp3hSUqb4FQrC6ZvR8iAedWKm2r+nTpw90sSs14jmO8vJV9MWyE42prSgr
         CnIz2aygBU8bkYggTPkSo1CXUx9Rk7GaX5Z0bkRvuwIpW8zWTrp06iXit3QLQJCK593L
         VtM7rF2w4NtoOyTM26QcB6WF4DkQSyvX2PNLbgwLdvwYRO/3I2luim2pEKnIT7AIww5I
         MvAQ==
X-Gm-Message-State: AOAM532B/vLImhl0ZHYigDf5mhmr7lQkjakiam0RBwNR23mhDwLO31Ib
        E3OlX5DqUxpPSkr+BuG0NmCsUZnItIPbRA==
X-Google-Smtp-Source: ABdhPJybV3euaHl+k0tZAk/t+wOp+guIWXrKu2m9AG16ALH3i0aquYM2uw6sUXvfhDhxUO/hKsIJ6w==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr7333861wmq.164.1639705175256;
        Thu, 16 Dec 2021 17:39:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:34 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Fri, 17 Dec 2021 02:39:22 +0100
Message-Id: <patch-4.8-ed64cd1bd4a-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 --
 shared.mak | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d290a28671a..50359603dbc 100644
--- a/Makefile
+++ b/Makefile
@@ -2543,8 +2543,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
-.SUFFIXES:
-
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
diff --git a/shared.mak b/shared.mak
index 29f0e69ecb9..155ac84f867 100644
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
2.34.1.1119.g7a3fc8778ee

