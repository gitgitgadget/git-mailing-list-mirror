Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C69C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC77F60F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhHQK2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhHQK23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:28:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080CC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:27:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t16so16639301qta.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbbdoR1T0g8DnoT3IF/hrCkkkuGNyaXJV+C5RBWd2xY=;
        b=iiqWsPdfSlami5iZ7NdwiwZeSmUIiICOksc6Ni12Tbco2Wftc+kDVpVUHe/y2nJR5c
         5WZGt2DjMok4ChuTvFgPaSbqfjwUIAfX7FWuRXH4GhyGgFiCh6RNFxpPBdChCXpeXTk4
         GZAycsUcLR36QK/7tr0KzsmUstPWGcJ9v0Kwx1B50/NA/QH3I//CzyvkB7r+TOjbMIqF
         QWMGjZogveBFfwFK62zvSmtQn6uY6LnvMSX5fNAUgGaR50lK2CphpfevuuC9HrX8dZBm
         p0MNltYZifoRtawSYyyVmLpSa6Z37QIVK0MJQSBg0BPAuVflhHTLj97eyT9VLKWExF36
         WJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbbdoR1T0g8DnoT3IF/hrCkkkuGNyaXJV+C5RBWd2xY=;
        b=E1IfCZ2KZAI/UHyLgJ9x0DfKsnXSADkHYUAItxHFBx2HmBMAMIRJXdQvLK52MC+fqZ
         rYCmXClszlPS51lTlpkHm+E5v9KUnWv/03gGztxPxe4bR3j+V5deJz78Tigum+SNJd+w
         BhB5A7gzznCSPb9vKwSvUkCqu1CIEu+bfTJV/RfAd6aafCsXNQBbdJ9DL1mtdx48quG7
         mih+rjFvnEh31boDsnNqpkg3Pb4H0bdzrV1xzIKv/d2J34ClrDqeDKE+5M1/ZJNEIhNe
         n9pf38dafo2ymcPnUJfu4X27vhYYlNjr6m0Sh/ZG5tc9/BFyRE1Ffdh4Q8WWe4lEffWA
         +Vug==
X-Gm-Message-State: AOAM530Xlu9FwGtw5CSFGTR+NKPRxiqCnUETlyVVCU4Qh8eH0oBxjCu6
        w/LjbEuFikx1zLEGP2PajvtjBhunfKg=
X-Google-Smtp-Source: ABdhPJykKwtvHgl92FI11kjeV8Y23RP6mllb5g8WiZbmyACvFl5Y/M68/eKiHdtGc2rg3LwXBLi4zw==
X-Received: by 2002:a05:622a:14ce:: with SMTP id u14mr2366650qtx.208.1629196075959;
        Tue, 17 Aug 2021 03:27:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id n124sm1060574qkf.119.2021.08.17.03.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:27:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/fsmonitor--daemon: use parse-options API fully
Date:   Tue, 17 Aug 2021 03:27:10 -0700
Message-Id: <20210817102710.23916-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--help and -h are already handled internally so just parse_options()
do the parsing and extract the command from the remaining options.

as a side effect, avoid setting a variable argc to a value that was
never used.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/fsmonitor--daemon.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 25f18f2726..d6a6010512 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1511,20 +1511,13 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc < 2)
-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
-
-	if (argc == 2 && !strcmp(argv[1], "-h"))
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+	if (argc != 1)
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	subcmd = argv[0];
 
 	git_config(fsmonitor_config, NULL);
-
-	subcmd = argv[1];
-	argv--;
-	argc++;
-
-	argc = parse_options(argc, argv, prefix, options,
-			     builtin_fsmonitor__daemon_usage, 0);
 	if (fsmonitor__ipc_threads < 1)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
-- 
2.33.0.476.gf000ecbed9

