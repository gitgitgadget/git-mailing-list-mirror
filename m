Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B321C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B29D23A5B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsqmIFbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgIUW2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUW2V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:28:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D24C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b79so1158564wmb.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uV6nip7fkrMMbddQ2fp7UKuaRL1b7PYVD0dXMSsFnFU=;
        b=RsqmIFbxJr4dOKfhywiR3QS2KssuBM5j8jL2IDHf+hKnwAfragBrDM//QEtf+5iMDz
         WCS5VH8b8TupKarjBh8DakMVQwxLb2m5yuE5vStjIDlMfT7TfsPmJwm34Rgjrt1QMkFt
         /u76wvG9EP3R7IRBb04doCnCs9hi0UyV5T5o1gqgUVy206IAv2NnWimLQmuUUjx9IjDA
         tAtBmjnsPXMeO3iBXmRZFl9gj3GBcqxABwOmPaOPOtwsJqbfYAAM1t9fgRNaMscoFcap
         M3pSzU0ExJYhucIo00ArCXiVC6jREYlyCsA8WWOA58bESLrojSjbWUHhbvQUBpZGyXZo
         nRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uV6nip7fkrMMbddQ2fp7UKuaRL1b7PYVD0dXMSsFnFU=;
        b=jgLJsDA7NEwqDc21z7qSt2L28zJD5Pt+LmQfkFHKszarIrIqEfGrl5RZ3m8XYWJ9Zr
         Vrvmeq12u0a5FJ2UCWKBeoCmppvNdMS2fMiGqUu3U7Di3rpZuc/ZREXFCPacVX6RMWpI
         iAYLR09wySyguhTQvvSDEgrz1Hg6iyK4ft9z55zHxfs8ncnmx5kkHEGYw7xpwJ/SmANI
         F/eNY618M679tpjSCpofyzNoirVM6GikI6qvOEFAbeCslzYTD6MaNTSOBapN+UcuYMfv
         D6FPuFlEY3tt2fwYcCQNLE7zseKxrIQIF6vBJNpSw4sSHjeq4ApFAshfMBsv1ka04GzL
         Sgbg==
X-Gm-Message-State: AOAM532HWaF8rNhCda6H5kSYnWbTMMG3kmMg3545Ya7w0eAOObKNFt3u
        TRsPRLqxmv4SPdXeZimUgQCsjn/fpzs=
X-Google-Smtp-Source: ABdhPJzooLQJUhQCR8xMvdfIDTx2SnBC2+5Oh4FgdThVaORshCb83yLjZXvdqF9y2DgaK4LmrkZGTw==
X-Received: by 2002:a7b:ca4a:: with SMTP id m10mr1369397wml.11.1600727300105;
        Mon, 21 Sep 2020 15:28:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm1306942wmj.28.2020.09.21.15.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:28:19 -0700 (PDT)
Message-Id: <5df767c9190b70f91a982c6eacec34aa4ef32bbc.1600727297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
References: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:28:15 +0000
Subject: [PATCH v4 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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
 Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index f1b1bc8aa0..ce072c4fb8 100644
--- a/Makefile
+++ b/Makefile
@@ -2921,15 +2921,8 @@ ifdef MSVC
 	# have already been rolled up into the exe's pdb file.
 	# We DO NOT have pdb files for the builtin commands (like git-status.exe)
 	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
-	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS),$(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)))) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS) $(REMOTE_CURL_ALIASES),$(PROGRAMS))) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 ifndef DEBUG
 	$(INSTALL) $(vcpkg_rel_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(vcpkg_rel_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-- 
gitgitgadget

