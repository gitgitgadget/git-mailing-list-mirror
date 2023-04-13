Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1202C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 23:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDMXbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMXbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 19:31:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538B3ABB
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h198so23710097ybg.12
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681428704; x=1684020704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76KQIvRDAoWE4iUGUMJRAu6V6XAytZiNEGCb/l7TpcU=;
        b=q/oryTdnJVMO4SxfQuUuIukvJowsix/vUeHGdwKVE7qgU5yqq/jMM8w+UHGnerNSD8
         vorLNS6rm6uJu6ouNtEsbf11Y4oiXyZXAREl4RE+RkzC0DuUIW3wgUgmG+Lrk1JcWZns
         Q80CY/Br0/COwyh3wgoF/3Twy/q+uuqi93HxMESlzHGKnbeMXF6e4Rx0g2/kBUFq5bA3
         8fNkn4nbSOIcxSTTxtFgXYkreLuzJgJKmYYUKHvR93RCSbd2yZKl1JxHQgJsBzI0rRcV
         +cLjKBaGfGgCjqjxfAoJG0NkPOyoVXl41sCiXoh7C2bwqbnsV2qP+qQQHb4maeonOjXL
         wgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681428704; x=1684020704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76KQIvRDAoWE4iUGUMJRAu6V6XAytZiNEGCb/l7TpcU=;
        b=AU+8h3XODMFIQonnwjsl61T/T8g+8L1jrHAlbZ5qmknguaiL/W0mFH0h8f4U/xZ2+T
         aHtLcrDJ8OacENzG/gkOU/MFjdSbcPA4z5gZhZF3z47QX/0irtGOfMeF2PhtP80ze5FH
         /k6GX5HlldDdqIwyOs0ykur2DHQEz6vBJTOzviN3hM6FAJfh92M0IXs/Oc9unggtmO3P
         gngTQG0m4J77bVQAryVkZvpNEZYCswZ1WeqgjELh3hQQvrG3pjid3UEyXioNa7w3Haou
         Urq0pRzDAsANqFvRVXwKh81B5nx+CaTUU+LdZumb+AnoX/XIEM7zxyrPhcCSk1dRNdYY
         65UQ==
X-Gm-Message-State: AAQBX9fpUhNDrA89JTRVU76By1KQlocq3bYHC2zJnR5pfw6ymipSLNhK
        KqlEQLy+4kliDjZtGA43m8kebwx2aM6LijQr0PoVkA==
X-Google-Smtp-Source: AKy350YG6hTBcbdtn9E2I6TgIjMxw4qTuE0zRaRYMH9Qw/Omee8+Oys3uDG6AmpLzvmIFs95cNfa9A==
X-Received: by 2002:a25:db0a:0:b0:b8f:f5f:13e9 with SMTP id g10-20020a25db0a000000b00b8f0f5f13e9mr3678724ybf.2.1681428704601;
        Thu, 13 Apr 2023 16:31:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s10-20020a5b074a000000b00b8f6eba39cesm61699ybq.57.2023.04.13.16.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:31:44 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:31:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <dda218c8c1fdc0ca2e4352b820f3432565a74a23.1681428696.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a variant of the `string_list_split_in_place()` function that
takes a string of accepted delimiters.

By contrast to its cousin `string_list_split_in_place()` which splits
the given string at every instance of the single character `delim`, the
`_multi` variant splits the given string any any character appearing in
the string `delim`.

Instead of using `strchr(2)` to locate the first occurrence of the given
delimiter character, `string_list_split_in_place_multi()` uses
`strpbrk(2)` to find the first occurrence of *any* character in the given
delimiter string.

Since the `_multi` variant is a generalization of the original
implementation, reimplement `string_list_split_in_place()` in terms of
the more general function by providing a single-character string for the
list of accepted delimiters.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 string-list.c | 15 ++++++++++++---
 string-list.h |  6 ++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/string-list.c b/string-list.c
index db473f273e1..67f9ff18904 100644
--- a/string-list.c
+++ b/string-list.c
@@ -300,8 +300,8 @@ int string_list_split(struct string_list *list, const char *string,
 	}
 }
 
-int string_list_split_in_place(struct string_list *list, char *string,
-			       int delim, int maxsplit)
+int string_list_split_in_place_multi(struct string_list *list, char *string,
+				     const char *delim, int maxsplit)
 {
 	int count = 0;
 	char *p = string, *end;
@@ -315,7 +315,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 			string_list_append(list, p);
 			return count;
 		}
-		end = strchr(p, delim);
+		end = strpbrk(p, delim);
 		if (end) {
 			*end = '\0';
 			string_list_append(list, p);
@@ -326,3 +326,12 @@ int string_list_split_in_place(struct string_list *list, char *string,
 		}
 	}
 }
+
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit)
+{
+	char delim_s[2] = { delim, 0 };
+
+	return string_list_split_in_place_multi(list, string, delim_s,
+						maxsplit);
+}
diff --git a/string-list.h b/string-list.h
index c7b0d5d0008..670d4fc8fb7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -268,7 +268,13 @@ int string_list_split(struct string_list *list, const char *string,
  * new string_list_items point into string (which therefore must not
  * be modified or freed while the string_list is in use).
  * list->strdup_strings must *not* be set.
+ *
+ * The "_multi" variant splits the given string on any character
+ * appearing in "delim", and the non-"_multi" variant splits only on the
+ * given character.
  */
+int string_list_split_in_place_multi(struct string_list *list, char *string,
+				     const char *delim, int maxsplit);
 int string_list_split_in_place(struct string_list *list, char *string,
 			       int delim, int maxsplit);
 #endif /* STRING_LIST_H */
-- 
2.38.0.16.g393fd4c6db

