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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E8EC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F47464EBF
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBBCAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhBBCAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:00:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E4BC06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b3so590545wrj.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYhUHo6Ku3bulSheUJkOZuqf/igSgjI+/StyEFlK6/Y=;
        b=MQAZddYBeASb40V6ArZ9NSuQrRSVwTYHSBlg7O5wxnThkUlSr4ZexjQzJ8S4jvsPuF
         zsJrDG+GJHh2GTxTzPE9oiUVOYZDZmHw9Xqaw7Wk3BGWAH/7Dkym6p5QLSL5cbbSFjs4
         B3qhT9I4+gZabmweP8vnHv2hfVQ2wIjmgjIjZBVkWl3z4dsuKggMklARTol+Ie74fQqt
         FNmMOi8yqljeKbV2NFM12S+Y3UQgSX9RKhiyYWCqk2pIQJwgxi7AQGt5UX1DGaXsyydX
         GD767mNQbnZajaN7Pl8QDyt6TxXJLMEkMhzChVer+JSBuiDUJozXNYTmFJHX1Z79CYdv
         odxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYhUHo6Ku3bulSheUJkOZuqf/igSgjI+/StyEFlK6/Y=;
        b=Z9QKJsTusfnYsT5FkxO3HPFTasAOdQOx2p/Nb8plXT0Rywf6tuMpp9cOIDlnDuV+4W
         ULC9QWlzOd3p7pjYtG8yB5/TJo8liQF6HQAFTF9P3SgEC++VY9ggXYFxp67y20ALilMC
         lOYIGa+7ZPjHTeMNFwmOEOztiZ5tdyMGLAZXPmn2DAIDLiTD9KAxci7UxEdcNjD+ZU6k
         eFr+Gj7w8TbHQv0EOlCXqwXMSwN7ntqd2HcPlLSSEviL10Lwh07s57INXXPMGSCdxdAd
         3KduwPR/gUxub9uref5SRvZtm58/lKhMjuWL5H55Ltkf3nS95qXIKZqvf5U/I8AzjEFh
         vjmA==
X-Gm-Message-State: AOAM533iRvomUWIsjfzztD474umUW9sHmO5IrF/1qnjKcEFznTUsOwvo
        5CKUoRRun3okDvsoEpym/URrqpWBn4P4Og==
X-Google-Smtp-Source: ABdhPJw44NPtjGRobyCIiePO134T4g/puxyuuOaZbQPilXYbfRxMB/XSl3DH9IYFL284REhKgBSWow==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr20852919wrm.337.1612231208164;
        Mon, 01 Feb 2021 18:00:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] pager: refactor wait_for_pager() function
Date:   Tue,  2 Feb 2021 02:59:57 +0100
Message-Id: <20210202020001.31601-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the wait_for_pager() function. Since 507d7804c0b (pager:
don't use unsafe functions in signal handlers, 2015-09-04) the
wait_for_pager() and wait_for_pager_atexit() callers diverged on more
than they shared.

Let's extract the common code into a new close_pager_fds() helper, and
move the parts unique to the only to callers to those functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pager.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pager.c b/pager.c
index ee435de6756..3d37dd7adaa 100644
--- a/pager.c
+++ b/pager.c
@@ -11,29 +11,25 @@
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 static const char *pager_program;
 
-static void wait_for_pager(int in_signal)
+static void close_pager_fds(void)
 {
-	if (!in_signal) {
-		fflush(stdout);
-		fflush(stderr);
-	}
 	/* signal EOF to pager */
 	close(1);
 	close(2);
-	if (in_signal)
-		finish_command_in_signal(&pager_process);
-	else
-		finish_command(&pager_process);
 }
 
 static void wait_for_pager_atexit(void)
 {
-	wait_for_pager(0);
+	fflush(stdout);
+	fflush(stderr);
+	close_pager_fds();
+	finish_command(&pager_process);
 }
 
 static void wait_for_pager_signal(int signo)
 {
-	wait_for_pager(1);
+	close_pager_fds();
+	finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
 	raise(signo);
 }
-- 
2.30.0.284.gd98b1dd5eaa7

