Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F69C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiBBHf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbiBBHfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7AC061758
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so36620441wrg.11
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QUAEoi4aLmkdvqTyeW5+zkc86dJRK8t2CDOBRn9/dKI=;
        b=FXhwF2jSpNA1viXxQZoFozvXsl1UKQUJt9evkVGTHOlf8lSocG/PQLeLbUeeP/H3wL
         I/pTD0yo0DOm/prjCXYGcxIiuXsLhOVXz8hkMhQmaF+eqHQvLhdAs1mxWn0aGVg8mVxN
         ++yd8bGCATJz0jxhKfv/GGbAkwvZ7Xtq2up1xKOpREHkZ8Pf15n66NObiCSXQ3Mu6IyQ
         V5xoyJ5WqFhTKXJ9wQ2n5cVDV9TcF5aRVooLv151f4addsPc4UzgZ7wbNJqb1LJbUJs2
         ADf19BiZAqzkndo0fcr5cCSpnHBKyFcZHBD3nxpWz31yaPs4fVBYgj95eqqFw/RNpat7
         51qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QUAEoi4aLmkdvqTyeW5+zkc86dJRK8t2CDOBRn9/dKI=;
        b=di/1SI2d0+YWZjHLAmTI3/g6mr3IHRuGQvbVNfga+SxNVksQGHPQCWIv56ZaSDen3H
         Q7SpdQp/Z2mEZH3m6Qpr945vrLHuBt22ufyeUbAfZuGz5XWBWdcrldMFVUWGoy5sDM46
         lfKzdIDh0z7XyX5xLj+HMxegv+ftNTK1H+zMVOYKiRzN9Fa1/b8Q7+fKPQniUqQWDE3K
         eVIh0xkacmgHviR3drubXB/s74mAj7BA4mgk7px1k7d4aql6uDDx9EftBl7vyibkGMKd
         nlnZy98FziR1Gznhqce7M+YnwsuTI0Y4yKGkV9J8BqzlrlXQBujug+HOlCPqBEdaKQgs
         Q3mA==
X-Gm-Message-State: AOAM532KanTRh7aYSWWY67D84K7KJDhzC/lljVxK+Jr2CSrBhzoEavgl
        TnEDl1s7oLj9U07bF2NqOSfOzefgeYs=
X-Google-Smtp-Source: ABdhPJzWZ0yANo40okGvCsttWGlZefHp3JRRJDG+LIO6bBaNCoGZjz5clSnMZRMONxVZB+VmB/djXA==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr24683392wrw.245.1643787292531;
        Tue, 01 Feb 2022 23:34:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm16547609wrd.98.2022.02.01.23.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:52 -0800 (PST)
Message-Id: <9c2389eef0e7c8813e0522011132d7f5e530d858.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:37 +0000
Subject: [PATCH v3 11/15] merge-tree: provide a list of which files have
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Callers of `git merge-tree --write-tree` will often want to know which
files had conflicts.  While they could potentially attempt to parse the
CONFLICT notices printed, those messages are not meant to be machine
readable.  Provide a simpler mechanism of just printing the files (in
the same format as `git ls-files` with quoting, but restricted to
unmerged files) in the output before the free-form messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  8 ++++++++
 builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 42e0f8f6183..160e8f44b62 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -55,6 +55,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -66,6 +67,13 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
+Conflicted file list
+~~~~~~~~~~~~~~~~~~~~
+
+This is a sequence of lines containing a filename on each line, quoted
+as explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
+
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 6a556ab1c9c..54dae018203 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -11,6 +11,9 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "quote.h"
+
+static int line_termination = '\n';
 
 struct merge_list {
 	struct merge_list *next;
@@ -394,7 +397,8 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2)
+		      const char *branch1, const char *branch2,
+		      const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *common;
@@ -438,6 +442,22 @@ static int real_merge(struct merge_tree_options *o,
 		o->show_messages = !result.clean;
 
 	puts(oid_to_hex(&result.tree->object.oid));
+	if (!result.clean) {
+		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
+		const char *last = NULL;
+		int i;
+
+		merge_get_conflicted_files(&result, &conflicted_files);
+		for (i = 0; i < conflicted_files.nr; i++) {
+			const char *name = conflicted_files.items[i].string;
+			if (last && !strcmp(last, name))
+				continue;
+			write_name_quoted_relative(
+				name, prefix, stdout, line_termination);
+			last = name;
+		}
+		string_list_clear(&conflicted_files, 1);
+	}
 	if (o->show_messages) {
 		printf("\n");
 		merge_display_update_messages(&opt, &result, stdout);
@@ -486,7 +506,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == 'w')
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index e2255711f9c..7113d060bc5 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -95,6 +95,8 @@ test_expect_success 'test conflict notices and such' '
 	#   "whatever" has *both* a modify/delete and a file/directory conflict
 	cat <<-EOF >expect &&
 	HASH
+	greeting
+	whatever~side1
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -106,4 +108,13 @@ test_expect_success 'test conflict notices and such' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Just the conflicted files without the messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
+
+	test_write_lines HASH greeting whatever~side1 >expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

