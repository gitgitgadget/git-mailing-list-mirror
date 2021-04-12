Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA54C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E285161278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbhDLRQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbhDLRQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CFC061346
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u20so2725869wmj.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJ9SoNjSLWvJAM/mKOXWgKqyTTcCfnyLuV9X5q6Kx9s=;
        b=rP51pbCpaCFeGmmo/G/EEj1Sc0jJqyo/5sInbOdpNONdiEmujVO1/6xvKJbboLCbGm
         75iboYJUPTi5BZCUxo39kZJdrPoVlwRGRd7CjwLy+rYnPy8dBrm+diqZjDTtef2XsC25
         Xhe1+Jyf/vuE+q9tnsp/8IJqYaKROb9tDS6KkzxdWLnDXP2pQHgm08RVGFNFF/eR6Pa6
         0yGjZdghSpMD54l9aYzBI59jXbl4of3DIRfMHI7uPMMOQN9xH82U8XwNKszM/uc7yUwD
         6srkWqJVrnEcLhqLdb+xrZ4Iyy0K7JKxo5cHvfuP++BDrvfa7C137ZcVL+h8D4BnQXuj
         rDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJ9SoNjSLWvJAM/mKOXWgKqyTTcCfnyLuV9X5q6Kx9s=;
        b=D/0G8KQqbM0uLsxLLg9CmwIq2OqAAuK1KrWq/aOfD9YcpV79/3owTdnad2T8XCSSFQ
         mr4uM/lAItXJBXdPbRwUTP+e0dL1ehiSdkT3ijexcKCkYIEEHMvSTWzOJWwrVPllZ0YC
         CnQbcyr/vMa0Sx/VIHtU4xPknB+VeizdZWyFi9h2nKFQwj58ccN7UWdOq3fL/e53xZPc
         EldBtUeOpEXA4OiAqpfujJLlGQBNgBeLntEaw/Nw6ISUJ+8R677rrKMcbi0+ewvh+zHr
         9TTpBIQuWXi4XQQW8G//Z6vM7+iwppSGwZNjy4ozeVP06h5/xunbOaqP2XeLzrR4H3h5
         wyHQ==
X-Gm-Message-State: AOAM531/taLOIXxdG0OEDLPQIrCf72PLzVlq/g8vEuBqiBZC9E5eqjpK
        TMKcNcdK36YCXU5sMl7bjnSQC4tMOLpHmQ==
X-Google-Smtp-Source: ABdhPJwqe7SAfrGNuWw4cSRfPb/M9yw8yw72oIX7IIzgeOmvZEND6EpnOEopwbQwtWU37y7cYjrZsQ==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr175424wme.68.1618247747217;
        Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/22] pickaxe: refactor function selection in diffcore-pickaxe()
Date:   Mon, 12 Apr 2021 19:15:19 +0200
Message-Id: <patch-12.22-c29deb428b1-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's hard to read this codepath at a glance and reason about exactly
what combination of -G and -S will compile either regexes or kwset,
and whether we'll then dispatch to "diff_grep" or "has_changes".

Then in the "--find-object" case we aren't using the callback
function, but were previously passing down "has_changes".

Refactor this code to exhaustively check "opts", it's now more obvious
what callback function (or none) we want under what mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a278b9b71d9..953b6ec1b4a 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -228,6 +228,7 @@ void diffcore_pickaxe(struct diff_options *o)
 	int opts = o->pickaxe_opts;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
+	pickaxe_fn fn;
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
@@ -235,6 +236,20 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
+
+		if (opts & DIFF_PICKAXE_KIND_G)
+			fn = diff_grep;
+		else if (opts & DIFF_PICKAXE_REGEX)
+			fn = has_changes;
+		else
+			/*
+			 * We don't need to check the combination of
+			 * -G and --pickaxe-regex, by the time we get
+			 * here diff.c has already died if they're
+			 * combined. See the usage tests in
+			 * t4209-log-pickaxe.sh.
+			 */
+			BUG("unreachable");
 	} else if (opts & DIFF_PICKAXE_KIND_S) {
 		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
 		    has_non_ascii(needle)) {
@@ -251,10 +266,14 @@ void diffcore_pickaxe(struct diff_options *o)
 			kwsincr(kws, needle, strlen(needle));
 			kwsprep(kws);
 		}
+		fn = has_changes;
+	} else if (opts & DIFF_PICKAXE_KIND_OBJFIND) {
+		fn = NULL;
+	} else {
+		BUG("unknown pickaxe_opts flag");
 	}
 
-	pickaxe(&diff_queued_diff, o, regexp, kws,
-		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
+	pickaxe(&diff_queued_diff, o, regexp, kws, fn);
 
 	if (regexp)
 		regfree(regexp);
-- 
2.31.1.639.g3d04783866f

