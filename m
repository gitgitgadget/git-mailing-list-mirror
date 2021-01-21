Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E9CC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629EA23A5E
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAUWWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbhAUWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:21:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC3C0613D6
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v184so2795256wma.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwW37Km+r4zps4r4VkD9Ul6EsBzptqoj2Ha5MI5WvLA=;
        b=uQGvvnA6vVMgSS+H1JK58bfbxcgP268ZXywWvNU8fLC6S8C5i//XmrTfio/kpBLvl3
         MZaSdDBWUnxM5MHLMpZe4HoIuKY/H3rUT7Cjzib6u01Q/M3BYpgD98w6NRj2hjXc/tJB
         x/7UFo/4Cs6aLzw0rldXsxrEQdI67RcFkg6ysHabHkcwbNrMTN8Kr8KSXkDX+dnB4Lwa
         OAsGkQ6YpwHTnKFdge3Dn+0fQaLA+mDBxdV8cXzx+EvKj1HHzWTRX2ik1THVjP+HSoNb
         sERXssbGhC10mzT73g5pctG/tuAhzPQfZNcD2qwISxBS8K1T6yNUm6E0G6HX3AuRb+hX
         e9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwW37Km+r4zps4r4VkD9Ul6EsBzptqoj2Ha5MI5WvLA=;
        b=JgXKjePq6GXVShTcMNeMT39wXpqRm/PfwhAr1jtn8CiRGHJ5G3lxTyoPCDrdTq35G8
         RGiCPfU+AVZ+iVwtWASJElyg+G7CU2o5v6ZtWDoCquv52QDI0RNC4HwVLTk4LlKAaDgm
         C+ly7A0LMXRT6org35ZjFoXeeuj7Z+XLLaSonN07kx6sGIWC0hOg1dVxKSJRvjddl8vx
         zKwCj+SOnxC+50y1xgpuCzoC4JAhBGS11VudsmC17QLCVTVCqrssNBDUa8m8ICveF2uA
         DLn5Dw1gN7Y+Ri6lJwAnpiNGhXAI+WAdw4O3jeSHK/uzVv6sLi8qBlQX+rHwbM9Qw2pN
         Ckrg==
X-Gm-Message-State: AOAM530RHZxIbl+mDmeKpwcw4Vtuq+B9pokl4FbFg7Grew/Ux+y2EYjd
        sywimVNvnYSK8YuQshlcfMGgUccGqvk=
X-Google-Smtp-Source: ABdhPJztl3kwS2eY5S9gYS2RaOXTdJy22OA5M2jj2eJKn1CnRrD2QNc8N+1tIJ7gkC1fHSwZWSEt6A==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr1206488wmg.149.1611267641020;
        Thu, 21 Jan 2021 14:20:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm8807208wmk.48.2021.01.21.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:20:40 -0800 (PST)
Message-Id: <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.1611267638.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 22:20:36 +0000
Subject: [PATCH 1/3] range-diff: refactor check for commit range
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, when called with exactly two arguments, we test for a literal
`..` in each of the two.

However, `<commit>^!` is a perfectly valid commit range, equivalent to
`<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
gitrevisions[7].

In preparation for allowing more sophisticated ways to specify commit
ranges, let's refactor the conditional into its own function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 24c4162f744..551d3e689cb 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -11,6 +11,11 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static int is_range(const char *range)
+{
+	return !!strstr(range, "..");
+}
+
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
@@ -46,12 +51,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		diffopt.use_color = 1;
 
 	if (argc == 2) {
-		if (!strstr(argv[0], ".."))
-			die(_("no .. in range: '%s'"), argv[0]);
+		if (!is_range(argv[0]))
+			die(_("not a commit range: '%s'"), argv[0]);
 		strbuf_addstr(&range1, argv[0]);
 
-		if (!strstr(argv[1], ".."))
-			die(_("no .. in range: '%s'"), argv[1]);
+		if (!is_range(argv[1]))
+			die(_("not a commit range: '%s'"), argv[1]);
 		strbuf_addstr(&range2, argv[1]);
 	} else if (argc == 3) {
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
-- 
gitgitgadget

