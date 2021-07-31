Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93670C4320A
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F78260E09
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhGaCmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGaCmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25144C0613D3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k7so11302963qki.11
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNYVQWMat+KPgO74MK+N8jTAoNvDTlqr2bfJREHgCvc=;
        b=dWsC+wbOIFkel43cxHknSy51a9OyzPfNXfGNE4PYXMZMcMwrz0lRd5tsW/SMcC4JZb
         g9pJWV8L5yflAbPPtXyYsxl1kTbTAb8zyNx9mjV+U2Q8tCODesZc2yeMxBgYryn37/Yv
         mZTT4aVJoTAnzaj9Y2ylXDKD9T2jeHzUiNmEEhYRs8eVdu0yxAuoYQFr0mAgxzayKJVY
         f+Jm7yNe08rxfPNgZ78gjRIwfO52yJ6Xu3zepZgYCacvRcik0w8i26ovHMLVsX8RXSlN
         Pq7QbgXe4rBxcGaB6B3LDOlI2PTVyCNH4QdvdJhffxd6KMjVSZzMYjJygpd5oyrOjmia
         YSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNYVQWMat+KPgO74MK+N8jTAoNvDTlqr2bfJREHgCvc=;
        b=mj9Gw060FeYe2LIScDQHw+GqrmBeV+xqQGXt6egf/vy6LcVG7PooU/2BXnMJXmfrL7
         Gw1seaGbAgjWJXe0sIW8otrO2g5xmPFEaryfbEbSw9PO/16uZTvug+wAjxXKwQzUKTCS
         urSUfoTFSJpYxClP0W4/4smZ6EV+Ww9xBMznSyVmuueP/IatRbJLSanouDgPofvQcGTa
         RrAhiw3zTYTTy2q3EUHqI7myXCy+X4qbL0KnlRn//NBJLvYAsgn2WhJcfGE1wQxEdYcA
         pY9hHRCgXHlLN0FzIHynyPG/Pft2ZWxYvU7fOgGNRj/C6dhp0g/vXubP949E51pI653f
         7MOA==
X-Gm-Message-State: AOAM530gvUR8VkrU1Z8TIywGrvixTrXndpKbvCnVzAl2LX69LqSsxfq2
        Yn/GmJR1v7NVKgjG8syHjGPfD97uGZFVJA==
X-Google-Smtp-Source: ABdhPJwGuI9Ko9RxZnSdtPSrwQJIg9Ug1iLw6XxbKUS3iBuEBFrdjEkjH9qH7OImLbE0i4uOVYFx6Q==
X-Received: by 2002:a37:9d41:: with SMTP id g62mr5399888qke.55.1627699352191;
        Fri, 30 Jul 2021 19:42:32 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o63sm1944318qkf.4.2021.07.30.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:31 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 3/6] apply: move `apply_default_*whitespace` to `apply.c`
Date:   Fri, 30 Jul 2021 22:42:18 -0400
Message-Id: <20210731024221.2113906-4-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These variables are only set and used in this file, so they can become
`static`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 apply.c       | 3 +++
 cache.h       | 2 --
 environment.c | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 44bc31d6eb..15dcd8b7d7 100644
--- a/apply.c
+++ b/apply.c
@@ -23,6 +23,9 @@
 #include "apply.h"
 #include "entry.h"
 
+static char *apply_default_whitespace;
+static char *apply_default_ignorewhitespace;
+
 struct gitdiff_data {
 	struct strbuf *root;
 	int linenr;
diff --git a/cache.h b/cache.h
index 551a6cb5cf..dc6c4172cb 100644
--- a/cache.h
+++ b/cache.h
@@ -944,8 +944,6 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
-extern char *apply_default_whitespace;
-extern char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
 extern const char *git_hooks_path;
 extern int zlib_compression_level;
diff --git a/environment.c b/environment.c
index 5d45152731..0cc086d847 100644
--- a/environment.c
+++ b/environment.c
@@ -36,8 +36,6 @@ int repository_format_precious_objects;
 int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
-char *apply_default_whitespace;
-char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
-- 
2.31.1

