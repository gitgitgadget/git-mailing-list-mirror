Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE3C433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhLaFEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLaFEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C8C061746
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so8382811wmb.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dtg/puNu4VieIa/dRN3Sd/se0saxgPkdU0f59mzAKCs=;
        b=ZiDkwi649kFALBE/vmNhblyhkgRT+I1QTCZ91uyym3R7XKg5mwRkrYtH9GTdy1ogrP
         gsAylp01v9opwlZt9/h5bUCF9a8wKCSn+rIG26sKP6M+OqDI778B2JZJNbf4IdWi6k+8
         Rllhta6bD+j7MHQ0GbjIZSmY2EoBVvt3T4fspAOy3c+UQcZhbveWyV8NJ68i80cP3RZd
         Fhp3Ghdhlfx/HJ70GwFMpq6ydf2nsYvWTrGO276TV2aJdtN9xjGhbnVoAPC7kw37G0cH
         G3lGWHJMzblxmOM1hb7+cn6Ldm6JmrBDDZh9ehTqTclx2y562pAV0pyvdOiYU7SDRMgO
         2B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dtg/puNu4VieIa/dRN3Sd/se0saxgPkdU0f59mzAKCs=;
        b=71mMYh3cNOeKLUZ1se3jj1TDFGwbjzca2INLEGIQfmxYs+SjPOMHyoJ5bP6mdjfeb4
         BT9kTUfEbYuSHR2+Yi2GlHx5meQxHW+RGarF/eYvtDvX6kfSZbW2TOwlbU4VIi+CkY8I
         lZ7jhq12hkOs2+WHobeGJHyAV0BnEYE1gD/jWXBSeceRRNSzyNj+izhUAuJPnC4DkF55
         ZBl0D58PPsu/zsjTPkONZeAnqb7dHTZ7KzPWC/zip4BGCyNWZGh5Rru+s2gFq3eHwoHY
         O3Uxl7AjtpcZxjgrXt9+kCgC2JlWK1CqFbMJgaDTc0CWzGj++RFEDG9r7zL93Ga8n4zN
         LhvA==
X-Gm-Message-State: AOAM5339WaNs6O3gd02iHDBWrBI4aS58AgN/xpqwIV8I+uVe9cyzgtab
        nhchwttA1ZuA9iMNYy+nUAQ5d1yhVMI=
X-Google-Smtp-Source: ABdhPJxauc6miY6MKoLGx73lZf9EQZZvc5zzqnMjXRjqT8pcfOqaEMKo7pL0qeo6fp4tBNAgqm57Rg==
X-Received: by 2002:a1c:7303:: with SMTP id d3mr15304089wmb.154.1640927051083;
        Thu, 30 Dec 2021 21:04:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm26862450wms.45.2021.12.30.21.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:10 -0800 (PST)
Message-Id: <1d24a4f4070de81e7850cc220cd784116ec33718.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:04:04 +0000
Subject: [PATCH 8/8] merge-tree: provide an easy way to access which files
 have conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
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
index 47deef0b199..90bd1e92135 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -390,6 +390,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int real;
 	char *messages_file;
+	char *conflicted_file;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -449,6 +450,19 @@ static int real_merge(struct merge_tree_options *o,
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
@@ -471,6 +485,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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
index 42218cdc019..0b725eef9fc 100755
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
