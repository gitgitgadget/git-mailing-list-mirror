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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD36C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA823613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhGEMfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGEMfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98312C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:27 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18169500otl.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DErwTfA+HDamFAy7JChjjTuHGkzO9O5t8TkvqSJIb+4=;
        b=GlmhX8gJY7WGbkSxFifkyPSWF0ogv5iRv2r5ukqdBqG2FrvUev9LLCRpWHdYGLjrPj
         CcLuSu7sQLPBG/di8UYD7F6HGJ7HpyjNg71uwxG3xlwNt0z7MvfWeGhGlMvdqQ2IOp6P
         0KaqVbw4LC+ygyOXDzAYT1lGC8m9/NpLKAbtMKGgJ0P1Xps5vS5IXowhDGhZempsQBpV
         haC26h+pzufQhkU10pwta+xWNtfDO7Xd4Xk2qFz7bTrx4TJtisYqN4PbH5q+jnuDBZQL
         penjuegSfnHUQFi7Z4vJddCeLx51KyV0rCBgg8+lc5gO01xKE8kzRe1GMiPRP2EZ/OJ5
         m/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DErwTfA+HDamFAy7JChjjTuHGkzO9O5t8TkvqSJIb+4=;
        b=MA8dR4oJ7+oyvmgoJkvsIJTzsqq1GnMxhH3EZgXY5Q3MiVb3LOytkzPgTCXmLn3Y6+
         EYzwKmxN93G43RcObXR+OIxieJjBP4XgpV44jXCZxbelz39y7a8Vi+fAc1Be691XGSmK
         kXW07vAhppmvMc4/wJFttHR7IrxM1pn0hETq81FADRcXMmhYB0UF93Dvv1HevtKusKm3
         maZK5CwD5SMjQSI8okmhrv09rbbfC4M44fRkikfutttTb4IIyj01QyK2xhvVw/2gJyTx
         EZvgSwfrPTVfEir29UNKPgUdnkL9hluHgIZhBJ+Ga8ucmlw8Gf8uO1B9kAeHgIK7RCmZ
         39dA==
X-Gm-Message-State: AOAM5303/oR+Tsx0mx9BstQDFuqP4T4bx9HfwwFe4Kqj3o2y7M2mlohI
        yNBQV1dGweQN5BV45dnee5GaCA3Hm1pXCQ==
X-Google-Smtp-Source: ABdhPJy+th7dFJR8VheCpmDCaxDPmW2q0x7/WJY7rNAmF2lMKTRZBRM3jDg/O6TW60yqaduWLkgcUQ==
X-Received: by 2002:a05:6830:3089:: with SMTP id f9mr10229434ots.160.1625488346792;
        Mon, 05 Jul 2021 05:32:26 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e24sm576071oou.23.2021.07.05.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 09/35] update: add options and usage skeleton
Date:   Mon,  5 Jul 2021 07:31:43 -0500
Message-Id: <20210705123209.1808663-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/update.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/update.c b/builtin/update.c
index 51e45b453d..1a69896aa8 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -3,9 +3,19 @@
  */
 
 #include "builtin.h"
+#include "parse-options.h"
 #include "run-command.h"
 #include "dir.h"
 
+static const char * const update_usage[] = {
+	N_("git update"),
+	NULL
+};
+
+static struct option update_options[] = {
+	OPT_END()
+};
+
 static int run_fetch(void)
 {
 	struct strvec args = STRVEC_INIT;
@@ -35,6 +45,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		setenv("GIT_REFLOG_ACTION", "update", 0);
 
+	argc = parse_options(argc, argv, prefix, update_options, update_usage, 0);
+
 	if (repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("update");
 
-- 
2.32.0.36.g70aac2b1aa

