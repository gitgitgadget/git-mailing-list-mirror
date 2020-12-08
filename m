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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223AC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DCB23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgLHA1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLHA1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:27:36 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3AC06179C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:56 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 15so6406916oix.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5RrNL3qbISKSNn6BgL5TY0SZIXjZv8UUv/8SSWrHc8=;
        b=BIBi2FwhnWaxBQCzkaKleji8X/rDhnrje+rEix+FlHKowqcdDs2AAiLoX5coRzopZw
         5odTBwCVYzgOqc55qSwThurYammqceoAs3wVIL8kVkc22u7Zw7DduLOmJ8nokCqi+kiK
         iodUD2rRr67MmgRTjoNsgRPt0tSSLGcUTuD/1asvTgUkHosLdLkdPlpW4PQxeVjrPkXm
         Yl9i/ImyBXW2k4gu7ek6lmxjOfkKJhh/fHNrnUMvWUwi883KKAxLXrUYO5SIb98Hx8s+
         00vRgUJBx7kqd10lFO/ixA7KWIpEUSz7BVP7BZuNqtR1MGkLZfRIHOMMugqh8/iUubPN
         iP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5RrNL3qbISKSNn6BgL5TY0SZIXjZv8UUv/8SSWrHc8=;
        b=pXTQcQl22LGGA4QoO6YaKP7rdNLAnUoV8FTeebYPYkIiIWuxD/AIITEHEzxf1f4W58
         ppbsjC9QaVRRKAWMpQaCjXKGIw9d7DJ6vCHVe/1t8OZsF13EF1TjmqDTKITyVIYCctbx
         sXeU4dm6wm4ExRt9jIRocB2mImYBeiXAjJ5p2ZfTADvguWrxmbtDk4C2w+MMQGdJwS+p
         iIA/FmdVrRyAiGX04XbH+O8BWrd2KnqNoyryaPBcg3GWNK4lJtAFVykkKhONaKWuqnlf
         iN+2a1rJBelcOT5WlZ8KjUWIBvsPkw0JZqC6YZrZepDeB5SSQuEtOQabPyHiUST3uzDq
         RHZQ==
X-Gm-Message-State: AOAM530z+Y6a+I7VFBVT2SWCK8FlglzxhXxF8/4+R05KRns4ZKzf7r7h
        oddp/wex+Qe0IOh6BkDUBHvDCc2whrZ8n0KD
X-Google-Smtp-Source: ABdhPJzOqEa+RAZ/NhOv9y2DZbyedQA53NH/2uUCzEHMq6BaQ7CTgCAS/UWpE8G82j9ezlTej9yRag==
X-Received: by 2002:aca:5792:: with SMTP id l140mr845778oib.175.1607387215633;
        Mon, 07 Dec 2020 16:26:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r15sm3034259otk.38.2020.12.07.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:55 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/19] pull: refactor fast-forward check
Date:   Mon,  7 Dec 2020 18:26:32 -0600
Message-Id: <20201208002648.1370414-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
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
index d6e707f8f9..e2964a0b5f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -924,6 +924,20 @@ static int run_rebase(const struct object_id *newbase,
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
@@ -1040,22 +1054,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
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
 			ret = run_rebase(&newbase, &upstream);
-- 
2.29.2

