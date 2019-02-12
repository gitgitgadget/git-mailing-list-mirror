Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1341B1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfBLW1K (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36499 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfBLW1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id o59so268601edb.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+8rZxNPvstgKoHkzsXlQba4uwrXMEW7QZ/8bE1dygQ=;
        b=XZ6+TwFmWmVCFAnkQt/FFso3B2OnZmdhVcYCfhSd8+s03oYzW5fQDbLlSz5MljcII9
         rhXPNTy9OFwZzAIvuEIe4unQJN5trtlGW4HrvOX2qZr9reG1mdtkRk/lRaALsTdJrKyl
         D0GzLv9X25LGXZpXPyj+OV6yly8eR6tfqHGvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+8rZxNPvstgKoHkzsXlQba4uwrXMEW7QZ/8bE1dygQ=;
        b=JEAxAjdu/K4ffkVyevshy1zRKpqdffrbZml8UspKrhza5bQF6RSuxr4M3VWU/6RZik
         BHORv6u9lLngIBCAP+eR0JRzC2JFUgcs2RWoTMd8T/IiaoimDlHjtqhUMxMDr4Wtgz8P
         xq9WV1j5KW3fOpcr+6D6pk5OASg6ArpXRTDF3fsV5EDY8aU4yGuX55L1yVti0Gl0ZK7P
         78NI7JddeFNGeZoQ5IDpf/vkE85X9I5KUNYlt8MMm4DVEg6ezvcn195HxEs/fy/IKM5T
         CSgSUOKVYG5G9TNhrWdARtCYtbgm6jJ6mmtuvFcgfbG8IZIoi2uKe6Y+BCHPAwfidvOb
         2thg==
X-Gm-Message-State: AHQUAubxDjlDcpw14Sy+3Jd/YHQrNTAY1uwIpcP/hjv+YgwtoYT28BXt
        Glz6JWR6UCUEHIOqZBg63n3tGUpJFKIWC2Ip
X-Google-Smtp-Source: AHgI3IZH+0fv0lSlQVOj06SOZyv4+I5iOZlGL07a/+ZLFZYgFE6nPTZVCHmH3zLXwsjYYxVdrphiFw==
X-Received: by 2002:a17:906:1343:: with SMTP id x3mr4145021ejb.76.1550010424303;
        Tue, 12 Feb 2019 14:27:04 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:27:03 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] builtin/grep.c: add todo_item helper
Date:   Tue, 12 Feb 2019 23:26:53 +0100
Message-Id: <20190212222654.7432-5-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
References: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a helper for indexing into the todo array with any of the todo_*
variables, in preparation for not keeping those reduced mod TODO_SIZE.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 92b9e6198d..35ed79b0dd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -62,6 +62,11 @@ static unsigned int todo_start;
 static unsigned int todo_end;
 static unsigned int todo_done;
 
+static inline struct work_item *todo_item(unsigned int idx)
+{
+	return &todo[idx % ARRAY_SIZE(todo)];
+}
+
 /* Has all work items been added? */
 static int all_work_added;
 
@@ -101,7 +106,7 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	w = &todo[todo_end];
+	w = todo_item(todo_end);
 	w->source = *gs;
 	if (opt->binary != GREP_BINARY_TEXT)
 		grep_source_load_driver(&w->source, opt->repo->index);
@@ -125,7 +130,7 @@ static struct work_item *get_work(void)
 	if (todo_start == todo_end && all_work_added) {
 		ret = NULL;
 	} else {
-		ret = &todo[todo_start];
+		ret = todo_item(todo_start);
 		todo_start = (todo_start + 1) % ARRAY_SIZE(todo);
 	}
 	grep_unlock();
@@ -141,7 +146,7 @@ static void work_done(struct work_item *w)
 	old_done = todo_done;
 	for(; todo_done != todo_start;
 	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
-		w = &todo[todo_done];
+		w = todo_item(todo_done);
 		if (!w->done)
 			break;
 		if (w->out.len) {
-- 
2.20.1

