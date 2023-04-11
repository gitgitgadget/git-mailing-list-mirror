Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EAC7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDKHnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjDKHmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5940C7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kh6so5469974plb.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198948; x=1683790948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o4AM7/ZZG4AKuZyJTo4jRlpKv588v0kh9SR9tcmQ2E=;
        b=ma6onbQ/w2nueMrpkG3XXoNJehdYYql+EECfOxO34QfldeV8c1jwmd59e3bA83IQjM
         51j5DIV9RR/fPZZyfJ/KTsgVhx4JIZx9FQGOnG8wOjVloa/1lLSQbI6Ong3Ha3tsMFAp
         seys2B1y2Qq/wvd41yISrZH5wNUoKRpg8XuuPexGXjE0/UwEPQBeEIqIbJ1tMEslrqAq
         Ju0rGmyKhY/MAPNzoyCBhtcb6QIuob9Cjd5qpattJXo5z/tuPheou3CTu0GMYV54GsiX
         1P0kYZZWDmhcYMuQRXF2a7XlqaN5h3UllV34FDmPvZXULD7ZSUAJsGPC1Rbobf02QfBX
         E8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198948; x=1683790948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4AM7/ZZG4AKuZyJTo4jRlpKv588v0kh9SR9tcmQ2E=;
        b=v4LwNeVVaxhOKOYe7uW97vxNKxK6SH24FYZI1VIsRW0bT644ZhLye8UAgli39qq9Ex
         ZUlYoVZNQHnDeDvOFmoAfDXLzf1vVKiRyScbrQT5SZXkRN0umr/i2LOWNA1+bBCNfmRX
         N1EVaRL9fh2ny5ovZMEXhK0CLfxDSKlHmzizHmmfVk8QOf9oHbVHtiIr2TjMA8agwzfR
         RaxY8FgOsRJMB+wcKs9ycr55no5reZ/HU9tSxobcZSAFT1RH0Uc/1mF+7gkOENTFw3wE
         0DIhSdMV5glyBX2pP6ltGKqXiKlulQFPk8iVxyidoD9gA/8n336qRnJSZlQdV8RIMNIz
         57tw==
X-Gm-Message-State: AAQBX9dLVcUx1WUbtCB/f7mkrCZ1PKaThKEJvlkDoL61ftRDE+6xW4ZJ
        LgyshcxvN0nf6JWiZVQvKc6BrUDvPF0=
X-Google-Smtp-Source: AKy350bHYuimq4slq3hVcrXzfTQzmAh4v4HvEvsg1QYz/V5XQ84b2PydEx6KPm76Bc0il5dScbFEuQ==
X-Received: by 2002:a17:902:d1d5:b0:1a5:b8d7:8ba1 with SMTP id g21-20020a170902d1d500b001a5b8d78ba1mr7585343plb.39.1681198948508;
        Tue, 11 Apr 2023 00:42:28 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 17/23] treewide: remove cache.h inclusion due to editor.h changes
Date:   Tue, 11 Apr 2023 00:41:58 -0700
Message-Id: <20230411074204.3024420-12-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This actually only affects sideband.c, but helps towards removing
cache.h inclusion in conjunction with some of the upcoming patches
that will be applied.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 sideband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 25e2a185716..6cbfd391c47 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "color.h"
 #include "config.h"
 #include "editor.h"
-- 
2.40.0.172.g72fe1174621

