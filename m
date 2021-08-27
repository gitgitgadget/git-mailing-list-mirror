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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20016C43214
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0242160F4F
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhH0Xug (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhH0Xuc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C9C06179A
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso10311325wmb.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IXJxACXefm+q8uf4n4bu/C6KwsEnKUjBPd8VAtER6Oc=;
        b=Y4Aoz2ac57UyaxxewCytR9cbGyA9sc9Q5rwnfWO+6ryfQMwrr1UOizbdyUmLv/8xfr
         MiuaCuJH3X68J0mZh+6pL6f+YK80jjxcQKutq6F1S4kJdDs0v5Gz+BQK0djE1bEMBe6s
         0Q43S7NaQnmPTWT1tgUzTl7M4Nvv5RDHtYmf17Ni5HzbkF9waM7rxj+5aQjpTehqc00B
         wg0LcQKdSgS4ixl0xSQRYCzdJmyLJ+YWtW8faznq2VObzBWByEiWJM2qRd4rk4twVxJo
         ehvbcIzNg4YR6We/jPEIlYMGxKOyjvkZGJrItR2IlX2VWlv30wVJ6RPCZnH+8aewlEKK
         2CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IXJxACXefm+q8uf4n4bu/C6KwsEnKUjBPd8VAtER6Oc=;
        b=cT8acz99gdk0/727Q4ygMrYXxjUc828RDyTM2K2eY2QPP4qUwMqj7RstpefUOUAUQ2
         R5lndQhCCAYXazLY9GnaQBF9UC6hbXbPObyx4pJ++GqCPKxajn+I1C/WW++L8hGr8pot
         0orwa8X8h4CnIXPkUudYqhwcMvZ8IB27h4XldtxAWyWlteruuG5Gpb1CKdltdZHcEsMi
         Jk2vcpBUI6+42Vq0V790Ej4+IVRI5ezVWupNL4uzzrvvNZO9pm/XBfs2HbvhmM5NuPvt
         X8Q61pSmZnu5jQenUsvc0CQ3YotMrF69oZywmN169x0cX168/QjRq2Gy39asMoTuOGvs
         efjA==
X-Gm-Message-State: AOAM533D6gz/lNhV3QgiNnVqRoC2NJCwKA1spWhSNBYzjhR3olDlfCA3
        s9eG7bYqc3Y+FCvWEpItPr1FU/PzzpM=
X-Google-Smtp-Source: ABdhPJxRjjnsjbBxyR2dWgP/OmR04Usw4JqIg1iYXnftMaJfjPYr75GVyul0dCJzg8l7VTmlDsAhhA==
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr11103981wma.136.1630108181253;
        Fri, 27 Aug 2021 16:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm6719367wmz.26.2021.08.27.16.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
Message-Id: <d8843185fe46e0c4e869159f9539714c5d232810.1630108177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:36 +0000
Subject: [PATCH v2 5/6] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
pack functionality and the new bulk-fsync functionality. This mode
is enabled when passing paths to update-index via the --stdin flag,
as is done by 'git stash'.

There is some risk with this change, since under batch fsync, the object
files will not be available until the update-index is entirely complete.
This usage is unlikely, since any tool invoking update-index and
expecting to see objects would have to snoop the output of --verbose to
find out when update-index has actually processed a given path.
Additionally the index is locked for the duration of the update.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1f16f2de52..64d025cf49e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1152,6 +1153,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
+		plug_bulk_checkin();
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
@@ -1166,6 +1168,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				chmod_path(set_executable_bit, p);
 			free(p);
 		}
+		unplug_bulk_checkin(&lock_file);
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
-- 
gitgitgadget

