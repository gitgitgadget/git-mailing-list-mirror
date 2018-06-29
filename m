Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEEE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030455AbeF2BX6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:58 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:56196 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936436AbeF2BXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:23 -0400
Received: by mail-it0-f74.google.com with SMTP id 7-v6so463817itv.5
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=EcBdQtdsvvBABQ0DYy8QieZifjmQUYQw3OcqUgsLm7Q=;
        b=GQVqMT24wj3HPsRF5PZhsI/JKNvdQiIsSZ6Q8piULJ9Qvwml+1z0afw1eUHkkV/idd
         Hyizd/yEDRzKjBmU8ERj8HCCdzBaxdHx/wGFaX5rwS4T5+U/HlyGKBmdKGkUWWMaSzd9
         zeUjTXlFlpUF/blZ8D0V2CEUpUEb3Nkl3nJEefoq9mJNqgEUKXHwVEV+73ZgE5yoIN32
         t5YG3NJU8ZVQHeaFls9BXmjW5tfPsWAwb66t/wxY9rXuWpNIIc1ISc+oViFUoppnTM1Y
         PcnEYEHKvc9tbBlHMbLsm4JJ32sEA67ILEU8RjUweSZUY+ET5VobCV1+iX2i8QjoEAUT
         nhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=EcBdQtdsvvBABQ0DYy8QieZifjmQUYQw3OcqUgsLm7Q=;
        b=IopaWpc9/neSa+/EYRWl+WaFnbPntYDXFHsIJhsjueIHdUctsbmtrTX2jo00JcD9c2
         NwAH2jV4KQaqargaLXNOGYoe+xfK5wwl/qVfV1+AJogqeebbwN8MJLSQznT0uj3gN9nw
         Cb88ilKxMs2YmLP7yKQxMlzrA7Fbi8Kx4lHAEnLiDgI7TkVDiz8BiBzjHMwPcp/p1vnn
         lmG1L5Qg1qbMCnDdvFwJ78/Iz2FV/Kwny1ROJtOaxyjDfKpe+VxHCSUNo9Gfpz0ugHjD
         gt6wp/JJdb8rHx1KvhR6yfljPn+EwucuOnO/t5mrmua9ImKUkOJpaf5hxYrNYj5Dmkvq
         D1yA==
X-Gm-Message-State: APt69E1pQ/GLMmT4Tk7vRsoIORF7EgqthWx+sVWbzQXi9d0bAUNB5iww
        7mEztJWoXmTURzcJvQ9kyh0HpT6Ml+dhJewEd38Zd3Q7HAjoI3oo7eecjaLhqGGH0xw3a3OCFwL
        iJefzVFObfJyQYnfuZ+I06X2Fa1Yyq0d+qmQ0UM9OJTY/eUMWlm0xLlzDbn8x
X-Google-Smtp-Source: AAOMgpcSMbnEoF77SDtna7v0WetgEzx2kNp/knNIBeoOabX+qCMVCmi8++QqSoaTPpDFHklovNlF9/La2ZOf
MIME-Version: 1.0
X-Received: by 2002:a24:4e06:: with SMTP id r6-v6mr84454ita.9.1530235403293;
 Thu, 28 Jun 2018 18:23:23 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:12 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-23-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 22/32] tag: allow parse_tag_buffer to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index 46b5882ee12..682e7793059 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -154,13 +154,13 @@ int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
+		item->tagged = (struct object *)lookup_blob(r, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tree(r, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
+		item->tagged = (struct object *)lookup_commit(r, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index 6a160c91875..efd4c7da67c 100644
--- a/tag.h
+++ b/tag.h
@@ -12,8 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
-extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 #define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-- 
2.18.0.399.gad0ab374a1-goog

