Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16746C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D844522228
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbhAANIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhAANId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCFC061799
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c5so21956739wrp.6
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cXyEDQ4y0XoEX/Rqp0mjkBPWFxjOFqTN90Fo14Q4W5Q=;
        b=KET72I8g9eUT2N6QkpVKYIxHjYSdbksgPUKn/0E/0ClIlGJsTYshMNwRUqu9cjl/pI
         fUBJpNgoUyKmv+/EyXV0mvfjppoKOWOhOPkdL6YahVAzLWD1WCmddX2MxbRSl6+15Emq
         wRsMHN426rRvuC1T+wGFmrc2qu93ML/ocZjKzEIVybzBbHyXUrxyeLrOO2PkfAUolO1k
         /pmfFluLY9/Q3cJY+kRhUK5C5NLpq/UaqW+7h7RfMY15ZCGELOTnWArlNVvoVsMrqboy
         qMP8ufEsl5d1eX/YhCuFB1R1o7tdr/Ap9D6qLqjfGFn2S4V0B3OMlGEY6lxAL6GYvgrm
         YM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cXyEDQ4y0XoEX/Rqp0mjkBPWFxjOFqTN90Fo14Q4W5Q=;
        b=FySCCfBi37G6XurWxJR0M1neLIb+osVbHABzQMguDApw75jp5vX5fNG4enpxRrayFI
         a7lyTShqd6ylOdbwNkmB08PcEH036ERmSY4G3B9a4dqUsHvj2bFresJ4OG7MX1/V0wOp
         sOOfyQPpLKvc12eMA8RjmCFPLfkL6uzM173wU4crYJaAkXIvrjjl14AYV0M95EcNWV37
         FGFfKFWL3UmHkGci/BW0NtKU8WFFzUPF55ykQ1orpdx8rDs3apxlDqjjHWiFnGwdN5EP
         pkOR3+1VPmdXg2lhfdwijuAsT6+PlXg4s0Y7lc2KtOg6ncI8bALhwTsYN5YQOP0nha+M
         /h+A==
X-Gm-Message-State: AOAM532cRljHqtf2kDJZ+e4nGoOpctGTuLgRHMCUQAXog2HFufbzgUJy
        g81oGTIOKCAfwTXI6VK2t6+0a7s4so8=
X-Google-Smtp-Source: ABdhPJwAvR4lRT0ADO3Xc7UqkXupPc/cHJ4ydDMfOPC7AKwxLlY1iTfMGU+HMnzLcpkNjkEL2YPp1A==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr68706240wrt.49.1609506436141;
        Fri, 01 Jan 2021 05:07:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o83sm16541302wme.21.2021.01.01.05.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:15 -0800 (PST)
Message-Id: <f841500c66310179d47478bb928eb35a4427fe5f.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:03 +0000
Subject: [PATCH 07/12] update-index: use istate->cache_changed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of active_cache_changed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1657a66496..a64f2f5a8f4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -242,7 +242,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 			istate->cache[pos]->ce_flags &= ~flag;
 		istate->cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(istate, path);
-		active_cache_changed |= CE_ENTRY_CHANGED;
+		istate->cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -926,7 +926,7 @@ static enum parse_opt_result unresolve_callback(
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		active_cache_changed = 0;
+		istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -947,7 +947,7 @@ static enum parse_opt_result reupdate_callback(
 	setup_work_tree();
 	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
-		active_cache_changed = 0;
+		istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -1146,7 +1146,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
 		if (istate->version != preferred_index_format)
-			active_cache_changed |= SOMETHING_CHANGED;
+			istate->cache_changed |= SOMETHING_CHANGED;
 		istate->version = preferred_index_format;
 	}
 
@@ -1234,7 +1234,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("fsmonitor disabled"));
 	}
 
-	if (active_cache_changed || force_write) {
+	if (istate->cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
gitgitgadget

