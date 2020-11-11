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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E77C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285B3207BB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdA/tOGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKKM2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKKM2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:31 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17203C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:31 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so2074751wml.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=PdA/tOGOE4Pl5Cue2jJ/I7Y8ABSWSozxIyc9o1W5WGjgyfNaJM6sp6YFK8T0gFeXxI
         VKZUtByMyn0mZgrQwATZJs/nQxNP883BDxnjmLGi/p91cG0dUV7JXyKZiSQGusBycuTu
         arPlqQcq3xh5ayv7p3fnyEj7BAm9J04YVKjujzraV3p4Vuz/C8V/trnzTUhg+ESjtwLe
         YE+GJPDGm1xP6jwVrl/Loca8jrUxCAkPseZ8cjf2PDbcDzaqUnbaJayTtOXQE7qWShKe
         z9dcFBh2oOM2B1DgDlDthEhNzfejXvxPYxNynBG6ElHBC/oVOzkWvcnuP7LXLR8YO4IX
         yvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wqcvrpnp66411xzdRYT+v8cQp9rgUou7SRfzShsgUY0=;
        b=dvmuNwsh2jtrRWCZjXIowuJRHjG+EtUm04Z6jf8ZKxWdDyzA5x9e8AJRucLmKsOOtn
         F8+pFINJmXOH+vYK5+u2188aD+4kJxG9Z2v/DPZDQIgMNe5vTOTvjiW+YHG+8LefqrJM
         FaItAMm1zkYGqQngF5yT1H9fWjojeBbGt6mtp/hQZMhMVX0Ni2LopSXJrRrPn3GxU1Ps
         K3x0KD3uchTTFmm9YL5hAXJ8SBSEaN9HQ3mjikE0WOrEZyfJ1D1kjVHfmsRoZ4ogyhEn
         3lQ0yOOhLNkFdWmyHJB65H7tgqwEMs4eI8ExoP2KouvGUTpZ2iEmgmbbMsIZe3PRUTwB
         DVAg==
X-Gm-Message-State: AOAM532KNsmMIRjkQsb/fSvKg46Zvp8lTXZfopSdvpOAtxOjiyW8+gVY
        M7gdRiCMB9KseTTWQ1wcY+JXO+qsOtw=
X-Google-Smtp-Source: ABdhPJzWs9ASL/TZf613+AOXg97nQqy1d3m9GQR0z65csdlr3gjbCU8HimWPexR8TfGXnb4Jx4gLhw==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr3730038wmc.57.1605097709758;
        Wed, 11 Nov 2020 04:28:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm2625729wmc.46.2020.11.11.04.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:29 -0800 (PST)
Message-Id: <337b45cad8b876e1811099f398bf0a05ade21acf.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:18 +0000
Subject: [PATCH v2 05/11] add -i (built-in): prevent the `reset` "color" from
 being configured
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

