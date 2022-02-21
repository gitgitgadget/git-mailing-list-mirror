Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D2C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379906AbiBUQJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:09:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379902AbiBUQJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 11:09:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B08220E0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:09:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so11504593wmq.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c117ZJI4+aoVwA672xfja2Ww3hCMaTy6kUCI5mZtFXk=;
        b=q6xwN0mjPl7QuNEppIcwe7i+bOk1b27BJ99y0+SIOIDMkSkLc41xXb8MSjP4exizq0
         vlD2KRbArBCODZ79mMC4i2sSgfiU8euvyhxUhMCDDeqKsdZeyqkDLJ8UoXDrbzwTVckq
         1OmbTxvbWE62Tqqgdi3NQleuGqZn6Dzm5BK7DM9KJiZvESjN4EBs7iM9DBs1MI8Hic/z
         Kia+i0t7Vcf01ZuqtzZ46GknScsdFyj/wNEKME871hgsXNHwiGFu8aLcRHZi4dkFY2PW
         ppfD39uETtZ5H8B8Zw5flCDMb/4/QTmMsUDiU78W0n2iiNFy9euomaXISqMZQ9+8m6u3
         Kfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c117ZJI4+aoVwA672xfja2Ww3hCMaTy6kUCI5mZtFXk=;
        b=r67/wdOup4DczRx3wWLRhOHu7u4r4IDKnlubJWWLFdSMEl5fnr2pLw3dTFWfxeJix1
         2a3NePdbdZz456rmWvgs9f9byVdjPmPCMSb9UaiBJIbrxCJPgZKO3ItlECVuOo+N3ugT
         I8JzhiTz9qsJwR8of1HIRuSOefFEN0OSTZ/v1rUZTavMd3HOhTRkBiBpND8Jk6FsZ6y3
         dGYKkCp2v94iDAaIvfz5oddsqSwx1IxRLx0DQq6tADZEG4cavwCDBkpi52mpR+ioYnJU
         RnKgb8xYGFPyJ+kgbbpfNWe+v0YezHkTI8m4cYLDWVyVst3Vvs7FQNs9WLwey4loN79+
         o7Cg==
X-Gm-Message-State: AOAM533UHEJx3iRIycGuSmWF6JWRnuQAKrsnO7jqPygJiM11ooI9fho7
        WdJ5bKBYwVKhWdLbFWb8Ms6hRb3oI9YxuA==
X-Google-Smtp-Source: ABdhPJywn1LYwC+zt5ggnZqs6UMU11u5Ts3JNWfo7QpA8SE3ES9uHT4rT1iXTdNyPrtcC0DhodSBPg==
X-Received: by 2002:a1c:6a03:0:b0:37b:dda6:4259 with SMTP id f3-20020a1c6a03000000b0037bdda64259mr22123971wmc.20.1645459762974;
        Mon, 21 Feb 2022 08:09:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c464400b0037c19c2d16esm7725024wmo.43.2022.02.21.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:09:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] usage.[ch] API users: use report_fn, not hardcoded prototype
Date:   Mon, 21 Feb 2022 17:09:18 +0100
Message-Id: <patch-1.1-7551daf131b-20220221T160719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of users of "report_fn" that hardcoded a definition of
it to use the definition of report_fn instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I'll eventually want to depend on this for a larger topic I plan to
re-roll[1], but in the meantime this trivial fix can hopefully cook &
graduate.

1. https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com/

 apply.h       | 4 ++--
 run-command.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/apply.h b/apply.h
index 4052da50c06..3ddc8be9c71 100644
--- a/apply.h
+++ b/apply.h
@@ -103,8 +103,8 @@ struct apply_state {
 	 * set_error_routine() or set_warn_routine() to install muting
 	 * routines when in verbosity_silent mode.
 	 */
-	void (*saved_error_routine)(const char *err, va_list params);
-	void (*saved_warn_routine)(const char *warn, va_list params);
+	report_fn saved_error_routine;
+	report_fn saved_warn_routine;
 
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
diff --git a/run-command.c b/run-command.c
index a8501e38ceb..3d854c498aa 100644
--- a/run-command.c
+++ b/run-command.c
@@ -362,10 +362,9 @@ static void NORETURN child_die_fn(const char *err, va_list params)
 /* this runs in the parent process */
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
-	static void (*old_errfn)(const char *err, va_list params);
+	report_fn old_errfn = get_error_routine();
 	report_fn die_message_routine = get_die_message_routine();
 
-	old_errfn = get_error_routine();
 	set_error_routine(die_message_routine);
 	errno = cerr->syserr;
 
-- 
2.35.1.1132.ga1fe46f8690

