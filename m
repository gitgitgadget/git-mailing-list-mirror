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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B15C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D3C22583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbhAYR5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbhAYR4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19789C0617AA
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so60073wmq.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Rs6uqC7Asx9Upezrgq7UeiN/r211M1U3vC2roWojKMg=;
        b=KpqNJ0JQEYGpcSk41FhlO8WLOMeUsl2inbtOmztR0W5urmruMc47jYmn2oxoJ8xisV
         61wwFNo9tDJv/yO4YnfEJYsTYUmnN31bqkpaHPaqMJgvQlUXBhpxgWqpZGF3Xp1p/ygs
         g7u+3irknhjgPwDCjjRV5oYDF2Og9wm6dyj+InFUgkeiGpbVuAx/9QVnh7z21A7eYjp5
         Ww9bA4uKIL8kdYVoL07101ET3E6kCRNAe4iXWLfYrsZwJnCfXHiG4yMZmhSjpKoV+wBd
         RluQSoQYNvJQitd0L83ulO/d/tu5HurqxF+rulkGLE7V41YfHo9Kn8q+eVRlaln8YzUH
         gStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Rs6uqC7Asx9Upezrgq7UeiN/r211M1U3vC2roWojKMg=;
        b=RHvSinwD+nu+3wmmN5yRI8H5QWGMy/YXT5ZEHG3rgbndVKnzOk7GnoDt0Dcw6i06Of
         IlnRky2jni7ye+ea0hac9T1Yptr//RFU8pbavnm4KSuu/XSdlcPl0/ZEcFoyBvnU+UbP
         gTdMLQBpkeBRooPbiUfstiB9dqcTgLabHodRbWmYNri3I6CR93mW1qxvymLqxv4ZrWyX
         t0ceNmKU6axGIIQRC7zoXwInluwQMLRtKrZI5Ba6e7xBU6lISGp1pzhbuhINoGslkEQS
         2pUuxzdyjOVq1i3ty62P22eCZUxo1itmJgh1BQQs46NxosBANh45uvNAasSIYp6iUa/G
         FIrg==
X-Gm-Message-State: AOAM533tkNuJ1XdGyeg0FMAOw6GRfA8wX28+j/uT4CwPI3iS/n6C5Wo3
        slYe10Hq2TeY9G15mBCyUdYRJBhjPGs=
X-Google-Smtp-Source: ABdhPJyZZw3NLquacgNmNYYAy5j2wuUrZPKhPv7YFMiR4vl7z8OZfOzEkyjtQ8YezKmNWhH4CTG06Q==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr1155486wmj.23.1611596539726;
        Mon, 25 Jan 2021 09:42:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm6510wmg.41.2021.01.25.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:19 -0800 (PST)
Message-Id: <e3b169c4fec8db34634c77d19a03fc46a3c7690e.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:50 +0000
Subject: [PATCH 04/27] test-read-cache: print cache entries with --table
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

This table is helpful for discovering data in the index to ensure it is
being written correctly, especially as we build and test the
sparse-index.

To make the option parsing slightly more robust, wrap the string
comparisons in a loop adapted from test-dir-iterator.c.

Care must be taken with the final check for the 'cnt' variable. We
continue the expectation that the numerical value is the final argument.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c | 49 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 244977a29bd..cd7d106a675 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,18 +2,55 @@
 #include "cache.h"
 #include "config.h"
 
+static void print_cache_entry(struct cache_entry *ce)
+{
+	/* stat info */
+	printf("%08x %08x %08x %08x %08x %08x ",
+	       ce->ce_stat_data.sd_ctime.sec,
+	       ce->ce_stat_data.sd_ctime.nsec,
+	       ce->ce_stat_data.sd_mtime.sec,
+	       ce->ce_stat_data.sd_mtime.nsec,
+	       ce->ce_stat_data.sd_dev,
+	       ce->ce_stat_data.sd_ino);
+
+	/* mode in binary */
+	printf("0b%d%d%d%d ",
+		(ce->ce_mode >> 15) & 1,
+		(ce->ce_mode >> 14) & 1,
+		(ce->ce_mode >> 13) & 1,
+		(ce->ce_mode >> 12) & 1);
+
+	/* output permissions? */
+	printf("%04o ", ce->ce_mode & 01777);
+
+	printf("%s ", oid_to_hex(&ce->oid));
+
+	printf("%s\n", ce->name);
+}
+
+static void print_cache(struct index_state *cache)
+{
+	int i;
+	for (i = 0; i < the_index.cache_nr; i++)
+		print_cache_entry(the_index.cache[i]);
+}
+
 int cmd__read_cache(int argc, const char **argv)
 {
 	int i, cnt = 1;
 	const char *name = NULL;
+	int table = 0;
 
-	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
-		argc--;
-		argv++;
+	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
+		if (skip_prefix(*argv, "--print-and-refresh=", &name))
+			continue;
+		if (!strcmp(*argv, "--table")) {
+			table = 1;
+		}
 	}
 
-	if (argc == 2)
-		cnt = strtol(argv[1], NULL, 0);
+	if (argc == 1)
+		cnt = strtol(argv[0], NULL, 0);
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 	for (i = 0; i < cnt; i++) {
@@ -30,6 +67,8 @@ int cmd__read_cache(int argc, const char **argv)
 			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
+		if (table)
+			print_cache(&the_index);
 		discard_cache();
 	}
 	return 0;
-- 
gitgitgadget

