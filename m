Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CCC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiKRLbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiKRLbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FA74CED
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so3011593ejc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA34uPcQWau48dvkw+c5Td/GrehN0vN8q6oyGyx5Gxw=;
        b=HfTjck8o1Eicb5/Avr2QcH6a5AtQzo9munTz/IEyaNTeT4rns5i0AwiTbGRZzTEbb4
         F+pr05W7SXBP1QJ3Iki6wxhs7/9C3oX8R4qGE63uORZagC5a2p3P3/J4yCr5kQp/1Lq3
         /wpqPdxKJEnWSF2Ffu6as5Z6D0EsQIyFjBVmdKaCjPAJ+J+SiP8ums6z7dKwhcuOa/e6
         i2Qco/obTtYlY2WD4Ns2qY8zEWmrLRreLIeLw9ZwzczTYQlxBrg1QbNOalLheM1mYRkx
         RA+vdo9I90GhlZfoWYHQfsFmuBK9uu2JdYIyaWQHpeENUqb5jjxLRuQFroN2kM4FMJ5+
         ICng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA34uPcQWau48dvkw+c5Td/GrehN0vN8q6oyGyx5Gxw=;
        b=OMMIJncToBapaEa8nflvvB4MtO7RcR6AWrlHwOkfVmcfQbWSzv7yzYftBf/K7IbsN9
         TFIr4XBNZK83snr7kbpNj/MmjIkaZfqhWum1A1uhVm4L0y+8JPp25AbgWwSL55Moj4gv
         OTILh/cXkuaDkF9ihH1H/sVXVoXFPmnPqvCT2DuUAwHbtdr96aTsBU4vWNWomCaMx5jG
         aQxHDPon6J3AJH674Fcdc9LS+sms78O5TkuvyiJxYD8FaPkgjlyXNLr9vzzqVOgg699I
         xMLNrKy/k/6dsPs/zKTTCFRQlK3mxaJPjRnUeXAMdGAwVGgmfT/8ay3yexgPiGRKrWUv
         86tA==
X-Gm-Message-State: ANoB5pm5cu5jfFx3c7GtEkaANMJPq5wwefbPZvfcobqfJElic3VT9qzo
        ch+8lQzF9gb9R5ODH2EZwtbBIpijZX2pOg==
X-Google-Smtp-Source: AA0mqf72tT94OvhFilTbF+yFpDa8H6oJYHVlnUa0TXeQ4ClOLZd55NR4BDYGoUJHI6hD++7Ul6efJg==
X-Received: by 2002:a17:906:375a:b0:7a9:a59c:4be with SMTP id e26-20020a170906375a00b007a9a59c04bemr5588583ejc.556.1668771070016;
        Fri, 18 Nov 2022 03:31:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/12] builtin/{grep,log}.: don't define "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Fri, 18 Nov 2022 12:30:56 +0100
Message-Id: <patch-02.12-9789509a902-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding "USE_THE_INDEX_COMPATIBILITY_MACROS" to these two appears to
have been unnecessary from the start, as going back and compiling
f8adbec9fea (cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch,
2019-01-24) without that addition works.

Let's not have these ask for the compatibility macros from cache.h
that they don't need.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 1 -
 builtin/log.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5fa927d4e22..f7821c5fbba 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,7 +3,6 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/log.c b/builtin/log.c
index 5eafcf26b49..89447a50838 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
-- 
2.38.0.1511.gcdcff1f1dc2

