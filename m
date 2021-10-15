Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A410C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3726108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhJOJqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbhJOJp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF92C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so25496153wrg.6
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0aPNBwCfdoAMegksN9nv71N+iTYj+/aoXVRkwOys1g=;
        b=hndMA4OHcqdcnxqeyOTLaaNPX1IUyqN2kB+rpInAuSBAmnEpcpC2AGZuPJeqDj2xop
         2omvHQDaLDqqDfvmXEvssvm49KklP5XjlWFVSVBy5a/8uy3e/lfQsUaOPyFqS/tgFdmV
         mZflRSNvGUJrRpYa3u+Jw8AlairI0UTe9VlAFAy6zTBdiUc6TWdQUHJk06fZp8WgbJbE
         M2u8oBoTMeWna2B18bPL1nGB0yFNkPBT5GhjdQ+FL9A0YYDFCfef33VT18y0xxs7St26
         nASLRiU/IXbOeANtzPp3H7i6PWVHSQ4vY6+Xwb/gX50iuSBm7NmQDDI2RomAg6YSKJSp
         Ho0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0aPNBwCfdoAMegksN9nv71N+iTYj+/aoXVRkwOys1g=;
        b=ettkPJc4JLZhI1JNRvKG1ylKZnwuD3afSQmNx+Lun5ox2I++vGxOQRbyPIKb1md6v9
         Q2N8dUPWYsINQTv8nO3GEfxPcV0BoshsjJEAzAk1tv1mooRXj1vhDROIUC2r0irJqXST
         krX04hEjO+xEEMzzi/AbFOvmdnctQebiOR62Xt79YQVOFlypVnYULyOXd+3Pdd2ziedt
         RzrYc9Vq3v+2P2K5/xSwpk+2yjjpppHE5zF01tpHS46VaQlaHPaE0J7jytN81upcj1+l
         kkAY9FzipSz5H5PR6U8BdMUtyKnIHXzFGVvaR19NfibqlFz8TL/ym54jmt8QifV6mcgy
         nEbw==
X-Gm-Message-State: AOAM531RdxOE2mJtc/lG4zeD1V/gqWNb2AVz4cJ+3aqctTWhwzUyCKvO
        WzlfA7AQdTnTG5utFmdtTKKkNJbgc9SS/A==
X-Google-Smtp-Source: ABdhPJy+pMNlu2XlKatY6qFPsWQimEERcIZaFkLXP8ZWeA+zQopG10chADq8NMJHjPIWTm9iwJ0MLg==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr13418870wrs.404.1634291030593;
        Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/13] merge: convert post-merge to use hook.h
Date:   Fri, 15 Oct 2021 11:43:34 +0200
Message-Id: <patch-v2-06.13-327f916f8c3-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the
run-command.h library to run hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cc4a910c69b..c48b875b82b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -488,7 +489,8 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks_oneshot("post-merge", &opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.33.1.1338.g20da966911a

