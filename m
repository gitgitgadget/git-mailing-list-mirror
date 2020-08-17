Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2152C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2BF206C0
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbtNJm2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgHQJJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbgHQJH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:07:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0EC061344
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 9so12602586wmj.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:in-reply-to:references:date:subject:fcc
         :content-transfer-encoding:mime-version:to;
        bh=9uN/MSfBMWyswWiU7ek/eyPg3UTXBZjvSsr47gFC2NQ=;
        b=HbtNJm2x1OYBVgnETZpfmXSU4LjF9jwk5MpVemTUrc738pHhY91ey52KgtUAZkSQtT
         MIj7zYDpCltlFoZJTQ6f1aD7p0Lb7nRt4GR6MK621lU0JbvuugALcxzKtifwp/VX2AfQ
         8ieOKdVNny/NRmpCi7LxWrXozHoGzyXktpVu3e5W+Um3GWrTxWK3C6bFAGNAzZ6OWCDz
         aUO4Btiy10PeB7HmWfwzKiUnm7CAcPE3NBQzCopWTeL4Ppl+zjecuSbQkVX2T9hvfQX/
         kxu3ES+V/NWqVzpzXn7I6wdBv+/EKpOoKx25QEtgomPK9bsyt1rrRVkhgGqhCbKiFN2s
         FGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:in-reply-to:references:date
         :subject:fcc:content-transfer-encoding:mime-version:to;
        bh=9uN/MSfBMWyswWiU7ek/eyPg3UTXBZjvSsr47gFC2NQ=;
        b=lVvUR4pbIx5kP7KqArjukxcE7Mhet/hS1aGMhY+bwPPT235Kf8Bbbjf98MeZDYb8Al
         xZTazBpb9HvoulnfaDMH/mj6NMcjI2IX+Jsvjb7XB3ZqaSdx/cGkuDHxs8hhnr+Ol0rB
         f2cw8QWJ7hSRvF5wBcUKlD10FKDVj1MfKu66EaPx8MLiC7H1quU5B3EtUSYFdDIV+znM
         yJf+gAqId5dUrzdw8dLFnxOsCYtT3S/BvPRYGDjjhft3XkPke/g2rTNQtBQ7GeZqpxvv
         6iV62Mzs07xuLnp99kcgU1+37mSExqb9+tZhv4bJBwwQj6qN0YRhUGmREDQDlNeAbEtV
         xwrQ==
X-Gm-Message-State: AOAM531em8maI2FERUESN8v/Do+SfHUVfdtUHIETfdqxUP+Qrn/ulyfO
        UbWxTt/t8l8pJfatoQK/lU6P096dHwY=
X-Google-Smtp-Source: ABdhPJzjv5OTp8Q1wtci6ptrZonAEx/ZzLXNw2I8DdB4dbu+0SJyMK9asxiZhPEm5Er4IwfWpPTsYg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr13211297wma.62.1597655275518;
        Mon, 17 Aug 2020 02:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm28062858wmf.42.2020.08.17.02.07.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:07:55 -0700 (PDT)
From:   Johannes Schindelin <gitgitgadget@gmail.com>
X-Google-Original-From: Johannes Schindelin <johannes.schindelin@gmx.de>
Message-Id: <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.git.1597655273.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 09:07:51 +0000
Subject: [PATCH 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a hard-coded list of `.pdb` files to copy. But we are about to
introduce the `SKIP_DASHED_BUILT_INS` knob in the `Makefile`, which
might make this hard-coded list incorrect.

Let's switch to a dynamically-generated list instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 372139f1f2..3f5ba97b70 100644
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

