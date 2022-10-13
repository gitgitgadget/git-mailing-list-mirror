Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D4C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJMPlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJMPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE740552
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l32so1460589wms.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUGCq7uSC6IH5NBFyax5sUExXC5H3CCmj6jVcUWg98M=;
        b=F/kzXoltzgg1ZkmR0tcEIp2DYLpZ33ZDYv0O/qm28M1bWYEdxVnZir7ELrzVsLFAsT
         cGKlnjLj0A6Zedf1HXyluE/jp4EJe/FyQZ9o79VxixZOH5UcpEzMGjnA1aQIB0C8fX7w
         aHo1CtuHFhgaxS5j/3P3J1B7dXMGS75aKBIFETSB4Zn3cq0EtRUm4aDk5CtLuND0CjYX
         YuV51/YcWcS4zGiTrXI2nTPVie8U/8GlzOPjDd28iNMtJmITkzQMGu++MlCN9HbICA2E
         xvDd0KJgTC0NFYJtavPaeWTVuwkeIMRpxpGs2P/fbW3b6z9q5RLskbB5M+8jlcm206Mv
         AEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUGCq7uSC6IH5NBFyax5sUExXC5H3CCmj6jVcUWg98M=;
        b=ijNsmRnLixIDWru/KoEwCEHmT99U/rd1RM9VYhXMx6vWWk48YHCXC0RxQY3JlH6qsZ
         MUR5qI1oGtBGLvg7Dnouwez/BcDjEK6ck9GeMKuE5+RXg/08Hb4kC39ItxN3qeN5sSsO
         Jbal1GlmULtmqarB/e1FKFEuMsQDWOVV4mlCrMQDsU67MSHxptfksGj78JphzLIUsb9L
         /CBNJyPJ+KmpNv9oWiSZgYvmJqFRDtrTP7Dg1qraPY88rMC8mwEXPmE1Sq8lzR72pFZN
         EGpW3vyR73mbFJTOxm0a/TiLN4x+dKL6GoPIpqShifk8CnZF2bus8Hw6VhwkExc5orC6
         fxJQ==
X-Gm-Message-State: ACrzQf1iLvbySl70USVk8lIMZRzc6PeW96jov8pSETyfnlRshBS74ZE9
        cUYgl/MBwaD4L3VtNvo1er0nNphLay/qfA==
X-Google-Smtp-Source: AMsMyM78N1EShChtriDbJl5/kZzUwYC7MauL6vMVMfhxxz9XO1Tyspa4PguS2SWMq3tjoY72WrRvNw==
X-Received: by 2002:a05:600c:4fd2:b0:3c6:db8a:4d2a with SMTP id o18-20020a05600c4fd200b003c6db8a4d2amr303503wmq.178.1665675595586;
        Thu, 13 Oct 2022 08:39:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 20/34] doc txt & -h consistency: make "rerere" consistent
Date:   Thu, 13 Oct 2022 17:39:14 +0200
Message-Id: <patch-v5-20.34-058b22e22f7-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For "rerere" say "pathspec" consistently, and list the subcommands in
the order that they're discussed in the "COMMANDS" section of the
documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-rerere.txt | 2 +-
 builtin/rerere.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 9d0e6f53e7e..992b469270c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear | forget <pathspec> | diff | remaining | status | gc]
+'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
 
 DESCRIPTION
 -----------
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 12570537d37..8b7392d5b44 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -10,7 +10,7 @@
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <pathspec>... | status | remaining | diff | gc]"),
+	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
 	NULL,
 };
 
-- 
2.38.0.1085.gb7e61c3016c

