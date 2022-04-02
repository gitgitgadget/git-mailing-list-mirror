Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDBC433FE
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354502AbiDBKv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354483AbiDBKvq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEED1403EB
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so7240673ejd.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WHSO1SgFiZ8NDaly33F2W1SYfrScjaq8VpX7r7UtuM=;
        b=JouwpB8M+h3bRK31AmDTEUbfJQNd1vmKWR1GgrVoCr1kc2qRB0yETAtQ4hMYBXjm2+
         CuMVG2cd4SBZzBoaVRfebjeCFkBKw/IoiExN80wIwZgL7yM7O3Odh6xFLWOmw3VcBNmQ
         SK33kv5BQov/0XCbegK6EBptGu49mxlL//r1SR7oPubdA0j22wb4oAngJgsPc3d7lXTc
         43nJ2BxW0CWJSD59dnQhUScLcbRb/Is6tHXZDPlQoh7RveWT8+rKQkMKqRF1sqOfpsnV
         vXQryBLlMWruYiQRUJhSY5EMicnDIhZADYAMeIt3bi0czYs8IwhPbUtxURuR7+RYZmM0
         E6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WHSO1SgFiZ8NDaly33F2W1SYfrScjaq8VpX7r7UtuM=;
        b=BN2bb4YmQzMCChl5AtsX+GmiS7tL7mqpgvdwfSo1EVImdfz1cAJBGvNSSU6oE6mWBu
         K8ehFuwEkFLg4cX7RvLhpa8CKJO1LMNuZfMB9CgaBdhKzudy1QOk+9D0KigdauBYDtD6
         L9vegqXbCvxbjl0xXJS0tRR4BLMGHCBrOPSMBDYfJzb+lbbMn3IKmSOzzUEFJs5jX/xi
         eH5PfFA3Tz2wgD/IbiqjkQXDZNbjuaLIncE6lQz+IrOqrj/8R0vyZj7/f2mLVLoVLD4/
         JeNAx9BDoE25vH1dCR9jdcH4YvMvIzwNxUl/hQ1ta42S7mXUCK3zKXlfWdiYxxfcBUNC
         iB8Q==
X-Gm-Message-State: AOAM530JY0B2lX6SdO5II7+QnBc25aTLNHLqNdYW5rz2yPywSwIBLa93
        LBof4Nw+8qZkRtVGdGKIpenQRfgFws6f6Q==
X-Google-Smtp-Source: ABdhPJxdW1EqOazcDF/LzDM+XbXBqy+YHGxn1EoytNfTXQrXhp9uPDQP40+BXMcfgF/8H5LqiNCYlQ==
X-Received: by 2002:a17:907:7da4:b0:6e4:8a48:d779 with SMTP id oz36-20020a1709077da400b006e48a48d779mr3358905ejc.344.1648896592944;
        Sat, 02 Apr 2022 03:49:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:52 -0700 (PDT)
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
Subject: [PATCH v5 08/27] revision.[ch]: document and move code declared around "init"
Date:   Sat,  2 Apr 2022 12:49:22 +0200
Message-Id: <patch-v5-08.27-003b507e0b7-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
2.35.1.1585.gd85f8dcb745

