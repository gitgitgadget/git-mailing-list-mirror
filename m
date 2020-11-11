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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA626C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A4C20795
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvFqk13n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgKKM2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgKKM2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87663C0613D6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so2326843wrw.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wtwRH7d2asDdW9AzKlKoJolSKk1x7GDxEy0Ku/21dzU=;
        b=GvFqk13n38L5la6CacNLN99fg7J/Pd7Kmd4gIZVV5fXob/89bi7pgVCg5F+ft9YzGG
         8v9NXF1eAs291tagPzd04rNLMBlPwIqQzEVJlV60T8t44PL9p1gE3z9XHvmoI82rna+N
         raF38snf/ua+hZuA7R95DS5FXK3e3OKEmtKNers4yRo0OjgtL9/Ka6765ycBCUEvzA2y
         PyyDSbyC2TegQYbMpRR6p8su4T8g9oTxzvDaUErWPsGWjGMHIemsALJALE420/b5c7sb
         vabr8+Zfoints76JIoSATeNrz6TiE4MQWEJlei7qtxJkaGEkulms18vFyB0+rHlj8Znc
         0xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wtwRH7d2asDdW9AzKlKoJolSKk1x7GDxEy0Ku/21dzU=;
        b=Eyo5/YeiazX46g4PMMll3iJIUieHDI6Z/Mlz746VWPEsqm0zt8O4mFbiRnpVu5Uo1T
         gFx27kq5XjkMGpKFnl6uWziBJRlI2o15wo3+j/fkksVC+mflk63keu1O8SNuUL5+N6mo
         dIn0ic+V70ow+xv8kcldxzVKykR6xi7LIcK+QG2BvcGCy+nsbfKytI1t+mJ7nBzCT9V8
         J8rFwBy1DbRVOikVIv8FRTYalEu8n8Awmg+mc0GVAriuBsOUicTS5MclRFhDto94DhR9
         MGFuc7SoQFDwKmgY16HlOFLuOBdrOW2Sf308EOjXSOANfW2MqubU4sSIqDk4M7uFCZwK
         Wi4Q==
X-Gm-Message-State: AOAM530BEwBXNVmgYvFYRZqsRTxnSvBkthmzvSeGG/5Ox0VjcUixJfye
        4yddvFQAAn/c9+8jnK+3oa+IoAb66CY=
X-Google-Smtp-Source: ABdhPJyDkocbQ+XVY7mYYReIJRYvjvdmr7gXHkTsXpmdGewB8g29a2qquz++o8Fg6FmRQPVCeDGiDA==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr20646140wrx.367.1605097711188;
        Wed, 11 Nov 2020 04:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm2273287wrq.47.2020.11.11.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:30 -0800 (PST)
Message-Id: <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:20 +0000
Subject: [PATCH v2 07/11] add -p (built-in): do not color the progress
 indicator separately
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

The Perl version of this command colors the progress indicator and the
prompt message in one go, let's do the same in the built-in version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bf89c43145..2fad92ca37 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1461,15 +1461,15 @@ static int patch_update_file(struct add_p_state *s,
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		color_fprintf(stdout, s->s.prompt_color,
-			      "(%"PRIuMAX"/%"PRIuMAX") ",
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
-		color_fprintf(stdout, s->s.prompt_color,
-			      _(s->mode->prompt_mode[prompt_mode_type]),
-			      s->buf.buf);
+		printf(_(s->mode->prompt_mode[prompt_mode_type]),
+		       s->buf.buf);
+		if (*s->s.reset_color)
+			fputs(s->s.reset_color, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			break;
-- 
gitgitgadget

