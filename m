Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C3C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiAVV4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiAVV4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9806C06173D
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v13so6470459wrv.10
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jD5SnTjqP16AUCWi/T/p1cOzzpGdUGc4ygDUm32+4Es=;
        b=arfWZXPBR+/HThz2dIG59fVVsHtSJRxEfq/NIxM4rzCob3FJsumk9KhFX63TMQA50U
         el1+bggalErMPXjbfmp78JEK9TPoybiSgYBNdEoyC6putQbufQAFhaRKzQbRuTAMOWYZ
         WAsJEyg3ODeZuWVoBV6jmFXlMLMC1U8s3+idIZyIMav1MPaCt+pWdFABDHOrxeaXd64f
         r1RmQdtU1+sRYwz+rrFiChNSqftyogJwXj2OeQDY18AV+qke3KryKeBFq9tR07dwApa9
         1Ug9+AGEUx0jdPRntwh6OZZeklM2PRIN9sZupHyo8Ie2bBVTurO0hHr5wwacWQuY065+
         Oc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jD5SnTjqP16AUCWi/T/p1cOzzpGdUGc4ygDUm32+4Es=;
        b=CduJgkWRGKIfn+4BBzB55tBqiaKEmMcE7ZArLvgiz0ogSfp3vCt9+uAm4UVG6qBIGy
         PI2OF411o1Ef/28D4yiRLyppDMAI25Ai2VvJts4OXjzLf9sI1o2q2vqp3rZRWtupCU70
         8OWZyNrDjrXPoJRwHQQ97aaUWi5FsrHJ8l/Xma+GfDLfn60M1QJL0ClF9ylM6T1/whbZ
         +zZe3Xo0wAWf+697bHkVEgjDM1ozV2Iuv85qMQo332lbymCZkZiFptTA0UA9OjpL7wRy
         mirILwKdv5yo0P2GSH3cN+lLhz6Y1DNobb9rRRLtWoiMZ6yxLE7R6mcaqKiYpg9/C8JP
         ei2g==
X-Gm-Message-State: AOAM5333TbdUkGI2FGdR7zxgw27MB3TkXLTQaCqCeC3JF9Hy7q5fBrHW
        P2vx7TZwYYHBla3qraLpRindgWr34zc=
X-Google-Smtp-Source: ABdhPJxQRY0oTXDLXd/N1z/riQ9yPICVMOGiGyUbqe4r4cMH38rk+FmK0ueDbDjXmVaY3yd7MEENWg==
X-Received: by 2002:a5d:58fc:: with SMTP id f28mr8624039wrd.665.1642888572348;
        Sat, 22 Jan 2022 13:56:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm3240208wrd.110.2022.01.22.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:11 -0800 (PST)
Message-Id: <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:59 +0000
Subject: [PATCH 09/12] merge-tree: provide a list of which files have
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
        Elijah Newren <newren@gmail.com>,
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
 t/t4301-merge-tree-real.sh       | 11 +++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index fd7a867de60..041a4ac2785 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -58,6 +58,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -69,6 +70,13 @@ This is a tree object that represents what would be checked out in the
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
index 560640ad911..d8eeeb3f306 100644
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
@@ -395,7 +398,8 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2)
+		      const char *branch1, const char *branch2,
+		      const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *common;
@@ -449,6 +453,22 @@ static int real_merge(struct merge_tree_options *o,
 		o->show_messages = !result.clean;
 
 	printf("%s\n", oid_to_hex(&result.tree->object.oid));
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
@@ -502,7 +522,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.real)
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index c34f8e6c1ed..43c9950dedb 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -94,6 +94,8 @@ test_expect_success 'test conflict notices and such' '
 	#   "whatever" has *both* a modify/delete and a file/directory conflict
 	cat <<-EOF >expect &&
 	HASH
+	greeting
+	whatever~side1
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -105,4 +107,13 @@ test_expect_success 'test conflict notices and such' '
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

