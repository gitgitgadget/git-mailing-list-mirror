Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA4C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiBORYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiBORYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636BD997C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso13464935pjz.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmghuhzjuIPy5ZcOGB9ii1Itvf2r+QNug7p5xRGRrv8=;
        b=Lp4kipL5bw9GFGwpd//aK2aXWj01pfYyGvPAQxot4EcoXYH2B+v8p4+MpB0D68Sa3A
         QJLoxStZfusLuKjwM97/6vaL4ljd2IFuteP+/RIC6pcuy94vaRUA0QS/E8WnOcdIfC8j
         L9buBSqqvIoHZhB6sJoU9UmI7lAYY3mCPXOaXmvGBvzZL6OIKNLAcQ0NVnWriJ9xH8G3
         s7RYhM9NUL3mKhQIsMvzMpRwkqLYGDrqa3NGwzqdd6bdpDw8uSoV+pFCXqAxO3DMu65d
         EHaFAVSxRcrH4Mq1IwDSEeYaxBC2cd3ERkkMF+lvY99SVgzwRK8/Cf1SDCWOKBm+NAsN
         uTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmghuhzjuIPy5ZcOGB9ii1Itvf2r+QNug7p5xRGRrv8=;
        b=z2k0xtb18PZ6ad7PGtzAjVI6be6rWtClMAr/s3wXtD1w+Ev1YNiTa7qGJJWvVbSh4k
         lPQGTNuWLgl6PsXwmKPAnannB95RTXHVZIzeTAYwwSF8lfkRpZMbaXhFM+60Rf77rfW4
         T47zuAmGTbZ4Zz/WXCiF/tc+h4t0H2OOS7xUZ4mky1BCXSpv4ZgFGHVsEigUgWV22abv
         zUGQWcaTrqdkfVxr/jOIp8LuBsQUJDvYHdhKX6KM8aW85dlo1IdnaXMFCQ9rgGxvXAL4
         VfQIyWyf362COO6dCGucUHOFSfGLujfx6GohmPMDipv6nNf8qAPyr3D/MRcuoerON5+G
         uOXg==
X-Gm-Message-State: AOAM531JQ1Ohkgy4vzNdsdoRzVJIgGMh6mFXIw0v2+Kv7f2c1WR5gGly
        EQhoQ05c5tQ1RvWZNZBIfClbRhgeGJIrdhfUn92heb06jLkEs/sggUQGlT9sZaQQVY2BX3SYdau
        WjZd8H4T3P77eLX0++tqRaRR/A0f5iff9iNVV4DPZztn4zvt5+AlRXqkkIiREI6c=
X-Google-Smtp-Source: ABdhPJwf8kpnpGzV5qBYqpRoFkfY15aaLEuW+gg0Uius2eGqvYxAqK7ihAlcsBnjnd+AlEb2RuXT7kakZfJzPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e616:: with SMTP id
 j22mr5461858pjy.45.1644945838031; Tue, 15 Feb 2022 09:23:58 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:14 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 5/9] submodule: store new submodule commits oid_array in a struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
 submodule.c | 54 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7fdf7793fb..5b1aa3fbe8 100644
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
-	for_each_string_list_item(item, submodules)
-		oid_array_clear((struct oid_array *) item->util);
+	for_each_string_list_item(item, submodules) {
+		changed_submodule_data_clear(item->util);
+	}
 	string_list_clear(submodules, 1);
 }
 
@@ -1069,7 +1085,7 @@ int find_unpushed_submodules(struct repository *r,
 	collect_changed_submodules(r, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1082,11 +1098,11 @@ int find_unpushed_submodules(struct repository *r,
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
@@ -1256,7 +1272,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	collect_changed_submodules(r, changed_submodule_names, &argv);
 
 	for_each_string_list_item(name, changed_submodule_names) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1269,8 +1285,8 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, null_oid(), commits)) {
-			oid_array_clear(commits);
+		if (submodule_has_commits(r, path, null_oid(), &cs_data->new_commits)) {
+			changed_submodule_data_clear(cs_data);
 			*name->string = '\0';
 		}
 	}
@@ -1307,7 +1323,7 @@ int submodule_touches_in_range(struct repository *r,
 
 	strvec_clear(&args);
 
-	free_submodules_oids(&subs);
+	free_submodules_data(&subs);
 	return ret;
 }
 
@@ -1591,7 +1607,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct fetch_task *task = task_cb;
 
 	struct string_list_item *it;
-	struct oid_array *commits;
+	struct changed_submodule_data *cs_data;
 
 	if (!task || !task->sub)
 		BUG("callback cookie bogus");
@@ -1619,14 +1635,14 @@ static int fetch_finish(int retvalue, struct strbuf *err,
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
@@ -1684,7 +1700,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	strvec_clear(&spf.args);
 out:
-	free_submodules_oids(&spf.changed_submodule_names);
+	free_submodules_data(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.33.GIT

