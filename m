Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7A9C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjEIRyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjEIRyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDD468F
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso62365165e9.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654857; x=1686246857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqtPWiwMcFwMlIQFYDnQPI6lnrP7JmKACowytD5g5h0=;
        b=NhKcyYOMAWDVAUIhI1VQUJ6RHM20FjbfHzvbQ1ElxlMiNpAe7P7amSeLny+B1cbrCT
         U8ZXxQaMJq8ffsztDst4mnMzIXjOE1un6SUepiZoLl8pdsEZ4n7pmfKKDg2oJiTBbSd/
         h5YApX6piUr8hrc+M8CEcsvnjeGnxXuQLEuMFdc0TGbA+KgyMBbJ7aW9krcNr2V7Ht3w
         AnOKRFRVKPLR7lEt5gmArWCZvOqbeCe8rEhEO+YJ3S79jG15ADgOYJrqMF5LyIm+o3tZ
         FCqVNKINFqXuMG69MF+DNuBlLY+ET6+rj2AWqYsB5SI95o0DWFc4imvjTHvWiDG38MY0
         p2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654857; x=1686246857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqtPWiwMcFwMlIQFYDnQPI6lnrP7JmKACowytD5g5h0=;
        b=AAmBJm9pZ3pV3LTiR/3xcMf7e8e/1E2VYZwkpZfrAGTjNdoV/SFP1czv9T81qEOZXq
         3ZaM3yaPdU3JW21BzUmpC4OYcmu+OBs5aDLfCa8IzlTxUxj2dAbTNROqwD6jlTNbC7pO
         WDTiEioXKPcKzzSQMi4WZhLjNCtW3qRT7r0o/OwiYVfWLzXNTm5mI8B7utXSjJO/3AV1
         bgYMjrTJouxiUQDStpq6mozv4DjP9iVEkmgbql7wKPNAOP0d0gLNM6eZV+jQGSS8gxjA
         z/XDjVIOZfpr6pKBW6aRB6SrB38pNoGMP2hXNT2QCNww9S8JWqTEN7wU+vNLGogM/qzu
         pjqg==
X-Gm-Message-State: AC+VfDy1Wl4iHQgf+Lz9ASXqcSERBbtoe8IHc9HCzAsIdpjCaZDDHSG0
        qrB1hxYkR8eShmOXYJ0/CM4ZeHd3RRE=
X-Google-Smtp-Source: ACHHUZ5zxnYOvWj6wwia5hN5QMRsw0ajhsqUMTTzoweWujbx4ZNgFPSsIpfUpxMXjDL79vApO9sC2w==
X-Received: by 2002:a05:600c:364b:b0:3f1:8af9:55ae with SMTP id y11-20020a05600c364b00b003f18af955aemr10785125wmq.18.1683654857369;
        Tue, 09 May 2023 10:54:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/15] replay: don't simplify history
Date:   Tue,  9 May 2023 19:53:38 +0200
Message-ID: <20230509175347.1714141-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let's set the rev walking options we need after calling
setup_revisions() instead of before. This makes it clearer which options
we need.

Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index f087d97353..9f6cca2972 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -171,15 +171,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
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
@@ -187,6 +178,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/* requirements/overrides for revs */
+	revs.reverse = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	revs.simplify_history = 0;
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.40.1.491.gdff9a222ea

