Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B7C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353343AbhLXRiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353329AbhLXRh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:37:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A079C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso7638910wmd.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeuXDZtSgxg3TECy2yjHo3NIVQcLYdfmDNvrxDf0hWc=;
        b=nKRBLGqt2rw1KMg3iDE3DJhes4zm3cwwP0bV9kNS8sgBxTdcxkur3s/+X1uJidTOrN
         dSL1GpaKbZqWHwrvFqMwhTWAA5Hqi44v0sOVWBk0NI04dQon5HfaVfbmy746FO9ss4Hw
         3wt3ioBWCGbwY8/Imulud3t6wbkvb1vIeXoTi6I/+kUFUjhklCq5FdXjWRfoMo6Nip4b
         iqdzJQmsdu9dnvix53YyX6eyFCXcxWiOpHuEVgPh430aIEi1qzwsXbJBkTRfq9S01dQj
         gopsqNbrf8KiO8ubzudRKpDucxnDOJrKOUrXgr49qU5kULynJJwM2kahMIRDBpd21rfj
         6oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeuXDZtSgxg3TECy2yjHo3NIVQcLYdfmDNvrxDf0hWc=;
        b=XVM6NEIL3Ef8alyk3X9b0czpgi3LuWKkiX6PV8AylVB6U8/QCAIJu5Rt24qMOpB9cp
         oB8ZM8BlR3LyqajAsFk5PpwaQpOkZ4rJDkBgx/GIe6GV4xVBBLok2MEFAsDOtwNAyZlU
         JmGkMrN6heU/yiCt0PGDEsoai5ClsInC0+znst8tT8cbTIX8NZbmIW2lwPln5E5HgYTw
         SPv8xOjPdrKXe8LgiS2C7l5MHcuIneNXFty5eikl/FD80U14LKivymTFl2roqHIEL9re
         Y0PcVFfNmGJnpuGqnrk9Zux0ZhcU4UyN3y19HrM25OgKovD2YlHPVHWo+BVmjIeB4+Mz
         GZlw==
X-Gm-Message-State: AOAM533wsuGMwatzZnkXkecWpWPPglJVyhl4zl1TdSc3+vMwVfD/ucZe
        QpcUUUMdzP2tUKsHtWZm2WDraXYnN0RFYigm
X-Google-Smtp-Source: ABdhPJxKXzPKw3aIA5Gu1jcrQm5ReRjdd0bd61STmjl4GrX8+TGo+CdTFZYFAnKGApinwUhpnD+Vhg==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr5395095wmq.151.1640367477864;
        Fri, 24 Dec 2021 09:37:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:57 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Fri, 24 Dec 2021 18:37:43 +0100
Message-Id: <patch-v2-4.8-4c6d8089fff-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
index d3ce0d22199..e30093b83d3 100644
--- a/Makefile
+++ b/Makefile
@@ -2549,8 +2549,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
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
2.34.1.1215.g6e154b84c77

