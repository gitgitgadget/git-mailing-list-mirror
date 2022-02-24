Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E4C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiBXKJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiBXKJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF828AD8A
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h14-20020aa79f4e000000b004f3aa388c1fso1091015pfr.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s/FLsWLRzpv4s8A/gCDPZWY0SRQ54rF476qzo5TKO5Y=;
        b=pmW6ZZvFrHTzJ2Ozh7HteoO76Md/WF+DaWBPeJtbgMkUU4by0SQUakbw30IU/J0+5X
         MIM5rCzu6ucgvbXc5aKARXQTI2sxy4nZehSYmciqoVzgwScd0xW0A/KWdHNsjG8H6mCA
         gqO3c8Cob5VjsolezZuoejJ79f3WjOWOPBkVyQ8fFj6MnBwt4ra1sQpwAC2+301YdtGI
         2YRNJ2V736W7f1clEk3mgY9CZEgvw7WX+J74R1FG45MNivHNoH1agxUhqL6KyXit9cYA
         a4CtRrQD07Uh19UBgNNWiPyDbP/lKDhYwsVFRIdm4y+23n0pCjh0yVzAMjSbWiWpTynn
         6B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s/FLsWLRzpv4s8A/gCDPZWY0SRQ54rF476qzo5TKO5Y=;
        b=ZZytrxQ2scdUZSEQ7eSJLY0klaZF4hp+F2SpLS4mxxH2VvE0O7GILCo6qAMcmGwzpb
         2ZKA0IjPyU3dFKdqQWOGD5pFr1AVACAOEJ4153k+oAuai3szwrk6mz5rlfcafbNxkcsZ
         Pd7betRGnQY3npaJZDCcBnqSoOIh6HqNOxP4xcpdsZehRsdV2Z83l0q82G0MmIojJWvk
         wN5jVnmvQXrVHDzc/lmBq2kT+ErxbM260Y+mIKxXmHV1OEcztJGP5RhgOxD9ovkh6Z6d
         435r12Nlrmt+qTjWgmAzVQTkdaCbIqubvgH+zMWSGfIuFwMY5cwgd03zSQ+T3caWyPVZ
         wWcg==
X-Gm-Message-State: AOAM532/hwxPabv05mW9NDfjvMir6zoHL2T9gjxF6d2AMBhrA2oKgzxQ
        YFfFkx1Rs+p1iNRK+BA+4qvFKyGzws6PYB+SQvEV5R5j5vTttUkz89mXVB5rmVBCRxcTIBjKQDj
        tlznj6xL7o3FeYhVj4ucU6MPF57RMx7qTVb17GFVK9+okB+dKeL79ALKkTTJm5eI=
X-Google-Smtp-Source: ABdhPJxJWy5b0+43hrwodIoIcUfEsMQ/RHs8pw8Vps8j10V88CFLJhNjNfF/4axBfsGKjRx8QF2fj+wLRVeMFw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:71c1:b0:1bc:cb52:ee06 with SMTP
 id m1-20020a17090a71c100b001bccb52ee06mr1464099pjs.232.1645697344352; Thu, 24
 Feb 2022 02:09:04 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:38 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 06/10] submodule: store new submodule commits oid_array in
 a struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit prepares for a future commit that will teach `git fetch
--recurse-submodules` how to fetch submodules that are present in
<gitdir>/modules, but are not populated. To do this, we need to store
more information about the changed submodule so that we can read the
submodule configuration from the superproject commit instead of the
filesystem.

Refactor the changed submodules string_list.util to hold a struct
instead of an oid_array. This struct only holds the new_commits
oid_array for now; more information will be added later.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3bc189cf05..0b9c25f9d3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -806,6 +806,20 @@ static const char *default_name_or_path(const char *path_or_name)
 	return path_or_name;
 }
 
+/*
+ * Holds relevant information for a changed submodule. Used as the .util
+ * member of the changed submodule string_list_item.
+ */
+struct changed_submodule_data {
+	/* The submodule commits that have changed in the rev walk. */
+	struct oid_array new_commits;
+};
+
+static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
+{
+	oid_array_clear(&cs_data->new_commits);
+}
+
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 					  struct diff_options *options,
 					  void *data)
@@ -820,6 +834,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		const struct submodule *submodule;
 		const char *name;
 		struct string_list_item *item;
+		struct changed_submodule_data *cs_data;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -848,9 +863,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 
 		item = string_list_insert(changed, name);
 		if (!item->util)
-			/* NEEDSWORK: should we have oid_array_init()? */
-			item->util = xcalloc(1, sizeof(struct oid_array));
-		oid_array_append(item->util, &p->two->oid);
+			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
+		cs_data = item->util;
+		oid_array_append(&cs_data->new_commits, &p->two->oid);
 	}
 }
 
@@ -897,11 +912,12 @@ static void collect_changed_submodules(struct repository *r,
 	reset_revision_walk();
 }
 
-static void free_submodules_oids(struct string_list *submodules)
+static void free_submodules_data(struct string_list *submodules)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, submodules)
-		oid_array_clear((struct oid_array *) item->util);
+		changed_submodule_data_clear(item->util);
+
 	string_list_clear(submodules, 1);
 }
 
@@ -1074,7 +1090,7 @@ int find_unpushed_submodules(struct repository *r,
 	collect_changed_submodules(r, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1087,11 +1103,11 @@ int find_unpushed_submodules(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_needs_pushing(r, path, commits))
+		if (submodule_needs_pushing(r, path, &cs_data->new_commits))
 			string_list_insert(needs_pushing, path);
 	}
 
-	free_submodules_oids(&submodules);
+	free_submodules_data(&submodules);
 	strvec_clear(&argv);
 
 	return needs_pushing->nr;
@@ -1261,7 +1277,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	collect_changed_submodules(r, changed_submodule_names, &argv);
 
 	for_each_string_list_item(name, changed_submodule_names) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1274,8 +1290,8 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, null_oid(), commits)) {
-			oid_array_clear(commits);
+		if (submodule_has_commits(r, path, null_oid(), &cs_data->new_commits)) {
+			changed_submodule_data_clear(cs_data);
 			*name->string = '\0';
 		}
 	}
@@ -1312,7 +1328,7 @@ int submodule_touches_in_range(struct repository *r,
 
 	strvec_clear(&args);
 
-	free_submodules_oids(&subs);
+	free_submodules_data(&subs);
 	return ret;
 }
 
@@ -1596,7 +1612,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct fetch_task *task = task_cb;
 
 	struct string_list_item *it;
-	struct oid_array *commits;
+	struct changed_submodule_data *cs_data;
 
 	if (!task || !task->sub)
 		BUG("callback cookie bogus");
@@ -1624,14 +1640,14 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 		/* Could be an unchanged submodule, not contained in the list */
 		goto out;
 
-	commits = it->util;
-	oid_array_filter(commits,
+	cs_data = it->util;
+	oid_array_filter(&cs_data->new_commits,
 			 commit_missing_in_sub,
 			 task->repo);
 
 	/* Are there commits we want, but do not exist? */
-	if (commits->nr) {
-		task->commits = commits;
+	if (cs_data->new_commits.nr) {
+		task->commits = &cs_data->new_commits;
 		ALLOC_GROW(spf->oid_fetch_tasks,
 			   spf->oid_fetch_tasks_nr + 1,
 			   spf->oid_fetch_tasks_alloc);
@@ -1689,7 +1705,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	strvec_clear(&spf.args);
 out:
-	free_submodules_oids(&spf.changed_submodule_names);
+	free_submodules_data(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.33.GIT

