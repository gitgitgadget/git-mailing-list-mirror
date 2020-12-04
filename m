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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40BC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8992622583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgLDGRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:11 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F5C061A53
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:31 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f12so4186056oto.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlxduxWQ2zYB6MQdSxkaIOFRjry5hQNNrUCA0ESi3Vw=;
        b=g8ukK7YDOfRnGXDCeL94H1pmAVHmRfRi/0EC2RlpNzeYqVGLlOS8DrJ3SlYdCOx/TR
         sg2U4uomGCauKJiz2Vm9OwbRvxFC1L4vUIsg0Q+9FXzHyfbNCoAl5EMcoKHb2vSOlcIg
         X3SHMxZof4QJGeyRkfGQ3sczkr2bcCmB0PvyPQ9JYcR6lJXX+AsBSlcXPDrKMI7vfQZG
         lxwa+hqK7oyLZC5v2cePfTmjyDjutBnxiN+3qUz73gqK21tCuR94neYvell/S5tgFO8j
         JIXZZB70p0lh+rewvuDRSAJUm4X5a/rMCtXAuoepBLVZVOhmK8xh/lG/YODzf+L6+zFM
         QgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlxduxWQ2zYB6MQdSxkaIOFRjry5hQNNrUCA0ESi3Vw=;
        b=Mxnl+vHBzbenmDRVXIP1rWzxEBKKou3fWEtG2CAU/AC4aPV3P82qduGqafvXBZ8Zt6
         e1O6DHhRkWfTrhzokfhFD/hS2Fc5Mzf/RhUjf/qngXiEGtdlEPorM4DAT+plLLr4EqLE
         r8HaGypYzssfzHQfrrlWF5fTrp9GeBByODjBRXpa89ivGfDryQl4mOIfT55PkWQQbumY
         tiFtzRDQHa1LsB8fxvBdcWM1XhKRrDOi+rIWlBYMQmOtyXYSVpKc26QY6orehoSW/36q
         Q739LXcBrJz7qfGV8bEqhrjNTJ3UuOloaqOgXmKNdWtRER25TRYI61E7+fmn+aw7iMLj
         QkBw==
X-Gm-Message-State: AOAM532S+4PcRlB0wAoLaUF7xzLTtwMBigtJMG8StHRjtS0MUJLXCQEs
        H/nWb/LxXykUFjbZgrHcMpzIjlVwm8q/yQ==
X-Google-Smtp-Source: ABdhPJxbcN9L9YYIWY3vFK/Pa0kAd1dcCQRP0NpdRzKAFICoLLKZS2KwFacgc7toSyUEbRyFVB2jog==
X-Received: by 2002:a9d:3a24:: with SMTP id j33mr2419919otc.259.1607062590505;
        Thu, 03 Dec 2020 22:16:30 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p3sm442050otf.3.2020.12.03.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:29 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/14] pull: refactor fast-forward check
Date:   Fri,  4 Dec 2020 00:16:12 -0600
Message-Id: <20201204061623.1170745-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
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
index 22a9ffcade..6279e9ee37 100644
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

