Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F925C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658616147D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhGAKyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbhGAKyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E42C0617A8
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r3so4202846wmq.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThP9Pez1hmbWoAaUrC+2tCNmSKRaBB9cDWMlDQkRvoI=;
        b=SNMIdYo6MdqHDDHPF/KKOEoL/IMLSaNvN33ZwQZPkLM/AFx53gocat4rYxJIBSOSh6
         +VwOA7IfjhsHzkOnNHSPPjzDgiGpsJPm1T2oQvZwuIFV1oGDYkCSruT1WWfxrCxgtztH
         +4yxf+C0/eZCNc/wAAL47Oz67XpoaKYiofXXPZhCur2laYqPEBxcjhwZRHeR+bmQiGKs
         0LNINHY+IKv1jZWeCjeFMnX5drvbjGhB4+J8aKUkYj1m0SIjhaVFoOlMNY8sBwoGeYNB
         o0CX35XIqu5GM9jeb5MVU4Njt5jJBcgNM+k0wsooutTpLPHmLhRmTNZyb40b6ncs9Zt1
         KJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThP9Pez1hmbWoAaUrC+2tCNmSKRaBB9cDWMlDQkRvoI=;
        b=pU1LOYpWxRIIcqwepvNixnomRy63a9xr3VK7on/D8FfdBeuENrk4BtvixQsliHR4ec
         FEZIsmqLnwSJnLXBFfJNscVXFv6CNu27d4BJVZ1VJPj+my2S06nvHcBJWIKfPVZjN7g6
         viiFONtXQC4s3lN0wKyDTMkGXAQWr8QKK7cKDZrHWzAiLusCZf1LNCg6ZnMkFNM3ujnN
         LsZQ6d8riGlDGYW00gHoP6LSaYTLuPq2gB87M9Ts8vlItIjKwqnkfeEvTjhusdfcS30Z
         +93kFJLnm5qelp5FicjqiSc0UeaT90t3UylJOFT7cDFvYw5mBl7N5B+hGdErnoCMxyfC
         3Nfw==
X-Gm-Message-State: AOAM5339ZFKVmTO+4L/8cZsQUyHfWp0bn1YS83lYer6fH87AhtLglLOX
        RoSZeJ4RvsUix2sYwtGwdv8MhhrxHGpkMA==
X-Google-Smtp-Source: ABdhPJyXE2bDvjFOlDWolds63xymbbsJMP+h17FHj0fT7bRLbDiw5FkMRA/SB8zSxa9Oio4vkKcygA==
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr9989542wmj.125.1625136697354;
        Thu, 01 Jul 2021 03:51:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] string-list.h users: change to use *_{nodup,dup}()
Date:   Thu,  1 Jul 2021 12:51:29 +0200
Message-Id: <patch-5.5-e6a6557b680-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change all in-tree users of the string_list_init(LIST, BOOL) API to
use string_list_init_{nodup,dup}(LIST) instead.

As noted in the preceding commit let's leave the now-unused
string_list_init() wrapper in-place for any in-flight users, it can be
removed at some later date.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c               | 6 +++---
 archive.c             | 2 +-
 config.c              | 2 +-
 entry.c               | 4 ++--
 merge-ort.c           | 4 ++--
 merge-recursive.c     | 4 ++--
 refs/packed-backend.c | 2 +-
 transport.c           | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index 853d3ed385a..44bc31d6eb5 100644
