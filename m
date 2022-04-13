Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE65C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiDMUEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiDMUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1517B555
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p18so3346435wru.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5zn1P5xNSELRY2uCUjZnOEDoIK3Lpq9Z8bka99vUKI=;
        b=iQAV9UcWQFJMLKl4q/mr98pdzRhtakmbZF3xQoyvJA0i3anf+YYQKzw5DEh+LIT2Is
         btScPgObXqbkybgJqamQoQqEZDEEU0CeEMMJ17QCbGGFmfOkoxk0gXJlh4WmSl+qIRtA
         SmNSa9NKOcEQTTtHh/8CBHvQbIJot3hlMcBbprx/wl4ycsfXUi/FZbLl0tN1mzmZpVCI
         BOxl4Inxs45QRbPlB/Wq5ppLDbN/QH+nRinD+KJUN+mB9ZohtYD00HS6zzbbZodpmTjS
         dT5pVDEr/FCyXZCRx0Nms1k+3nKuPEQMWe8R4m0iK9fhxC8W6UnJ55Ck5zAOhWd65TKt
         OPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5zn1P5xNSELRY2uCUjZnOEDoIK3Lpq9Z8bka99vUKI=;
        b=A/FjhUVsZzu5GAwQjheZvlYAYrd1L2f1vBAbpteL5z9eZZA32ZL3q2KnLOIRbYErvr
         XmzcX1hJtyWGmpe+zMCcQYd9cpgfLCwTDdw0881cbeFbVa24mXWtPoWNDN/2nZCMGfy4
         eS4A9e/cTItkNqQZYJXNYU1aN0gruUM9Szur9gFiSObTuuQieV6iTqAokMGhxfIMZkkD
         64ti9dQ2rcMt4woQ/icR/7UQDK6542liVng+5HNV4cML9JfeHJMLovpBTSjkCJPWc5C0
         +TXRtbqdv9nJFo4+BUULnrx9qSHaoAmLfLBYl+iCQ/vX2RE7l+9oFKlbDmvAIWTO2dFs
         HV2w==
X-Gm-Message-State: AOAM530yUBgxxdmncBgGcw3hvCsDAv6eDoHW3nmgH29nqh3vpeZ5vbnZ
        0DJBtTBAZPNSScuB3ko2jMK+SQQFCVEZqg==
X-Google-Smtp-Source: ABdhPJwOLH7BhFw20LGOgOtF8cFVzKDVx3e4tpLF/zyLjnbo12TJskWipzEP0cMG0QqZydHn7X7oHQ==
X-Received: by 2002:a5d:6d0b:0:b0:207:81ec:93ff with SMTP id e11-20020a5d6d0b000000b0020781ec93ffmr339424wrq.239.1649880129234;
        Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:08 -0700 (PDT)
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
Subject: [PATCH v6 09/27] revisions API users: use release_revisions() needing REV_INFO_INIT
Date:   Wed, 13 Apr 2022 22:01:38 +0200
Message-Id: <patch-v6-09.27-2bfa8640b6b-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() to various users of "struct rev_list" which
need to have their "struct rev_info" zero-initialized before we can
start using it.

For the bundle.c code see the early exit case added in
3bbbe467f29 (bundle verify: error out if called without an object
database, 2019-05-27).

For the relevant bisect.c code see 45b6370812c (bisect: libify
`check_good_are_ancestors_of_bad` and its dependents, 2020-02-17).

For the submodule.c code see the "goto" on "(!left || !right || !sub)"
added in 8e6df65015f (submodule: refactor show_submodule_summary with
helper function, 2016-08-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 18 ++++++++++++------
 builtin/submodule--helper.c |  3 ++-
 bundle.c                    | 12 ++++++++----
 revision.h                  | 21 ++++++++++++++++++++-
 submodule.c                 |  3 ++-
 5 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index cc6b8b6230d..b63669cc9d7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1010,7 +1010,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  */
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
-	struct rev_info revs;
+	struct rev_info revs = REV_INFO_INIT;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	enum bisect_error res = BISECT_OK;
@@ -1035,7 +1035,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 	if (res)
-		return res;
+		goto cleanup;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
 
@@ -1060,14 +1060,16 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		       term_good,
 		       term_bad);
 
-		return BISECT_FAILED;
+		res = BISECT_FAILED;
+		goto cleanup;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path arguments?\n"));
 
