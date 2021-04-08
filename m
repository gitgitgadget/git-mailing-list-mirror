Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D205C43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0574561132
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhDHV3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhDHV3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:29:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6FC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 14:29:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y204so481766wmg.2
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2d+uxy3vTbP2QNGOE8vwzID3OCMNJytsKHx8wSItn4=;
        b=W15bPzrw7trWK2q//h1afJc1YVhqtkEIPTo9B/3EiTxpbdHcnb8wRd/BEkYgQn7fXH
         UfjY7Iqjqu/ONEWnl37t7hTYI76BMSMxEJA7MPmo7FNK3M0BfMkNgj/vzU1Nivi248dl
         ye0DzbLCV12CM0F6sNMf6/1PEW/QIUpzIJBPXDpbClxzmPObrlEhrN9dg1IWc/1JNe8t
         FpJNGba6FaKwEVMQP9J7bM8PdJM+eXSGy4laefETqv6ALU0GfBn4uwzOBg72FG3okl8y
         r8Mk6HPOB3DKdyqIrsGWmf5WXd2xH7Ho/sCgsj7higmM1KdtYtVoHxkyrwSFYWZd1Y52
         jbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2d+uxy3vTbP2QNGOE8vwzID3OCMNJytsKHx8wSItn4=;
        b=XI9MYk45APC4MWV30J+0/Oa1WfJGTsfohsOA/lfhhQKaSc1X+lynJFuO46rNKe5AZB
         OZpu2faacss7O7WPPgYZnmMGLRNbDKoOI0pZXcTVGvqj/OOBMo2hr9ZZxaaxNfTavmqO
         vMen/DXsQ5qN4NHODvF7atb0a8vg8W9ycxC9KLpJh9xvlFSpPEegHOONEixeuEH5m41W
         tH22YHpqRYIXJT/FQDAtOAJgZ7cwK8I9ACdFLO0+fqGfamShp9UV3o8PanUOLNbJcwun
         pKrqag5xQKc7XNCHpJ1NKQDDWHeAEhmSzNzmBIiwTF/Yt5VkeVTeExO164OnpaXqfUsp
         gwig==
X-Gm-Message-State: AOAM533z1Hxz1vRUVAGkl91tFplX8jT4QXgMXtEkXS0tLfIe/EkFOCjd
        6VBwL0+/6YVrlXSRgqxlKqboAkyNYyw=
X-Google-Smtp-Source: ABdhPJyl3CHqfSW+eQuxx9WGvqPqgSE4YPFDNHm/AtyyOSidz5KSo2hggkEzjXzsfdF1JUPUOeqMSw==
X-Received: by 2002:a1c:4045:: with SMTP id n66mr1536884wma.94.1617917363942;
        Thu, 08 Apr 2021 14:29:23 -0700 (PDT)
Received: from localhost.localdomain (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id g64sm712029wme.36.2021.04.08.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:29:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Makefile: add missing dependencies of 'config-list.h'
Date:   Thu,  8 Apr 2021 23:29:15 +0200
Message-Id: <20210408212915.3060286-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.31.0.346.g7485d9830f
In-Reply-To: <20200416211807.60811-2-emilyshaffer@google.com>
References: <20200416211807.60811-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We auto-generate the list of supported configuration variables from
'Documentation/config/*.txt', and that list used to be created by the
'generate-cmdlist.sh' helper script and stored in the 'command-list.h'
header.  Commit 709df95b78 (help: move list_config_help to
builtin/help, 2020-04-16) extracted this into a dedicated
'generate-configlist.sh' script and 'config-list.h' header, and added
a new target in the 'Makefile' as well, but while doing so it forgot
to extract the dependencies of the latter.  Consequently, since then
'config-list.h' is not re-generated when 'Documentation/config/*.txt'
is updated, while 'command-list.h' is re-generated unnecessarily:

  $ touch Documentation/config/log.txt
  $ make -j4
      GEN command-list.h
      CC help.o
      AR libgit.a

Fix this and list all config-related documentation files as
dependencies of 'config-list.h' and remove them from the dependencies
of 'command-list.h'.

  $ touch Documentation/config/log.txt
  $ make
      GEN config-list.h
      CC builtin/help.o
      LINK git

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5a022367d4..2c41f125e0 100644
--- a/Makefile
+++ b/Makefile
@@ -2151,13 +2151,13 @@ $(BUILT_INS): git$X
 
 config-list.h: generate-configlist.sh
 
-config-list.h:
+config-list.h: Documentation/*config.txt Documentation/config/*.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
 		>$@+ && mv $@+ $@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
+command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@+ && mv $@+ $@
-- 
2.31.0.346.g7485d9830f

