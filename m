Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D5CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJJMjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjJJMjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118E9D
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1020823466b.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941552; x=1697546352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WVQI9EjfG6xbmP0tPftS1CJm5uruGzTjG2k3MMcbxI=;
        b=j7lUWSJFamlU8G6MgOn7WJn5LBKJ886G47UFAHPQAwqod85FofjWfXaE4x4nT26hL+
         zxrNG9VIVn7Vm5S+OxL6vKxfwreEhJF+M5mq8e4IYjx+zP+/cLXOYSHVSvptBVEbs0sG
         aGQTCHrxYv3feOigA2KdiV4BVnnzHK5BUkXHusDukBVIvgMWTwdIUtbgz16DZGszLzPP
         DbRoKgo0C1hO7AAZGBC3/T0IUlp8EWd4lwsM3FBcEHEUiRbo5R8Eexu7iNGGFRDYw7OW
         UbTt/Kviv3UTHwNymO603TSAie6F+MsG+v9Jvz+vUTxxVl51ejUKcco8c3s5wBHYcbN6
         RVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941552; x=1697546352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WVQI9EjfG6xbmP0tPftS1CJm5uruGzTjG2k3MMcbxI=;
        b=RErrgPhMCSn2Uuxdpp96H1qRYCOhbM9pSINATXy3mGJawdwL8ijIGBwQ16pqMXYmCj
         VANgpOaRqUc2LPXPQ617kCO68oJPwCumXgaMj1MGXjzNIjA+bc/2OxMJAy74ntqWX6kQ
         9YVmwc4UBw1oCprhhtZO8PEXDQjTpTlz0TJtNvgvnTn6yhckFR2fb7e3qPkbQLjS8fcR
         wMgYs1o5t1aFag07U0Ych8oLctztj49N9u3WLGHJ+gFUeV6e/+LrGPbeTOhz+3n6kGJu
         ZwDYkIgBOWq3Y7XwwIb6CGG8dZ9KjAp0VBk08maJP6UG/57g27pkWmxA8ODl6NiUY7Un
         Dayg==
X-Gm-Message-State: AOJu0YxDtZF26HBYfistzsR9eNgk9PnYBlGvKsQrD5W+4mcDKD0Uyqz4
        kNxrOHN9vviajpIy4yoe2AhHf/VMx4OXzA==
X-Google-Smtp-Source: AGHT+IFi/WpMjCqncUPx5zHY5cr+4btOZozjJrNHYItgNne9J9QhAJ0zylP1YWHDihEttSkDclPGJg==
X-Received: by 2002:a17:906:10b:b0:9a9:eef6:434a with SMTP id 11-20020a170906010b00b009a9eef6434amr16733046eje.36.1696941552118;
        Tue, 10 Oct 2023 05:39:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 06/14] replay: change rev walking options
Date:   Tue, 10 Oct 2023 14:38:39 +0200
Message-ID: <20231010123847.2777056-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let's set the rev walking options we need after calling
setup_revisions() instead of before. This enforces options we always
want.

We want the command to work from older commits to newer ones by default,
but we are Ok with letting users reverse that, using --reverse, if that's
what they really want.

Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index c66888679b..5bab89857f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -173,15 +173,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
-	revs.reverse = 1;
-	revs.right_only = 1;
-	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
-	revs.topo_order = 1;
-
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
@@ -189,6 +180,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/* requirements/overrides for revs */
+	revs.reverse = !revs.reverse;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	revs.simplify_history = 0;
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.42.0.339.g663cbc8ab1

