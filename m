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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA0C56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753FC21D93
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWlM2qJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgKJXme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbgKJXm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DDC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:26 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so118599wmd.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A5bDKyCl0obBVU+z1Kv+8waCmoKQ+uehMreT3MevQVI=;
        b=FWlM2qJNqpSclYKREGHOXCF8eiUkVxoAqba9EYxNcxlLYKOmN4+y51Pqc+zbwItJU2
         hPmV83wVhx+pEzDaK+Ya+ICXJtijDqM6LjI62fx6JoOTQhEbRWO5fxlJoKkwIHSuybaY
         52Yg1c2MmZ4G+/+lyB0NCjZHV74w2hAf5jNeAjQ+sp0/vnH66yxXlu04wV3/54ivctnF
         8tMn7/4wn8y8DKsdNSMz2+TWhiZCgaSxtdKI7VpJf4WYPjRU8XebEgMFEwq0qtDeTK7G
         +sjVx3oSL9/SMPdLCW+BoR9h/R4BPoGmEbNJ1geDKSvOClkeDYUn9dRx4GEq1asQRw/p
         ZmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A5bDKyCl0obBVU+z1Kv+8waCmoKQ+uehMreT3MevQVI=;
        b=M2muNYVyZSyc5TTafwOnyp+trmgHJ43vuAaMXA+9Bb8rNgDhNwNZi3hbaOFkva4Sek
         g/fI0uv6tC3Huef4YdOsW0+keEY4E/y+SCQaNBNxrg2mTbQnoodmPxbq6JJlghwBAO5h
         QSsm1ZojFRlj3WUOr4FEWEDZZJjgoO2x3nlnD4GI1uqHONDXD/zrw0C7FsslaOsKqh/T
         eGjfRtrwKKzUbUsIZ28VzUyxb/CGpr4dDfvcLj1L0dhtuWbDMn+Pp7MmkJL6zcqA9S8c
         ZtRr+kiKNuWcafVXnniXtXGf21lp2VXIb6ihudBPzbWt9asEwN//vdFYtQfXkh6ksJmb
         dxFQ==
X-Gm-Message-State: AOAM533bBxyveLMF2sbHoxHOK6Ad++tO3JPaC0huyGlJwSDgLqggYxfs
        QUwZBjwOKUDmjBLIOxI0b62p6RbDH44=
X-Google-Smtp-Source: ABdhPJwvoAHMEHY34EEpH3NMSV39ik0Q7kRhlMR37ogalssDSvBxZx7IGOZzP4MoFFErfAcJrmGTKQ==
X-Received: by 2002:a05:600c:d2:: with SMTP id u18mr591646wmm.102.1605051745264;
        Tue, 10 Nov 2020 15:42:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u203sm381802wme.32.2020.11.10.15.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:24 -0800 (PST)
Message-Id: <059344bfaf40da90dbe951a58f826b1ed21b5e12.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:16 +0000
Subject: [PATCH 6/9] add -p (built-in): do not color the progress indicator
 separately
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

The Perl version of this command colors the progress indicator and the
prompt message in one go, let's do the same in the built-in version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 33a24f58fe..6f4c187238 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1456,15 +1456,15 @@ static int patch_update_file(struct add_p_state *s,
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

