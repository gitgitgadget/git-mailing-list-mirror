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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC03C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AAB60462
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbhIAJVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243589AbhIAJVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:21:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870EC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 02:20:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o185so2875277oih.13
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MS5v5rBLWTHt01EM0/TvTuqmudhkafLQR+jqkNz4l2U=;
        b=TTk9gjnNOiIVT4/K6nJbuoUTfaPModIvT90vCdvRjhJCpf0wgVkk9vAQ9f24/6OHeS
         Gtrw+XNIu0rEjbrxxfmGaPHH8NY9y3uweUrqR0lcxu6M2AakqpMf8rPMbKTlKCCxLfA5
         HCLuy/Db9dvyNyGyl7PjmKg+ZWNLkENfWdZkegDAnz/zJNSVknAlc7cPxu75t+Vzorhh
         7MTT+RiSmOeqFRP4uZ3tCJzvitf5rGRhVbZO5U/6sfh0T5Vx/gniMzazYZwZSZ1i9P4U
         vM2Vf/2hUzIOwei2PGvBrByO93q/0tEh2qO/eleJiMXkySYJ8h8CwTMG8P1btDrETuJu
         ec0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS5v5rBLWTHt01EM0/TvTuqmudhkafLQR+jqkNz4l2U=;
        b=ug7WV5fFbMc7BHoyOUzvNy89P9+7p20jwbN6xeMPGy+J972c1RjZNu27w4zJXTOB3w
         4FcEqOKpjvzpXymBVfPf/7T8rURA426BN50oVL1s3N2Wh4gbKCvSfg8iMOyYqYVaiKV1
         rRiVn1hXBp3Y47n3vBeljRp6/eyHsjaGOG52lmRJ83oA28Yuy+PHlMb2vz4tocxWjRhu
         +Rvsh4Xz+NgMNxPu9zbkje+VWvYA8Yq3OKT6JPtKmwjLUWuBPb0SpTGvzwjlRucMwGUL
         9PjqTo4bPPsNC1Lr1QPk+WryexUiPdYkobR7PAmmB2akxy5S0/aRqs22qFP73bUU/Cys
         kAZA==
X-Gm-Message-State: AOAM531jc2SghNT04rrtaorGUHPw2OxiEvAdNW1jxO1FQ2f9f4UwPCjl
        n85vt0Kbbf6FsbUZ2STuBFZCR1bUL+c=
X-Google-Smtp-Source: ABdhPJxGaOMpKIpkSk0M9z1cBe7QEp5e0n+QhC+UJmCttFU9eOuAdfWF2uhR7aZZkARspanzvtb60Q==
X-Received: by 2002:a05:6808:bc2:: with SMTP id o2mr6710281oik.73.1630488022786;
        Wed, 01 Sep 2021 02:20:22 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s206sm4161597oif.44.2021.09.01.02.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:20:22 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2 2/4] developer: enable pedantic by default
Date:   Wed,  1 Sep 2021 02:19:39 -0700
Message-Id: <20210901091941.34886-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the codebase firmly C99 compatible and most compilers supporting
newer versions by default, could help bring visibility to problems.

reverse the DEVOPTS=pedantic flag to provide a fallback for people stuck
with gcc < 5 or some other compiler that either doesn't support this flag
or has issues with it, and while at it also enable -Wpedantic which used
to be controversial when Apple compilers and clang had widely divergent
version numbers.

ideally any compiler found to have issues with these flags will be added
to an exception, but leaving it open for now as a weather balloon.

[1] https://lore.kernel.org/git/20181127100557.53891-1-carenas@gmail.com/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile       | 4 ++--
 config.mak.dev | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4e94073c2a..f7a2b20c77 100644
--- a/Makefile
+++ b/Makefile
@@ -486,9 +486,9 @@ all::
 #        setting this flag the exceptions are removed, and all of
 #        -Wextra is used.
 #
-#    pedantic:
+#    no-pedantic:
 #
-#        Enable -pedantic compilation.
+#        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 41d6345bc0..76f43dea3f 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -2,8 +2,9 @@ ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Werror
 SPARSE_FLAGS += -Wsparse-error
 endif
-ifneq ($(filter pedantic,$(DEVOPTS)),)
+ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
+DEVELOPER_CFLAGS += -Wpedantic
 endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
-- 
2.33.0.481.g26d3bed244

