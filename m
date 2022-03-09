Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C37C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiCINTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiCINSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DFB1637F0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so2961417wrg.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uD9FgiY8oCj+2DwwMEWyNZHNclVVCUfMr9Vm3LOZmaY=;
        b=ntDL4+ECXwCUT0xc8WypY/F/PbdT5WHIY1sXdXncD70YuRdBEh85i6gJBOIQ5SkFBK
         c57sohhABXN38nCeWpo2mPfQJKsdFrDLwMLJP0o46Njz4ituvVc2PGBCKOj1QhvrbmNv
         CWc0JOwZIolax7SKQvxsRWC5uhJPLiuF5ZePu4Ymqhfkoqeqs2uiusL3+pMP7KFf2n3P
         W55cniMeASR3E+tZM744HLY5l7uBUyA6YiFP6cUAYlpN1AC21Gjn3i0VX+tgauCir1Lu
         As9wmCX52VmE8hsZYnCa6LuFRldozPd4QeJV7g+hC7txEFIn50I/oRJAX178tIAM6wIN
         vMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uD9FgiY8oCj+2DwwMEWyNZHNclVVCUfMr9Vm3LOZmaY=;
        b=ZlCf5kHun4COuRHtzjTaUBVRvHNqUoSIsWPdOZA/xAZGqlJ2cRyZxC2ifvKB5ztgD0
         mn8Z1RP2ql3qu/CbffKhW/1fK5Mcw9YMfFdHLtloETsL4mJ+6sxkei8SGJjvtLS9D2KB
         eY5KrxJ6/DOxUI1JuQ6hX81tNsT3G3UItAmBtTBMIWek6ku2l7aAB/8NvXMYMq5tApWD
         PFUMJDtKWBiJRD9HKzBKQAdYmewYzdXAxllA5r201UHM44WBy/l3opC/u/Z5hG1azr6R
         froKtG7P7oA2Yyn0dfRJ49B33Oxu2wJTSk+SSCQGuKA+Rw6L3PDsaI+tVsgxdbbacRg1
         0Z7Q==
X-Gm-Message-State: AOAM5322OF2kS1qtO/H+lzirfRtwzMsfEfULJWaqbVgvRl+GXvi9Lkqc
        8CDlQdFtq7IT2T1EUhszP63kfej6tx2B7Q==
X-Google-Smtp-Source: ABdhPJw4he/zmpAETTbuEP8gGjJJABaFdFEyUhEBP7Fdv3xtmS48CJtMzj6Wt3zOploHY8YI7YJXgA==
X-Received: by 2002:a5d:59a5:0:b0:1f0:bf:64c9 with SMTP id p5-20020a5d59a5000000b001f000bf64c9mr15897932wrr.352.1646831869948;
        Wed, 09 Mar 2022 05:17:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/24] revisions API users: use release_revisions() needing "{ 0 }" init
Date:   Wed,  9 Mar 2022 14:16:37 +0100
Message-Id: <patch-07.24-295fa35174f-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() to various users of "struct rev_list" which
need to have their "struct rev_info" zero-initialized before we can
start using it. In all of these cases we might "goto cleanup" (or equivalent),

For the bundle.c code see the early exit case added in
3bbbe467f29 (bundle verify: error out if called without an object
database, 2019-05-27).

For the relevant bisect.c code see 45b6370812c (bisect: libify
`check_good_are_ancestors_of_bad` and its dependents, 2020-02-17).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 18 ++++++++++++------
 builtin/submodule--helper.c |  3 ++-
 bundle.c                    | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index cc6b8b6230d..159a4b644df 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1010,7 +1010,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  */
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
-	struct rev_info revs;
+	struct rev_info revs = { 0 };
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
index 7fbba812583..09db2620829 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -756,7 +756,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 {
 	char *displaypath;
 	struct strvec diff_files_args = STRVEC_INIT;
-	struct rev_info rev;
+	struct rev_info rev = { 0 };
 	int diff_files_result;
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
@@ -843,6 +843,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 cleanup:
 	strvec_clear(&diff_files_args);
 	free(displaypath);
+	release_revisions(&rev);
 }
 
 static void status_submodule_cb(const struct cache_entry *list_item,
diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..207541a3410 100644
--- a/bundle.c
+++ b/bundle.c
@@ -191,14 +191,16 @@ int verify_bundle(struct repository *r,
 	 * to be verbose about the errors
 	 */
 	struct string_list *p = &header->prerequisites;
-	struct rev_info revs;
+	struct rev_info revs = { 0 };
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
@@ -216,7 +218,7 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 	if (revs.pending.nr != p->nr)
-		return ret;
+		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
@@ -270,6 +272,8 @@ int verify_bundle(struct repository *r,
 			list_refs(r, 0, NULL);
 		}
 	}
+cleanup:
+	release_revisions(&revs);
 	return ret;
 }
 
-- 
2.35.1.1295.g6b025d3e231

