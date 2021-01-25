Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4631DC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F39022D04
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbhAYRzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbhAYRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB320C061351
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so13822194wrz.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DLHpNtZdXcw+qiTCBYSCYZeRA+wJGG0YpncTEfBc3+g=;
        b=gz5AeZ12Hqole3lnOpyOaDMWBltJOZSD9nI8lsRquRUxJc9oy8d2a0fnvsXuuWFGHA
         4Yl83BbNpyqL2r3pEsBELRVqKk2IopxdCvzK0tnfoKm6ZP8m/0E7SH+Cxtvm/+uVr/Us
         9xT/Y1jIlLE5NwT60GCHjgNCsOcus/9cHo1M1XvturuBqQyxU/0Yyc4C6oDWQf+XxhzR
         bLs3c/CZ1wd4KBqniZEsv+t69ADKS7QJmPbHlI1Y4yRsMVnJlKxVHW8ZrsWtBFcAra8J
         qzV344hcxfyiWHPLR95qclmGYq9JUE1fXV5Fc+z6aaahy6sT9MNYooa1f13q09KvQo00
         U2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DLHpNtZdXcw+qiTCBYSCYZeRA+wJGG0YpncTEfBc3+g=;
        b=ABsyrqvvp02FIHqZshmJ1XUEgpHz3yfMG46NwoOBw2HuihfoFevvhqOrEeDQusvEr/
         GI0+VE5RzGTDKVha/sRqeafII6EoF3e0kZExu8o7DA12E10aN4VXy1krIKCkeKd3n+dR
         VcUmLcJBZvH8hhpzcEe/b5UXWSCnPhYenUUl1WJbnuOY0Q52YavZUpPhCQhZ4RjwUoXq
         JOqxsubYdK69rkHEzKbkeS6JAYRHJWdJxb67j/2yYMDEYGQDTUF4jxZG/JQjLmPv3Z3Z
         xQ999wQR9YcLBcSnELc3IySa/sa3yJq/5E/0ef4vk8aDtd5oVVBUh4W0gY6Rn5Vp9zPv
         FL0w==
X-Gm-Message-State: AOAM532lyfTjv917MW0xVdjtbtlBATvYUpomOKtMjAq0JMl6tR8smNCd
        mXh4r1guLfruCPUec1uMqSfV6RY8Rss=
X-Google-Smtp-Source: ABdhPJwoHF62iC6J4O2afuN2PIN9KQmKXQ9xDYjlsxyBp+P4hXRT4rBoo6RBwpMruh+A9Dlqqbi4tw==
X-Received: by 2002:adf:b1db:: with SMTP id r27mr2241419wra.125.1611596541625;
        Mon, 25 Jan 2021 09:42:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm55172wmk.3.2021.01.25.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:21 -0800 (PST)
Message-Id: <8bbd1cd59ba04720cf5f77903a1883a25eb8606b.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:52 +0000
Subject: [PATCH 06/27] test-tool: don't force full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will use 'test-tool read-cache --table' to check that a sparse
index is written as part of init_repos. Since we will no longer always
expand a sparse index into a full index, add an '--expand' parameter
that adds a call to ensure_full_index() so we can compare a sparse index
directly against a full index, or at least what the in-memory index
looks like when expanded in this way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index f858d0d0a0c..3c45dfeb3cb 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "sparse-index.h"
 
 static void print_cache_entry(struct cache_entry *ce, unsigned stat)
 {
@@ -44,6 +45,11 @@ int cmd__read_cache(int argc, const char **argv)
 	const char *name = NULL;
 	int table = 0;
 	int stat = 1;
+	int expand = 0;
+
+	initialize_the_repository();
+	prepare_repo_settings(r);
+	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
@@ -52,6 +58,8 @@ int cmd__read_cache(int argc, const char **argv)
 			table = 1;
 		else if (!strcmp(*argv, "--no-stat"))
 			stat = 0;
+		else if (!strcmp(*argv, "--expand"))
+			expand = 1;
 	}
 
 	if (argc == 1)
@@ -61,6 +69,10 @@ int cmd__read_cache(int argc, const char **argv)
 
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
+
+		if (expand)
+			ensure_full_index(r->index);
+
 		if (name) {
 			int pos;
 
-- 
gitgitgadget

