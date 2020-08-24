Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248EFC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0186C20738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9eCD8D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHXPnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHXPie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:38:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BFC061796
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d16so9152428wrq.9
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/JwA0cEdAUEqbjaT7+PXvQzsmprs57pIB1P9Ld1TXQ=;
        b=l9eCD8D1WD5wyYw8T5RNd7472FnoH1OoeKV/MfkCezxC/rslUe81RSdM+CG3qOJF3V
         v7gt5Re2D5wpTFVvyNGJfWLBtzqTn6M8BkGN+N2xDplIdtCsJOLo1jvkbGuS7sQ6n5oF
         6M1TF7grrcei8zpxMRQZdEAFaRUjcIfUJq7eo6jAolramHol2zBGp70d6WDXBWbb+AUt
         C+0WpaQG/VN+w/JlWRgu1Vrx8M7tpWSJhmQBna/8c9UAY2XazGS6/8dbOObkR5RjDp3H
         H5E2XqlyylmL9X8nZMntrvgXJNR4Yqt+/hBVrTRkoFWK9tTDu7acDSO7VX2Rcnc9wnqe
         CXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/JwA0cEdAUEqbjaT7+PXvQzsmprs57pIB1P9Ld1TXQ=;
        b=MRSF1YiUdoJ/2zx8njrH037vDm86EWwqTTV3UlU1BrPvGFexlXDO1SyblkCgjQjeJE
         97N9eP21BadQ8K6XIGbsKnltNqd0ond6Wtqrf6bb4ZhTAeJ5Ixq6Z3ZX5CC6TfeVK0S9
         9/XPZcqOS4Q8sdub/mHPRxEzc/T+03AALj520JDWKtAYfBnXbkRN3K4TtStjZGKLppXM
         /tkoYmgbg/l1SQnHmu4qgb2nmW7Sn+S5suES4GUt4jcCkFJFSGymkKUU28uCow7aKcYX
         pQ5I3ObKHcTYaRF6jE2b5YbI87j1VbcVSrpjdlR4J0rvzYp8gxJulGM4LQvHfkBspJGo
         xwPA==
X-Gm-Message-State: AOAM530oss+rZyIKpzsQ6JLug1XfmmRP7C1iNewXOYSbFs8/UKPxhDBP
        cWby2bZ8xzPrTGfbOLAyBYnJUXnLIio=
X-Google-Smtp-Source: ABdhPJwSWyUc6IGCS834/s7IqNC2qRP3EdnOlQBB4CKQx5KeElsZbme8FMj9dOkdlKhvxAdtHg+d7g==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr6106713wrm.238.1598283483175;
        Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm26030325wme.13.2020.08.24.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:38:02 -0700 (PDT)
Message-Id: <1880a0e4bf80b5880305e3677ac4dcc5bd3d3c50.1598283480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 15:37:58 +0000
Subject: [PATCH v2 1/3] msvc: copy the correct `.pdb` files in the Makefile
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

