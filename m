Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5556EC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352274AbiCaBOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352245AbiCaBOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E866604
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1075629wmn.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbUYHzHozsIrSd0Wd6iugrNQMQNvV1tsxshpFKBHuIM=;
        b=NeN7AtrSttT/0viNaCtwHaMpDA4gTIbFRFn19TpGe8oavTwbtCqOW2jLJTGy9g/D2l
         cOLL0VlcmBXMUOghkDPA0uu48o59DlTLPdjXCsyDX/hvdgnb0S2lLpIfLXWD+aAgE6p7
         QNNPB59Ro0crS6rseg01tpFHus0f24hPZBuB1WtHLpvWWAvJofZ4uN/7lZVORRNvXYaB
         M6ke2BJGPyE0VZ4HhX5PKs3xqQnU6SAy+kTm3wfBeRQIG8cVOd3mibvQ17Xc5/v0KOJz
         H1exD+zqnBv9cbKQ4dAtpxtDrE5pmeHUxgBeneiSXqbFS3tmiJw1u59jEkjYrrz8n0qe
         cTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbUYHzHozsIrSd0Wd6iugrNQMQNvV1tsxshpFKBHuIM=;
        b=u6mDac6++meiihEEtiSC2qC4ahNwg6RMJEWYkWiBFdAAf2RJ/m1G563guQF8TO1Z8P
         GhbbFfn5NuRFbFlu5oni9z7aSRZr802yAILhg/oJ2bEf3LsGpgXBHj9+P9BtDoSi0mSV
         W0SHrZ3ve5m9OnY2tdQgntMLYe1sKEgusgOpMLsrP3reoi31rT9/dy8yHk8FHEttXEUV
         Dj+Pp4ZQNlZWnWiukqY7f+s05OajO73Uy8fc+HHAY+qmJCFU+qU5jON0u3Z9PihDNUzr
         E/SXayp6gUEqVOoNCrgcde1IgwMSRTf1E9ukMwUKGzZ8Q0vDZAyhFO7RMpqBveXSpz5y
         1wPQ==
X-Gm-Message-State: AOAM5314N6+yN/oCSDLH0876MSS+49K8bhXVgj0GzIKdWdSf00HEI/Er
        7y71sNtiTAqyONj2bN3yxExjOqlGkeyPzA==
X-Google-Smtp-Source: ABdhPJywlK5G9yd6Dgj1KKaNSbfY3SyM8JzacBoEcFf9hodq4Npe9pgFPEk1621xP6MfsnEOK03Y4A==
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr2325711wmj.143.1648689132351;
        Wed, 30 Mar 2022 18:12:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/27] revision.[ch]: document and move code declared around "init"
Date:   Thu, 31 Mar 2022 03:11:13 +0200
Message-Id: <patch-v4-08.27-086cec742b4-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
index 9a3c05b69a5..8fc157e9ee7 100644
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
index 61c780fc4cd..19f886472aa 100644
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
+ * Helpers to check if a "struct string_list" item matches wild
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
2.35.1.1557.g4e3e9cdb5e0

