Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB151F406
	for <e@80x24.org>; Wed, 16 May 2018 22:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeEPW6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:53 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:54985 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeEPW6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:48 -0400
Received: by mail-vk0-f73.google.com with SMTP id 196-v6so2135680vko.21
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SqCiHjSr4XT+UyPFb0m5EkQtRt31BSsELix58fzUwGU=;
        b=Zj4Z6mePMk0Jp2nU/UdIuIBhC4f75kNok2FlSOE6UFw8yhOAQOgTQp+H1XLN6SUUvJ
         MWno2dSXCpiYTdDru31erczUc9PSKWFlb2sFN4+PQ+BzvG5TjQ2+hkysxXcg1LweYYYx
         M+ujN3EAl4CkdUB9X5iptfcMno/jUWIvPx9O5rga8RBck357p7YX1xktcVhQY1J2vfT3
         4DiQU/69wuNFqE/XTpaDOg26NhKzWo9BSDywfacy4vgTGNLAX0zidXOApyNWX1nHTlgx
         cDlpEU5ySWwpiauJhTXDtIAfzVfZ/VTdVkCg5AhHGt/Gi0p+Rm4SHG1ZQbV1JvPRwF6J
         Q7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SqCiHjSr4XT+UyPFb0m5EkQtRt31BSsELix58fzUwGU=;
        b=uPgWQtoZfkICofQmR+kCc4+vpKKFjJTBvFUt2YZiSEeILFvJemkx7hpacsK4PdE0ae
         FQsX7ji/aXtFLFMCziWO+nMM+De7s/TK5J0OhOY5HVgWxGHt53SBuJwi9JyYtPlCG3NA
         uffWSYZOomaAWW4kecTP7iEUT8YTi4DlMCw+99VGsnkDq6ChQdz1R0lkEu6n57s5M6O3
         eIsd/MTBGvmQ7+3+XHJz3JzuNw/5OGTgZ0BLHjT7gqr+b/LQv9Q/i4FqLwHnkQI4Qp0E
         LKRgniJmZ6XvP+VAjNyYQZI75hrvvKPiOZ8z5UOvEsMrkwUOvuNLKwAIPGCytXXqMaLC
         VN9g==
X-Gm-Message-State: ALKqPwfT0COPWZjZ5sXKfOJNF+b57zIyVDoFqvQ0Vfw2jrjEiIeLj93p
        T8cE8ezKvkYpONIG5MwFivROwCkz646IJ628LODBvgBzpJP30obpUSpybF5GhcdyeXwEsgcHjyA
        1Id7+H/eqqOq67U8HADuncxpwJCa0e8WmwkoM4cfjdtIYgzrsdpgHCiY18A==
X-Google-Smtp-Source: AB8JxZrSlYizLBD5enQOTJUl4LKYql8rL2SikAmgB+jRIiDgSOlMozfXrmdvqU0KUuebAZaYdRXGPAGaq0g=
MIME-Version: 1.0
X-Received: by 2002:ab0:248a:: with SMTP id i10-v6mr2427486uan.108.1526511527639;
 Wed, 16 May 2018 15:58:47 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:51 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-5-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 04/36] refspec: introduce struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'struct refspec', an abstraction around a collection of
'struct refspec_item's much like how 'struct pathspec' holds a
collection of 'struct pathspec_item's.

A refspec struct also contains an array of the original refspec strings
which will be used to facilitate the migration to using this new
abstraction throughout the code base.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h | 25 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/refspec.c b/refspec.c
index 8bf4ebbd3..af9d0d4b3 100644
--- a/refspec.c
+++ b/refspec.c
@@ -178,3 +178,67 @@ void free_refspec(int nr_refspec, struct refspec_item *refspec)
 	}
 	free(refspec);
 }
+
+void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
+{
+	memset(item, 0, sizeof(*item));
+
+	if (!parse_refspec(item, refspec, fetch))
+		die("Invalid refspec '%s'", refspec);
+}
+
+void refspec_item_clear(struct refspec_item *item)
+{
+	FREE_AND_NULL(item->src);
+	FREE_AND_NULL(item->dst);
+	item->force = 0;
+	item->pattern = 0;
+	item->matching = 0;
+	item->exact_sha1 = 0;
+}
+
+void refspec_init(struct refspec *rs, int fetch)
+{
+	memset(rs, 0, sizeof(*rs));
+	rs->fetch = fetch;
+}
+
+void refspec_append(struct refspec *rs, const char *refspec)
+{
+	struct refspec_item item;
+
+	refspec_item_init(&item, refspec, rs->fetch);
+
+	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
+	rs->items[rs->nr++] = item;
+
+	ALLOC_GROW(rs->raw, rs->raw_nr + 1, rs->raw_alloc);
+	rs->raw[rs->raw_nr++] = xstrdup(refspec);
+}
+
+void refspec_appendn(struct refspec *rs, const char **refspecs, int nr)
+{
+	int i;
+	for (i = 0; i < nr; i++)
+		refspec_append(rs, refspecs[i]);
+}
+
+void refspec_clear(struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++)
+		refspec_item_clear(&rs->items[i]);
+
+	FREE_AND_NULL(rs->items);
+	rs->alloc = 0;
+	rs->nr = 0;
+
+	for (i = 0; i < rs->raw_nr; i++)
+		free((char *)rs->raw[i]);
+	FREE_AND_NULL(rs->raw);
+	rs->raw_alloc = 0;
+	rs->raw_nr = 0;
+
+	rs->fetch = 0;
+}
diff --git a/refspec.h b/refspec.h
index fc9c1af77..da3135825 100644
--- a/refspec.h
+++ b/refspec.h
@@ -20,4 +20,29 @@ struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec_item *refspec);
 
+#define REFSPEC_FETCH 1
+#define REFSPEC_PUSH 0
+
+#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
+#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
+
+struct refspec {
+	struct refspec_item *items;
+	int alloc;
+	int nr;
+
+	const char **raw;
+	int raw_alloc;
+	int raw_nr;
+
+	int fetch;
+};
+
+void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
+void refspec_item_clear(struct refspec_item *item);
+void refspec_init(struct refspec *rs, int fetch);
+void refspec_append(struct refspec *rs, const char *refspec);
+void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
+void refspec_clear(struct refspec *rs);
+
 #endif /* REFSPEC_H */
-- 
2.17.0.441.gb46fe60e1d-goog

