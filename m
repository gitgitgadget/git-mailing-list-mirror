Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910BC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbiCaBOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352247AbiCaBOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195366222
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r7so13310349wmq.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4EigHaFAvpCFsbbZN/tw/KyLgrfKxrW/VKAnMcMRC0=;
        b=O5PHMD7SFC5Ld6QTIP1ujaPKNLwM40bGctqRWIDy6kNaOHqQ8A3Y3vaPoTsP1PzVpN
         HTBZGFcSVyRAg7mEpkxlXhtEtYpKmpYaaKMOWxdVoTaV13FhMhiKCga+AjgSWH/j06R8
         n51jSejD8tu2U4am1cRa0vd6NrUxo/7SG8Pn18mzr7Qdsoe52R3xd2W3K8xXv98jVHb7
         dFaTsvViynIyQNWd1e4fj0dn11lAcGLiGhEvVSrGsxfySkaaqmFe0Oun1SWmSK9UGUBQ
         5DD5Huq5yJ+tqLba5kM1CWIkUcPzVZTYJpg0hfbbewhEGEjje8K8TslZ9iyisrGi2TK7
         MWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4EigHaFAvpCFsbbZN/tw/KyLgrfKxrW/VKAnMcMRC0=;
        b=yCW6bsizUfymERwqtU0PAi1HxORQ0GLKoHb7Ljor6iMWL8AFazj/XZQ/Sv/DVeUDfE
         VjEVi+PeL3WNoUadrs8bP/L2oYvGavDYLSSfU4560Buhy1ohBg4I/VRxDJ9MYwV3hwSh
         GcU7Qz/Y2jHBlJO9qKDn9Eyo0V0/YzYCx1DsJhaOSa6S9h+qDSdw+h5fGvnU3jcn/egR
         ExNLg5daiggorw0TICgWzltK4IROsZr3jx8zblDbRtGMQ0PKFFKQgFeygSNAi2UG9KRv
         zHU92zkU4AIXNBvi/qZLrLGMElxmbgFap5GVHLRNJSYrx8wOBJxNBVgY3KmoWm49xn1b
         EokA==
X-Gm-Message-State: AOAM533mjEUdKv1SKlhuH9KZ6xKMSN0Z2J/+YRdwTpfGOr+DFn1St9eI
        UzETU0/+97Cm/UD4m7Dofh0mANefeFEdlw==
X-Google-Smtp-Source: ABdhPJzAtjBrlfT6ow3PLgS+8HyONjIsg9vOnYvDB6p15+ColyZLzK1ckcYSbPQffqMgal3hXVJy1A==
X-Received: by 2002:a05:600c:4e92:b0:38c:73e8:7dcd with SMTP id f18-20020a05600c4e9200b0038c73e87dcdmr2378259wmq.196.1648689133162;
        Wed, 30 Mar 2022 18:12:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:12 -0700 (PDT)
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
Subject: [PATCH v4 09/27] revisions API users: use release_revisions() needing REV_INFO_INIT
Date:   Thu, 31 Mar 2022 03:11:14 +0200
Message-Id: <patch-v4-09.27-2f4e65fb534-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() to various users of "struct rev_list" which
need to have their "struct rev_info" zero-initialized before we can
start using it.

To do this add a stub "REV_INFO_INIT" macro, ideally macro would be
able to fully initialize a "struct rev_info", but all it does is the
equivalent of assigning "{ 0 }" to the struct, the API user will still
need to use repo_init_revisions(). In some future follow-up work we'll
hopefully make REV_INFO_INIT be a "stand-alone" init likke STRBUF_INIT
and other similar macros.

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
 revision.h                  | 13 ++++++++++++-
 submodule.c                 |  3 ++-
 5 files changed, 36 insertions(+), 13 deletions(-)

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
index 24980863f68..cda33ee4d2b 100644
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
index 19f886472aa..c920753e8b9 100644
--- a/revision.h
+++ b/revision.h
@@ -329,6 +329,17 @@ struct rev_info {
 	struct tmp_objdir *remerge_objdir;
 };
 
+/**
+ * Initialize the "struct rev_info" structure with a macro.
+ *
+ * This is not sufficient (yet!) to initialize a "struct rev_info",
+ * but it's OK (but redundant) to use it before a call to
+ * repo_init_revisions(), which does the real initialization. By using
+ * this it's safe to call release_revisions() on the "struct rev_info"
+ * without having called repo_init_revisions().
+ */
+#define REV_INFO_INIT { 0 }
+
 /**
  * Initialize a rev_info structure with default values. The third parameter may
  * be NULL or can be prefix path, and then the `.prefix` variable will be set
@@ -363,7 +374,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 
 /**
  * Free data allocated in a "struct rev_info" after it's been
- * initialized with repo_init_revisions().
+ * initialized with repo_init_revisions() or REV_INFO_INIT.
  */
 void release_revisions(struct rev_info *revs);
 
diff --git a/submodule.c b/submodule.c
index 4df04ae14e4..e796151ac6f 100644
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
@@ -645,6 +645,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
+	release_revisions(&rev);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
-- 
2.35.1.1557.g4e3e9cdb5e0

