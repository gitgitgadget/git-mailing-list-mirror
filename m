Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E031F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeC1R4b (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36900 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbeC1R43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id m16-v6so4738422lfc.4
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhJQiRTRtZmGXei1L1UJiC9NDJUZNw6bhXO08QAO9Xs=;
        b=CjuxaBkk6EQDrmCbwIFW6yVsldHOz7cafm/mcrJrRn/giJGDLLMx2PWG4ysR6z1faI
         g0wKAx8la7/bx2jJrqL63qQ56F0rVsd1tPyfhElXOrbmGVeHy8n5nFsDToCXCs3VwOZi
         E8J9Ww1DY4uPJ4lnAg3eTDCHmQvxrhprOOS4pNLuj3pgwq7RWJ5M5yUc1tR6Y3IWbyn7
         QmHhVvfIrsMhG7W89IX+ko2JNeOQQm0/O5abWKBf8c6VkCHxPaL8xxxrDxPaJlS4nbpH
         5hiTJpsup91R836VMSjhUCkIOXetsKCx97oygvHb4hd3F7nt2AJFBs0GiknCOqdZmoky
         kcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhJQiRTRtZmGXei1L1UJiC9NDJUZNw6bhXO08QAO9Xs=;
        b=Wy2POQZbliv3v0snSTCQkldgOhbF2or5K8lfN75uCJvPeA+CqIzi2VOj7r27Qhv+Lr
         M7AtTCZFQ6KVbeD4/C6w6q73dTAt9vIDyNlD0Wm7Slh8XFjVqgLyd/rvnXyfDFnmYTUL
         72f5lMQs2/athTwWVcgbeYtaSRq/ytY5UNILOj4FPgnOWyOxkxYThQkpflL0Wm6rUtO0
         3GxSJlwKsRnUVM5FR+BDuRMFRbGaNQcPH+ukWZ3X5lq+MChBTX/0Y+b2DHALXvy5aAVG
         0LTMvvjAM6yNp6NbF/pCZON2tfWRMa7LwJlyNcYPGMu+riS7QLWNrkUF0LJBKUvl7HEq
         76/g==
X-Gm-Message-State: AElRT7GNd+0TgOc/45DtL8LfVUIIQHIPALlEYN0aqPinT6VkywnUhMjv
        KAe+U3jXmM7XgMiiHOzhSZ4QCg==
X-Google-Smtp-Source: AIpwx48k6AozSIJCWdNHS2q4DCeOmG8BHYYksWn3EeyJyzv+9NhBiUGaLpX6eS1NUq4dZz3CH/Ox2A==
X-Received: by 10.46.137.138 with SMTP id c10mr3263922lji.0.1522259787795;
        Wed, 28 Mar 2018 10:56:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 4/8] setup.c: introduce setup_adjust_path()
Date:   Wed, 28 Mar 2018 19:55:33 +0200
Message-Id: <20180328175537.17450-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

When $CWD is moved, relative path must be updated to be relative to
the new $CWD. This function helps do that. The _in_place version is
just for convenient (and we will use it quite often in subsequent
patches).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h |  3 +++
 setup.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/cache.h b/cache.h
index bbaf5c349a..05f32c9659 100644
--- a/cache.h
+++ b/cache.h
@@ -522,6 +522,9 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern void setup_adjust_path(const char *name, char **path,
+			      const char *old_cwd,
+			      const char *new_cwd);
 extern void setup_work_tree(void);
 /*
  * Find the commondir and gitdir of the repository that contains the current
diff --git a/setup.c b/setup.c
index 664453fcef..e26f44185e 100644
--- a/setup.c
+++ b/setup.c
@@ -376,6 +376,26 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }
 
+void setup_adjust_path(const char *name, char **path,
+		       const char *old_cwd,
+		       const char *new_cwd)
+{
+	char *old_path = *path;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!old_path || is_absolute_path(old_path))
+		return;
+
+	strbuf_addstr(&sb, old_cwd);
+	strbuf_ensure_trailing_dir_sep(&sb);
+	strbuf_addstr(&sb, old_path);
+	*path = xstrdup(remove_leading_path(sb.buf, new_cwd));
+	trace_printf_key(&trace_setup_key, "setup: adjust '%s' to %s",
+			 name, *path);
+	strbuf_release(&sb);
+	free(old_path);
+}
+
 void setup_work_tree(void)
 {
 	const char *work_tree, *git_dir;
-- 
2.17.0.rc1.439.gca064e2955

