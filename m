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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EACC4320A
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BC261053
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHIGai (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhHIGah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 02:30:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84ECC0613D3
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 23:30:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 14so17313989qkc.4
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnzBnMQhFZkKkyshh1/kSD2D62Z31DSS8JErgOgb95U=;
        b=HwFKO36o3aUnwGHjcYsA9gaSNWzet7QFerQyka77RUOdknW+69nGZfBRMjadKrIoBM
         Cu+WiZxlpMz5VtsKKzIsqxPj52KqxX4lPwoS2h7VnURjPenBHiRA3jhZOW2Fz/tmkrXx
         L7gQGvNjo/wNCIEKWJNDe1sISbqwAjUlVOVw0BOmD5uee93AJXcuvdQjSM5yIHCPfgQh
         8dmDxsVTqilhpNq/mu5VYLBeauKguCQ5wZF0aizAUSucYG41+Fk+7isvBncaHT9g64LJ
         LXOAqpUJ1Wu5xq9Fn3PTXJfZotNmsgD78VjgCnh3n9BLBEqQCfIROa6OzZUSyTBvtLOw
         1S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnzBnMQhFZkKkyshh1/kSD2D62Z31DSS8JErgOgb95U=;
        b=ftbZQf0JHH7lfFzq6HM5FJsK4SNGHEIhLNt7RSL4sKslzezH2ceQCyO/00B9bfZ5NZ
         tAQ0Zw0R0V3mulfoyituUvM5lScP4zTP/M+CeaPLLOZnbWjTTqd4Pp34q/gg/jwMYXzx
         yX1muH/1lsMZ7iUDO0d8EQOpmFmKw0M3GRLRuyOADenAKEurs77qFjg2zFjc1HgszY7/
         sIXHhTM9sjAQrIPCUlbAYXdNI2yTum04C3DWE+Ena4xLfANT9y0JBOR9132vnKmgN4VY
         N4h8dE/J0VEOXTRNIQ/4/HKiK8k5sJ9se6EZogn9z9gbbk+MPehQAkvKS+CZtxryMLuX
         o8qQ==
X-Gm-Message-State: AOAM532E8HDMg2iAwv0BTnQwU19eXfUc+NSI7zyqzSCONZbA+1cNwZ3j
        AKQlbgpLXS4INBPf0rREhTRSfmksglo=
X-Google-Smtp-Source: ABdhPJyeACtS0ETkh8Ze5LQRy1kYunCXW63sJEhscfxuiyWplo/yYGdDsJk/OmLZ8oKtpuI9fzg7RA==
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr12573887qkg.252.1628490615995;
        Sun, 08 Aug 2021 23:30:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 10sm1239994qkv.135.2021.08.08.23.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 23:30:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] fixup! fsmonitor-ipc: create client routines for git-fsmonitor--daemon
Date:   Sun,  8 Aug 2021 23:30:03 -0700
Message-Id: <20210809063004.73736-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809063004.73736-1-carenas@gmail.com>
References: <20210809063004.73736-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsmonitor: ensure enum ipc_active_state is defined before using

In file included from fsmonitor.c:6:
fsmonitor-ipc.h:23:6: error: ISO C forbids forward references to 'enum' types [-Werror=pedantic]
   23 | enum ipc_active_state fsmonitor_ipc__get_state(void);
      |      ^~~~~~~~~~~~~~~~
In file included from t/helper/test-fsmonitor-client.c:9:
./fsmonitor-ipc.h:23:6: warning: ISO C forbids forward references to 'enum' types [-Wpedantic]
enum ipc_active_state fsmonitor_ipc__get_state(void);
     ^

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 fsmonitor-ipc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index 837c5e5b64..7e02c7285a 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -1,6 +1,8 @@
 #ifndef FSMONITOR_IPC_H
 #define FSMONITOR_IPC_H
 
+#include "simple-ipc.h"
+
 /*
  * Returns true if built-in file system monitor daemon is defined
  * for this platform.
-- 
2.33.0.rc1.373.gc715f1a457

