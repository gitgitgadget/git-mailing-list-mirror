Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F4C63777
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF0620729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRTqMY9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgKPQIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgKPQIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A950C0613D1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so24222224wml.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=SRTqMY9Zn3T5VjOXYNdBN6GAfCGI5/OEVJCSMGym6A+jm1J8S9jGcR8Sk4Dl0y102r
         p/h+GGYQQkC7dkEAhJb6MaKARJFjF4iDMQEVqWNKV5WdLYQsSwRpwPRZIhxrd196oPm9
         5/kL1zNHSgvB22Dujr1ca4H6bq0wOAD4OcdsZycKEIUdG13VhpepnxCnlvcLQ1+A477L
         iWX6K7K2Gvo33rez+632AdVtynDxVYzQC3b8slp3LP1TPHzDaK04spcNHZMmLiupVewh
         WpMEdnuomd9yg4ppI5D3eRW49YstuJfkfwx25NNWvJHF+BSj2TVNcQnf9BEzqnjFYG79
         WxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=BmGTxjQxQBSwLM5zsSnCgZvzyygdIjV58gPNSifylm0tQE8EfJv4wBqyhaHebBbljJ
         syO+yGL7WtTVVKm+XQj0jZ0gYugNSI5mhzV4mj85MgRTvLoJVDwa3ijUh56xUS94u4s9
         vrqxf51ZsV6ANVhZ4W77G1t6iibP0ZZbU7juzm7D1ewgI2x0BFl6ANeezhaLCFFQfRIF
         2o1ImTfLgSCB/4UGVo185u2x9+Zg/tKMY+aINDDgXkWnFVWNP2VBnKyaVWgOTla1w9d9
         fkN+vFVwD4ScEJo44rOpHl9MbMF8FCpgX3vzObnh6Kvlk3mVMvRfiJeyQunVnepZpQn/
         cxTg==
X-Gm-Message-State: AOAM532W+PPO2MMNl1i33J9508vPFI1prAqSARbGpLLzYXOr1YvSLWcW
        JM87SzgK6LH1CFhTWqkD09AIj5L5kMY=
X-Google-Smtp-Source: ABdhPJy103jWuEev8MSP+qhJ22feQ7qfq3ePMn6YsW+MAf9WKYqBzhYb5vgPl6IgIh5vzF2vEMdj8Q==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr16405945wmj.77.1605542919115;
        Mon, 16 Nov 2020 08:08:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm20285220wmg.28.2020.11.16.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:38 -0800 (PST)
Message-Id: <dcd2ffc4586960386eb8a517ff9478a8975d428c.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:27 +0000
Subject: [PATCH v3 06/11] add -i (built-in): use correct names to load
 color.diff.* config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The builtin version of add-interactive mistakenly loads diff colors from
color.interactive.* instead of color.diff.*. It also accidentally spells
`frag` as `fraginfo`.

Let's fix that.

Note also that we don't respect the historical `diff.color.*`. The perl
version never did, and those have been deprecated since 2007.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f3a1d7456e..9126684348 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -12,10 +12,10 @@
 #include "prompt.h"
 
 static void init_color(struct repository *r, struct add_i_state *s,
-		       const char *slot_name, char *dst,
+		       const char *section_and_slot, char *dst,
 		       const char *default_color)
 {
-	char *key = xstrfmt("color.interactive.%s", slot_name);
+	char *key = xstrfmt("color.%s", section_and_slot);
 	const char *value;
 
 	if (!s->use_color)
@@ -40,17 +40,20 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 			git_config_colorbool("color.interactive", value);
 	s->use_color = want_color(s->use_color);
 
-	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
-	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
-	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "fraginfo", s->fraginfo_color,
+	init_color(r, s, "interactive.header", s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s, "interactive.help", s->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "interactive.prompt", s->prompt_color,
+		   GIT_COLOR_BOLD_BLUE);
+	init_color(r, s, "interactive.error", s->error_color,
+		   GIT_COLOR_BOLD_RED);
+
+	init_color(r, s, "diff.frag", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
-	init_color(r, s, "context", s->context_color,
+	init_color(r, s, "diff.context", s->context_color,
 		diff_get_color(s->use_color, DIFF_CONTEXT));
-	init_color(r, s, "old", s->file_old_color,
+	init_color(r, s, "diff.old", s->file_old_color,
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
-	init_color(r, s, "new", s->file_new_color,
+	init_color(r, s, "diff.new", s->file_new_color,
 		diff_get_color(s->use_color, DIFF_FILE_NEW));
 
 	strlcpy(s->reset_color,
-- 
gitgitgadget

