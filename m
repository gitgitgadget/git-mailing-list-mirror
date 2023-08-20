Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23A0EE49AA
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHTJAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHTJAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8AEE
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-318015ade49so2111569f8f.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521696; x=1693126496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O968/4XngqdSXUyum7jeMBHfaf+NuJRfQHdS2BxZ3nk=;
        b=gEf/ysbe9XdZlwGJvJZNNRH6IMKj2pb+UqM7NRzocNrsxT0sDSTc/7RrWvLNcZHO7k
         qKtkComwiizHeCF/ZVM1awRaC7hBMTqWUGqjLablkgroRuYX9d7+Jm3jAYywHoix7d8t
         s9ALCHdhBlnGDkSrLQX7sY1Ydhr3mYGUbDPAtvmmZShGufcvRLJ5p0uDy7joos/9rZkE
         yqsL2emPtvGXLh0o75n89VEtqS/ldnw0m7T0lu5YeNqAO/lu0nbgtcBpwAC4szmLiUQQ
         IyO/oYAWa8hwcKvlOOeY/jyJu6LBJTxyVCW1N2Ij2SQ35DfyhB99DzRvIGkUgdSdTm/Q
         uxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521696; x=1693126496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O968/4XngqdSXUyum7jeMBHfaf+NuJRfQHdS2BxZ3nk=;
        b=cVeyq967IxR4Cga2ZHTJ6YedrsK9Cj9WXO/lfGPTITWXwRkECWZxl0xuUCQu1Ba9LP
         /5Np7qJFb+u1lY8NDZ1QL57N3EMP0Bcjfzf8xaqKbOCw5IAM1tG0Jru+oR9akvkdmEsN
         y2ct7DcR9cA96zauPL1DsRajib3NdRbRsaivIuIvQ1h/+w03cv4hrWvN7EORsye2afjx
         q14YkK5g3xSAXfgNLc2B6/+SUS3q8FYhyTkXG5TWyQVOu7+beSZ3pn3eevgz/wZyVoHv
         L65nB91crIQEw9Ia79O+5aPA/lSVhC4ZP6yf0LF9+7kGyo4PtLp9KfcZFSXmX7PzJo2J
         It9g==
X-Gm-Message-State: AOJu0YyBzx8wgy5JCy8Dn7kKN4Wl5JCsAsVzRl4Yq+hkdmISi91VkL0J
        lXj3V8LIb3cAxTIYxt2u6Cg5/v6XVnzHefTm
X-Google-Smtp-Source: AGHT+IEMLGxUdI7nmLwK35IqB1GzY29XMQRfBCcHitD4wH+TBylVj6DM0Pemx8wKM1TNt9MEIEMKEg==
X-Received: by 2002:a05:6000:187:b0:319:6b8f:8473 with SMTP id p7-20020a056000018700b003196b8f8473mr2387868wrx.29.1692521695908;
        Sun, 20 Aug 2023 01:54:55 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:55 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 4/8] decorate: avoid some unnecessary color overhead
Date:   Sun, 20 Aug 2023 09:53:32 +0100
Message-ID: <20230820085336.8615-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
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

