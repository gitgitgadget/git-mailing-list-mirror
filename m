Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88B1C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 13:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F7464F6D
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 13:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhCGNUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 08:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhCGNUR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 08:20:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BCEC06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 05:20:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n22so4444600wmc.2
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1TfRp3ShreCUbJEXu5gcwdKDmHGP60KgwMaByVmj6nw=;
        b=XIs+9hlXgwUMf6V/KJSkqfpAhUFsEQGRG+U7IDlbki+NEvx8ttfpqtdz+99Q0XnE61
         Ca2/d7IckxM+k611+DHfhH6efTyK28f/SiJIa2gdOe+3ymF6nNYtzratzzw8+a6yClLk
         MBNjm9jmEsa1CKQIm0oFc1mZHqWkdvR/ODHR3cO8RL48IR0vf6IfDGAS3nTO9CXLaG3h
         3aOqhqns30HziiGZeKv3fOxyScHZxD1UJb7QFqumddONavjiDwb106mN9ZAXaQCs4fea
         gTb966tMJDVVIOmb+8gIhldCdwefYL2o4I0AF/qZ7THtwp10O/m3eNQ9slPVBhMK3h6I
         8yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1TfRp3ShreCUbJEXu5gcwdKDmHGP60KgwMaByVmj6nw=;
        b=JFMmqEvjo9fK7iN+iA+IPXKGKq41Dxy/f0qCwifMgPlhPoVg1yOYQd6H0Rzg4dZcKI
         qQqqyGs9NP5jKsp4tPw389JIsOIMqJ5TCMAZQi0STTz9HTjJODGfH64qTPYDi6HhlBgF
         umtNuMbxe8d8SPAGroqrGjhJOS2Dk2EeGbSbEHAUiPbDn5CKSutYMcogUT6YYvy0Ns93
         QMGY2y4KmkKYIVONP1OhULKATcyHFl2t2wPDQb/na4mZIizhr0HvqoFLz7c8PrVDsH18
         GT9nWioqCvMaHgGuYzIqerQmqjchKk9MhvDjSv61Es3mDviKw8cyHtMvAzZHrwRdPpkT
         hooA==
X-Gm-Message-State: AOAM531nVHiba5Ogr73ZNk8ukOTbr57vvkXmrV7DUYWPh94AlxSs2JYi
        0mptgCpvyZa1kaYk7YneLZcvrhKqcHnH4A==
X-Google-Smtp-Source: ABdhPJzhV/xHAfEU1ZSuFZBz6QyTDWNmxcujOUhySZ/mXzMFk38Kpx6s9aAFXJmwUrzIOxuet0ssYQ==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr18092560wmk.82.1615123215261;
        Sun, 07 Mar 2021 05:20:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4sm1824332wmq.40.2021.03.07.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 05:20:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: generate 'git' as 'cc [...] -o git+ && mv git+ git'
Date:   Sun,  7 Mar 2021 14:20:01 +0100
Message-Id: <20210307132001.7485-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the compilation of the main 'git' binary to not have the CC
clobber 'git' in-place. This means that e.g. running the test suite
in-place and recompiling won't fail whatever tests happen to be
running for the duration of the binary being regenerated.

This is not a complete solution, in particular I'm not doing this for
any of the git-* binaries, so it's effectively only for
SKIP_DASHED_BUILT_INS=Y.

I think that's fine for a small best-effort solution to this, even
those who rely on dashed binaries for something are likely mostly
using 'git' for whatever scripts they have running out of their
git.git checkout.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index dfb0f1000fa..c5c754a9a12 100644
--- a/Makefile
+++ b/Makefile
@@ -2159,8 +2159,9 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS) && \
+	mv $@+ $@
 
 help.sp help.s help.o: command-list.h
 
-- 
2.31.0.rc0.126.g04f22c5b82

