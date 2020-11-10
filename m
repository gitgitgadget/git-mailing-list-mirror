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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455DDC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE27D20867
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnPaO0VA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgKJXm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbgKJXm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473AC0617A6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so352109wrc.8
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=FnPaO0VA1ze0cSxhxZpHjA2/syGfyo8Qu/Z6K/KIZPcOTdFIEdt5bEvS6/Bv+iicxM
         GVtyYi59quGCTOJdd8TxF+R2R+ocJdFTLPYlYjnPMMKwDOi29/wUV678EjbWuuayuvb+
         sXSSt+9P40Y635mvW8Io0ztwQLs0aj5oXBV2mcuEUT6rJxqcMSNZUQRWlETkFfIff6GJ
         GoiAW75wQB96EULL59LpANd3qu75adlBUZLMOFGkoBBPU6LQdC5O0r9cturPF9eaIWwv
         4Jlu2vuxPamt5MQrXXNF+Hg4p5tEbWBPwXSttnHlbc6lxUgzkguU+Pq+Pp/i5w6Sdr5O
         AyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfewZDe6pyLTRvzVboxTA78Zdq0TjQvvkV3C3VOSFME=;
        b=gAvQFkrMqNoZ2gBCM08+sTvNnZ515fsHqSfcbref/cFK5n/SDvw8XsMmkGYBJ7rKbj
         B/KQRG3T5pQaPwQkuPyMpKUVg912WgUVb00YbtfG8xFgifawFRRR98phfxMXmK8jYjvC
         2YWXKI2QyJPwgWBBcBSgRo/jVGsYTWXuosiNqYfEyaHRtiNTeM88RJs7EmVxwXL19ebq
         rLZsMlKpJHYAuDRzNfCkz564L+tj//MFRysBimxljmac5F684fBtjIIqB3BkBtbfIrgj
         hf7vpMwbSG7ucmEdQQ7AMQ42QLxMkrpsqi/8SGaMDrPYhT/TmOcDdP1O5I+lduFGAKcz
         iG9g==
X-Gm-Message-State: AOAM531zkYj6l8kadz78/vXGAsAsYnhno8FVgY8cTfw4q9Lkhcb5vV1v
        7zvAA3zqR2cEoieXX0nGdW10+YGfe7Y=
X-Google-Smtp-Source: ABdhPJwkurV+98EaQHZlLcmFMn0M7U4tknBUpA5xq2xKh/RYvYtVcazLs5MC5PA3LFqG83Rmmy3+jg==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr25424836wri.233.1605051744438;
        Tue, 10 Nov 2020 15:42:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9sm281947wrf.90.2020.11.10.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:24 -0800 (PST)
Message-Id: <85b0d27d76e31033d691b69b271db6ad033f9e29.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:15 +0000
Subject: [PATCH 5/9] add -i (built-in): use correct names to load color.diff.*
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

