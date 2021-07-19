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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF346C636C9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFBE610A1
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhGSDvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhGSDvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 23:51:02 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7FC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so5118980otd.7
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+BOdGPj2MHBEqDOUbPZBbwpnKxj/72kveCUuzrnQjI=;
        b=RCl+N/s8AZx/dgHUg2VSrqyN4SXYgeHTNT00hwLdhwd6QoZg7mNbp+EK2poS6PtSdh
         gxSMAgOaUzo8d36OZNXuGefn6sExqkQIOTom0zPL02Pm5nLA3wPQ0s4P92gt8NWh0Y46
         7mAZ5D0YFTCVzn/avORop5Bqn93Ubvy4CfTKPxhVGqrPk4JsmM2g+7je0rePXxscx7J1
         NlxinjyFi6L0mi52EYfDK2dLC8mD2JZlJDK0zQNEpGsmF55Ovv0A6JJf8O9iTqnFijOn
         2Z0E0UBCKvZkIModaRoYEYrjjp5uL4LU/MgDX0udSnlPazm27GvOAjpYR/nH/Bs7yMNR
         oY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+BOdGPj2MHBEqDOUbPZBbwpnKxj/72kveCUuzrnQjI=;
        b=oJqI6+dchkH6AMhO5rgVtN3XaJXi31MSkQxX8gSXe8TOJdp6rCupIaAvLbPKiOsHhx
         vPQpFLk+7LqNReJTMak1z8kpzlJZ+WhuenJJ0w6hWLqq04nkZIuxO26XSsu1ianyg4NX
         JHQFtAPxTfETUOeLQVS/pth+YYOrWRVb87l0MhgY+Se4WXueRaJbkX2AKOLASNDVmweo
         QVyCRGK5GM67hLwzeVIo9yF25z1cIAzv02HURprLr/OMwhKqYE55CbUHGJkCAcVzePF5
         TJL2jZ7GCwbZn/DH2096h4/DLj4aedBpgMgcQyhoQYQwmBfjBcsDJPm5oFgg6kXvWXo+
         FRRA==
X-Gm-Message-State: AOAM533NnTd3XzCqmLG6bza9Uh4EHC74cvZ9TnSMHRYIlKbOLFugTJbS
        TuC5rDGTdTZ/0jFoXOiTKawM3xydvnL5ag==
X-Google-Smtp-Source: ABdhPJy2VSZx7ofs0l2cm0Oh+l1iBrUdDRrB765ZOsLRyRxj7VvT6LZ94elhFUIgTQ2jWSpOXJkilw==
X-Received: by 2002:a9d:630f:: with SMTP id q15mr17757382otk.155.1626666482114;
        Sun, 18 Jul 2021 20:48:02 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g1sm3357584otl.5.2021.07.18.20.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:48:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] push: reorganize get_upstream_ref
Date:   Sun, 18 Jul 2021 22:47:57 -0500
Message-Id: <20210719034758.1288766-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210719034758.1288766-1-felipe.contreras@gmail.com>
References: <20210714164900.606330-1-felipe.contreras@gmail.com>
 <20210719034758.1288766-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying inside the function if there's no upstream branch
configured, return NULL and let the callers do that themselves.

In the next patch we won't always want to die.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e8b10a9b7e..3ee7d6ada1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,16 +185,10 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
+static const char *get_upstream_ref(struct branch *branch)
 {
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
-		die(_("The current branch %s has no upstream branch.\n"
-		    "To push the current branch and set the remote as upstream, use\n"
-		    "\n"
-		    "    git push --set-upstream %s %s\n"),
-		    branch->name,
-		    remote_name,
-		    branch->name);
+		return NULL;
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
@@ -234,7 +228,16 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_SIMPLE:
 		if (!same_remote)
 			break;
-		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+		dst = get_upstream_ref(branch);
+		if (!dst)
+			die(_("The current branch %s has no upstream branch.\n"
+			    "To push the current branch and set the remote as upstream, use\n"
+			    "\n"
+			    "    git push --set-upstream %s %s\n"),
+			    branch->name,
+			    remote->name,
+			    branch->name);
+		if (strcmp(branch->refname, dst))
 			die_push_simple(branch, remote);
 		break;
 
@@ -244,7 +247,15 @@ static void setup_default_push_refspecs(struct remote *remote)
 			      "your current branch '%s', without telling me what to push\n"
 			      "to update which remote branch."),
 			    remote->name, branch->name);
-		dst = get_upstream_ref(branch, remote->name);
+		dst = get_upstream_ref(branch);
+		if (!dst)
+			die(_("The current branch %s has no upstream branch.\n"
+			    "To push the current branch and set the remote as upstream, use\n"
+			    "\n"
+			    "    git push --set-upstream %s %s\n"),
+			    branch->name,
+			    remote->name,
+			    branch->name);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
2.32.0.40.gb9b36f9b52

