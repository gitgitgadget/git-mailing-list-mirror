Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B21C11F6B
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FBE6140A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhGAKyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhGAKyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A01C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so7585380wrf.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTLISbf6p2pNma+2eMCuKpqmOS9y3FqEfNvVCqHWFSk=;
        b=Oau1qkm3EcA2+jvQAankOQv4fpRCKPdIKF04s1/NDgJyB1FBQCawDoCdQ/jpGdN2hK
         LhDn4In0KAaV73W0cwVvX4XNSktFGipnEq7MNccyfg+8Uvj2YPj96WBUWCbW+09OE8w6
         LrSFzaQY3qDWdxtVxC2RgMdXuHcYc3B7N8oxqxLT8PubDOafYeQfXwr73bE/0z728mYM
         gN36KJjzxo18Qv8sPsSgwjlSPB1SYuTnGCSeguIsYb5Bw07yzvrNblWP7yCxagIAIjo7
         olO1RregF+RusVNBnaaGGxZ9SKpvpf1lSVWeNGZZnl/4qBA7PnmGClcXCoRp4bTfG+oH
         Yp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTLISbf6p2pNma+2eMCuKpqmOS9y3FqEfNvVCqHWFSk=;
        b=DpsNP6r53YRuNZUKDNNh4FqEeZLtBgSRKtULdTvKNtR9x8GDQNGkWfBFmslSJzOiPQ
         wR//+RPXdBDttiBT61feSVtXnSbEMK+14dIWt04Ujf5VIjZLi9vhmZRDaypbVpOpPQAg
         /qb6L6Ma6DfWulSkvYmNmSlzRV+dMjpbRd+D7ved721T9r7hR5PzOEw2MtRxEyHrFfPw
         AZQmIWMnKUIT+/3KuLmVJm53ENNoelGNLPcHRyiOMiBpKGADmVwXE4bqBdPv8MBY4Ivs
         TbsQJOBHaaqPrtTmV6+D3E1I0MaAcj77Wx41Jn8+qTLzoEOJrFthMnxDKhuaICTFu1eD
         qNsg==
X-Gm-Message-State: AOAM530ql924DDq4RpwcBT8XKXrfKfJEUf7LTGIoTDRvrnwU6P4mTQzG
        TN9uPl+yio7B2nqmgfV8/5Q5AvHDvJN4/w==
X-Google-Smtp-Source: ABdhPJww8vjybrrGOYvQ5RvLyY1osy2T7sGjipVDfq+37XxlXXxdbL++/8H3GzmeJDmryAOwcPmFbQ==
X-Received: by 2002:adf:f946:: with SMTP id q6mr43984137wrr.283.1625136696661;
        Thu, 01 Jul 2021 03:51:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] string-list.[ch]: add a string_list_init_{nodup,dup}()
Date:   Thu,  1 Jul 2021 12:51:28 +0200
Message-Id: <patch-4.5-b05a393b5f1-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to use the new "memcpy() a 'blank' struct on the stack"
pattern for string_list_init(), and to make the macro initialization
consistent with the function initialization introduce two new
string_list_init_{nodup,dup}() functions. These are like the old
string_list_init() when called with a false and true second argument,
respectively.

I think this not only makes things more consistent, but also easier to
read. I often had to lookup what the ", 0)" or ", 1)" in these
invocations meant, now it's right there in the function name, and
corresponds to the macros.

A subsequent commit will convert existing API users to this pattern,
but as this is a very common API let's leave a compatibility function
in place for later removal. This intermediate state also proves that
the compatibility function works.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 string-list.c | 18 ++++++++++++++++--
 string-list.h | 11 +++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index a917955fbd8..43576ad1265 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,10 +1,24 @@
 #include "cache.h"
 #include "string-list.h"
 
+void string_list_init_nodup(struct string_list *list)
+{
+	struct string_list blank = STRING_LIST_INIT_NODUP;
+	memcpy(list, &blank, sizeof(*list));
+}
+
+void string_list_init_dup(struct string_list *list)
+{
+	struct string_list blank = STRING_LIST_INIT_DUP;
+	memcpy(list, &blank, sizeof(*list));
+}
+
 void string_list_init(struct string_list *list, int strdup_strings)
 {
-	memset(list, 0, sizeof(*list));
-	list->strdup_strings = strdup_strings;
+	if (strdup_strings)
+		string_list_init_dup(list);
+	else
+		string_list_init_nodup(list);
 }
 
 /* if there is no exact match, point to the index where the entry could be
diff --git a/string-list.h b/string-list.h
index 521b9c0748d..0d6b4692396 100644
--- a/string-list.h
+++ b/string-list.h
@@ -97,8 +97,15 @@ struct string_list {
 /* General functions which work with both sorted and unsorted lists. */
 
 /**
- * Initialize the members of the string_list, set `strdup_strings`
- * member according to the value of the second parameter.
+ * Initialize the members of a string_list pointer in the same way as
+ * the corresponding `STRING_LIST_INIT_NODUP` and
+ * `STRING_LIST_INIT_DUP` macros.
+ */
+void string_list_init_nodup(struct string_list *list);
+void string_list_init_dup(struct string_list *list);
+
+/**
+ * TODO remove: For compatibility with any in-flight older API users
  */
 void string_list_init(struct string_list *list, int strdup_strings);
 
-- 
2.32.0.623.ge833f40cd87

