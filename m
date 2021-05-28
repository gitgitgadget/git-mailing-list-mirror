Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A024C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F7613E3
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhE1UM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhE1UML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AEFC06138A
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so4658362oto.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g04W9JY/JOahuUPsiWb8TZbbZe6QH2TGw+zH4m6yw5I=;
        b=Dk7Q4+VKAiOIT8KkUt0cgVHmu78zTQ2mYesF6rMiujExxBCRJ76us3/b1FdjtZwA+7
         3AgOsoqsCLFMvuKFFCRGdhMiGKPtqaYnvqNDyC41o3LeweQG4UDPTmcTwhh1EEjxAYM4
         TpEibERi1qbM3dvOwLtGR5ivXwL0MuZAfHfKHeNDDpFEAKLz9tgZigqy4xFinhWaWrXI
         bnapqjnKBEK7PYPoAFPn/gXQYq88QTEnQZuPEgW/mctqwmhs2Mb6MQuIr3akw+1iErcv
         ml5EWFZ13INEHURjpvweOulFygkOXk3qkTDhXhrIXuj6nmRm9RM+bL+4bbXS3YDsf036
         RlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g04W9JY/JOahuUPsiWb8TZbbZe6QH2TGw+zH4m6yw5I=;
        b=O4Cdk1/8M2AuBz89sh+pCYhKdS+4ZJFLGMr40L0GyzUBcjbviNSIE7IBW8uiEmeuLM
         1GsRjDAkRWIdMLhDGFobgY37vAyiApniXYHAtUrDy44Q+czPTW5sYovFJgC/MdIWTNfi
         nDB9ihED0ejjARiyixUD/u8q+RogRZemYpHErYOclwQw8UvCKTwJUTBWbjEvRjtiGsmw
         t74LKR9EAVSRl2v56kY2KOs+YdIFz1JS4Y062iaQ7nxERZBb0rbud+ERIMNLdVACyZmF
         eZiD28rzItPUSbii46DJkXPQx5uTrXT9i6t55A6aO3YUk0T3kgqaCjSX8VizcczR3Gq/
         Ts3Q==
X-Gm-Message-State: AOAM5303ESm1ydlzdJLI4TKvshUfhZdRWtsYIvmTtD6zaZGDf7PFLC1b
        qrpCjPrc4yEPCMK2bEwzJLAF3c1GLjEeLw==
X-Google-Smtp-Source: ABdhPJypYvSOw7JFAKzWbNWLhNMtqCUnVN8mZR7x/VP5Wpv2Wn9lK8tFLVBwH7yrm17Y3aPol9Lw5Q==
X-Received: by 2002:a9d:bd7:: with SMTP id 81mr8466767oth.133.1622232632009;
        Fri, 28 May 2021 13:10:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a14sm1331778otl.52.2021.05.28.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/11] push: flip !triangular for centralized
Date:   Fri, 28 May 2021 15:10:13 -0500
Message-Id: <20210528201014.2175179-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is a *distributed* version control system, centralized workflows are
the uncommon case, where we do need to do extra checks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8ecfbe8d63..1856f62861 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular)
+				int centralized)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
@@ -201,7 +201,7 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (triangular)
+	if (!centralized)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
@@ -210,12 +210,12 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }
 
-static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
+static void setup_push_simple(struct remote *remote, struct branch *branch, int centralized)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-	if (!triangular) {
+	if (centralized) {
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -238,7 +238,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
-	int triangular = remote != remote_get(NULL);
+	int centralized = remote == remote_get(NULL);
 
 	switch (push_default) {
 	default:
@@ -248,15 +248,15 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_simple(remote, branch, triangular);
+		setup_push_simple(remote, branch, centralized);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular);
+		setup_push_upstream(remote, branch, centralized);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_simple(remote, branch, 1);
+		setup_push_simple(remote, branch, 0);
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
-- 
2.32.0.rc0

