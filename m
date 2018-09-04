Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26191F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeIED3R (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:17 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:53002 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:16 -0400
Received: by mail-yb1-f202.google.com with SMTP id w74-v6so1806492ybe.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uHxEQnJ5DMBFtzI3t1FRU0Dh6V3haKvfbO76y6nyUWg=;
        b=iqxz9643RUxmATqr/NtwvlGTN/y+3ZAldBT6ODT1Gt9q0lQnNm9btSyhpYtfxGBBb6
         C/Tn5jz/TsaMLbHreSi2YMmKf5IXccl1uZ8tAxxJstF+xZ+sb/IuWH8gFf0T82undy6R
         AvZ5M+0uOkGXwYl1lnafmaxOXPeOcnrYVVX0C0v9nuH1W7Gtg2c2tDR+RhLBTJD2UMrc
         d+8K0hSRB0RzZW4pi3A38QbgWurQqOVVCCkxMceGWfcRlkYn/NToq1UHJs4q83c2Gc9g
         F10vfH6rRLUWhVDEtoSeh1fGbyE+qq15vj8o2A8fq8eKLDT3FiByt5Hc6hG4lL0tlfDj
         97GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uHxEQnJ5DMBFtzI3t1FRU0Dh6V3haKvfbO76y6nyUWg=;
        b=IALU6QTvkvn+awRhLcpbS07WYp+mw7LA03FXUJvVPzVeGFT/YJGywmZoqhUQg0xGQQ
         bAagP0nO6qMlRZfgP9LlyG/ooho54/AFwltNVFs7H+93BqZcMFxWPaloHjqZSDTzz46d
         ctX4KnuxLTBxPiYNxmUNvgRUD9TES3sQBJ0Ad7mL/d7b/cZkGF0iQFQaq6YdomQjtWXN
         OuoemfqFMbzCe7FSL0agf5rZ9hhZf3RObwdfmhp4S/qIyzoDQj5P3q50a+biqcRhgrrR
         KwIgk491z8evgmeMZZ/srm3A3GwnzCocYwFSEiVPNFFxaZPAOwkeH/QQHLhVVzBBxp+P
         Z/IA==
X-Gm-Message-State: APzg51CVYoCITklyC9qHMiH2hXCIAhH12BtxmL7GJ96h9PsPEzGJrMWh
        lUvbVbz6b9tgGgMvmPV9MAz2+pwp705AsDRdo8GAHKcC8hgVA4Q8uGNZbscJRsOd5Dx0pZFucpd
        JoPKO9ars9TR5BVqVzJ+PuJZl3gWYDFXGvDge4IXv/ckek0U1sFKRGKTI/LDf
X-Google-Smtp-Source: ANB0VdYRM766bkifM2HDWjSYxbJ/g+4ziaB3kN8N/cx7oQ3ssFEFNaB46opCSX4RDMW071+Ft4e52EDbsUYz
X-Received: by 2002:a25:aace:: with SMTP id t72-v6mr7882941ybi.55.1536102119614;
 Tue, 04 Sep 2018 16:01:59 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:39 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 01/11] string_list: print_string_list to use trace_printf
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a debugging aid, so it should print to the debugging channel.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 6 +++---
 string-list.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/string-list.c b/string-list.c
index 771c4550980..1ebbe1f56ea 100644
--- a/string-list.c
+++ b/string-list.c
@@ -196,13 +196,13 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 }
 
 
-void print_string_list(const struct string_list *p, const char *text)
+void trace_print_string_list(const struct string_list *p, const char *text)
 {
 	int i;
 	if ( text )
-		printf("%s\n", text);
+		trace_printf("%s\n", text);
 	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
+		trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
 struct string_list_item *string_list_append_nodup(struct string_list *list,
diff --git a/string-list.h b/string-list.h
index ff8f6094a33..5b22560cf19 100644
--- a/string-list.h
+++ b/string-list.h
@@ -114,12 +114,12 @@ void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
 /**
- * Dump a string_list to stdout, useful mainly for debugging
+ * Dump a string_list using the trace_print, useful mainly for debugging
  * purposes. It can take an optional header argument and it writes out
  * the string-pointer pairs of the string_list, each one in its own
  * line.
  */
-void print_string_list(const struct string_list *p, const char *text);
+void trace_print_string_list(const struct string_list *p, const char *text);
 
 /**
  * Free a string_list. The `string` pointer of the items will be freed
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

