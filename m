Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727901F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfI3Bvv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40717 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfI3Bvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so6410379qkb.7
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAHx6dNVHtQnsN4hlXQaghh9Z6aH9U6OUj77ClLhva4=;
        b=RuMovP3wwuaW7SkfmoEkw7ghHq+KrA79f5pcjHxvpm5QKQQ28mVC3g+C6nT/EBKM4l
         w6Vg1AEPd6DIKQKQzEjbFRPNpGsF08L3xzLT5uY9k+LCJ/763szAp54IqCAd3bPFiXSp
         /PD+vkUwjVm5t6feNUZQlSXa274tTX+dnd/tZfwrr55nPkuLNuJLbK5UaQ8peymKgKUa
         92EozDb2fSMUk0EdCHP7c5GWomu6Bd77IUeXad8c1f7P3lFB4DOsnM7rzADcd8ZT06Gx
         dURcNVIYmdj84dodf76kguo4ZrTJSLNz4mYeFx7sjqbatIgKL8nWT5uThFcG0UBzKQHU
         JtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAHx6dNVHtQnsN4hlXQaghh9Z6aH9U6OUj77ClLhva4=;
        b=Qyy8A+gNECwiq2yI7+6/mUD1CVPUiJJkUNyRhdwTMNo21T/u1WAoBIi3irlFvz/bRT
         9kxAFZ/hE9HuZsOFGWx0KQbejc2lP+XCrChC+w0RBDojCLf9eBGDq6CzFy3+5jrsugIr
         YjLSWy7PVw7I3FDgzbm/5VNNmF25EiN4hw9qINb4Vpf7R2cKEH/cb4c5xYE+V2IUTBhA
         VOYE/zps6L+62/YaxazzP8LjNO+GTgH//GTm8obR+WIn1dMMDTaI+6qb2cdFah7W9BKv
         b7kMs0Zz3T5h6aIw0LVbNGAVCAjq9M9duzk6HS6ZzmGR3FyxeZ+LP2kYub3bfyaTKGES
         R1Gw==
X-Gm-Message-State: APjAAAWgpdJbi4430LteMU4UfQElBK0pRY2Ox2Y2/oisLbD3yMSaLNcQ
        YQ7q+ajOdjqari9VShlo6e2dGzykxJg=
X-Google-Smtp-Source: APXvYqwD27toE/d/dwKGVw2u3+AtsEz3rjvH1SnvUcwOBWIWubXV83jBMtGDK/mdJLc0WzSr7Oycrg==
X-Received: by 2002:a37:bd45:: with SMTP id n66mr16206201qkf.272.1569808309907;
        Sun, 29 Sep 2019 18:51:49 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:49 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 11/11] grep: move driver pre-load out of critical section
Date:   Sun, 29 Sep 2019 22:50:57 -0300
Message-Id: <7b0358d1596e6673d12f9592cf05f5193247f3ec.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/grep.c:add_work() we pre-load the userdiff drivers before
adding the grep_source in the todo list. This operation is currently
being performed after acquiring the grep_mutex, but as it's already
thread-safe, we don't need to protect it here. So let's move it out of
the critical section which should avoid thread contention and improve
performance.

Running[1] `git grep --threads=8 abcd[02] HEAD` on chromium's
repository[2], I got the following mean times for 30 executions after 2
warmups:

        Original         |  6.2886s
-------------------------|-----------
 Out of critical section |  5.7852s

[1]: Tests performed on an i7-7700HQ with 16GB of RAM and SSD, running
     Manjaro Linux.
[2]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
         04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 163f14b60d..d275b76647 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -92,8 +92,11 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(struct grep_opt *opt, const struct grep_source *gs)
+static void add_work(struct grep_opt *opt, struct grep_source *gs)
 {
+	if (opt->binary != GREP_BINARY_TEXT)
+		grep_source_load_driver(gs, opt->repo->index);
+
 	grep_lock();
 
 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
@@ -101,9 +104,6 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 	}
 
 	todo[todo_end].source = *gs;
-	if (opt->binary != GREP_BINARY_TEXT)
-		grep_source_load_driver(&todo[todo_end].source,
-					opt->repo->index);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
-- 
2.23.0

