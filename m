Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbiBWR4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbiBWRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86E2736
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j22so14838840wrb.13
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5mG5vvumPmhw2DkdF6cHCjGmFvwG0XBh/NgIZByVDf4=;
        b=YgQNa1lAUn6PFhNHjMjhqdID/xq2607oxQwEV/8GduSjrt7t8GLnp3ymYWf92JzBqZ
         LdD6Ps0tB3Z2Jm6xQhsHZ4Dkuacy0ilosnkDnvYUDQFbIQx4w+wWEq/HV04I5c1aFiK2
         kucpKQou8cWmbjJo+wK4FlSwFx7B8J2hht2q1P97yXOmuIk6MeAYegB6z7qzoM64bLCW
         XTltV8GHSM7K0/hgLCi/zNZGKGkSCleXmSLWZD8XFlQEdTMb5Ubh/+Mpy3IiFK5ueARs
         hh27LFxQLo5G8YHc0Ci5I1Tm2xkT9obg9rVaqO1A+pxbirP61tD/NhmV6nFqz1W24yhn
         LGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5mG5vvumPmhw2DkdF6cHCjGmFvwG0XBh/NgIZByVDf4=;
        b=UEvrH+4uw+Yw4EUxVR5a6SLMvWkmVigDMQRnzSbrKYZLWythkQdGLi0U0Qru/cgx5U
         EQDP2dbpXU4YMaerOioqXzjBuI719aVi0J3bAvC9sGbe4NloVKEd1Ued27vHR0s5D6id
         nCwOr3sa/ERKCTymV52cDUOTzovr3voPSOYo1jPsuCL48yUY/keZepsIO7MK7sC5J6m8
         a7L1/ui4mE6aWOWt+Oxaf3/ARZkjq9kW6k+8EAJiE1OqG88JXwzc9WciZdplctLPgOEP
         RulsMq887B5FyuZ5N6J/L6n9Z9jrsajRkOGuAPQogqtscl0NNXxLFeNzlJF4qcLIDiX3
         GfSw==
X-Gm-Message-State: AOAM532XTz4h5HXK6ErpW5drjdyaELpratn00PqUBvKDcOMA4AZ6l3QA
        BgtE7CEZVweppyUpJfnMVGSSCeEilcE=
X-Google-Smtp-Source: ABdhPJz9I+IdvaR1fVWxULjZqTH+roo2tEmX//sv5Y7QmUSUqAnbUVjRd0qDnJfEX/AuEYg8pUJz4A==
X-Received: by 2002:a5d:550d:0:b0:1ed:c155:6c2a with SMTP id b13-20020a5d550d000000b001edc1556c2amr581475wrv.470.1645638922473;
        Wed, 23 Feb 2022 09:55:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm223825wrn.48.2022.02.23.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:21 -0800 (PST)
Message-Id: <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:10 +0000
Subject: [PATCH 10/11] bundle: create filtered bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change allowed Git to parse bundles with the 'filter'
capability. Now, teach Git to create bundles with this option.

Some rearranging of code is required to get the option parsing in the
correct spot. There are now two reasons why we might need capabilities
(a new hash algorithm or an object filter) so that is pulled out into a
place where we can check both at the same time.

The --filter option is parsed as part of setup_revisions(), but it
expected the --objects flag, too. That flag is somewhat implied by 'git
bundle' because it creates a pack-file walking objects, but there is
also a walk that walks the revision range expecting only commits. Make
this parsing work by setting 'revs.tree_objects' and 'revs.blob_objects'
before the call to setup_revisions().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 56 +++++++++++++++++++++++++++++++++---------
 t/t6020-bundle-misc.sh | 30 ++++++++++++++++++++++
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/bundle.c b/bundle.c
index 2afced4d991..e284ef63062 100644
--- a/bundle.c
+++ b/bundle.c
@@ -334,6 +334,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
 	strvec_pushv(&pack_objects.args, pack_options->v);
+	if (revs->filter)
+		strvec_pushf(&pack_objects.args, "--filter=%s",
+			     list_objects_filter_spec(revs->filter));
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -507,10 +510,38 @@ int create_bundle(struct repository *r, const char *path,
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs, revs_copy;
-	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
+	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
 	int i;
 
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	repo_init_revisions(r, &revs, NULL);
+
+	/*
+	 * Pre-initialize the '--objects' flag so we can parse a
+	 * --filter option successfully.
+	 */
+	revs.tree_objects = revs.blob_objects = 1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	/*
+	 * Reasons to require version 3:
+	 *
+	 * 1. @object-format is required because our hash algorithm is not
+	 *    SHA1.
+	 * 2. @filter is required because we parsed an object filter.
+	 */
+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] ||
+	    revs.filter)
+		min_version = 3;
+
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
+
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
@@ -533,17 +564,14 @@ int create_bundle(struct repository *r, const char *path,
 		write_or_die(bundle_fd, capability, strlen(capability));
 		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
 		write_or_die(bundle_fd, "\n", 1);
-	}
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	repo_init_revisions(r, &revs, NULL);
 
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	if (argc > 1) {
-		error(_("unrecognized argument: %s"), argv[1]);
-		goto err;
+		if (revs.filter) {
+			const char *value = expand_list_objects_filter_spec(revs.filter);
+			capability = "@filter=";
+			write_or_die(bundle_fd, capability, strlen(capability));
+			write_or_die(bundle_fd, value, strlen(value));
+			write_or_die(bundle_fd, "\n", 1);
+		}
 	}
 
 	/* save revs.pending in revs_copy for later use */
@@ -566,6 +594,12 @@ int create_bundle(struct repository *r, const char *path,
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
 
+	/*
+	 * Nullify the filter here, and any object walking. We only care
+	 * about commits and tags here. The revs_copy has the right
+	 * instances of these values.
+	 */
+	revs.filter = NULL;
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6522401617d..39cfefafb65 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -487,4 +487,34 @@ test_expect_success 'unfiltered bundle with --objects' '
 	test_cmp expect actual
 '
 
+for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
+do
+	test_expect_success 'filtered bundle: $filter' '
+		test_when_finished rm -rf .git/objects/pack &&
+		git bundle create partial.bdl \
+			--all \
+			--filter=$filter &&
+
+		git bundle verify partial.bdl >unfiltered &&
+		make_user_friendly_and_stable_output <unfiltered >actual &&
+
+		cat >expect <<-EOF &&
+		The bundle contains these 10 refs:
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		<COMMIT-D> refs/pull/1/head
+		<COMMIT-G> refs/pull/2/head
+		<TAG-1> refs/tags/v1
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		<COMMIT-P> HEAD
+		The bundle uses this filter: $filter
+		The bundle records a complete history.
+		EOF
+		test_cmp expect actual
+	'
+done
+
 test_done
-- 
gitgitgadget

