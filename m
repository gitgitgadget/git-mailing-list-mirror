Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CD620A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdITTsX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:48:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdITTsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:48:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id m127so3356521wmm.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vxXBHB0H5suMGPrtT33J1BGyFQ8v4DJTSXdUe/Gd7M=;
        b=Z+Fads7iRJsqRwWwTiOvRzTfLcwQyiui+ejoWXjK8HoInLSUjqpxAq1eK8wD5QbCDi
         YkwnOuTX91jjWCk3XZ3C1qKhgIEAfFaUtTELUGXgDLCxnO7Sge4gykyqIhh+J1j2NJQg
         Q3Tf0pZfVP1EbPst+KnTFucdocqCBCNjJdm3685EPe8WdVFrUsn1xKcM/JSjUrJ2KgBH
         TYkZ9HdukwPSEnDj4hDB3RtW6xzb6pc+ki4rCnbzRF7t1KCrWBBcSW9DX4EiZQUlLzRC
         ZRxjkJEKxBLXL0rNaHtwUXJPecec2jMYeg9sI3IO+0cC2mZ8RWJEA0WWBm50iKFlk9fP
         KpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vxXBHB0H5suMGPrtT33J1BGyFQ8v4DJTSXdUe/Gd7M=;
        b=myh1hfPNpGT35/47XXVQUKzQi3fiAe41rZUHB1auuMVcz90hJgG7XC8FKwechGWDQO
         ZLP8+9QQdQfOzUlDa5CCwP5pI/j8M74lhzLeJbVZK+Hy7HxU7xcPsOVq5jMFBvV3RsY6
         9JUoknkLm2I5nGDEszEatD82AP4RK0qoR2VEH+PIRQ8NKDM6nA+ecGGSWcd6hqoIbr1T
         6n0hKd3kHm7SWYEiUw581gf9bxO13wTREo0QjEIo70k4ZaD0GkGTho4Cw9q36OC1gfLa
         gl7BwvgxgFBDAaZM8KXPsrWqIFvGi95bZHwQNFOyqASK8U4Gju3IVumGypygP6c0s8Op
         4msg==
X-Gm-Message-State: AHPjjUgi82qz4KtRazZAbrBwdLmcnL3h3yBp6I0gOkGvqS9cmieGB3Dx
        a37AW3QGVz6ZR2pMjjysMbXX/lDg
X-Google-Smtp-Source: AOwi7QBgWxGRlB8xtgtrpKJediHzyn9ZSDGBSPVPIojMLocWApFoKzxm3I5RXpbblvDDUEdmr0XQrQ==
X-Received: by 10.28.217.134 with SMTP id q128mr5254124wmg.116.1505936901661;
        Wed, 20 Sep 2017 12:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t141sm2419652wme.33.2017.09.20.12.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 12:48:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision: fix memory leaks with `struct cmdline_pathspec`
Date:   Wed, 20 Sep 2017 21:47:26 +0200
Message-Id: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't free the array `prune_data.path` or the individual strings it
points to. Do so by introducing and using `free_cmdline_pathspec()`. To
be able to safely free the strings, always use `xstrdup()` when
assigning them. That does mean we allocate more memory than we used to,
but it also means it is clear who owns the strings and that we can stop
leaking those that we do allocate.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 revision.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index f9a90d7..dfb6a6c 100644
--- a/revision.c
+++ b/revision.c
@@ -1682,7 +1682,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 {
 	while (*av) {
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
-		prune->path[prune->nr++] = *(av++);
+		prune->path[prune->nr++] = xstrdup(*(av++));
 	}
 }
 
@@ -1695,6 +1695,18 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 	}
 }
 
+static void free_cmdline_pathspec(struct cmdline_pathspec *prune)
+{
+	int i;
+
+	for (i = 0; i < prune->nr; i++)
+		free((void *)prune->path[i]);
+
+	FREE_AND_NULL(prune->path);
+	prune->nr = 0;
+	prune->alloc = 0;
+}
+
 static void read_revisions_from_stdin(struct rev_info *revs,
 				      struct cmdline_pathspec *prune)
 {
@@ -2392,6 +2404,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		prune_data.path[prune_data.nr++] = NULL;
 		parse_pathspec(&revs->prune_data, 0, 0,
 			       revs->prefix, prune_data.path);
+		free_cmdline_pathspec(&prune_data);
 	}
 
 	if (revs->def == NULL)
-- 
2.14.1

