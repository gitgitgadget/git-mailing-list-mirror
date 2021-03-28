Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D15C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7896193E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC1CSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhC1CSj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:18:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABDC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:18:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4917581wmi.0
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFKcfNe7JLKIxDTgOLpVItG1RASzVaS5qD49aLoNkqI=;
        b=LY8HJi4ZHM97fbLZZ4rteQWhuJWrpcY3uIsEmXCIXBC7WSHiIEOsmODDe8TN/JgirH
         0tz2IAI9XxhorcwpLJklvzFzpLsky+NRfInrHVVdvdU08tVCKaAyIjRV7wzEVxvIV773
         RMtrfpNnVnmQ4nS9A/PV1v5bhN+rQfPqM11vdU6R8bVXa7ku4XXNp1MWJp6eIsfR4MtU
         Mj+c9lobZMOvIaH0VOtwRyP25UZqw+ACStImJf5O5Z6HFF96V39dSw9PXoIxbpO4yBXa
         FcjgoExCwR2F2WKkX3XgGhR937yx5aauxM9HvDLFU95X9Qsdq1WCqVTnJkAoRZ4ojUyJ
         tZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFKcfNe7JLKIxDTgOLpVItG1RASzVaS5qD49aLoNkqI=;
        b=V2uyzL0x+CwDVkfCoR4ZllnNbmLb0hlJ1GSCcTqSMRRlPHimDcxR2Jbpb7BmgWHuon
         6fjOg/7g4faKtNgkhyREgWgKoidcj7RnhZAhtfSuapMW4FIFpkWTRPP72rpERq+v8zDM
         vL1c7d89plJdUfAg4IgwYipnR3kfUSNACL6rf7BW8aNk6YgjiI5Oo3nroBjC6ugUj0+Q
         zXQ/oqSkvOFs8drWt2T5b+ivDWy7tmWXkL8x3AdQIXPl9W9tbPU1ulW6xr2kQXMExy1m
         P3cznjfY3zjaFM4a6MdjGP9ogJ72mNh2M/rDjBy5DjElNjqv/vB15Ag9Isq+xkyDeU5E
         2jLA==
X-Gm-Message-State: AOAM531udLwegEa61JvHoaf6StH18g3FfFxhxrb24MGgOi3oYUHt/bDH
        5drRRBCdXGT0140hkGD0mvm6WdSbi7zBJA==
X-Google-Smtp-Source: ABdhPJwbFFCoKVfEB9i4jPKnhZQZ74YwyTwcO86tevaKdGxsigWPOH7/I1ZS5y7KoiIf0FcIEk0akg==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr18744357wmq.60.1616897917415;
        Sat, 27 Mar 2021 19:18:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm24983559wri.27.2021.03.27.19.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:18:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: add QUIET_GEN to "tags" and "TAGS" targets
Date:   Sun, 28 Mar 2021 04:18:34 +0200
Message-Id: <patch-1.1-afd0c18ca86-20210328T021814Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't show the very verbose $(FIND_SOURCE_FILES) command on every
"make TAGS" invocation. Let's also use the "cmd >x+ && mv x+ x"
pattern here so we don't momentarily clobber the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 55c8035fa80..f317af1b602 100644
--- a/Makefile
+++ b/Makefile
@@ -2690,12 +2690,15 @@ FIND_SOURCE_FILES = ( \
 	)
 
 $(ETAGS_TARGET): FORCE
-	$(RM) $(ETAGS_TARGET)
-	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
+	echo $(ALL_SOURCE_FILES)
+	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
+	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
+	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
 
 tags: FORCE
-	$(RM) tags
-	$(FIND_SOURCE_FILES) | xargs ctags -a
+	$(QUIET_GEN)$(RM) tags+ && \
+	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
+	mv tags+ tags
 
 cscope:
 	$(RM) cscope*
-- 
2.31.1.442.g6c06c9fe35c