-		return BISECT_NO_TESTABLE_COMMIT;
+		res = BISECT_NO_TESTABLE_COMMIT;
+		goto cleanup;
 	}
 
 	bisect_rev = &revs.commits->item->object.oid;
@@ -1087,7 +1089,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		 * for negative return values for early returns up
 		 * until the cmd_bisect__helper() caller.
 		 */
-		return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
+		res = BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
+		goto cleanup;
 	}
 
 	nr = all - reaches - 1;
@@ -1106,7 +1109,10 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(r, ALL_REV_FLAGS);
 
-	return bisect_checkout(bisect_rev, no_checkout);
+	res = bisect_checkout(bisect_rev, no_checkout);
+cleanup:
+	release_revisions(&revs);
+	return res;
 }
 
 static inline int log2i(int n)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5d6b43fe3c0..9a65985b418 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -766,7 +766,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 {
 	char *displaypath;
 	struct strvec diff_files_args = STRVEC_INIT;
-	struct rev_info rev;
+	struct rev_info rev = REV_INFO_INIT;
 	int diff_files_result;
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
@@ -853,6 +853,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 cleanup:
 	strvec_clear(&diff_files_args);
 	free(displaypath);
+	release_revisions(&rev);
 }
 
 static void status_submodule_cb(const struct cache_entry *list_item,
diff --git a/bundle.c b/bundle.c
index d50cfb5aa7e..6a870a6edb7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -196,14 +196,16 @@ int verify_bundle(struct repository *r,
 	 * to be verbose about the errors
 	 */
 	struct string_list *p = &header->prerequisites;
-	struct rev_info revs;
+	struct rev_info revs = REV_INFO_INIT;
 	const char *argv[] = {NULL, "--all", NULL};
 	struct commit *commit;
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	if (!r || !r->objects || !r->objects->odb)
-		return error(_("need a repository to verify a bundle"));
+	if (!r || !r->objects || !r->objects->odb) {
+		ret = error(_("need a repository to verify a bundle"));
+		goto cleanup;
+	}
 
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
@@ -221,7 +223,7 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 	if (revs.pending.nr != p->nr)
-		return ret;
+		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
@@ -284,6 +286,8 @@ int verify_bundle(struct repository *r,
 			printf_ln("The bundle uses this filter: %s",
 				  list_objects_filter_spec(&header->filter));
 	}
+cleanup:
+	release_revisions(&revs);
 	return ret;
 }
 
diff --git a/revision.h b/revision.h
index b9070e43428..2621eb6d65a 100644
--- a/revision.h
+++ b/revision.h
@@ -329,6 +329,25 @@ struct rev_info {
 	struct tmp_objdir *remerge_objdir;
 };
 
+/**
+ * Initialize the "struct rev_info" structure with a macro.
+ *
+ * This will not fully initialize a "struct rev_info", the
+ * repo_init_revisions() function needs to be called before
+ * setup_revisions() and any revision walking takes place.
+ *
+ * Use REV_INFO_INIT to make the "struct rev_info" safe for passing to
+ * release_revisions() when it's inconvenient (e.g. due to a "goto
+ * cleanup" pattern) to arrange for repo_init_revisions() to be called
+ * before release_revisions() is called.
+ *
+ * Initializing with this REV_INFO_INIT is redundant to invoking
+ * repo_init_revisions(). If repo_init_revisions() is guaranteed to be
+ * called before release_revisions() the "struct rev_info" can be left
+ * uninitialized.
+ */
+#define REV_INFO_INIT { 0 }
+
 /**
  * Initialize a rev_info structure with default values. The third parameter may
  * be NULL or can be prefix path, and then the `.prefix` variable will be set
@@ -363,7 +382,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 
 /**
  * Free data allocated in a "struct rev_info" after it's been
- * initialized with repo_init_revisions().
+ * initialized with repo_init_revisions() or REV_INFO_INIT.
  */
 void release_revisions(struct rev_info *revs);
 
diff --git a/submodule.c b/submodule.c
index 7b5d7753930..7923e951e1c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -619,7 +619,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	struct rev_info rev;
+	struct rev_info rev = REV_INFO_INIT;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct repository *sub;
@@ -646,6 +646,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 
 out:
 	free_commit_list(merge_bases);
+	release_revisions(&rev);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
 	if (sub) {
-- 
2.36.0.rc2.843.g193535c2aa7

