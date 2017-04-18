Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9362C207BC
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757858AbdDRXSY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:24 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34650 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757500AbdDRXST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:19 -0400
Received: by mail-pg0-f46.google.com with SMTP id s64so3363965pgb.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHo/BgB5NF0QGfR/MBJu1xJh0oZSNsOKmNnuLdm3c90=;
        b=JnN9AibdyCAUibnTi/ErAVCBcYNWLnzYHZ4l9/f1mXqesebjdPY5DsFLLQUz+aWlTE
         A1ALAqqAJUjiZAQAuYZ5DCAD0vE6ncgNFQy1TwOuofz5KPsS8CxviC+aiDjnj8kdVJ+g
         14EJKW8Lqx6Tsg+nD1NNA1COJzAK3aiHFUx2cGdP+0uL8Jvee3VAbxNfkJucexM7Itvp
         pcCtQ2Lc8k1koMhhSY2BUKzfSt9qB1M53KImCUtjvlxfoNt7cDjq6m1z8hCWFl+GSlH7
         bAuhvw1YnggvNc4VTpcngczFUa1r0KEM9HWAHK66gniQ9sHAHM100NqikhL4yIsqoTSg
         wFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gHo/BgB5NF0QGfR/MBJu1xJh0oZSNsOKmNnuLdm3c90=;
        b=S4pMjPipv46YmR3tHbNJOwiLo+UmXGF1SkGoTv1SgByjOG/kqsCFOPxyO8Xs2Z3Mvx
         0b5aIAxa647x9A7cCGyiOoNdtlOweJmUkzLGmT3+/LJueWXeYlnpeEqlvdPjov3NdEoH
         NR24TiTjin4z1EWf3Cc8WJsV3dBQYMlRgr5vInvnBNSkxzurcxI7TgoTbJU8Qu7IcDVI
         CTt6s4O385pTy7dFFipUXfaPrQDrVcaq/pZHoSnVAJUqRMtchlTLL47qej9usJ94D+JL
         Hw2VlpSGZureTsxc1G8UWaWk+0hFQNcqRvmALk/mPzJeKNS3Wtk/xBrhrmF7+LjkwVoL
         6d4A==
X-Gm-Message-State: AN3rC/57JFXT7nnbLxeOtf67aNgneXjEqSQwKDfYHeCtXyR+nwOtlzPm
        JwjAoCtFtEQBN5HQ
X-Received: by 10.98.26.70 with SMTP id a67mr20555231pfa.117.1492557498250;
        Tue, 18 Apr 2017 16:18:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 05/11] string-list: add string_list_remove function
Date:   Tue, 18 Apr 2017 16:17:59 -0700
Message-Id: <20170418231805.61835-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach string-list to be able to remove a string from a sorted
'struct string_list'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 string-list.c | 18 ++++++++++++++++++
 string-list.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/string-list.c b/string-list.c
index 45016ad86..8f7b69ada 100644
--- a/string-list.c
+++ b/string-list.c
@@ -67,6 +67,24 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 	return list->items + index;
 }
 
+void string_list_remove(struct string_list *list, const char *string,
+			int free_util)
+{
+	int exact_match;
+	int i = get_entry_index(list, string, &exact_match);
+
+	if (exact_match) {
+		if (list->strdup_strings)
+			free(list->items[i].string);
+		if (free_util)
+			free(list->items[i].util);
+
+		list->nr--;
+		memmove(list->items + i, list->items + i + 1,
+			(list->nr - i) * sizeof(struct string_list_item));
+	}
+}
+
 int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
diff --git a/string-list.h b/string-list.h
index d3809a141..18520dbc8 100644
--- a/string-list.h
+++ b/string-list.h
@@ -63,6 +63,11 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 
 /*
+ * Removes the given string from the sorted list.
+ */
+void string_list_remove(struct string_list *list, const char *string, int free_util);
+
+/*
  * Checks if the given string is part of a sorted list. If it is part of the list,
  * return the coresponding string_list_item, NULL otherwise.
  */
-- 
2.12.2.816.g2cccc81164-goog

