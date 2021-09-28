Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D59EC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E3F601FF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhI1Mva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbhI1Mv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:51:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FCC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:49:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so2149169wmb.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXSxrW/J61MoILm3tnLXC3dxxEzcsd6I4oAnDViiYDM=;
        b=cVy8aYydoTLDQ0JfZ7IszthJHuxxNWkEmVzRlpRgQIbn5sYTmOzXrIILB8FBJPq9RP
         5SCqxFmysVQY5A2SOl3Qw5Ca3Co2gnvVm/k71YVTS3qqIFRb7MzP8XhOluHt+kGmWtHl
         A7CgykRaeVtvy5gHzjT9bPtiMoLU7cM7xs5t5oJBME+YG9J8KjdhHZ+zth4kcNN1mNn9
         sQHRKKDugJYhmYAeYCmRpqSih2G2SHDyz7e375eBAyDdQKSJcGCDKAsrFRMp2dNjctHW
         Z1JV6ztS87/pNhR1EgZKR6RmNJ9SSZSyHwhZ7DzF3K642ST7Ec6cnqAPTuQE2NuYwLHS
         qELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXSxrW/J61MoILm3tnLXC3dxxEzcsd6I4oAnDViiYDM=;
        b=k+VNG4o32zLMQonxlxQmlrwK3A6+tJvw8x7MwT0Qz4SvBOQ+jfRHDWuhXs1EQCGKh5
         xv9l+3mlxCqSXwJsCSKMzvbM7sNL93OPTae1fBtmTEmDsbwTGxGf8VOAJRL5OZUuhj4J
         HDuMzeuPtd31Vdxdaktv7yYyL0S4GtA5jZlKPRm29Y51iunX0DAJ39Lq5PZ3QoXIzhUA
         2jkGDkVjb7OuJRZHTx+N2Zd6VJehYQVe5m8aYbloQbHG25HTIqFsTyAFz6QSoBX/g7WP
         WGoqwfeS70FFjmvndDIzoj3SgjflsulNvdsaZ2t2VMCf9YqyLtn/n3RTsjTiq+bpmv4W
         rFQg==
X-Gm-Message-State: AOAM533E45azJmeB9idnNIdhtQ39oa1ilX8kcizEUrSGqy9jsbsyochX
        +pyZsRZRip80GwMeZWvO3gGQOChCBMwKeQ==
X-Google-Smtp-Source: ABdhPJxPeMP3l/4pR1lCGpm7qDjQOVGIstHxY+6ZZYPj9ksAs7yuV7AuZrGz0ekCaRqcB2vyHF5/Kw==
X-Received: by 2002:a1c:9d83:: with SMTP id g125mr4476324wme.45.1632833388190;
        Tue, 28 Sep 2021 05:49:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3136027wmk.2.2021.09.28.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 05:49:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] string-list.[ch]: remove string_list_init() compatibility function
Date:   Tue, 28 Sep 2021 14:49:45 +0200
Message-Id: <patch-1.1-03c805dd90f-20210928T124939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove this function left over to accommodate in-flight changes, see
770fedaf9fb (string-list.[ch]: add a string_list_init_{nodup,dup}(),
2021-07-01) for the recent change to add
"string_list_init_{nodup,dup}()" initializers.

There was only one user of the API left in remote-curl.c. I don't know
why I didn't include this change to remote-curl.c in
bc40dfb10a0 (string-list.h users: change to use *_{nodup,dup}(),
2021-07-01), perhaps I just missed it.

In any case, let's change that one user to use the new API, as of
writing this there are no in-flight changes that use, so this seems
like a good time to drop this before we get any new users of this
compatibility API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote-curl.c | 4 ++--
 string-list.c | 8 --------
 string-list.h | 5 -----
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 598cff7cde6..3f5688e4262 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1478,8 +1478,8 @@ int cmd_main(int argc, const char **argv)
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
-	string_list_init(&options.deepen_not, 1);
-	string_list_init(&options.push_options, 1);
+	string_list_init_dup(&options.deepen_not);
+	string_list_init_dup(&options.push_options);
 
 	/*
 	 * Just report "remote-curl" here (folding all the various aliases
diff --git a/string-list.c b/string-list.c
index 43576ad1265..549fc416d68 100644
--- a/string-list.c
+++ b/string-list.c
@@ -13,14 +13,6 @@ void string_list_init_dup(struct string_list *list)
 	memcpy(list, &blank, sizeof(*list));
 }
 
-void string_list_init(struct string_list *list, int strdup_strings)
-{
-	if (strdup_strings)
-		string_list_init_dup(list);
-	else
-		string_list_init_nodup(list);
-}
-
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
diff --git a/string-list.h b/string-list.h
index 0d6b4692396..267d6e5769d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -104,11 +104,6 @@ struct string_list {
 void string_list_init_nodup(struct string_list *list);
 void string_list_init_dup(struct string_list *list);
 
-/**
- * TODO remove: For compatibility with any in-flight older API users
- */
-void string_list_init(struct string_list *list, int strdup_strings);
-
 /** Callback function type for for_each_string_list */
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 
-- 
2.33.0.1340.ge9f77250f2b

