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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1160C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674AC20809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miyBd1qJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgKJXm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732446AbgKJXmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:25 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D65C0613D4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so108837wml.5
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=miyBd1qJmblZJzo/RwWTtlIUQsc6AasydfuZ5MkAkqKmrt3F21rYIjufx9EhqBAHSA
         DHjBx2NzBEexEQGYJ11FRdYVhpMgATySqVfYMfTE7MisVpsALQCNAuvjmuRIJ4Ks67GL
         GGNJhbxPjEU1UNG/JZbL5rODB1edgNEfQtNUoLWl6fadxEgHG4t/Px7rRKKc4mbjZ5gd
         NkF5AixM9+QjrjbBbNIZ7A0NN+nzhlkOhq7WtB+/L1KtdVAqBqUfCZkQ1HU/IhabZ8IO
         8PKxX5qIjupDEG3hQMcjxniiziIVgeEx48OIOQenjriPZv6dN4IJsBcVnwjpY2hBFivd
         +EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=DsrtSzS6fMcJSB+7fKV9xeh8VtIGzDDopcdEfy6SEEp1Cn9Dzs3FSPMr7zbQDXgmzz
         DPDC4IFZgCplRG+L1H0Ab5qHgOAtSokE7gQyHXjjsLJpWyjEISaMbncTKiMvO8smuBhF
         2lxBpUbOUb0IjnuQoah95ZRdV+DFr2iJD7PIgJfg0sp3ta821hFsnVgqSDecmy2HMEMw
         0q35YDHsxbz5uFJ1EflhWGeJAKyvkCqsx/NrAO4H165dMKda5hobJ0z29Sk3Rba2fjfU
         h2PPi6PRy3rDyCELLUDB7pB/G8rdgFEev4pUEx+NFx7C37rbnt5BCJhRoOsNAWmTo00K
         Ik/g==
X-Gm-Message-State: AOAM5328tvyej0SQ7Kuo021Z6sffqwsPnZwT0AT/HYjGGdXj0SV7ZRjJ
        n+UuARaRvVn/IWcWD1H+uLxBRhjeA/g=
X-Google-Smtp-Source: ABdhPJzNCTKSUrweylb5c58wlcYOGiurWiOOsuWhtMYS08O6Q0tUzjF2wKGlx/ZbsrEgccFrIcHT9Q==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr581906wmz.74.1605051743713;
        Tue, 10 Nov 2020 15:42:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w186sm375710wmb.26.2020.11.10.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:23 -0800 (PST)
Message-Id: <b48c878fad2966063a44a31034184af4386f8511.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:14 +0000
Subject: [PATCH 4/9] add -i (built-in): prevent the `reset` "color" from being
 configured
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

The Perl version of that command sneakily uses `git config --get-color`
to figure out the ANSI sequence to reset the color, but passes the empty
string and therefore cannot actually match any config entry.

This was missed when re-implementing the command as a built-in command.
Let's fix this, preventing the `reset` sequence from being overridden
via the config.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 0f24992ca4..f3a1d7456e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -44,7 +44,6 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
 	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
 	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
 	init_color(r, s, "fraginfo", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
 	init_color(r, s, "context", s->context_color,
@@ -54,6 +53,9 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	init_color(r, s, "new", s->file_new_color,
 		diff_get_color(s->use_color, DIFF_FILE_NEW));
 
+	strlcpy(s->reset_color,
+		s->use_color ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+
 	FREE_AND_NULL(s->interactive_diff_filter);
 	git_config_get_string("interactive.difffilter",
 			      &s->interactive_diff_filter);
-- 
gitgitgadget

