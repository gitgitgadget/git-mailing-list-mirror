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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3156C64E7D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A31320872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcyJMDz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKYD34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:55 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD9C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:42 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id l10so174790ooh.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BoELlIO2Np/7X0XEhnINPzKgRHlCgI89Vir8ImGdC4=;
        b=EcyJMDz4WXyEsW/88LQgzwuVA0HrvcpJXFUYH/IpQXxeDFm3Fp9fh4Y2VrhEGYssCp
         SnJRbzGJ1jLga2UY9pcSGFck3VMabtRmrExbjeY8n+mag0AZnUpswRjqN1YwlCZgB6yM
         KKJ+kPXRReuCXIeFf63uThPo2jSeD08GxKCihUA82j0seVz5d+srFTnyAc7HEfUhadez
         4OKbNE3GYcBv9N+OYpbeRE3XMw44GMF358yl6X1Kivgkqjz6+Cc75PIq6wKzJVpo0f65
         qvK+H53Qt7WUdzQaRZhK2DtZMa7j5Yv4VoUq22jpt0elLH39JEyx7noOXqdAiOMkmFjx
         Vuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BoELlIO2Np/7X0XEhnINPzKgRHlCgI89Vir8ImGdC4=;
        b=W1cdzSnsGnthfipnwNvj5rABWITbQjdidAZ+5UO7rtWsiX9y2tqG4u7zLqyuZE81sf
         2IlFK0Uj7KH7gVNAxXrZAycAx7xwGV3LhSrUVYes5yOwNTfMymIoCctswq/gnYPbVaSU
         q1gc1IIhxnLZmNQr5EiOUy7IUHe+NRES9twhGAn2JMmb6AvYFPuevGYe8DGx5VZxmqLh
         w7szybcOKhXdzV9rMS4Gv1rhF6BRTqHjO90/ihXqsB27WK/TBHkKkQIHcXrIpNOmRIfL
         NvpjGJ6dpBtkQUuaivfydWxXDjpHC4N1xkD9L7uGL9H4rWsKouTJB9PF2+kPkuYeu1PB
         Hsmw==
X-Gm-Message-State: AOAM533WyjDSIBIM1BXt/4pTij0aSOdkzxomBWGYWsQvaFdnDQbB1IxN
        cndCyFw1poxq6MvbUuoFJzKeoD1a5SNNTQ==
X-Google-Smtp-Source: ABdhPJxCud00f8gR/8Z99kvh+ajRhd6bKoKbWgqG+5my1f9C4MJCpb2QHIN4MTIoyNkVE1FHqBeccQ==
X-Received: by 2002:a4a:5857:: with SMTP id f84mr1303003oob.34.1606274982134;
        Tue, 24 Nov 2020 19:29:42 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s131sm655305oie.58.2020.11.24.19.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 01/10] pull: refactor fast-forward check
Date:   Tue, 24 Nov 2020 21:29:29 -0600
Message-Id: <20201125032938.786393-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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
index 17aa63cd35..e2de0d4c91 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -906,6 +906,20 @@ static int run_rebase(const struct object_id *curr_head,
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
@@ -1016,22 +1030,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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

