Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249BC43217
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiAVV4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiAVV4P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE259C061401
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u15so6462392wrt.3
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7glMBzES/z+oiSwYCi+tcPrJ6YC39GY3cGhTRt9XDzI=;
        b=j+yCCdSSNSmOTcWFvU70lYCBbJtIejtiLc76uUwYIZzBeFvWnq2MlDVPCNmXahtVqj
         jAMAMk7wc2pAuggdiuSIGj8+MMU+TEZ2OcAP7op/JcAJv8ODx20jDaEruQlDobjViUEi
         XbrCzejbnTK5XRnNlRB2NVM7kWu6/BawoEmtXHXE0rQpEStnvCQ5S3dcjXOWWdElRPhn
         DUF2ke+05F0PzXjS7oR0JhDj1NPIQQZ+b5O9GJfzWrwAzS4Cyoj3+XerwJN/mnIz3jJw
         8zZGIZl4gCYyCU5s6VsfGH/zBxEIruWxbI19EZ/VFr3HASkkl1MtQ6rgjw2Claj8oOCG
         XYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7glMBzES/z+oiSwYCi+tcPrJ6YC39GY3cGhTRt9XDzI=;
        b=p/inWe04+opKIiZodL55QASudtQAwbOUtYPYqSkXOk/CXtRHNyG0JMQOT1jGm4/XFV
         zl3l5LmdJVI3RR99kma/18YHSvdFDPEvXDRCrm7DB8CDgz0s6onUGGJXLKzFr7YyaxTs
         GaxtoeA8zdWHySrAtn2K4KlMQKhY/ZoXwO8eaiS31cmvIuHZq+FV62pmCGufgK2RPUkA
         UPr4WnXsRHNk+eLBi8Fh/Md+AbihenRc42z4K/V36sTMwreZgTXvf7zsprHK9Bg0FhDW
         b6OntmlLpxAUH6Xhzd8qeYCkLqPEs3vkqLKF4WzbjP59085wqXRGKEXw1aTkxAsDdP94
         f8Zg==
X-Gm-Message-State: AOAM531DEyhzChT7wbPH2P+ZU2YB3pcQ4nWlQEuazJ05/tpwR907YQnE
        psSuq41iHAh6HxpDZ/ZlPF3VxNe5Q/A=
X-Google-Smtp-Source: ABdhPJyGuTjpbIRdTGWkaNRl/PAjSKqu/S11F4r4FAjxgGf7kT9ngvbMb4GryIki1ZMVmZWHZIChQg==
X-Received: by 2002:a5d:4889:: with SMTP id g9mr8538766wrq.574.1642888573113;
        Sat, 22 Jan 2022 13:56:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm2700232wmq.26.2022.01.22.13.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:12 -0800 (PST)
Message-Id: <050add3e4986c457cd467b36eb4fd1f215b7406d.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:56:00 +0000
Subject: [PATCH 10/12] merge-tree: provide easy access to `ls-files -u` style
 info
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

Much like `git merge` updates the index with information of the form
    (mode, oid, stage, name)
provide this output for conflicted files for merge-tree as well.
Provide an --exclude-oids-and-modes option for users to exclude the
mode, oid, and stage and only get the list of conflicted filenames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 30 ++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-real.sh       | 26 ++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 041a4ac2785..beb08269a70 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -41,6 +41,11 @@ discuss the first form.
 OPTIONS
 -------
 
+--exclude-oids-and-modes::
+	Instead of writing a list of (mode, oid, stage, path) tuples
+	to output for conflicted files, just provide a list of
+	filenames with conflicts.
+
 --[no-]messages::
 	Write any informational messages such as "Auto-merging <path>"
 	or CONFLICT notices to the end of stdout.  If unspecified, the
@@ -58,7 +63,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -70,18 +75,23 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
-Conflicted file list
+Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
 
-This is a sequence of lines containing a filename on each line, quoted
-as explained for the configuration variable `core.quotePath` (see
-linkgit:git-config[1]).
+This is a sequence of lines with the format
+
+	<mode> <object> <stage> <filename>
+
+The filename will be quoted as explained for the configuration
+variable `core.quotePath` (see linkgit:git-config[1]).  However, if
+the `--exclude-oids-and-modes` option is passed, the mode, object, and
+stage will be omitted.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
 This always starts with a blank line to separate it from the previous
-section, and then has free-form messages about the merge, such as:
+sections, and then has free-form messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
@@ -113,6 +123,14 @@ plumbing commands since the possibility of merge conflicts give it a
 much higher chance of the command not succeeding (and NEWTREE containing
 a bunch of stuff other than just a toplevel tree).
 
+git-merge-tree was written to provide users with the same information
+that they'd have access to if using `git merge`:
+  * what would be written to the working tree (the <OID of toplevel tree>)
+  * the higher order stages that would be written to the index (the
+    <Conflicted file info>)
+  * any messages that would have been printed to stdout (the <Informational
+    messages>)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d8eeeb3f306..7aa7f9fd54a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -395,6 +395,7 @@ struct merge_tree_options {
 	int real;
 	int trivial;
 	int show_messages;
+	int exclude_oids_and_modes;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -461,7 +462,11 @@ static int real_merge(struct merge_tree_options *o,
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
-			if (last && !strcmp(last, name))
+			struct stage_info *c = conflicted_files.items[i].util;
+			if (!o->exclude_oids_and_modes)
+				printf("%06o %s %d\t",
+				       c->mode, oid_to_hex(&c->oid), c->stage);
+			else if (last && !strcmp(last, name))
 				continue;
 			write_name_quoted_relative(
 				name, prefix, stdout, line_termination);
@@ -495,6 +500,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			 N_("do a trivial merge only")),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "exclude-oids-and-modes",
+			   &o.exclude_oids_and_modes,
+			   N_("list conflicted files without oids and modes"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index 43c9950dedb..e921115cd2a 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -46,6 +46,7 @@ test_expect_success 'Content merge and a few conflicts' '
 	expected_tree=$(cat .git/AUTO_MERGE) &&
 
 	# We will redo the merge, while we are still in a conflicted state!
+	git ls-files -u >conflicted-file-info &&
 	test_when_finished "git reset --hard" &&
 
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
@@ -85,7 +86,7 @@ test_expect_success 'Barf on too many arguments' '
 '
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --exclude-oids-and-modes side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	# Expected results:
@@ -108,7 +109,7 @@ test_expect_success 'test conflict notices and such' '
 '
 
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-oids-and-modes side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
@@ -116,4 +117,25 @@ test_expect_success 'Just the conflicted files without the messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Check conflicted oids and modes without messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
+
+	# Compare the basic output format
+	q_to_tab >expect <<-\EOF &&
+	HASH
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~side1
+	100644 HASH 2Qwhatever~side1
+	EOF
+
+	test_cmp expect actual &&
+
+	# Check the actual hashes against the `ls-files -u` output too
+	tail -n +2 out | sed -e s/side1/HEAD/ >actual &&
+	test_cmp conflicted-file-info actual
+'
+
 test_done
-- 
gitgitgadget

