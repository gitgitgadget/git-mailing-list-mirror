Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162051F463
	for <e@80x24.org>; Wed, 25 Sep 2019 21:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfIYVhZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 17:37:25 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45467 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfIYVhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 17:37:24 -0400
Received: by mail-qt1-f202.google.com with SMTP id r15so315683qtn.12
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B7AQBr1vfKDxnIzxM1urLpxXVogAbeDx/Cw8jSEQJ1g=;
        b=b7QKdOd6VlM9OxiC+UTYdAn0VSr1xof61uScQDuvmQZzhpBnx4SoliOiMAdxVx0LLH
         ibtvN3s0fKQ02NsIEAnHX6nt5rc98hEE2AcL9r8cwg2tm/EXp8yUXlhp0tyv7D0eE48y
         sEnykScxqQzB7qigTO2NewDu+aS49GE5TE7TldaOyCFvuUd+vEJRlRlGV9lc+SYeZrUm
         JY12KeDVgb/HpdLaiIjGwGkfLD1hIAv0qXrL9oSOKtzZQaWF8rMq6bkMS7r8qDzKc2lb
         MgKV0vcoz9Lrgv4D4tOKMaV9jb8C4ixnq3SBfLcwrJg/4KBkXscLVKArrm3oWgHdvPHV
         3M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B7AQBr1vfKDxnIzxM1urLpxXVogAbeDx/Cw8jSEQJ1g=;
        b=ZdGYyZCd43pNlMfrHvY5GSbf5FjoDtGFArv80+2iFxZcyznfGUU826pgU5/jfB3BnW
         dtYSOs20RyMvxTXW+ezlbAj5SBgsMKHNEp6BSGs3TMHhLj0xrgDnJ5JYqhVdO38jO1pM
         L47/bGLvEdBXePuUixJf36eW3v1HzC16oZB6Ufuc0KDcgkmPJ4ZAFfJwU/nYG0OrFbbn
         UOrfw8zEnuFxuush2YwnFrULqhnhTKbBsACtHrkEmMD3n8F8Y5XlQYb31MshsF5pRIoi
         ftpvtZfKJ1GdDDaAA9EoifRWS6ZpTZ6ggqiVtX2FGF5cUKYOhVwOtzukNZ8YXxDRSCV1
         pnuQ==
X-Gm-Message-State: APjAAAVSLv2UDGVFT0XbknmT39utOrG9WTC7t2RRZvwOUqfQOkkcvyvb
        yhHJKBGzU8OM4JzdCzNccfwmiXAoTd2b2aj6tSt3MbkKPoa8yje9y66gfY24Mrhv1rLZdrk3tKv
        ZqmwsFTY5/qQaZQYzDBgCVKR2GjiWjb/PPdnpMXzS5CvywU6S11aRkPW52j9arPh1bPIDMEZaag
        ==
X-Google-Smtp-Source: APXvYqz7XZXlMYyos4KlFnz3xQ1l23HHLYYlAbcv3iLPdrvZjJ2guXKKi/L6EitpOij7iGC9eAKe0AITbqwA9CW0dTY=
X-Received: by 2002:ac8:16e2:: with SMTP id y31mr587067qtk.370.1569447443700;
 Wed, 25 Sep 2019 14:37:23 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:37:18 -0700
Message-Id: <20190925213718.231231-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH] promisor-remote: skip move_to_tail when n=1
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when promisor_remote_move_to_tail() is called for a
promisor_remote which is currently the *only* element in promisors, a
cycle is created in the promisors linked list. This cycle leads to a
double free later on in promisor_remote_clear(): promisors is set to
promisors->next (a no-op, as promisors->next == promisors); the previous
value of promisors is free()'d; then the new value of promisors (which
is equal to the previous value of promisors) is also free()'d. This
double-free error was unrecoverable for the user without removing the
filter or re-cloning the repo and hoping to miss this edge case.

Now, when promisor_remote_move_to_tail() would be a no-op, just do a
no-op. In cases of promisor_remote_move_to_tail() where n>1, it works
correctly.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
This change showed up for us in a user bugreport; I'm actually fairly
unfamiliar with the codebase here but given the drastic nature of the
failure, I wanted to get a fix up quickly. I'm still working on how to
reproduce this exact case in the test suite (and actually would
appreciate any pointers). Specifically, it looks like we only really
break if we have a single promisor_remote in the linked list, call
move_to_tail() on it at least once, and then call clear() on it without
adding another promisor_remote first.

 promisor-remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9bc296cdde..dccd697c2d 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -89,6 +89,9 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 static void promisor_remote_move_to_tail(struct promisor_remote *r,
 					 struct promisor_remote *previous)
 {
+	if (promisors == r && promisors->next == NULL)
+		return;
+
 	if (previous)
 		previous->next = r->next;
 	else
-- 
2.23.0.351.gc4317032e6-goog

