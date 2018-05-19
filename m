Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2AB1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeESF2s (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32922 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeESF2n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id h9-v6so16908163lfi.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6W8np6lKNmZ0F5MFM0tUNwGA1UO5XWx0XSgTzG0XR4=;
        b=gt6qPJv9heeRaAL2w+V3OKhSa4eva676Hgs/7INNq682w6LT4EoZrKYKzU+Rd1cZYW
         ArE1MUdWPZg2hLDj1ebjMehS5e6fBNYXQACNsDdh8mZyE4b5femiyk7wF9p4Mc7CiCcH
         6NX61Alc5GvjVZ+T7pmR2QtlrLqQsxq04TWC1J0P3ETILjcw+SOEGfMWYHTPjSyD7fyE
         A/RmuPwlb5p0uHdi64lcXmgp0K8KqVYlhVklYdywyINC341XUyXJMkLdvGdAmhMIcUJw
         280hwc1xsRDeOEC+fY5za8n30D7Jw2ZHZ1KooXBqBZRs6vWBocvlNi3qUcIgDshADKDM
         8hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6W8np6lKNmZ0F5MFM0tUNwGA1UO5XWx0XSgTzG0XR4=;
        b=oXU3nVUUdDcmCje2F0HRdYyLReQIa5hyj0Pvep57xpEsclVtlgAeqn2j73pTcisOlH
         DKpnU6rdZ548fIYUmRexPJU6GLcEQXwRyxKGnFbB4ooRCHLi9pYMa9b+j6xkwZU+49HG
         sjLAKgLrsM5azI/9rpte+hrHOUzHAAGVsebLRZpyDY35hjVwWvBtgKMrgMmxdpD15w/P
         JAJcuHFEP2EkiA+eWSpd9o0CLFcxx+bv/4o4Pf5RpOW+GTOfQuod78ftDugDFicwcAbu
         wwSOtY/j1UvI9LSMwPhlMG9l51XrtHTMRLuFYTf+TZvIioBPavfUDxvPBtPhTEIqOA1i
         lZWg==
X-Gm-Message-State: ALKqPwc/miW9YfGP5ga2+pAqeOpU0Yy5XWnm+MB6w9LZ4ozykR9SB/cA
        UhDqFcH7hEMzroyukAm1BJA=
X-Google-Smtp-Source: AB8JxZqnZjMcVaiZ47M6V4u6ZcukJZ0YkRg5f/DUUiZYuF32HmeeH8YATm9geFe1flxNKOHG/K88rQ==
X-Received: by 2002:a2e:4949:: with SMTP id b9-v6mr7620623ljd.116.1526707722216;
        Fri, 18 May 2018 22:28:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 06/15] sequencer.c: use commit-slab to mark seen commits
Date:   Sat, 19 May 2018 07:28:22 +0200
Message-Id: <20180519052831.12603-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.
---
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4ce5120e77..3af296db3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "commit-slab.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3160,6 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
 	return CHECK_IGNORE;
 }
 
+define_commit_slab(commit_seen, unsigned char);
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
@@ -3173,6 +3175,9 @@ int check_todo_list(void)
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
 	int advise_to_edit_todo = 0, res = 0, i;
+	struct commit_seen commit_seen;
+
+	init_commit_seen(&commit_seen);
 
 	strbuf_addstr(&todo_file, rebase_path_todo());
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
@@ -3189,7 +3194,7 @@ int check_todo_list(void)
 	for (i = 0; i < todo_list.nr; i++) {
 		struct commit *commit = todo_list.items[i].commit;
 		if (commit)
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 	}
 
 	todo_list_release(&todo_list);
@@ -3205,11 +3210,11 @@ int check_todo_list(void)
 	for (i = todo_list.nr - 1; i >= 0; i--) {
 		struct todo_item *item = todo_list.items + i;
 		struct commit *commit = item->commit;
-		if (commit && !commit->util) {
+		if (commit && !*commit_seen_at(&commit_seen, commit)) {
 			strbuf_addf(&missing, " - %s %.*s\n",
 				    short_commit_name(commit),
 				    item->arg_len, item->arg);
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 		}
 	}
 
@@ -3235,6 +3240,7 @@ int check_todo_list(void)
 		"The possible behaviours are: ignore, warn, error.\n\n"));
 
 leave_check:
+	clear_commit_seen(&commit_seen);
 	strbuf_release(&todo_file);
 	todo_list_release(&todo_list);
 
-- 
2.17.0.705.g3525833791

