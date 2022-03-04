Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40234C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiCDA7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiCDA7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:11 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2A13775D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:18 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n135-20020a628f8d000000b004e16d5bdcdbso4083258pfd.20
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s/FLsWLRzpv4s8A/gCDPZWY0SRQ54rF476qzo5TKO5Y=;
        b=qOLri9Vll53yCv/GS8jw6ThOY6yDK1oeAt8IUe0FL2zpvnoUd6AYAXaXLhx4ny0ooc
         vdwC+Ej3lRrIBJhza8/UDY39TCG1i/Yu9K9Y/Vi9EV4E/2uI8gnt+76AZpr8eGXJcytA
         AKXuQl4qt691BqTgq/AXBOPvNQ3ZRdSFVUyb4CdmYlI5BZ6fP7fEi48Slxvurcc3dIGb
         SiTjpCuZpUev6ETYeYJSVnTRiOpQNnrHzfIL4jp/UpK/++LLB8L9Y/vopCTHtQoKaQtb
         KNrxNYGu5XRfJ3wPtgu9nlOYyG29JbJfMbO2OkrcVROl+rXL978GHHUMHw7wpwS00qFC
         /xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s/FLsWLRzpv4s8A/gCDPZWY0SRQ54rF476qzo5TKO5Y=;
        b=DKXiw78ytkCvBFtyB85YnQE0775mMsmluNiDoYqx22yG26eZ6mKCXRH+L3UCMTtz0w
         eQlDz0JVW4PdgFoRx7ycemc+PON2EdrzoYNevMY0V6JLy3B9YUQ2om47ElKmfPT+9Bsl
         hvV1cVmkbj5bcqYyQLM63h8YEhjTDZnBK+YQKlAdLSA9Z/nqYl46+vChMl1zjAZb63Lp
         DudOHc8bn6mFomyUJtlWZk9UtGWLJtVDY6oowCrKUP6QQyhGHK2g9tBxDaadQhQSSf2u
         UxIYQGBZwcRq+6sHUqN4VhrCTtBVWlnWAGpZBqTEPVX0j91bnBIu6ykTkBiePyu4FU31
         1M1Q==
X-Gm-Message-State: AOAM531Eu4w3qvx7ON+rh6ahYj1c+N4rhMb8TPD60EUujmo2sV4sqvM3
        +eTuPGIQq4BLkS50EDpJCkVCWz/f2jJCxcvA1vZmF2V4TAJ0Xukj4oqV7wkHyJb/5UUyBDcDIJb
        iCYhCMlSlzUbkHoiaLOHUuVEtu7GtjfDr4YvXkcUPQgTHm4pkaAgS7A+a41s4iN8=
X-Google-Smtp-Source: ABdhPJyQSRIxGq5x7rJ+aVm/m43nyKhQvQA182P2VZo0q9CsR43svBEB1kmfF7gcs6BRakEzDbn+fULlzMEwGw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6bc1:b0:14a:c390:a44b with SMTP
 id m1-20020a1709026bc100b0014ac390a44bmr40228056plt.11.1646355497658; Thu, 03
 Mar 2022 16:58:17 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:53 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 06/10] submodule: store new submodule commits oid_array in
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

