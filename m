Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDEEC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F7061100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbhIISsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbhIISsp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:45 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4EEC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630e41000000b002528846c9f2so1733479pgo.12
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gQ4CAY6JSfqC4SP7Uc1+cPdBqMt/HnlNWH5cF3NjiuU=;
        b=j4xLrZF2/DmumC36DRbiNMJRwsCp7GKSUFfApn2RKq7Ammm34oMJYKScsGK5dOZv8m
         Wi72EfKvoXfzo3grsNssipD4zxGsrIkUtz2xhw7OhV9PevfIAekBhDHkcpuGaK8ZChCT
         Iw1E+KB1B8W1Q1GNT72kV+poT7uUG59Pa1xgfwWqWDgJFtFM0PskHVXHaXuROEMlrYJ+
         YdpwWCaTuUYHgE77MUYcKI5sRySnHnC7tK8RaVbxWtKtmR8LCgh/9L8CtPPsqG5r7fjF
         7geocbmIzM4JYD04FIozJkmyaL92SEDg8syCyrovNO8ZHa5/HLcMTA0IW1xFZnR4gAQm
         45rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gQ4CAY6JSfqC4SP7Uc1+cPdBqMt/HnlNWH5cF3NjiuU=;
        b=z++BI12c12Y5QWi1sVPT7lQBzS8ObD2jtAnTP7LWDs3z00dHDUSBLOcUyDMJymllC1
         DJXs4zUxjpRGS+gzA6kjcUhWCGBRJhdsCXK8wtHUlAARBQjdooBaCHoBxXwYZQC9Hbtg
         s7nBiqH/zV292DXQO5gWW0E9RrFiPhPY/2IKFt3fl/ftcHg43YEU8/o5MJJUfKUshUrn
         1M8U+VhB/xKq1oWlOi+xeDikUf1uBxd8KkE6+RVlVe2H+9YBzkc04ukb9RrJgXQeuR3n
         y4sPZbd2C6VJl318oht1vqXWFA/6CvR8DhPAQTB8pBrE9ZI9XRfwmt8JggWQLUPoQHZa
         4MzA==
X-Gm-Message-State: AOAM530nc2O3DZymFXvf+cH5nEQH/CeJnQM2ukXrx8x3fE83w2edWuBT
        6bNzNFr2jzSq6hNgcwBN2TJ7rXC4WKF5yqVAVrfDZTdPBnH/NbMgc/DmCQx8uFsuQ/aE33jgY8R
        OJccanchstPYS+RYI9WBo85Ovlr+euMzEPQPEYNBnhfh/WRj1QsHmA3iFmVJGGC0qe7kpiJoXcB
        Dr
X-Google-Smtp-Source: ABdhPJzKlnw82yDkq5J0w5L7VLhY6/8CIjtIXdqaDb7feHvj8QUmrTbI+he1VXJACOqjVnNz+XNbrJbFN7WnQTvI08Ho
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e749:b0:13a:148d:2d32 with
 SMTP id p9-20020a170902e74900b0013a148d2d32mr3901206plf.51.1631213254835;
 Thu, 09 Sep 2021 11:47:34 -0700 (PDT)
Date:   Thu,  9 Sep 2021 11:47:27 -0700
In-Reply-To: <cover.1631212893.git.jonathantanmy@google.com>
Message-Id: <a71965545d940f57cb82cac925d5c937959ddf64.1631212893.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com> <cover.1631212893.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 1/3] submodule: remove unnecessary unabsorbed fallback
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In get_submodule_repo_for(), there is a fallback code path for the case
in which a submodule has an unabsorbed gitdir. (See the documentation
for "git submodule absorbgitdirs" for more information about absorbed
and unabsorbed gitdirs.) However, this code path is unnecessary, because
such submodules are already handled: when the fetch_task is created in
fetch_task_create(), it will create its own struct submodule with a path
and name, and repo_submodule_init() can handle such a struct.

This fallback was introduced in 26f80ccfc1 ("submodule: migrate
get_next_submodule to use repository structs", 2018-12-05). It was
unnecessary even then, but perhaps it escaped notice because its parent
commit d5498e0871 ("repository: repo_submodule_init to take a submodule
struct", 2018-12-05) was the one that taught repo_submodule_init() to
handle such created structs. Before, it took a path and always checked
.gitmodules, so it truly would have failed if there were no entry in
.gitmodules.

(Note to reviewers: in 26f80ccfc1, the "own struct submodule" I
mentioned is in get_next_submodule(), not fetch_task_create().)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index 8de1aecaeb..3af3da5b5e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1409,19 +1409,8 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	struct repository *ret = xmalloc(sizeof(*ret));
 
 	if (repo_submodule_init(ret, r, sub)) {
-		/*
-		 * No entry in .gitmodules? Technically not a submodule,
-		 * but historically we supported repositories that happen to be
-		 * in-place where a gitlink is. Keep supporting them.
-		 */
-		struct strbuf gitdir = STRBUF_INIT;
-		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
-		if (repo_init(ret, gitdir.buf, NULL)) {
-			strbuf_release(&gitdir);
-			free(ret);
-			return NULL;
-		}
-		strbuf_release(&gitdir);
+		free(ret);
+		return NULL;
 	}
 
 	return ret;
-- 
2.33.0.309.g3052b89438-goog

