From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/15] string_list: add string_list_duplicate
Date: Tue, 26 Apr 2016 13:50:19 -0700
Message-ID: <1461703833-10350-2-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wi-0006WI-8a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbcDZUuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33855 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcDZUup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id r5so11011506pag.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Xt7GvOmPQWUEOrVY8MV7GM5g+NNNmG0NSeeAEnw8cw=;
        b=lbnBdzjJHSGFdm/ekD8KT60KQCxTtVq55fbrgBFdm6gSS8L9VC5gJkVj6tjuvIMbU5
         Fm+gmcBl2tpjPMcVs48TBs5aDmjhTbzuzIVkY3WC8mZwWRYwoPLRENxIDC201m1z62Uy
         jvV/7ypuAhJxfy4m5PQMfBK7HgberFffBw7s1sHOPM7n25IPItD6bTHMTQGoDezHz8Ae
         O8zR1OrxPJKugmjXs7YGOqlniy3UQ6xMVA+UMNiegUgqaktnnm1mKzN/YJmyXgAT3J0m
         vl/L0qrslrMaR5cHoBAx5gIRU4Nh70YoRUgE9HteDkxcO7BnXHzpxB1FwzhNCWoCaUH/
         cgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Xt7GvOmPQWUEOrVY8MV7GM5g+NNNmG0NSeeAEnw8cw=;
        b=IfmtdB+dcaTZ5B2oLc63W4xxqaJcJy6Ntqe3fGdTUrdfQXY+ye75wFSmvnll1Xexeh
         3bTa/RXvOQiDKgPUY0owrMVjtudszqqYli0p642qy9SaSZw18sriuj9FAXEy5s1mgmnS
         dNyH4Uhz3rxIr8Ac5j+lAslInXVVK9YGfrHk2/iky/vlyBZAzvz5TAedvUznm0CZ65IA
         FeqVm2FJvU2S3YQywO9WhLjZOtoT0CiLcqdDL9tBfxJOFvAx4Q7gDHrU6YFBO9GcnQeb
         VQ9yQbOM0AS9QFns4h+h5DJIm+5OIkG3ahcVbWHSsJwGSkiFD+Gq8TtWZKGd6t6DTNKi
         3G9A==
X-Gm-Message-State: AOPr4FWy7USD1jX8w7YOeR+qAuKYWOJjqWNfgC1UPzJPQ31mUu+nBDotUggUl7NWyhBkxmm6
X-Received: by 10.66.162.101 with SMTP id xz5mr6552668pab.157.1461703844701;
        Tue, 26 Apr 2016 13:50:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id b19sm481692pfj.41.2016.04.26.13.50.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292671>

The result of git_config_get_value_multi do not seem to be stable and
may get overwritten. Have an easy way to preserve the results of that
query.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 18 ++++++++++++++++++
 string-list.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/string-list.c b/string-list.c
index 2a32a3f..f981c8a 100644
--- a/string-list.c
+++ b/string-list.c
@@ -7,6 +7,24 @@ void string_list_init(struct string_list *list, int strdup_strings)
 	list->strdup_strings = strdup_strings;
 }
 
+struct string_list *string_list_duplicate(const struct string_list *src,
+					  int strdup_strings)
+{
+	struct string_list *list;
+	struct string_list_item *item;
+
+	if (!src)
+		return NULL;
+
+	list = xmalloc(sizeof(*list));
+	string_list_init(list, strdup_strings);
+	for_each_string_list_item(item, src)
+		string_list_append(list, item->string);
+
+	return list;
+}
+
+
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
diff --git a/string-list.h b/string-list.h
index d3809a1..1a5612f 100644
--- a/string-list.h
+++ b/string-list.h
@@ -19,6 +19,8 @@ struct string_list {
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
 void string_list_init(struct string_list *list, int strdup_strings);
+struct string_list *string_list_duplicate(const struct string_list *src,
+					  int strdup_strings);
 
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
-- 
2.8.0.41.g8d9aeb3
