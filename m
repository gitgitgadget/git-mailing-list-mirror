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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D81C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2042207BB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgOSM7Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKKM2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgKKM2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8095C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c9so2074937wml.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fWhYFLm87UYuCIjPFgBzbh9jSW2xTQmwaysBZzk2pPU=;
        b=vgOSM7GdJFI/edG9ytpa6fHyi70JclBo/2dy70/JkU0AZzXBJxn6LZjOGs8ZA5/Vdy
         DyrGc36c8fTPloXLhGbtgqRWw8OOekCwELkfIQLCVZA0rbiWoHI1BKfv0owfIWWo7ZER
         3jjVe6RYS11nMpU0TM7/RrqzwiwFUmbX7KBz5ZaQWBx0zr28a+ma6ZwQFnYn/PvGgtMP
         6Lo6ZrKGfusclMJZWdaK64VPXAYR/J2vWnFk1Ocl2XHvVDhxYISRlu0Hbww2OnjmVbd2
         Y7oGx8aO17WE/FfBr9GOHc2+MI3AT8tNHydvSegpYJBwm0Keb1cRjwcKM2aV/JsRUmxt
         rxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fWhYFLm87UYuCIjPFgBzbh9jSW2xTQmwaysBZzk2pPU=;
        b=BvqbcFRiBe0DBQVvlJMwxolsvRnyulOIyvdL+N8HoiR/wlN5aYB9KtSagtFGICrIg9
         iPknY/j6m9xiIBsMHP2PZOuTJEl3jIm167IhFb6qFf1dcMPoocZ/MEzJoHxHo2Qpsp7L
         uSfRr6soQlLf7KFwEVWEYS2j7IzgrDQNqulhEpNcBT65S8ilAiyxxqsy4Mos+R6jxxVp
         QcNdtCsryDovdBuhOXbklcoCImFNg+N2bN7wl7Mooe3dw+7SeAqKuARVP/8RQoAUM7Oy
         QjgswdKK/BQtR7KK3oqoSo6jFPwEl2EsvDr0rhiA7x+4O6A8rWN+cdd4Qtr24J0wBad7
         g8dA==
X-Gm-Message-State: AOAM530aywktKBlfOjapqYBl0J5ldNIHE82gWC3xdUolDitGx5GXwqLE
        PYkF5kDtguQNMgQ9BMpw30zkVk2Ovho=
X-Google-Smtp-Source: ABdhPJxKmSaEFmeNy1E+2v16kxrH8PafjhMR2y2Y/o08C9rcB3sle7tzPAvUaHt6FCrrAxcRzfQJNw==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr3699067wmk.127.1605097713387;
        Wed, 11 Nov 2020 04:28:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm2392130wmh.16.2020.11.11.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:32 -0800 (PST)
Message-Id: <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:23 +0000
Subject: [PATCH v2 10/11] add -p: prefer color.diff.context over
 color.diff.plain
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

Git's diff machinery allows users to override the colors to use in
diffs, even the plain-colored context lines. As of 8dbf3eb6850 (diff.h:
rename DIFF_PLAIN color slot to DIFF_CONTEXT, 2015-05-27), the preferred
name of the config setting is `color.diff.context`, although Git still
allows `color.diff.plain`.

In the context of `git add -p`, this logic is a bit hard to replicate:
`git_diff_basic_config()` reads all config values sequentially and if it
sees _any_ `color.diff.context` or `color.diff.plain`, it accepts the
new color. The Perl version of `git add -p` needs to go through `git
config --get-color`, though, which allows only one key to be specified.
The same goes for the built-in version of `git add -p`, which has to go
through `repo_config_get_value()`.

The best we can do here is to look for `.context` and if none is found,
fall back to looking for `.plain`, and if still not found, fall back to
the hard-coded default (which in this case is simply the empty string,
as context lines are typically rendered without colored).

This still needs to inconsistencies when both config names are used: the
initial diff will be colored by the diff machinery. Once edited by a
user, a hunk has to be re-colored by `git add -p`, though, which would
then use the other setting to color the context lines.

In practice, this is not _all_ that bad. The `git config` manual says
this in the `color.diff.<slot>`:

	`context` (context text - `plain` is a historical synonym)

We should therefore assume that users use either one or the other, but
not both names. Besides, it is relatively uncommon to look at a hunk
after editing it because it is immediately staged by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c         | 6 ++++--
 git-add--interactive.perl | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c298a8b80f..54dfdc56f5 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -49,8 +49,10 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 
 	init_color(r, s, "diff.frag", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
-	init_color(r, s, "diff.context", s->context_color,
-		diff_get_color(s->use_color, DIFF_CONTEXT));
+	init_color(r, s, "diff.context", s->context_color, "fall back");
+	if (!strcmp(s->context_color, "fall back"))
+		init_color(r, s, "diff.plain", s->context_color,
+			   diff_get_color(s->use_color, DIFF_CONTEXT));
 	init_color(r, s, "diff.old", s->file_old_color,
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
 	init_color(r, s, "diff.new", s->file_new_color,
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index adbac2bc6d..bc3a1e8eff 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -30,9 +30,9 @@
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
-my ($diff_plain_color) =
+my ($diff_context_color) =
 	$diff_use_color ? (
-		$repo->get_color('color.diff.plain', ''),
+		$repo->get_color($repo->config('color.diff.context') ? 'color.diff.context' : 'color.diff.plain', ''),
 	) : ();
 my ($diff_old_color) =
 	$diff_use_color ? (
@@ -1046,7 +1046,7 @@ sub color_diff {
 		colored((/^@/  ? $fraginfo_color :
 			 /^\+/ ? $diff_new_color :
 			 /^-/  ? $diff_old_color :
-			 $diff_plain_color),
+			 $diff_context_color),
 			$_);
 	} @_;
 }
-- 
gitgitgadget

