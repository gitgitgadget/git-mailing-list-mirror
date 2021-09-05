Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD96C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5880A60F45
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 11:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhIELF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhIELF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 07:05:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEAC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 04:04:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so3716963pgp.4
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVZQTkpWtNrwr4iUx/RvsIs3ucQnbkkUO7f4lpPJmKM=;
        b=e9CMaeSZio4BcYezpXbKYk0BuOxMt0xT/0OhQUj7cHg3gZgKekzcv0slqIZzKnkUnH
         BmuMWQ9BwqXAbCEjXRq3Etr5ewMGaO2mjSbVQx34LiY5aNa57n+/6LCNWDsdq8EdQAfe
         YCZfKn3JdD5dWet0gNIp8CdopmcU3wS6DsoIRLw4p9tci1uhEddyxhX02K2yjNMGMSdL
         wMK/j9Ft1GdXFm2gUbkX01nAjVGAY0Ud140K26QtCRmaD0wkqKbMEiGGG8qbXgpljtsF
         ndgNMeA0a2hC/wnHfCknWroco7geZ/h94QWTgqC1YCrOoU7Sy/iHE7sDAeOrO/b0dbUS
         9Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVZQTkpWtNrwr4iUx/RvsIs3ucQnbkkUO7f4lpPJmKM=;
        b=abh9lVKgc5vWuH5dpHq9ezgZMj9ZbORs9wzYBx1qy3A+jKuoWk+4Emj6ufYbuqZEzU
         PF6SaP8AU11F8r+59KrHRanpXQrZAmtBu5iG71YtWdoxaij25k7oPAcCntHAR/ljmGmn
         YtQ62yHp13GYjzcWb+ofCluhiKQBjUqVDfbG7nG62F+o9YagGLo8fKwd7PBM8bSyDCkS
         xDcK1dkoTZM4YSRjOG22SgRE+oyQtmWSJCCbzMpFvNwpw6965fNMLpUc4ozPxB8ZPqmU
         dfeZyJHeSUEr7kwEwJHtWOJVcz1XT9V0fb6bLTSqaTqoZJkChCDa7ZgYiXLU912pbWW/
         kJFg==
X-Gm-Message-State: AOAM533jrJ9o3KefFt+m3qZJtt8oFdTEqZujSYHPouAStLk0EKrB29va
        Q92FnP3B8wbKsssoPTyPrN9ceuljVeYk/w==
X-Google-Smtp-Source: ABdhPJwa9fn5OZwuYTQL3RssXW0MRb9euF3+8dJdcLTaChImh8AfXyrZ+6SPVdLURTpvZ58oMazgYw==
X-Received: by 2002:aa7:9f5e:0:b0:409:dbf2:88de with SMTP id h30-20020aa79f5e000000b00409dbf288demr7074961pfr.14.1630839893099;
        Sun, 05 Sep 2021 04:04:53 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id x9sm4534161pjp.50.2021.09.05.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 04:04:52 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH RESEND v3] make: add INSTALL_STRIP option variable
Date:   Sun,  5 Sep 2021 18:04:18 +0700
Message-Id: <20210905110417.35702-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Add $(INSTALL_STRIP), which allows passing stripping options to
$(INSTALL).

For this to work, installing executables must be split to installing
compiled binaries and scripts portions, since $(INSTALL_STRIP) is only
meaningful to the former.

Users can set this variable depending on their system. For example,
Linux users can use `-s --strip-program=strip`, while FreeBSD users can
simply set to `-s` and choose strip program with $STRIPBIN.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v2 [1]:
   - Squash suggestion patch from Junio, which:
     - drops install-stripped target and rename $(INSTALL_OPTS) to
     $(INSTALL_STRIP).
     - Describe $(INSTALL_STRIP) usage on the top of Makefile
   - Rebase on e0a2f5cbc5 (The third batch, 2021-09-03)

 Note: In the future, we may add global $(INSTALL_OPTS), which applies
 to both compiled binaries and scripts. When such happens, we should
 rename $(INSTALL_STRIP) to $(INSTALL_STRIP_OPTS).

 [QUESTION]: I squashed Junio's suggestion patch to produce this patch,
 and I want to credit his work. In such situation, what should I do the
 right way? For now I add From: line and S-o-b trailer with his
 identity, in addition to my S-o-b.

 [1]: https://lore.kernel.org/git/xmqqo89cqkt9.fsf@gitster.g/T/#t
 Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058..c7a9995062 100644
--- a/Makefile
+++ b/Makefile
@@ -465,6 +465,9 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
+# if your $(INSTALL) command supports the option.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -3004,7 +3007,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3017,17 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
+INSTALL_STRIP =
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.

base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
-- 
2.25.1

