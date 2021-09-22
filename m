Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8B761211
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 10:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhIVKjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhIVKjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 06:39:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505CC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 03:38:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t7so5203093wrw.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NU7Ov5PeOKcR2OzXEJ9hKHTfUoGWdhzuqIPEVDDHN9c=;
        b=L4u+qpmvvGyotPYiuyGscGODC0pJHoPPMOLy6t5GwYv/WUs3Lt5n0/rVahOMlZArM5
         h3/uBzPdE6HDeBz3sX4U74E+HVztc9iEEr0mDgjGDXqsr5Ajpp2/Z3caiUWT2JjqQGUV
         VnS/SmnZtg0twOsq0HR4oT7JQ/LpX9LbdZlyA96KuRqcF/BsdzKA0EAT9MzWRy2IhJF0
         H4jRhIbRCQfmbGJsWf0lAYvSLlMNlZW9yDBvd7VxYfQnAbyd+RXXBYAXiKMSmb2O2092
         X/P/JgFFTmPUJN0ZMOLrn9vIvbXI2jKCvgdgDOjNby70qrtFjEtrkz2bp60s95R/aVia
         /wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NU7Ov5PeOKcR2OzXEJ9hKHTfUoGWdhzuqIPEVDDHN9c=;
        b=uq18SZYPBwbY8s7JE+jbJS/e/jiHAUtwKTi5C+KvLdU4BNFfmb6MxWj4PCfNbDjELt
         WE256KY9yer1m8MBYSYFV6VRQ9zINfDheXIF6mhOTD7tvVn+rdsNldFg6+hEnm1343lq
         01ZGJs78500fUDhQH0cmMKFswXRwAcRkC/NwjKWtWsPukn/ma3XWzh3k868cgEUs/paW
         P1I7HMcLkSkLFaT6UaZCbj3ID2yA5sc8/ymPOxvpq+LMgTwLKVnunHBMwRaDS6G38coi
         tGmu2gX65erC80w3BLNK0GwnnKF3Lks4wswgoZLIA5GNccBuKuMMDMI10uZK3j17K1Zi
         II/w==
X-Gm-Message-State: AOAM5307kh7QXG8IwW5jYZ5vWL5B7gEu2dV/c2JFCs//AI12CJckjATb
        WMqQckJ1h9abGTXoiLSlTYc7iwG+Yti5Ww==
X-Google-Smtp-Source: ABdhPJwS2op1C1b+nE9Gh7GY1g1UVxE8bc2E0aTsPn027QuXAWcTv4dWA/H/Ty3Xax2XBjceJEGxQg==
X-Received: by 2002:a1c:8096:: with SMTP id b144mr9638146wmd.189.1632307101301;
        Wed, 22 Sep 2021 03:38:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y64sm1669474wmc.38.2021.09.22.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 03:38:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
Date:   Wed, 22 Sep 2021 12:38:07 +0200
Message-Id: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g17f21f53d74
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
use auto-detection in [2]. Then when -Wpedantic support was added to
DEVOPTS in [3] we started passing -Wpedantic in combination with
-Werror to the compiler here.

This broke the auto-detection, but since we'd quieted it in [4] we
didn't find out. It was emitting all of this on STDERR under GCC:

    /dev/null:1: error: ISO C forbids an empty translation unit
    [-Werror=pedantic]
    cc1: note: unrecognized command-line option
    ‘-Wno-pedantic-ms-format’ may have been intended to silence
    earlier diagnostics
    cc1: all warnings being treated as errors

Let's fix that bug by maintaining a NON_DEVELOPER_CFLAGS, it's like
ALL_CFLAGS but without anything we add in config.mak.dev, and
furthermore stop redirecting STDERR to /dev/null, this means that
someone whose compiler doesn't support this will see this output, but
also this new message:

    Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect

It's also possible that some compilers will emit warnings but still
give a zero exit code, anyone using a compiler like that will
potentially get more verbose output from the Makefile until they set
COMPUTE_HEADER_DEPENDENCIES=no. E.g. on AIX's xlc we'll now emit:

    /opt/IBM/xlc/13.1.3/bin/.orig/xlc: 1501-208 (S) command option D is missing a subargument
    Non-zero 40 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect

And on Solaris with SunCC:

    cc: Warning: Option -x passed to ld, if ld is invoked, ignored otherwise
    cc: refused to overwrite input file by output file: /dev/null
    cc: Warning: Option -x passed to ld, if ld is invoked, ignored otherwise
    cc: refused to overwrite input file by output file: /dev/null
    Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect

Both are quieted by setting COMPUTE_HEADER_DEPENDENCIES=no as
suggested.

I considered piping the output and the exit code to a variable
instead, but e.g. under GCC that would lose the coloring in the error
messages.

1. f2fabbf76e4 (Teach Makefile to check header dependencies,
   2010-01-26)
2. 111ee18c31f (Makefile: Use computed header dependencies if the
   compiler supports it, 2011-08-18)
3. 729b3925ed9 (Makefile: add a DEVOPTS flag to get pedantic
   compilation, 2018-07-24)
4. 6a8cbc41bac (developer: enable pedantic by default, 2021-09-03)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9df565f27bb..c30f3b8b204 100644
--- a/Makefile
+++ b/Makefile
@@ -1242,7 +1242,8 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
 endif
 
-ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
+NON_DEVELOPER_CFLAGS = $(CPPFLAGS) $(CFLAGS)
+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(NON_DEVELOPER_CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 comma := ,
@@ -1277,13 +1278,14 @@ COMPUTE_HEADER_DEPENDENCIES = auto
 endif
 
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
-dep_check = $(shell $(CC) $(ALL_CFLAGS) \
+dep_check = $(shell $(CC) $(NON_DEVELOPER_CFLAGS) \
 	-c -MF /dev/null -MQ /dev/null -MMD -MP \
-	-x c /dev/null -o /dev/null 2>&1; \
+	-x c /dev/null -o /dev/null; \
 	echo $$?)
 ifeq ($(dep_check),0)
 override COMPUTE_HEADER_DEPENDENCIES = yes
 else
+$(info Non-zero $(dep_check) exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect)
 override COMPUTE_HEADER_DEPENDENCIES = no
 endif
 endif
-- 
2.33.0.1225.g17f21f53d74

