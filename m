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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DBC63699
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4125221F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhU+sIOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgKPQIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:41 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97704C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so19294962wrw.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=vhU+sIOyivkFmIVtrwYZXHEBtZBZruPFG2lT4ZfKpaqfxoV2E6MwsQhz91DCWsogtx
         96M52ySrjk7sbsPoswYsDznLakmIzQjqp+q4gLeqEVxz4YawEr/S4AJoI30HkdHZO31Z
         39S4rYiy90/TPlfX1A8aSlKdlreylsJqzZiu1FDymUtWfTgcunu1zbXQj/7fzvBEFdkf
         E1NcVDBIUADeBiQS4a7OEFmnsGOFBx7ILQgA1BQhapsLQVZqnzpra3PGNi4vAHJwHdrO
         Wxas3uD8N7AiBGYrMuzwmWXmtMh1ID4k58KDg+BLQON8Tkl+cuBaw/K1kGhtnzaxqHCh
         7xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=BVISMQywvokaZY0/bxihZGbqELEtKO40dn8P16OqUa1w7SY4MKVOHIkF/xRC2LyyFw
         R+76o8Amu9wBwvzEXmulGV0P8dowUbFC99F1ino7zN82xjuIjIxGTNXLr7h0g8wGK4Rr
         9/JnTQFdU9Uw5MVas26ff6rSbYYjKq01itl0VbUrImNKciQkxFiRIfqYvfXZo4zQC34l
         k3U/tmM8r7atB7KhWnPdRBYhFoNTzBnrnllgsma+8OjomKzh5dVl7XWxq8SoNgzA9wmI
         kiBSsWkulORim5IDNgIRUovXdGWZsRmusd4F+Q6YP9KOyed6cnxevl7/JQnsvQf+Qzih
         laCQ==
X-Gm-Message-State: AOAM53362VnDUCwdC7Mb95SVC/4CVjLig8yFxfSu5WjWp6he8Vyk5Iv5
        VU0M6guOo26bxPPW4Az00nEBvMo2D18=
X-Google-Smtp-Source: ABdhPJxAwpKLZxOOpkI7lihTQ3EOGD7nYb3x9FPq2ya874qDGTRvhn/wiDbLw2oBPRxPy5/A4mb3zQ==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr20146127wrw.365.1605542918277;
        Mon, 16 Nov 2020 08:08:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm19422006wrv.6.2020.11.16.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:37 -0800 (PST)
Message-Id: <337b45cad8b876e1811099f398bf0a05ade21acf.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:26 +0000
Subject: [PATCH v3 05/11] add -i (built-in): prevent the `reset` "color" from
 being configured
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

