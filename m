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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C4C4167B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483A823609
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgLJKGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLJKGY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:06:24 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC9C0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:43 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s2so5145374oij.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBkcYudC5IYbiUK+V0PX4doz+JknEvoGMT+r73ZiJhY=;
        b=UFIGDf2VtjfOMuJfubGjL20zd1Umsulh9oNvkb33zRR6aJcR7nvokiBjxqPHmGinEP
         A1fHp8XI4DJHQ8GXyN9EeNv7/RY7cq/gefI+XFmyGuPCs5+kc4mBz84UaC+ZPAQCaFhp
         ayrFpzftcvByf/yLr62S6cWTmrjwxrCyj4s6GmPkut3/bmWFJIw7OS9N1JFHtXWXK/59
         E6hmfBf/O8+0gnkIsFQDJVlw4u9ljlXeWP0N7HhpvOBxxBMxcLbksWtEIrl3cbeYlK0a
         XYjgyvIpkHtkCGhE7pc1A9LxCaruk93JAM/AraZ7nuLbLa4WuwAxTd0ryAIlUAPDnEYN
         QlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBkcYudC5IYbiUK+V0PX4doz+JknEvoGMT+r73ZiJhY=;
        b=bRXm54hkPtec8RbdmJTTnSFmqVhgB64S8UCcJbkpbvK6MkqLKSGttE8EzOql8kVjGr
         JNmSUIU+betXuXBo6muG8cZ737oN/DrTY6/MHRuUTd5edA8O5m5Ge/7Mki5VBwgrPDib
         TkVW5ve/188fqic57dB6oy1fk8t4zxtX89om+/Z39i3afLcSI3u0x24jZrDXKu8mmNu+
         S6o0RdUb1meT8w04J2g95LC6YzdptZoXNXgrSMvXo7Zrz3vZTEWe6VqSfnSjx2qSRC9h
         iN934MUQbsndgpM4kCTlYF/S3gfVlpnNubsQN9OsusDFlqn+wWKYCQ3mSLrgODG3+6WH
         VsrA==
X-Gm-Message-State: AOAM532ErH8gc61Xu3MTvZ7VthviP4Zzsvqn0XeKiDf4Nr0Ymv9pOhiW
        7OJMEgCzqFSg268QPHdMnaeOtGGg9CXU9g==
X-Google-Smtp-Source: ABdhPJxhojwnsC6qjApwaQo9IwV8MJ9BwadSULeJtC/86bLxS55qtw4h28JWhuUQacxEZTbO2msN0g==
X-Received: by 2002:aca:b1c3:: with SMTP id a186mr4900486oif.8.1607594743040;
        Thu, 10 Dec 2020 02:05:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g5sm984836otq.43.2020.12.10.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:05:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/3] pull: refactor fast-forward check
Date:   Thu, 10 Dec 2020 04:05:36 -0600
Message-Id: <20201210100538.696787-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210100538.696787-1-felipe.contreras@gmail.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's much cleaner this way.

Also, we would like to be able to make this check before the decision to
rebase is made.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index aa56ebcdd0..03e6d53243 100644
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

