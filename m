Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6458A1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbeIVD7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:59:15 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:52994 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391323AbeIVD7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:59:14 -0400
Received: by mail-ua1-f74.google.com with SMTP id w10-v6so3640742uam.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZO61LQ+pPoXoaechy8W4jWsmgGK3J5kKWb0lC36KvMk=;
        b=WealI/pnG5c8V0Ho2LwtKTz6m+vhKCFxo7IVsZpwK6REIoJg1G3BT8ZFQMJHKhT94P
         8Sy5Pd2HujWW03FH/PwvK1XZuX7GsdfhuC6PsGtJ82bPmwsDdnJDhtRSYGix/1Pr+spB
         PZkzBVUO6h/E7rlVVCWridKXOgfZPChhTgRIutfeAEwAJhbHg7NTFyR4pF4e0RjcMnQ8
         e7tKyc+kSBoD04h0FINWF8pM9r3m93cdIAibyYFvXx9pWoHRe7PP3QfEv93ZrIT7IKVI
         HhNqbLZLyNjOLeO40W0hhsrd2TC/zq7EZR/Qw9Amui1AB8PUfoA7/eYotHvmJlQBIOg3
         HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZO61LQ+pPoXoaechy8W4jWsmgGK3J5kKWb0lC36KvMk=;
        b=p2GSZWluD0b4vCFD5Iiu/8Qtq3Y2eOh1kqD3Ovbw4GG0fsVGpLroty90fkDiD+H2pa
         k9tuPg8bAxK+GrTiaWxmD2Rotd15ugE3cPHrtUR6qReEoGZD22DIet//247+74J90oPT
         RDq6uSw4gJlfcleXT9vVTT1MuCGD5ubqMqxfwJGPQFigcWb8NeV1cYfaURWi7hhStpsS
         7IMKiusROGJWv3uqKL1u8mHJR+AUlYzowBU7J+bij2f4PvH9sXX1m41qRlnVOgm4U/qN
         qFxdHDUEqBRPn4qZ5zOPZ72gApwZSlBY6pxJjcfcgx+nzCH3VXpKIG9190ylkxvqK1KO
         vegg==
X-Gm-Message-State: APzg51AV8I7cw/i0HeYsvNNwqus1ynVVT+cvemCgpnRhKQbqC7OF7jKT
        MEd3/ttVwn8OxrT9S/6D77Q4Wter3oDO
X-Google-Smtp-Source: ANB0VdYAs9s5Q9HJr4OHiLhmrE+ND94hgjU1y47o8uU5jtOxuMRfXP1yWc4kstnCcCk59Udv5O7RtVoUMvLE
X-Received: by 2002:a1f:2ecc:: with SMTP id u195-v6mr10093102vku.26.1537567704875;
 Fri, 21 Sep 2018 15:08:24 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:08:20 -0700
In-Reply-To: <20180917213559.126404-2-sbeller@google.com>
Message-Id: <20180921220820.49446-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180917213559.126404-2-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH] string-list: add string_list_{pop, last} functions
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

I will be resending this series shortly, but it will not contain this patch,
as I will have no need for these any longer.

For the record, this is the final state of this patch.
It may be useful on its own.

Thanks,
Stefan

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
2.19.0.444.g18242da7ef-goog