--- a/apply.c
+++ b/apply.c
@@ -101,9 +101,9 @@ int init_apply_state(struct apply_state *state,
 	state->ws_error_action = warn_on_ws_error;
 	state->ws_ignore_action = ignore_ws_none;
 	state->linenr = 1;
-	string_list_init(&state->fn_table, 0);
-	string_list_init(&state->limit_by_name, 0);
-	string_list_init(&state->symlink_changes, 0);
+	string_list_init_nodup(&state->fn_table);
+	string_list_init_nodup(&state->limit_by_name);
+	string_list_init_nodup(&state->symlink_changes);
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
diff --git a/archive.c b/archive.c
index ff2bb54f622..3c266d1d7bf 100644
--- a/archive.c
+++ b/archive.c
@@ -645,7 +645,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	args.pretty_ctx = &ctx;
 	args.repo = repo;
 	args.prefix = prefix;
-	string_list_init(&args.extra_files, 1);
+	string_list_init_dup(&args.extra_files);
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
 		/*
diff --git a/config.c b/config.c
index f9c400ad306..2edb282b43d 100644
--- a/config.c
+++ b/config.c
@@ -2072,7 +2072,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		e = xmalloc(sizeof(*e));
 		hashmap_entry_init(&e->ent, strhash(key));
 		e->key = xstrdup(key);
-		string_list_init(&e->value_list, 1);
+		string_list_init_dup(&e->value_list);
 		hashmap_add(&cs->config_hash, &e->ent);
 	}
 	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
diff --git a/entry.c b/entry.c
index 711ee0693c7..125fabdbd52 100644
--- a/entry.c
+++ b/entry.c
@@ -143,8 +143,8 @@ void enable_delayed_checkout(struct checkout *state)
 	if (!state->delayed_checkout) {
 		state->delayed_checkout = xmalloc(sizeof(*state->delayed_checkout));
 		state->delayed_checkout->state = CE_CAN_DELAY;
-		string_list_init(&state->delayed_checkout->filters, 0);
-		string_list_init(&state->delayed_checkout->paths, 0);
+		string_list_init_nodup(&state->delayed_checkout->filters);
+		string_list_init_nodup(&state->delayed_checkout->paths);
 	}
 }
 
diff --git a/merge-ort.c b/merge-ort.c
index b954f7184a5..d7ae8d0558f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1836,7 +1836,7 @@ static void compute_collisions(struct strmap *collisions,
 			free(new_path);
 		} else {
 			CALLOC_ARRAY(collision_info, 1);
-			string_list_init(&collision_info->source_files, 0);
+			string_list_init_nodup(&collision_info->source_files);
 			strmap_put(collisions, new_path, collision_info);
 		}
 		string_list_insert(&collision_info->source_files,
@@ -3942,7 +3942,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 */
 	strmap_init_with_options(&opt->priv->paths, NULL, 0);
 	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
-	string_list_init(&opt->priv->paths_to_free, 0);
+	string_list_init_nodup(&opt->priv->paths_to_free);
 
 	/*
 	 * keys & strbufs in output will sometimes need to outlive "paths",
diff --git a/merge-recursive.c b/merge-recursive.c
index d146bb116f7..be473f854be 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -121,7 +121,7 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	entry->dir = directory;
 	entry->non_unique_new_dir = 0;
 	strbuf_init(&entry->new_dir, 0);
-	string_list_init(&entry->possible_new_dirs, 0);
+	string_list_init_nodup(&entry->possible_new_dirs);
 }
 
 struct collision_entry {
@@ -3703,7 +3703,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	}
 
 	CALLOC_ARRAY(opt->priv, 1);
-	string_list_init(&opt->priv->df_conflict_file_set, 1);
+	string_list_init_dup(&opt->priv->df_conflict_file_set);
 	return 0;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db6..5f50def076c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1425,7 +1425,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	 */
 
 	CALLOC_ARRAY(data, 1);
-	string_list_init(&data->updates, 0);
+	string_list_init_nodup(&data->updates);
 
 	transaction->backend_data = data;
 
diff --git a/transport.c b/transport.c
index 50f5830eb6b..25f77ce6ab2 100644
--- a/transport.c
+++ b/transport.c
@@ -1052,7 +1052,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->progress = isatty(2);
-	string_list_init(&ret->pack_lockfiles, 1);
+	string_list_init_dup(&ret->pack_lockfiles);
 
 	if (!remote)
 		BUG("No remote provided to transport_get()");
-- 
2.32.0.623.ge833f40cd87

