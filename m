Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A6C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F1A23122
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgLETyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgLETyB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:01 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC0C061A52
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:21 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id d27so2967352oic.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuazQtJNSs6tffNRzPK8EmqGCGei5rCkO969r89wiak=;
        b=KoUcPmNiojV9NqrpSKnzmjmfByBn889SvujYsrGfB1Zy5d5nM/NZCHBGv6XyF3HQk3
         VENGO3TSdWC+F26qeozoFi9LA8459qOYAWPjhybdgkL58dw+xr7SAb0uIOJUYxFnw/vm
         fTE7dA3vnijuFGY+r6Sz0D2RhrED+xI9JFx4FJiiW0qbm3UNUi8XJSPG7c30UxFig+ca
         A+kKZ2VbKvHCVk2i6d6x+DmTCtHOO6OzCbC+7zCAS1Nj0zVVUQ1n92KsWIyc5iv/ZpXi
         4sS+Db/XV2XHaJtrzHii2kzkEBNydZCL0lQU0VrcI+jWp8otqNTzIlNsJg9/5UCLan6Q
         1GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuazQtJNSs6tffNRzPK8EmqGCGei5rCkO969r89wiak=;
        b=Uj9B5O9ILfpGQIfrPx2hbx4TVoOaqgcyZrOA1LSIcJBhZNofiWJg4Y176Lk2yGVjwv
         QhxJOsV0J106hLiXYIZoUFac3svZNYlgbpkQMrqz0HIFl62w9yoq32t3o6sq7cOlNSsN
         TCz7Q/wnoxGtRSKAt3bWGKXqu6z+Yq5cbmHmLAhU+2XKsBb0fVNGj4iqGuEt2sVA2y+E
         8PuhzgN7tiw9/e9owcP1uXYsgYxENe3iW7rf+TstWj69y35pjm5ug3Oj9ouy3vA8WMzO
         98cEDmX/dgnWsU2y3F2srau7PGDbppkNjdZUoEujD8AQUakNayw/Zrjndcwq0lARTiQF
         IrTg==
X-Gm-Message-State: AOAM530yQ/9UKj050Vg+v8fdbrQZ9stNF0ZAqzp27e5DufqtqI+AgSA9
        wEB9OW03mss2ftrEFIyUsUoUzxwi6pQZMA==
X-Google-Smtp-Source: ABdhPJwTZMzo6Ro5K0Q9CYSUVUG07lOB9QcHeZGfsluLS6sm9bDCv/q2xZca4PDrpIhqBsGQGn69JQ==
X-Received: by 2002:aca:b3c3:: with SMTP id c186mr7053050oif.39.1607198000595;
        Sat, 05 Dec 2020 11:53:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e5sm1504895otl.75.2020.12.05.11.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:20 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/16] pull: refactor fast-forward check
Date:   Sat,  5 Dec 2020 13:53:00 -0600
Message-Id: <20201205195313.1557473-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we will be able to do the check unconditionally (merge or
rebase).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d71344fe28..7a5b343fe2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -907,6 +907,20 @@ static int run_rebase(const struct object_id *curr_head,
 	return ret;
 }
 
+static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_head)
+{
+	int ret;
+	struct commit_list *list = NULL;
+	struct commit *merge_head, *head;
+
+	head = lookup_commit_reference(the_repository, orig_head);
+	commit_list_insert(head, &list);
+	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
+	ret = repo_is_descendant_of(the_repository, merge_head, list);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1017,22 +1031,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
-			struct commit_list *list = NULL;
-			struct commit *merge_head, *head;
-
-			head = lookup_commit_reference(the_repository,
-						       &orig_head);
-			commit_list_insert(head, &list);
-			merge_head = lookup_commit_reference(the_repository,
-							     &merge_heads.oid[0]);
-			if (repo_is_descendant_of(the_repository,
-						  merge_head, list)) {
+			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
 				ret = run_merge();
 			}
-			free_commit_list(list);
 		}
 		if (!ran_ff)
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

