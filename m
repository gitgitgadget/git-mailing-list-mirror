Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074DEE49A5
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjHTS4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHTSz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D752BEB
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so26151475e9.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557455; x=1693162255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O968/4XngqdSXUyum7jeMBHfaf+NuJRfQHdS2BxZ3nk=;
        b=YMuwgpc7feNX+p9pmPbLiKqjS3CBf0ITm2L1fN9w0uX6F5OF06YP7DGPSxew2l/+hw
         UGdWBSKT0xmQQn/egHEE4qbyQxrviLEPcB/7JqC3MY7Hc/mlMmS6AIBkmBXxdAgrYH6c
         MtYMCX5XiVPRoOXuPuKMFUwUdFRO46M1ed24Kc2vIg858gluYb6axy8SQY/DahjUt3dF
         VdYygtrYxuiRNZ1FA4UKb+kXjgkEDrSY39zRRDz2P+qZHeDHmYDA3NLk6HoWCjEzMZ8H
         Flf3mLv8IDM2FFwR2HNEIdxRi7+sx1R6pvQLND1+QDtg9Z+rOHqwj6dHpuFjYG7SMxAm
         Wbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557455; x=1693162255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O968/4XngqdSXUyum7jeMBHfaf+NuJRfQHdS2BxZ3nk=;
        b=Uz08ZUN0QSUY5Jglj8pnWWzIVwPwxGa9XVqmtXafPH72ED3CDg9cCOJAVZYtLI4oto
         f9e0kIR3a/TaJ4b5EuTAjP/9pdMgFo/DJ97zK1f+GDy5KTtIabHAHO0W0dAQRxdTWdB1
         w+gdVUd23LtSHols4qu6o9fdRhHZUelCkpp8tOpO15LOMONGkymBbXz88acJleOeG5nB
         medpegumUYwwbx4irvpiT8lisNUGfdNeU50UgKojQdZoRyMmscGq51xME33kADtu6LM6
         Dv6cnjW72uQ+vAbwCkAGytGXHd2Y9Tn65jIJnSdlMf9QzS9rkzYbQWOiwErzgF6apmAf
         BToA==
X-Gm-Message-State: AOJu0YzqOhZGvtg5QnpwQHQZsCeDfaGaIx9P4uylkxYDmsDL4tgxvXmZ
        C1U4PJcWZ+7GnV1mawPxlCpyN3N6RPDQcR7H
X-Google-Smtp-Source: AGHT+IEfIbghxK17bQN9TwGotLrBw8i58dAakxOU9u7KFqiXqc2NkmHsRyhiwrF0fUduhfaOW2tpMg==
X-Received: by 2002:a05:600c:2807:b0:3fd:30f7:2be1 with SMTP id m7-20020a05600c280700b003fd30f72be1mr3247284wmb.39.1692557455091;
        Sun, 20 Aug 2023 11:50:55 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:54 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 4/8] decorate: avoid some unnecessary color overhead
Date:   Sun, 20 Aug 2023 19:50:05 +0100
Message-ID: <20230820185009.20095-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In format_decorations(), don't obtain color sequences if there are no
decorations, and don't emit color sequences around empty strings.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index cd12c26c29..7c6d3f1ac3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -312,10 +312,7 @@ void format_decorations(struct strbuf *sb,
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
-	const char *color_commit =
-		diff_get_color(use_color, DIFF_COMMIT);
-	const char *color_reset =
-		decorate_get_color(use_color, DECORATION_NONE);
+	const char *color_commit, *color_reset;
 
 	const char *prefix = " (";
 	const char *suffix = ")";
@@ -334,6 +331,9 @@ void format_decorations(struct strbuf *sb,
 			separator = opts->separator;
 	}
 
+	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_reset = decorate_get_color(use_color, DECORATION_NONE);
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
 		/*
@@ -342,9 +342,12 @@ void format_decorations(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
+			if (*prefix) {
+				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, prefix);
+				strbuf_addstr(sb, color_reset);
+			}
+
 			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 			if (decoration->type == DECORATION_REF_TAG)
 				strbuf_addstr(sb, "tag: ");
@@ -364,9 +367,11 @@ void format_decorations(struct strbuf *sb,
 		}
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+	if (*suffix) {
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, suffix);
+		strbuf_addstr(sb, color_reset);
+	}
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
-- 
2.42.0-rc2

