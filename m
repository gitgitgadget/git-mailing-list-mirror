Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2321F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeIRDFP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:15 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:57439 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:15 -0400
Received: by mail-it0-f73.google.com with SMTP id e6-v6so314531itc.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q/YHaaUEkXqeiP8cs5krMvpohGk9wgEzGvicQ92UvPE=;
        b=WLm9WTZpgIf1OQ/KvkFHnL4jCdZYelWfsiKkQ06zOv0RMRPg0Hk+04bB8r3S655KXi
         cizaFDj7bBBeyc7ZL94J+1cN1m3XHwOz2Rp6tUv4fsNUhDlEe+TN+bqdSjCEyPTftMVg
         qJ5ZRRHxQjNNR9rvzLRzH2wsSsOsMAabLwX6hS/g0NgCHX2NjgHXVxuCui3PN76+FFZz
         NN6jxDUdwE53aosrzUcjD/GAQNwOK2xOP7qDu2k7k3sZGcAP8QHxlSRpa7k03WE1KcPs
         SAhLUxWYFaBwq+dLvhdTDrto6wYXluR5TcVH0HR4Ma4+/6TUcRYHP0chZjJX6EjDz7Vr
         UBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q/YHaaUEkXqeiP8cs5krMvpohGk9wgEzGvicQ92UvPE=;
        b=OM4Zn3MhOfquMmZSV1VUCdXEDSSkadHeaqw0VqBF+IGGeDAXoOdTU6ckPkdAqY93Mk
         /cA0Bq0lXxtq6xUmbTLrl2WvuRpe+qusbteX4p+nHLMO7yHCj8AS/noPmW37bFlf6Mlq
         fb3PPKKLYIbniA2r3T9SXc9xhAn/196DuY4sCRvQvnQj5gMKrgWOGcmSTnCpXpIOkyqB
         cvpvKGp79a/Al75Q4og0lnSoxYelBsFXHuYkmyQcIRFMPuTRYBBiyyHyhA/LiUytdkqO
         Zw7166IqXaAcwWVnvqAYaUQsevFqM1u6kCvaAirUSp2A345dFyLxcqPzxMsrUbmze4qM
         8etw==
X-Gm-Message-State: APzg51A7wa9UNZ38WrqyUXOyk5PmN5pSAC4Bn+lOiNPlwcR0Rkxj7fZw
        hyASTBQd7s9kqMN3xYQv9cp2bXBl5ZYE
X-Google-Smtp-Source: ANB0Vdb4rclKxFo+XayGfxOhG1jvk/kClFQ0MqkOX9aIGV4tDS/XbpGd/eNAbJPz7O0nDWZ8ePWn4oNaFfHP
X-Received: by 2002:a24:eec8:: with SMTP id b191-v6mr12167529iti.42.1537220165520;
 Mon, 17 Sep 2018 14:36:05 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:51 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 1/9] string-list: add string_list_{pop, last} functions
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a few functions to allow a string-list to be used as a stack:

 - string_list_last() lets a caller peek the string_list_item at the
   end of the string list.  The caller needs to be aware that it is
   borrowing a pointer, which can become invalid if/when the
   string_list is resized.

 - string_list_pop() removes the string_list_item at the end of
   the string list.

 - there is no string_list_push(); string_list_append() can be used
   in its place.

You can use them in this pattern:

    while (list.nr) {
        struct string_list_item *item = string_list_last(&list);

        work_on(item);
        string_list_pop(&list, free_util);
    }

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 14 ++++++++++++++
 string-list.h | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/string-list.c b/string-list.c
index 771c4550980..04db2b537c0 100644
--- a/string-list.c
+++ b/string-list.c
@@ -80,6 +80,20 @@ void string_list_remove(struct string_list *list, const char *string,
 	}
 }
 
+void string_list_pop(struct string_list *list, int free_util)
+{
+	if (list->nr == 0)
+		BUG("tried to remove an item from empty string list");
+
+	if (list->strdup_strings)
+		free(list->items[list->nr - 1].string);
+
+	if (free_util)
+		free(list->items[list->nr - 1].util);
+
+	list->nr--;
+}
+
 int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
diff --git a/string-list.h b/string-list.h
index ff8f6094a33..15f2936e337 100644
--- a/string-list.h
+++ b/string-list.h
@@ -191,6 +191,21 @@ extern void string_list_remove(struct string_list *list, const char *string,
  */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+/**
+ * Removes the last item from the list.
+ * The caller must ensure that the list is not empty.
+ */
+void string_list_pop(struct string_list *list, int free_util);
+
+/*
+ * Returns the last item of the list. As it returns the raw access, do not
+ * modify the list while holding onto the returned pointer.
+ */
+static inline struct string_list_item *string_list_last(struct string_list *list)
+{
+	return &list->items[list->nr - 1];
+}
+
 /*
  * Remove all but the first of consecutive entries with the same
  * string value.  If free_util is true, call free() on the util
-- 
2.19.0.397.gdd90340f6a-goog

