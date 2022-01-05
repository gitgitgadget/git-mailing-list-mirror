Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A2C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbiAER14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiAER1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24607C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v123so92422wme.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JJXql95jnPmZtiZfmd+4qqg+IOMqUYchmPiA6893R2U=;
        b=G/51VbYteMMo3JBrV/DCa64deeR53J0OuvlcoS/dXrMlIcSlHNDHrUh1b3rKH8TB6x
         83VJm8KS/3fpH92GUiiOVV2mOZ1M3/N4h+2Jky+Iw/vHg7yLCPApx0RQ2+RM0Gok91qd
         49BvTdY6fSh2mdGCVyKfNPENQbaYogLXO9R+Z3Pl5a/HR3oLk4YZb8xeSi9eoPPcgww2
         OASD/O+hpm9oAw3ObvA19An5R1V0UVpQVzx+gQ8gZmnpZnAksHlyE+OM8tHTTLYbWaw0
         qGiCniYPMeI87dmt4rpeSNEUbE7tB1y2leAELudq1jOf+tfyPibpFLLSek56Paz8ChXR
         0JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JJXql95jnPmZtiZfmd+4qqg+IOMqUYchmPiA6893R2U=;
        b=T8BZeORuOxBocVFf1fpyUZCb+CbdnmmRnoslytnrILX7S3cclha6PGaHtY+5g1HTLD
         rLaWcG3Btg6HTTiNPdG5sdgM3wtMR/431ZcEWx67j7UE378DnKee9K9SqrpapRzkUF77
         7pauXWR5Sa4TSNb2ypGQYipLQSgz/48kaL3G1shR1o2LBXcirRjO7rHIb76s/lJip0jR
         W6H1MSPD3fYQmDOffYligy7UKm4xMtr3aHcKKJsLEhxqIhrAKm8+G2z5bi+H8OCMWSob
         nyO/aRe98Ku8AzpWV9klKysxfuYZatW+EZ28TLo81PVJKBIkTLeTM0R3VxZ1oYSxH7GC
         0oag==
X-Gm-Message-State: AOAM532NT6bHlOPigQh6KJHDsbhVjx05mWFQ/uPft3ALC044iKEFvYiR
        pOgG0aDi1N56UuQA0c1+G5YCQKt2fxo=
X-Google-Smtp-Source: ABdhPJyhQDmmV4nQILEFrmoX/3n5ghli+L1u/LCPJdwKu44uwz27fVIvon5KWVcDwCjSCeeOpEeKNA==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr3781711wmq.152.1641403662516;
        Wed, 05 Jan 2022 09:27:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm3068886wmj.8.2022.01.05.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:42 -0800 (PST)
Message-Id: <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:35 +0000
Subject: [PATCH v2 8/8] merge-tree: provide an easy way to access which files
 have conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Callers of `git merge-tree --real` might want an easy way to determine
which files conflicted.  While they could potentially use the --messages
option and parse the resulting messages written to that file, those
messages are not meant to be machine readable.  Provide a simpler
mechanism of having the user specify --unmerged-list=$FILENAME, and then
write a NUL-separated list of unmerged filenames to the specified file.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  6 ++++--
 builtin/merge-tree.c             | 16 ++++++++++++++++
 merge-ort.c                      | 13 +++++++++++++
 merge-ort.h                      |  3 +++
 t/t4301-merge-tree-real.sh       |  9 +++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 4d5857b390b..542cea1a1a8 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' --real [--messages=<file>] <branch1> <branch2>
+'git merge-tree' --real [--messages=<file>] [--conflicted-list=<file>] <branch1> <branch2>
 'git merge-tree' <base-tree> <branch1> <branch2>
 
 DESCRIPTION
@@ -23,7 +23,9 @@ will be `0`, and if the merge has conflicts, the exit status will be
 `1`.  The output will consist solely of the resulting toplevel tree
 (which may have files including conflict markers).  With `--messages`,
 it will write any informational messages (such as "Auto-merging
-<path>" and conflict notices) to the given file.
+<path>" and conflict notices) to the given file.  With
+`--conflicted-list`, it will write a list of unmerged files, one per
+line, to the given file.
 
 The second form is meant for backward compatibility and will only do a
 trival merge.  It reads three tree-ish, and outputs trivial merge
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 46b746b6b7c..4ae34da98b1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -391,6 +391,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int real;
 	char *messages_file;
+	char *conflicted_file;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -450,6 +451,19 @@ static int real_merge(struct merge_tree_options *o,
 		merge_display_update_messages(&opt, &result, fp);
 		fclose(fp);
 	}
+	if (o->conflicted_file) {
+		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
+		FILE *fp = xfopen(o->conflicted_file, "w");
+		int i;
+
+		merge_get_conflicted_files(&result, &conflicted_files);
+		for (i = 0; i < conflicted_files.nr; i++) {
+			fprintf(fp, "%s", conflicted_files.items[i].string);
+			fputc('\0', fp);
+		}
+		fclose(fp);
+		string_list_clear(&conflicted_files, 0);
+	}
 	printf("%s\n", oid_to_hex(&result.tree->object.oid));
 
 	merge_finalize(&opt, &result);
@@ -472,6 +486,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			 N_("do a real merge instead of a trivial merge")),
 		OPT_STRING(0, "messages", &o.messages_file, N_("file"),
 			   N_("filename to write informational/conflict messages to")),
+		OPT_STRING(0, "conflicted-list", &o.conflicted_file, N_("file"),
+			   N_("filename to write list of unmerged files")),
 		OPT_END()
 	};
 
diff --git a/merge-ort.c b/merge-ort.c
index 86eebf39166..3d6dd1b234c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4234,6 +4234,19 @@ void merge_display_update_messages(struct merge_options *opt,
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
 
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct merge_options_internal *opti = result->priv;
+
+	strmap_for_each_entry(&opti->conflicted, &iter, e) {
+		string_list_append(conflicted_files, e->key);
+	}
+	string_list_sort(conflicted_files);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
diff --git a/merge-ort.h b/merge-ort.h
index 55819a57da8..165cef6616f 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -79,6 +79,9 @@ void merge_display_update_messages(struct merge_options *opt,
 				   struct merge_result *result,
 				   FILE *stream);
 
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index 5f3f27f504d..ec7bd8efd06 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -96,4 +96,13 @@ test_expect_success '--messages gives us the conflict notices and such' '
 	test_cmp expect MSG_FILE
 '
 
+test_expect_success '--messages gives us the conflict notices and such' '
+	test_must_fail git merge-tree --real --conflicted-list=UNMERGED side1 side2 &&
+
+	cat UNMERGED | tr "\0" "\n" >actual &&
+	test_write_lines greeting whatever~side1 >expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
