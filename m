Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157BC1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGQOmJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56199 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOmI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so22425573wmj.5
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfshZRPLJED8TsMTWY3ns+QjCQKe0FXzyXfPXOtu4c0=;
        b=iah95mnMR8S8pkbIMgFl5zLuhBD+szz7riSiqdCnRc+XCoxgLlDazjYW8Cpvkxb5y2
         MXnjbxm25P46RDOcUV3/jqxyua9r/XBe5y72NdXot0cLIh4UktLrcljFl5gZZzSt3wua
         J5kUg5T9xtF/goDiyeA8P3ygTJzLZ8Mhn/i7IzW2LnVG7BW2RbQszY1mOxvEvqZ65T6m
         mpPW044NG0uQqSeWyTidwKOk55wdnSiKa40xnIZTZwEYyT/B4Gdrp5U9EWfCzAgux3ZK
         CL+/sYYeDNWf0Bc3AVLhPt6PJRwovImS/8ibDG73dD2fRUL82ovupw/qYOhKHfPYrNgb
         b/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfshZRPLJED8TsMTWY3ns+QjCQKe0FXzyXfPXOtu4c0=;
        b=N1j3IwXp21D8PF6gJiJQ+CvzAHhzz5KLJyMVAvIaFVX9zmlR5k0pcUgTSlldnI83FJ
         yoW9aGiNJA0akv8Alb/k16z/IvOQ5PGrBXb7ozrYYgIx+6W/QS7FNij8r12/uE/uy4jV
         a7VPxr4C6sUaz+CeHpyQAX/nOFCQ3YOGjRNcR5Mu6Dq2HtQ/XFG3tfXH4KHzSEJ14JRo
         f8qdGZAoA3gQrljut80n/0MyBHD31Oeqj5e9uWTCwWWOJCEhbyew26gKZLbmEdmb1a1Y
         55uJojOS6CCeHMRSTLycOa+14FwuqTgp4mpztE9Ya6dok129PW9HgKN1LVWrFEgHTdQV
         Afww==
X-Gm-Message-State: APjAAAVpl+MyHRVCHrukvFh7M1rnZWrT85HBIYQ8gh0cXrc+kHl1YBYn
        pKSBjQjw0UwUl8oBt5ioSlp5hlDW
X-Google-Smtp-Source: APXvYqxsKfDPGRytBZrmN2zWgOZFGvda/llZ8gp4ayOT5d/oj954uyn/yeZDXeGqq/kzORY7fuRw4A==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr37272427wmu.137.1563374525802;
        Wed, 17 Jul 2019 07:42:05 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:42:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 8/9] rebase-interactive: warn if commit is dropped with --edit-todo
Date:   Wed, 17 Jul 2019 16:39:17 +0200
Message-Id: <20190717143918.7406-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the ability for --edit-todo to check if commits were dropped
by the user using todo_list_check_against_backup().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index c7dea85553..c346d4ced4 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -95,6 +95,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 {
 	const char *todo_file = rebase_path_todo();
 	unsigned initial = shortrevisions && shortonto;
+	int res = 0;
 
 	/* If the user is editing the todo list, we first try to parse
 	 * it.  If there is an error, we do not return, because the user
@@ -119,10 +120,13 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 
 	/* For the initial edit, the todo list gets parsed in
 	 * complete_action(). */
-	if (!initial)
-		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
+	if (!initial) {
+		res = todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
+		if (!res)
+			res = todo_list_check_against_backup(r, new_todo);
+	}
 
-	return 0;
+	return res;
 }
 
 define_commit_slab(commit_seen, unsigned char);
-- 
2.22.0

