Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91298C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiDMUEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiDMUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D07B545
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1845245wmz.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3g+gATyUdX3Duarj5GVrfjqga0s7reF85RnYudbDvI=;
        b=am+CDRgB1D8xFFX9LA3vokKYuu05QiuZkA9fVO0T6FCysqUZIGc5QD6C81pyBjU1Ah
         FSz0YTbSOksRXxTJhRTEpeXJLwJyC6piZ4hpkRmMAvwSoFjET8epkPjOiQibgRj4Ov8j
         DdFEaTkUcRpvgbh52Kkrwlr1BXbevfAR6ZnGJqhTCWNl9FZjsEdHY30EMjWTYrWfY8uW
         kOH+YvL3CSFJ7UWsE1oTCkG3w1IFH3erlvtdvZTe8uhCrVNHJ/E+qPBBTnr67iZm8W9S
         1d2hXf5Dic9Aq6fZev4BWntblFsY2i0siI2sUdTqlWfRXFf4RblXvEHwyVu85mzVCgpF
         nf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3g+gATyUdX3Duarj5GVrfjqga0s7reF85RnYudbDvI=;
        b=WsFN4MpCs2VgODOPH521/rjP234isSXMbV+ihEO+wgcqND1f7tISg1sb5c7mMUb8c2
         h/r5kxiWitL1rYTDz1EgvsrtfiNSpZ/zKlecMwx6SmOvJw+3hHHPeqxYrv5Wu5SfsV0M
         K2ulhS9IfMMuKsFMFcC6By+QssQrnsGZkmfBa206hOrgejxAKZjqaxUdhpZ7lEZqQK5M
         BCCr8SB3JXbHYW9fZ11jbF8+wMDcXTXF8eqGh/GFyZepr+JRJY7m2JctgWSfzqTutGYq
         HL5KTWUgkS7xwQg57PGu29Jv+rJkvGoV6oI11spx3QQK3P0TvqN9pdsJBn7H0gOSDHo0
         1nbw==
X-Gm-Message-State: AOAM531Bn4IYXm9SX/OGOQJYqZ0frpbsvH+HYbdWnRn+WVGwM/Q/e4Dl
        AR25CVX1mykLt0lL7y5aN+NoxLrUsPIwQQ==
X-Google-Smtp-Source: ABdhPJxsPjsezcyDuak4vlNGlPJBJj01YKftJ/PUqUoyPySmKmJ7ZdmfVyJlIE/JqWRSYSf81N8+Sg==
X-Received: by 2002:a05:600c:a03:b0:37b:daff:6146 with SMTP id z3-20020a05600c0a0300b0037bdaff6146mr292651wmp.85.1649880128305;
        Wed, 13 Apr 2022 13:02:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/27] revision.[ch]: document and move code declared around "init"
Date:   Wed, 13 Apr 2022 22:01:37 +0200
Message-Id: <patch-v6-08.27-4a0e57acf17-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will add "REV_INFO_INIT" macro adjacent to
repo_init_revisions(), unfortunately between the "struct rev_info"
itself and that function we've added various miscellaneous code
between the two over the years.

Let's move that code either lower in revision.h, giving it API docs
while we're at it, or in cases where it wasn't public API at all move
it into revision.c No lines of code are changed here, only moved
around. The only changes are the addition of new API comments.

The "tree_difference" variable could also be declared like this, which
I think would be a lot clearer, but let's leave that for now to keep
this a move-only change:

	static enum {
		REV_TREE_SAME,
		REV_TREE_NEW, /* Only new files */
		REV_TREE_OLD, /* Only files removed */
		REV_TREE_DIFFERENT, /* Mixed changes */
	} tree_difference = REV_TREE_SAME;

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c |  4 ++++
 revision.h | 50 ++++++++++++++++++++++++--------------------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 5dd4b2e910c..472fff1e0a7 100644
--- a/revision.c
+++ b/revision.c
@@ -606,6 +606,10 @@ static struct commit *one_relevant_parent(const struct rev_info *revs,
  *
  *   2. We saw anything except REV_TREE_NEW.
  */
+#define REV_TREE_SAME		0
+#define REV_TREE_NEW		1	/* Only new files */
+#define REV_TREE_OLD		2	/* Only files removed */
+#define REV_TREE_DIFFERENT	3	/* Mixed changes */
 static int tree_difference = REV_TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
diff --git a/revision.h b/revision.h
index 61c780fc4cd..b9070e43428 100644
--- a/revision.h
+++ b/revision.h
@@ -329,32 +329,6 @@ struct rev_info {
 	struct tmp_objdir *remerge_objdir;
 };
 
-int ref_excluded(struct string_list *, const char *path);
-void clear_ref_exclusion(struct string_list **);
-void add_ref_exclusion(struct string_list **, const char *exclude);
-
-
-#define REV_TREE_SAME		0
-#define REV_TREE_NEW		1	/* Only new files */
-#define REV_TREE_OLD		2	/* Only files removed */
-#define REV_TREE_DIFFERENT	3	/* Mixed changes */
-
-/* revision.c */
-typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
-extern volatile show_early_output_fn_t show_early_output;
-
-struct setup_revision_opt {
-	const char *def;
-	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
-	unsigned int	assume_dashdash:1,
-			allow_exclude_promisor_objects:1;
-	unsigned revarg_opt;
-};
-
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
-#endif
-
 /**
  * Initialize a rev_info structure with default values. The third parameter may
  * be NULL or can be prefix path, and then the `.prefix` variable will be set
@@ -366,6 +340,9 @@ struct setup_revision_opt {
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
+#endif
 
 /**
  * Parse revision information, filling in the `rev_info` structure, and
@@ -374,6 +351,13 @@ void repo_init_revisions(struct repository *r,
  * head of the argument list. The last parameter is used in case no
  * parameter given by the first two arguments.
  */
+struct setup_revision_opt {
+	const char *def;
+	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
+	unsigned int	assume_dashdash:1,
+			allow_exclude_promisor_objects:1;
+	unsigned revarg_opt;
+};
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 
@@ -423,6 +407,14 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
+/**
+ * Helpers to check if a "struct string_list" item matches with
+ * wildmatch().
+ */
+int ref_excluded(struct string_list *, const char *path);
+void clear_ref_exclusion(struct string_list **);
+void add_ref_exclusion(struct string_list **, const char *exclude);
+
 /**
  * This function can be used if you want to add commit objects as revision
  * information. You can use the `UNINTERESTING` object flag to indicate if
@@ -478,4 +470,10 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+/**
+ * Global for the (undocumented) "--early-output" flag for "git log".
+ */
+typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
+extern volatile show_early_output_fn_t show_early_output;
+
 #endif
-- 
2.36.0.rc2.843.g193535c2aa7

