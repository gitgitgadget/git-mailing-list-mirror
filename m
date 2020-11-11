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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E80C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC45220795
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZQzjgTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKKM2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgKKM2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D04C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so2367957wrx.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=EZQzjgTP+yDuoZazyM1CiiEPmnRPFX/7prVbuKTKvzyH5mAjLOW1q8G3XKTbFI+Qt8
         2wb06AL+ieIum2gfW9OZqtT321kEQIn1nv06DZaxej+nBYbq5tTnb+bu1BA6RC6JL5P/
         mtNOgB/q+CjYqtHavQTW3Fn9R6pSTAIFfzYi/rmwmjmYE01ejK14v5VkM7HDfXyV6c5F
         b9zonrpNt5HD/b8L4hou1lZtLvAUm7LGQlb4yl5tx8X9pU0XV/2h2FjBZIE38i1fjp2z
         OOj2jPCDYnVB6NUmcyITt4zdH+Menk1vXSdR8fQG0BCd1ckveS3rnXLqvKPVt0o3/qxR
         SbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=FbzCtUavt2o348G5iT56Iv+ig8pKIkmXmDKkry+EyI8L/EL90UfBrRuBsQoTZ3URfZ
         Ho9CY0FDmmqPgFEOWGXux6w3fJdU0SEUNpBagsxlrPvF8YEmt7azUdDZaeZzaB1J6/dT
         /h+sxWRNb3N9tMiTOMxL3yVpIkHG+Fy0VKYXu+Fkko5mZr0sNQKb7WVyXQp2iATBvmok
         N9bPqsJoLseAamsxqdF7lX7M5lRUj31IY5wy8FUmh8eBQhIRk6ly9hkHQOs1qaq9K1DB
         mf/h40k6aJ1l7XsjMNxRs5uC9tcg2rVwXrXyhYP/5oxyGmGzmUNRBYblBPhk3BaHI2UZ
         7tbg==
X-Gm-Message-State: AOAM5325kCz6kRn/WW05uhFH9Syg596mUCCq+mTCLD/jbJETNpR+2KOm
        5hXt+lKJXjgWr/4N6s5JlZO1KOtFn+k=
X-Google-Smtp-Source: ABdhPJz2xfdpabHhqPc9W8xilPwRMWBJ9EkOFtrI33VHnb0edjEcexwfO70WazB61hiMP9wXDqPfgA==
X-Received: by 2002:adf:8465:: with SMTP id 92mr28063078wrf.50.1605097710495;
        Wed, 11 Nov 2020 04:28:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x63sm2588653wmb.48.2020.11.11.04.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:30 -0800 (PST)
Message-Id: <dcd2ffc4586960386eb8a517ff9478a8975d428c.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:19 +0000
Subject: [PATCH v2 06/11] add -i (built-in): use correct names to load
 color.diff.* config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
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

