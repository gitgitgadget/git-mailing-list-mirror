Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiCWUeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344713AbiCWUeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEA8C7FC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so3750420wrc.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DujuV37yP5xt7uGsZVUQKTrBVjSeRWX7fRJ3PzQuyo8=;
        b=BPOZi1TnONzhHeV4NMdADTPdkvZslrK1PLyLLPHuv5ezP8yos7byrQJqrQcuOt86qE
         0veRPf8k9VKeatC/0vgy8xPw3QSkdVQWu4cYCwZndE0UBTKYuAfDl1LX7gK+YSA/SlAS
         2/lnRtWmH0GyPFm3YVQWer4C8YOx1WGEXU4bdmjTmpk3QUGME+/9bLWN0z5aZh4JDL1X
         23aTl4BYMaSf9kfN+hwAsX3RTHE37Kb8h//DE1fiy2H62xbMUlT4aYfYmWLTNjReE+xm
         31xrnulEKxWhM7RidT58z+bZk6XgS7clYIthbJ3LBQYbwudAZlYqlYatIHsHM/9a9E28
         oDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DujuV37yP5xt7uGsZVUQKTrBVjSeRWX7fRJ3PzQuyo8=;
        b=Mi9oM9ziYE6PyGpZk8NnGMWjbmrKHxcisd6uSsvkuIqhv+yIlI/4Sqg5Y/yXdRqa/r
         POdbybANGHescDi1BvORE25L5Ja29Esbq3BNVINIRv3BJeLx/rM2yiT7NrspzIPHIwLs
         gVT8ypidqs5rDoZSjjwJ0/PuM1pR50zxQHv45Wudd53gLVaxtP093Wxk50KRRLo2/WcT
         WQLA0sYw2Poh8/JvKZT4Es3+X6QjuofkTZe3DA9pxhwNTNBmVX5F4vzCP+1EroQcI1lP
         8/kI1JT7zkkTJaT0mz9/E1Cog+TAdulyx0pLkgpi/Xnf8PgJsYvUOnlj+VO4jSKUHUvV
         JQAw==
X-Gm-Message-State: AOAM533aR6I8D4X7uEECjwaGfx5aPJNtNXmuNOUXPZXN8ZcwbaP7tes8
        L+sF0FHb0UnvKc2ZrcWQCpTkqjnPYS53bQ==
X-Google-Smtp-Source: ABdhPJyGAacovhSf+Zqpx9xiYDSYCb3sSOnnx6NLuFl8neHaMeAurg872dmMFQt7tMA7Rx/hxyKrOA==
X-Received: by 2002:a05:6000:1561:b0:204:1ba3:3b8b with SMTP id 1-20020a056000156100b002041ba33b8bmr1468213wrz.325.1648067553812;
        Wed, 23 Mar 2022 13:32:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:33 -0700 (PDT)
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
Subject: [PATCH v2 08/27] revisions API users: use release_revisions() needing "{ 0 }" init
Date:   Wed, 23 Mar 2022 21:31:58 +0100
Message-Id: <patch-v2-08.27-42ad1208934-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
index 0eeced8a10d..e8e20cdcc53 100644
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
index e359370cfcd..a83d253a815 100644
--- a/bundle.c
+++ b/bundle.c
@@ -196,14 +196,16 @@ int verify_bundle(struct repository *r,
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
@@ -221,7 +223,7 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 	if (revs.pending.nr != p->nr)
-		return ret;
+		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
@@ -283,6 +285,8 @@ int verify_bundle(struct repository *r,
 			list_refs(r, 0, NULL);
 		}
 	}
+cleanup:
+	release_revisions(&revs);
 	return ret;
 }
 
-- 
2.35.1.1452.ga7cfc89151f

