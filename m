Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F6C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353029AbiA2SHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353011AbiA2SH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4EC061753
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m26so789403wms.0
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4vpK7gvSSTnnlTHW028zn/66BNp2/IopKxZgoFX/3Ek=;
        b=TdpYfuwQS/lh3xaO4/wohm2PxxVkefHjbkaSFQjXxkJr2FisY80NlAXAIY7GWO5ojq
         RTGrKVSoZzR05CRmL2pQEbMgXfs8wb2MWZAkGK7lJMquP2oZsdsbMTARgsfboRsd2YRo
         qjmqEX8ivYcYW4uXvvsI7rZB4zQgo3FSsS9T8qzeCCsX6Q5O7L6KLsANWjtechJIteIo
         lkd0WRr1PGWP+0j0cWGv2D4E4/4W3bQXHu9h/r0x16nDeMCqZHJF7V3rGairMBsH1Ct3
         QZA04/4JSmlYtYQX9RDILJO2i+mnYXrZakpVT8TEiconj/k+LPIad3yiZ3IlDeWFktVT
         l9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4vpK7gvSSTnnlTHW028zn/66BNp2/IopKxZgoFX/3Ek=;
        b=iL7iFiSmepuwWGnoCcx6rqIdJS373LkGyRKKXaQEcfQhpxr3xwy+aaTnCOoCtB4Xqn
         e4x08bruOBW5pNqWjWDoVYIQVAh9bA2717RAX8OVHUd23B7+K9YgHT00P2Ttpa5KDspe
         vKeG+SxPlzHYhAOIIIlRH/4sRo3qShcxdT9KpL0rmRVT9W+y5d9HTwbsCi21VtfEWjGh
         3MaU+Vm5EppewR7nEUBoXUsuBofpQHBqUdPyWVotcPYOptsNpegzd/x/0/f85M3awZGe
         lpmPf/9mrfoBw7OH7yNzyLohMFfistwR5KZHYDak9383ldsCTtV/DcCdAcMSaGCTJSmu
         LhQQ==
X-Gm-Message-State: AOAM530u6WGSVdVZ97Uv/iP4npwo/6hL2GGwQ79gbOBVaGS0tis/+qUP
        IoCXjBTxctiFLgTqscH9wR9fWavcheo=
X-Google-Smtp-Source: ABdhPJwF3CaaK2WIJIxsaksVAd0FaSRwO7PYFqLg521RisbQ+4QWd/MWGP0cwzW3Yxmn2eaA9YmlOw==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr20862125wmi.72.1643479643783;
        Sat, 29 Jan 2022 10:07:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm7308682wrm.47.2022.01.29.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:23 -0800 (PST)
Message-Id: <c322e4c6938b7270b6e90998994642074a2813e0.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:11 +0000
Subject: [PATCH v2 11/13] merge-tree: provide easy access to `ls-files -u`
 style info
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

Much like `git merge` updates the index with information of the form
    (mode, oid, stage, name)
provide this output for conflicted files for merge-tree as well.
Provide an --exclude-modes-oids-stages/-l option for users to exclude
the mode, oid, and stage and only get the list of conflicted filenames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 30 ++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-write-tree.sh | 26 ++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 160e8f44b62..55bb7bc61c1 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -38,6 +38,11 @@ See `OUTPUT` below for details.
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
@@ -55,7 +60,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -67,18 +72,23 @@ This is a tree object that represents what would be checked out in the
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
@@ -110,6 +120,14 @@ plumbing commands since the possibility of merge conflicts give it a
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
index 54dae018203..dc52cd02dce 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -394,6 +394,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int mode;
 	int show_messages;
+	int exclude_modes_oids_stages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options *o,
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
-			if (last && !strcmp(last, name))
+			struct stage_info *c = conflicted_files.items[i].util;
+			if (!o->exclude_modes_oids_stages)
+				printf("%06o %s %d\t",
+				       c->mode, oid_to_hex(&c->oid), c->stage);
+			else if (last && !strcmp(last, name))
 				continue;
 			write_name_quoted_relative(
 				name, prefix, stdout, line_termination);
@@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), 't'),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F('l', "exclude-modes-oids-stages",
+			   &o.exclude_modes_oids_stages,
+			   N_("list conflicted files without modes/oids/stages"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 7113d060bc5..1572f460da0 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -47,6 +47,7 @@ test_expect_success 'Content merge and a few conflicts' '
 	expected_tree=$(cat .git/AUTO_MERGE) &&
 
 	# We will redo the merge, while we are still in a conflicted state!
+	git ls-files -u >conflicted-file-info &&
 	test_when_finished "git reset --hard" &&
 
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
@@ -86,7 +87,7 @@ test_expect_success 'Barf on too many arguments' '
 '
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stages side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	# Expected results:
@@ -109,7 +110,7 @@ test_expect_success 'test conflict notices and such' '
 '
 
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-modes-oids-stages side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
@@ -117,4 +118,25 @@ test_expect_success 'Just the conflicted files without the messages' '
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

