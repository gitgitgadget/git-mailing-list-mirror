Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415D51FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940302AbdDSXNv (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:51 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35830 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940293AbdDSXNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:47 -0400
Received: by mail-io0-f171.google.com with SMTP id r16so41074568ioi.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBDHeXiPQs+2ANd5mCKX5FRvyv5YJwVCh9NlvARdMX0=;
        b=MRHqibYT7p3jTNo6y0F9Ssmo0nzztKSmfXaJScvFs/Ap4qzzZNauUsabOq6TtxLSw6
         eQEVitqzuAL28bu5fh71/x4Vt/wSPkycRSBkdlzyRGEMRy9CBw7f6vyJ0rfhZoRgDFrA
         L7Wyv0FDpSslauZ6ZEGXDlw2lB0Pqmhgcju5L76zDPN94AD2crJicvKfdMwJm3RkJMxL
         B6aflCyrOqZcH0rEoZ7EhR+OZ8ld0g9Df53x3CEeO169McL/i7/vkrDDxatA67BwpTi6
         xdfYiI3c15Pw+MvoETGr929EK8V/y3i747bN7kWAVHt1VNz7mJk+1YF93C4v+hOmVKOs
         BiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBDHeXiPQs+2ANd5mCKX5FRvyv5YJwVCh9NlvARdMX0=;
        b=BKhtxNLurTTH6pi5lfQT6X06Y551vJCGv3RDgc4fE00jf6MMN/DHlLwzkiQYO15Efg
         SBA40F62Das/Woq+CdmJIEm0EdJufCTBzhl174UwaiH7H6rIV18PgDr/r9klAaaojpKh
         xSZXLdwGOfLpH1yp+c7vpZkpkIh10TY1xl+r51869WBl3fauqiSaqd1kt6MDqZhal8qf
         xnmuzs4W/ybxaaXzg0bj/EJQUpw3uDhH/Tz4TP5VBWDiOnWYynXLKEcNdTAOkbTq2H/K
         fhPScmIxWqVAyQuuPDBJe6xFQL8NVlISVgoO79WUZa1+hQCDNHqVM8oJwcYvPSFwjFJU
         U9xg==
X-Gm-Message-State: AN3rC/6iTXtRzgHl0DJhvrYWNvy7urJGCKCIGqU+MCOHHAb5FQ5GD00h
        /jJxiTCLgyRNkLpR
X-Received: by 10.84.141.36 with SMTP id 33mr6703098plu.81.1492643622312;
        Wed, 19 Apr 2017 16:13:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 05/11] string-list: add string_list_remove function
Date:   Wed, 19 Apr 2017 16:13:21 -0700
Message-Id: <20170419231327.49895-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach string-list to be able to remove a string from a sorted
'struct string_list'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 string-list.c | 18 ++++++++++++++++++
 string-list.h |  7 +++++++
 2 files changed, 25 insertions(+)

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
index d3809a141..29bfb7ae4 100644
--- a/string-list.h
+++ b/string-list.h
@@ -63,6 +63,13 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 
 /*
+ * Removes the given string from the sorted list.
+ * If the string doesn't exist, the list is not altered.
+ */
+extern void string_list_remove(struct string_list *list, const char *string,
+			       int free_util);
+
+/*
  * Checks if the given string is part of a sorted list. If it is part of the list,
  * return the coresponding string_list_item, NULL otherwise.
  */
-- 
2.12.2.816.g2cccc81164-goog

