Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8684CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiBXKJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiBXKJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B14828A10F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:09 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090a8d0e00b001bc72e5c3ecso1074990pjo.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hbJoHdJ2QZDbI2dDWLG+p2K6A0OlB+xDeYUBgmECRtc=;
        b=hig8n+l0c1PFHk3S+W9iMj3rEYM5SAlRFhtQzbr/n+MckSoZoiOI5m7f59zFDe6KbV
         0oGIri9NIsODDN1TFJJB7PtHUpi1znmI3O4B7HfGY6IGqoIQxak6TzpjdhV5EVPW54A9
         NTWD1sL/zPaOwV+Rs6aTwiAcwSgDG9EScDnHONaOcueu+c7hZMoEyCgvSO4CvItlhrYP
         92gjzxWATCeiwFH45v28iZ/39GCm48IC5uWZs27u1CEY02OnjerO6hmvCfZP1hPJpEZc
         qOvuvRRQAu0LaalZByCLf4Ct5eBZA+Sdu9YRLswcN8rCWOa9h4r/wCOWdeGH9waFNYm8
         hWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hbJoHdJ2QZDbI2dDWLG+p2K6A0OlB+xDeYUBgmECRtc=;
        b=oANMMdNVWJ0efl54Nl2jvLduDCJFVbEHydRActQdsFdZlEBtr2i/tRjChwq5LqM623
         4Za00O4ln5iZNDhfAV2yMwZiOXmtxAomujGZWRh5SNkHOdJ8OiA9zcHNdEw/kg01AEUH
         iiogCUaU8gYPPRUXVtCes2zfOvUGDAleHumCAJdNSxyFkiXRS7cBavJz0jo8xD5JQg3G
         GxIBZ1AvWHP8w7hPwaLNlKfKb2JroI6NTeJezFisCo9U1yQq4gtkmC73+1LoGeSiupWf
         9ljBedPbMXkJAiJKeI33lhXgxBqO5+wXWb9BIviICPPzZ4sCPhNrGr+4om0bOADOqeJy
         jufQ==
X-Gm-Message-State: AOAM531VWkSbGseehIZyQ13IZZejh9A60XaW7DffpbwDR3ycW5QKpc+F
        cVivAAlAy+EKsWCF+7CR8BSl7jmxnXqpKpTjPGFAWG0qqHf+CkD10XKiS2Pw+33I8oXGCQeH8NG
        9tOeaOURSu0/igcGjXB5O0hUyx4lHwuR/iRD1cmo0WIQ9FW21lPmng2KoWHcThG4=
X-Google-Smtp-Source: ABdhPJxk0AsCNZm1u5RRN5mEPalZme/S7Ph32vrQnhNwsxWn5BqpbspL36SmebCgkiqf1WAtI9vXPl4xXCgrng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP
 id j16-20020a056a00131000b004cacc4620c7mr1926795pfu.44.1645697348547; Thu, 24
 Feb 2022 02:09:08 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:40 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 08/10] submodule: move logic into fetch_task_create()
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

get_fetch_task() gets a fetch task by iterating the index; a future
commit will introduce a similar function, get_fetch_task_from_changed(),
that gets a fetch task from the list of changed submodules. Both
functions are similar in that they need to:

* create a fetch task
* initialize the submodule repo for the fetch task
* determine the default recursion mode

Move all of this logic into fetch_task_create() so that it is no longer
split between fetch_task_create() and get_fetch_task(). This will make
it easier to share code with get_fetch_task_from_changed().

Signed-off-by: Glen Choo <chooglen@google.com>
---
I think this patch could be squashed into the previous one, let me know
if this is a good idea.

 submodule.c | 99 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/submodule.c b/submodule.c
index 988757002a..03af223aba 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1415,32 +1415,6 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
 	return (const struct submodule *) ret;
 }
 
-static struct fetch_task *fetch_task_create(struct repository *r,
-					    const char *path,
-					    const struct object_id *treeish_name)
-{
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
-
-	task->sub = submodule_from_path(r, treeish_name, path);
-	if (!task->sub) {
-		/*
-		 * No entry in .gitmodules? Technically not a submodule,
-		 * but historically we supported repositories that happen to be
-		 * in-place where a gitlink is. Keep supporting them.
-		 */
-		task->sub = get_non_gitmodules_submodule(path);
-		if (!task->sub) {
-			free(task);
-			return NULL;
-		}
-
-		task->free_sub = 1;
-	}
-
-	return task;
-}
-
 static void fetch_task_release(struct fetch_task *p)
 {
 	if (p->free_sub)
@@ -1467,6 +1441,57 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	return ret;
 }
 
+static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf,
+					    const char *path,
+					    const struct object_id *treeish_name)
+{
+	struct fetch_task *task = xmalloc(sizeof(*task));
+	memset(task, 0, sizeof(*task));
+
+	task->sub = submodule_from_path(spf->r, treeish_name, path);
+
+	if (!task->sub) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		task->sub = get_non_gitmodules_submodule(path);
+		if (!task->sub)
+			goto cleanup;
+
+		task->free_sub = 1;
+	}
+
+	switch (get_fetch_recurse_config(task->sub, spf))
+	{
+	default:
+	case RECURSE_SUBMODULES_DEFAULT:
+	case RECURSE_SUBMODULES_ON_DEMAND:
+		if (!task->sub ||
+			!string_list_lookup(
+				&spf->changed_submodule_names,
+				task->sub->name))
+			goto cleanup;
+		task->default_argv = "on-demand";
+		break;
+	case RECURSE_SUBMODULES_ON:
+		task->default_argv = "yes";
+		break;
+	case RECURSE_SUBMODULES_OFF:
+		goto cleanup;
+	}
+
+	task->repo = get_submodule_repo_for(spf->r, path, treeish_name);
+
+	return task;
+
+ cleanup:
+	fetch_task_release(task);
+	free(task);
+	return NULL;
+}
+
 static struct fetch_task *
 get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 {
@@ -1477,30 +1502,10 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name, null_oid());
+		task = fetch_task_create(spf, ce->name, null_oid());
 		if (!task)
 			continue;
 
-		switch (get_fetch_recurse_config(task->sub, spf))
-		{
-		default:
-		case RECURSE_SUBMODULES_DEFAULT:
-		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!task->sub ||
-			    !string_list_lookup(
-					&spf->changed_submodule_names,
-					task->sub->name))
-				continue;
-			task->default_argv = "on-demand";
-			break;
-		case RECURSE_SUBMODULES_ON:
-			task->default_argv = "yes";
-			break;
-		case RECURSE_SUBMODULES_OFF:
-			continue;
-		}
-
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
-- 
2.33.GIT

