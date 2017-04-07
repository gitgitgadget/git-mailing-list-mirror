Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBBC020966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934193AbdDGTYW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:24:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36192 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbdDGTYK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:24:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so17406546pgh.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZKdEIeyApIWj4dQUQ6gZW4f8+t8GgQWKp4L+uo1LKo=;
        b=OGD/jqOkBdoRmfuBi23XP2+JMup3DcyeNoP9TnDqeIfjrfcb3RrfNW44wH7z0jtcwy
         W54YVwwrttC1k8CdbkSnx/UDUwBa1vce7X4qzTeonuuZdg1mk7heWxdxuA7Ijsb+ktSJ
         ELuNiWBDIjJhlugvlIKHBxaU1q1FY+8tfe0qATnCOOngzOCpu7pfNaYs4YgpWTIrDNz3
         JDdVV46MTIYMdLdtMuRY5JDATFLfO+OJtSd6GbFR4NxjoRXnHfHplUCaIPrqXKRAXXqo
         D30IeyszVYfyvW5XAN2iG1saRdbau9d9SY2hnziu1bJhPEr1aXWN69DCPjTyQRgkKk56
         RyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZKdEIeyApIWj4dQUQ6gZW4f8+t8GgQWKp4L+uo1LKo=;
        b=mb0efItB8nPDxyG9HkIDCa5OV5uLlomBPlPkTcgQuRn1GtD7gHT8CVO8v1MBaQdvAP
         wRBNNb9MLD4IUa2F/zYvkk75IPKmz16eWBWsufx6ZtsnfGRz7orldjfrRwPlUPUjwAEK
         BS4xichMrLWbwZGc8dzK3dl3ci2r9yaI9MTD8EbZVnoGBnSl0+U8bYrpJRzaj6T8Ujay
         vzeW2CfD0NmywGFyoUFUhTgTaHZXajhuqBSiBPTX6OLIivoN3E6K08xS1gZ33cb8fE3R
         waXLHPh4QKsiM9gQurUdU5sSOmZiiaJm3jqRYiQIsjPFNnbBfW/FlYZ/03GtBw8/KAvo
         8n0w==
X-Gm-Message-State: AFeK/H0J1JhN6LnPEvH5I5z0TdQ7SUSsv70QK5tUqQ0tAkUiI11Wj6b2oVFbA30r/B5KGw==
X-Received: by 10.99.143.88 with SMTP id r24mr44033573pgn.177.1491593044736;
        Fri, 07 Apr 2017 12:24:04 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:9::3b6])
        by smtp.gmail.com with ESMTPSA id u29sm11018797pfa.123.2017.04.07.12.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 12:24:04 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 3/3] reset.c: update files when using sparse to avoid data loss.
Date:   Fri,  7 Apr 2017 12:23:57 -0700
Message-Id: <20170407192357.948-4-kewillf@microsoft.com>
X-Mailer: git-send-email 2.12.2.windows.2
In-Reply-To: <20170407192357.948-1-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the sparse checkout feature the git reset command will add
entries to the index that will have the skip-worktree bit off but will
leave the working directory empty.  File data is lost because the index
version of the files has been changed but there is nothing that is in the
working directory.  This will cause the next status call to show either
deleted for files modified or deleting or nothing for files added.
The added files should be shown as untracked and modified files should
be shown as modified.

To fix this when the reset is running if there is not a file in the
working directory and if it will be missing with the new index entry
or was not missing in the previous version, we create the previous index
version of the file in the working directory so that status will report
correctly and the files will be availble for the user to deal with.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 builtin/reset.c                  | 34 +++++++++++++++++++++++
 t/t7114-reset-sparse-checkout.sh | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 8ab915bfcb..8ba97999f4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "dir.h"
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -117,12 +118,45 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	int pos;
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
+		struct diff_filespec *two = q->queue[i]->two;
 		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int was_missing = !two->mode && is_null_oid(&two->oid);
 		struct cache_entry *ce;
+		struct cache_entry *ceBefore;
+		struct checkout state = CHECKOUT_INIT;
+
+		/*
+		 * When using the sparse-checkout feature the cache entries that are
+		 * added here will not have the skip-worktree bit set.
+		 * Without this code there is data that is lost because the files that
+		 * would normally be in the working directory are not there and show as
+		 * deleted for the next status or in the case of added files just disappear.
+		 * We need to create the previous version of the files in the working
+		 * directory so that they will have the right content and the next
+		 * status call will show modified or untracked files correctly.
+		 */
+		if (core_apply_sparse_checkout && !file_exists(two->path))
+		{
+			pos = cache_name_pos(two->path, strlen(two->path));
+			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) && (is_missing || !was_missing))
+			{
+				state.force = 1;
+				state.refresh_cache = 1;
+				state.istate = &the_index;
+				ceBefore = make_cache_entry(two->mode, two->oid.hash, two->path,
+					0, 0);
+				if (!ceBefore)
+					die(_("make_cache_entry failed for path '%s'"),
+						two->path);
+
+				checkout_entry(ceBefore, &state, NULL);
+			}
+		}
 
 		if (is_missing && !intent_to_add) {
 			remove_file_from_cache(one->path);
diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
new file mode 100755
index 0000000000..8dd88fd46d
--- /dev/null
+++ b/t/t7114-reset-sparse-checkout.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='reset when using a sparse-checkout'
+
+. ./test-lib.sh
+
+# reset using a sparse-checkout file
+
+test_expect_success 'setup' '
+	test_tick &&
+	echo "checkout file" >c &&
+	echo "modify file" >m &&
+	echo "delete file" >d &&
+	git add . &&
+	git commit -m "initial commit" &&
+	echo "added file" >a &&
+	echo "modification of a file" >m &&
+	git rm d &&
+	git add . &&
+	git commit -m "second commit" &&
+	git checkout -b endCommit
+'
+
+test_expect_success 'reset when there is a sparse-checkout' '
+	echo "/c" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout -b resetBranch &&
+	test_path_is_missing m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	git reset HEAD~1 &&
+	test "checkout file" = "$(cat c)" &&
+	test "modification of a file" = "$(cat m)" &&
+	test "added file" = "$(cat a)" &&
+	test_path_is_missing d
+'
+
+test_expect_success 'reset after deleting file without skip-worktree bit' '
+	git checkout -f endCommit &&
+	git clean -xdf &&
+	echo "/c
+/m" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout -b resetAfterDelete &&
+	test_path_is_file m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	rm -f m &&
+	git reset HEAD~1 &&
+	test "checkout file" = "$(cat c)" &&
+	test "added file" = "$(cat a)" &&
+	test_path_is_missing m &&
+	test_path_is_missing d
+'
+
+
+
+test_done
-- 
2.12.2.windows.2.1.g7df5db8d31

