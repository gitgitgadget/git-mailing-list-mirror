Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CCC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiBBHfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiBBHfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E70C061760
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v123so14537786wme.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ob2Mrmg1rskHNmkAusKEMik4COjQ1FXYLgs6bVr8714=;
        b=OJYk8uwwx00QhdwTnht5I1HQ0OTADo5LLPe6vhUEBUFNeb0n5mkeCM2Di6gwrm/tlX
         sNmvACO8B38okrmKV1haMRlUzHSJc0ZhmdyQc4SQKEQxfitpC4DpHud1CUR6LwJTys54
         WIiVahoq4m1qTCBbRbKJNaC9gkQcMkJM4Hs+2LCI1RFPmRruqj90Sfr5T46a6OC/mubg
         f07lahla6wx5zkJzQk5/Y50UuOlMINp+o51SdUFQ96DNAXViQuEFMknbvUrEi0rLXlKi
         4pbmZDYxa+x91uIk+2CUi1hWMuH/PctUQ/igS19gxYF2CFO0Fckn1HacKT0Qq2iYVpib
         Xd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ob2Mrmg1rskHNmkAusKEMik4COjQ1FXYLgs6bVr8714=;
        b=TLEIp1e9J7gLf0qGjP2TfEZMMDzW5wyT8raRh0CmWudx9dLAB3lM6LFdc8AAlcU49K
         IueOE0jutcmQFBZMvoOjN8cDrASqz7s2Ke53PrE2cXWZip281h/rc5qxdLM8s7ReyOkB
         6niNI0R1qJ/eO2BkQepNvjbABdJFTapKpGertqbZbw67peWAzofrC8dK9mBhntthatVh
         KrCANQ6wxWeK8JYPaPVfpO4EKss4KZ1mA6Epv09G6JcHKIv8wvBSMDBjtYSTZ6JYNqsT
         jei9O+hPKcXuh0T7ONJD224DT7c0cPCFGx0w9Q4lE2+tAJfODBDxb/b4pRs0/NTS9A/Y
         29FQ==
X-Gm-Message-State: AOAM530692Zq7b2jSnYXOo65vYvzw8uXfdTxYXg2lQcReOVGwOMEb20k
        XK35kMX0hXN+X/QaGQ3MruBDCngQ8Vs=
X-Google-Smtp-Source: ABdhPJzXgAQyCNvarRfrszeY4B2AdFlowXxq6vpLK1n8xLjonJ9Se0jSdSrbV+FgXCrGTPv2tzRE2w==
X-Received: by 2002:a05:600c:3b90:: with SMTP id n16mr4813448wms.178.1643787294081;
        Tue, 01 Feb 2022 23:34:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm19486293wrn.18.2022.02.01.23.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:53 -0800 (PST)
Message-Id: <52339b396fac6c3ae7a7dfa42d4d2d6eccc4ede7.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:39 +0000
Subject: [PATCH v3 13/15] merge-tree: allow `ls-files -u` style info to be NUL
 terminated
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

Much as `git ls-files` has a -z option, let's add one to merge-tree so
that the conflict-info section can be NUL terminated (and avoid quoting
of unusual filenames).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 21 +++++++++++++----
 builtin/merge-tree.c             |  4 +++-
 t/t4301-merge-tree-write-tree.sh | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 55bb7bc61c1..02f766716f9 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -38,6 +38,12 @@ See `OUTPUT` below for details.
 OPTIONS
 -------
 
+-z::
+	Do not quote filenames in the <Conflicted file info> section,
+	and end each filename with a NUL character rather than
+	newline.  Also begin the messages section with a NUL character
+	instead of a newline.  See OUTPUT below for more information.
+
 --exclude-oids-and-modes::
 	Instead of writing a list of (mode, oid, stage, path) tuples
 	to output for conflicted files, just provide a list of
@@ -70,7 +76,8 @@ OID of toplevel tree
 
 This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
-files within this tree may have embedded conflict markers.
+files within this tree may have embedded conflict markers.  This section
+is always followed by a newline.
 
 Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
@@ -82,19 +89,25 @@ This is a sequence of lines with the format
 The filename will be quoted as explained for the configuration
 variable `core.quotePath` (see linkgit:git-config[1]).  However, if
 the `--exclude-oids-and-modes` option is passed, the mode, object, and
-stage will be omitted.
+stage will be omitted.  If `-z` is passed, the "lines" are terminated
+by a NUL character instead of a newline character.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This always starts with a blank line to separate it from the previous
-sections, and then has free-form messages about the merge, such as:
+This always starts with a blank line (or NUL if `-z` is passed) to
+separate it from the previous sections, and then has free-form
+messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
   * "Failed to merge submodule <submodule> (<reason>)"
   * "Warning: cannot merge binary files: <filename>"
 
+Note that these free-form messages will never have a NUL character
+in or between them, even if -z is passed.  It is simply a large block
+of text taking up the remainder of the output.
+
 EXIT STATUS
 -----------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index dc52cd02dce..7e55f0fa301 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -464,7 +464,7 @@ static int real_merge(struct merge_tree_options *o,
 		string_list_clear(&conflicted_files, 1);
 	}
 	if (o->show_messages) {
-		printf("\n");
+		putchar(line_termination);
 		merge_display_update_messages(&opt, &result, stdout);
 	}
 	merge_finalize(&opt, &result);
@@ -490,6 +490,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), 't'),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F('l', "exclude-modes-oids-stages",
 			   &o.exclude_modes_oids_stages,
 			   N_("list conflicted files without modes/oids/stages"),
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 1572f460da0..f89d87c26b7 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -139,4 +139,44 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'NUL terminated conflicted file "lines"' '
+	git checkout -b tweak1 side1 &&
+	test_write_lines zero 1 2 3 4 5 6 >numbers &&
+	git add numbers &&
+	git mv numbers "Αυτά μου φαίνονται κινέζικα" &&
+	git commit -m "Renamed numbers" &&
+
+	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	#   "Αυτά μου φαίνονται κινέζικα" should have a conflict
+	echo HASH >expect &&
+
+	q_to_tab <<-EOF | lf_to_nul >>expect &&
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~tweak1
+	100644 HASH 2Qwhatever~tweak1
+	100644 HASH 1QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 2QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 3QΑυτά μου φαίνονται κινέζικα
+
+	EOF
+
+	cat <<-EOF >>expect &&
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	CONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
+	CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
+	Auto-merging Αυτά μου φαίνονται κινέζικα
+	CONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

