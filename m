Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22058C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKSNHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKSNHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A78FE72
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y24so5581583edi.10
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJOkBSTkAasoV7n9eEuw+rwhopFqR9JYGgBJ61xdu18=;
        b=gH7CCgTE9sHF6XlkdihQpTVOT5sQoatSvFQKlURlcn3W9CCIZKLlp099AFw1ZTq862
         n5rNDAqr/1Ct5Axn0fdxHh3wrc9wlmYQXu8UXttrCiwAFb9tNlLViLTP+6VMUfCcvMNJ
         TfMmpMxiOnKrPrVbm+qxOcp/RekGLFtBTM+/NtvZnhUe29l+sXCgtsbDoz3PjlV+8QlJ
         8Phhcz6QF7cNbDD0SQAwmSkP+KP2naK64dxRK5eGQXauJa9ANqK5VsJzaXhBzvNuBgR0
         MNLdKL6gv3oP/a248f/X5JwlCEQCRtpliEg08frVNjkGhq6JTAbcv0W8WGtiO4m535a7
         6kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJOkBSTkAasoV7n9eEuw+rwhopFqR9JYGgBJ61xdu18=;
        b=owryRiBsZst4PutJChLtOjx2mJ4XuF08OzxvAgk+MB+mhiM+y8Y1AMuNzIY0mOE2D9
         rig0c0lIrbu4tMetfUVg9QOtjLDep9GSsBXsETqaByG1eI9CchBc4G9W5kibbqixQfMk
         M0gfcv1APIBKPUy761iHH0Rmezt9r2iT5cdPJhRrWaxfWKhCKDsAWs6G1WmQgPE5z/ix
         mydwxdpr5vaGB6XBGkhvHlUfTQhD3pBS2UQVXtSdiasj0sCxIOwoX6rUM7CdaFXXoWui
         iVZ2oE2AnphpGqQjJdvnfGiwMhZd67TNAVxOwIHpqt5cx2cEpXdoQ3CTL0bvvViL//4V
         Gjkg==
X-Gm-Message-State: ANoB5pmq8a0Zpcy/SCoEV5nNvXjjuOG4ritxmf3SGSiCjzZej/rdeKEY
        zMPDJK+rdVz9zrP0OcDJ4O25GrHEci52Tg==
X-Google-Smtp-Source: AA0mqf51BOC328JUxOH+ypkK1M7bVvLUQ4TaLpOR+l5h3Y8+CNavi3WkvzV4EbKkqxFJqDZLme4Mmw==
X-Received: by 2002:aa7:d88c:0:b0:468:ffca:6982 with SMTP id u12-20020aa7d88c000000b00468ffca6982mr7177031edq.282.1668863268661;
        Sat, 19 Nov 2022 05:07:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] builtin/{grep,log}.: don't define "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Sat, 19 Nov 2022 14:07:29 +0100
Message-Id: <patch-v2-02.11-3dd3af7b7bb-20221119T125550Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
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
2.38.0.1509.g9445af83948

