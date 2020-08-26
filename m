Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F1FC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FD720897
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML5VP/wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgHZL5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHZL5B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:57:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6BC061756
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:56:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b18so1511436wrs.7
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/JwA0cEdAUEqbjaT7+PXvQzsmprs57pIB1P9Ld1TXQ=;
        b=ML5VP/wfrqKYz4YuZK9NPjjhaPxTRPkikVe9ZQsFMBHixBJSvlfHRRUph9bHaEQx7h
         Jsyghc/OJpRZ/IrfHmokbphOZWivdwAaLw8bxpLBAeeHquqFhWhD6pfd+dwunVVSPHM0
         Ci0zsQ1utnlb8r6Q6P1Aq0P35BoQU2ChG8ukFWPw6l0KQQZI+jS5HXt99G7MP/DXRsMQ
         RHgAXcjs7IJzV3X0bBj7mpha2q68E249UAAbeI0NnrjjVZ4gcwJff7DgJfHQcOO0StkX
         X97fsDKcE7PUtM6IWiAW5Uj5ZnVMxkpil887A8vzGNieK43Jlfa+shYwCwzIVkwPK2S4
         cCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/JwA0cEdAUEqbjaT7+PXvQzsmprs57pIB1P9Ld1TXQ=;
        b=SBWlpuDogFM4TKJjzDn9KHs+XexATyv9EVxNT5U1g0fj3bkZJjBSpWmvqT263xoW5B
         qen217x/un+LEc3XblptF+f9mpAgWzgxj3K260WCmeuAU8QxBlECobP4T1UOTBuqJFBA
         yy8FVirFFbVr1B0nXndYB2BnNMnf0HPa5gVTyijtemDO4KLciIY9ZhlddpU9QeR2D9wf
         EXPQZPLWi4eVVKRuiQ9fb7vovFp7y5YlqViSiuLF73MSDblbye7oRDk9uSwXPxHmojnd
         mwhdkxhkESw6P5yihZU434N3DnETh9QkJ8fGsk20dZSpZuc/80bqTeXYg0kuoW+dhnjE
         Iv0A==
X-Gm-Message-State: AOAM532bc4TbgY2TWb1XQlavk5F+fgzWdeOkaMRpJBSHKYP3UqrP+Gd9
        BdhC5EcDW3hd7GrJ9Lc63uwmzOuJ9N8=
X-Google-Smtp-Source: ABdhPJwDEBd91tWVvOsbYdJwSlfvPVBtseifWvtJ4xu4RbHX4/2cXPgIpYUBNzM8/xR9rUlC3tqv6Q==
X-Received: by 2002:adf:db43:: with SMTP id f3mr16509403wrj.219.1598443016972;
        Wed, 26 Aug 2020 04:56:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm4817440wmg.0.2020.08.26.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:56:55 -0700 (PDT)
Message-Id: <1880a0e4bf80b5880305e3677ac4dcc5bd3d3c50.1598443012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 11:56:50 +0000
Subject: [PATCH v3 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a hard-coded list of `.pdb` files to copy. But we are about to
introduce the `SKIP_DASHED_BUILT_INS` knob in the `Makefile`, which
might make this hard-coded list incorrect.

Let's switch to a dynamically-generated list instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 65f8cfb236..66b6e076e2 100644
--- a/Makefile
+++ b/Makefile
@@ -2899,20 +2899,8 @@ ifdef MSVC
 	# have already been rolled up into the exe's pdb file.
 	# We DO NOT have pdb files for the builtin commands (like git-status.exe)
 	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
-	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS),$(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)))) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS) $(REMOTE_CURL_ALIASES),$(PROGRAMS))) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 ifndef DEBUG
 	$(INSTALL) $(vcpkg_rel_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(vcpkg_rel_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-- 
gitgitgadget

