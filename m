Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BDFC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354525AbiDBKwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354490AbiDBKvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05DB1403F8
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so10741936ejb.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+INmhvHjxa57pFbY+pr4oXlNQBq0GivCWgOKPmxjs9o=;
        b=c0jpsYC0LsBfRjXBg06Vb8ktBFMtyBU4wZk1i0+qm+zPFbWEKUhICjD0TCzYb0U9Rl
         +/rPkclcwNibcw07eu8VF1OymsjI1dXOFrjfQsY4WIUAinRewhnDCt3QjIdkfM3ioCk8
         4kKBHkuPCxTjd3T/DRKADhLqJmcNGp302cIXgJgCkcxkkn7ocBLJL+YfvDUW25e3jct4
         GdMbBg+BSY6GH2znyLIdKlGrok4G1KIHJZHRxM07aLBejT1BXlNECqutzk5ey2EJAlDl
         8Fe772gHYA5fTlCuuKTeYpscHJj+Pd/zB0LOlmT00fhDq6wYus0yKvYaLDxfAGq2gzYS
         GXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+INmhvHjxa57pFbY+pr4oXlNQBq0GivCWgOKPmxjs9o=;
        b=OCmSBSdCY0MeW289Xx+T7Zb69UEVmkvHvAAcQmUjH/3YsnAlpkRq+vj6x6523zOjxI
         0qJNd98FuXTIJl1DxG0ur+ORaSLeOZoGsoyOSe2VjBhz5q2jfXuomovUOXJg3yp1JaaN
         xkBghxwtXnu32yt87PKEIuUjFUn5Pz93la1qysXC2OOcOqnYur8SbUdb/n+DA+GhYxbm
         fhsM8c2XypoOrNhbKXqq22T7JNeXPp7DRbTHhcsjkuHzFFsAlbrNq7tW3mEdPPzL3zGi
         xKlyUc4WnU7A8fXjY12w+oDhXNVC9L7XCWNQ1/7VkbZVWCihPOior8YGnviYACGIQyUG
         UY/w==
X-Gm-Message-State: AOAM533/r0huYGS6MamMbOCsNTMcHtuAtIC0Qp1V2N8TMidDmUV9Af2t
        6v+ZrZdEqD/MFbXLJYfHG4PP7KDzdBLEJw==
X-Google-Smtp-Source: ABdhPJzTU3uRb9r7GP3mbZPtNoV4odijCZvsBuYPHJsVT81fzdBE4yfyEFszdJNAdH3EEPgdeQOrYg==
X-Received: by 2002:a17:907:7d93:b0:6da:8f57:68fa with SMTP id oz19-20020a1709077d9300b006da8f5768famr3549888ejc.42.1648896593905;
        Sat, 02 Apr 2022 03:49:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:53 -0700 (PDT)
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
Subject: [PATCH v5 09/27] revisions API users: use release_revisions() needing REV_INFO_INIT
Date:   Sat,  2 Apr 2022 12:49:23 +0200
Message-Id: <patch-v5-09.27-240307bc3c6-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
2.35.1.1585.gd85f8dcb745

