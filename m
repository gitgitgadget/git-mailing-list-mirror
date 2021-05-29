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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7588C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EF6613CD
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE2Hql (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE2Hqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF79C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:02 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y76so6675167oia.6
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCouTDpCt8L7n9XOHkRrdCzzkvUp5WY9oXjdA2aguhQ=;
        b=lHkO6P6A00EXwhoNO9EmJOG+CWekMUVTxlIeLXnuT6BJu9/JaOTf+so9yKjhMft9SU
         yugf07E0IT3zXHlZTcY0mntbL0Pv7yLbPs5DJUCtW91LRmYjJEX59gw3X2G6fBtYceVY
         EBNIWbA0G73GSe50+luKTROsop1zFxWCLpHBjUeDjLsqxKnq/Lthmjx074FS+a++fFHY
         sj06pZdqOIcgJ5Jtq3xc9fULzMvzY6WfKXgeBBaCkR+N5sdSaJhtvezuMnnmjBS56CRt
         0OIfrh2u2T1humd1wnHgAV8P1izjch3v/DrbvcLhxup182YHMEpT7pPmxjDQ/JrR1vq+
         NvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCouTDpCt8L7n9XOHkRrdCzzkvUp5WY9oXjdA2aguhQ=;
        b=MQVIezXSC+N81DGwESlDl/ZeWvmNVc/k9QX+FGdjymAduttD+b8noGgan4M3/jJEIW
         QbG59SFQd1H1kvg1ZsIOm5ybFxmMDBOW91jEP79QZcpHNqkYcIgIL0giZIxOmvQNVJAH
         gTkbchWa5BL1Ea9wYswXF4Q/YK8kwU+FSQLQmrO5zTg5fxlK1GuRhWv9NlJFERE4iYXL
         fb1exgChArgtAm1xaZLaVdQq5NqjWPwJn1meL/Ze+cMSDQm0l5qpgCN6q8JXOuCjJGmi
         66QBH8V68eCE8DHC3OmGJHvqpaie5A74mfZ0+7hwFHLOn0bpI/L7alU5yrG7lSUTjn1i
         +vvw==
X-Gm-Message-State: AOAM533nC7l6iKifXMRRSyQesKUpc6/7UxRFoLrcFWWlYdFzkJ6bsrEg
        EelaTggMqrVzO39LdVEtHjQjHHHROOwkiQ==
X-Google-Smtp-Source: ABdhPJxrv5qq2ImAqVO/Y1ynspEq0bfjIv6lT0Q4M+pRhITSF/QpsNI1OgC0t6T9IVJ3SrWmoe813Q==
X-Received: by 2002:aca:410a:: with SMTP id o10mr3174349oia.51.1622274301582;
        Sat, 29 May 2021 00:45:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l20sm1575748oop.3.2021.05.29.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/15] push: create new get_upstream_ref() helper
Date:   Sat, 29 May 2021 02:44:44 -0500
Message-Id: <20210529074458.1916817-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is duplicated among multiple functions.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 0961826269..39a271bb27 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,29 +185,37 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular)
+static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
 		    "    git push --set-upstream %s %s\n"),
 		    branch->name,
-		    remote->name,
+		    remote_name,
 		    branch->name);
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
+
+	return branch->merge[0]->src;
+}
+
+static void setup_push_upstream(struct remote *remote, struct branch *branch,
+				int triangular)
+{
+	const char *upstream_ref;
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+	refspec_appendf(&rs, "%s:%s", branch->refname, upstream_ref);
 }
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
@@ -223,20 +231,12 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		die(_(message_detached_head_die), remote->name);
 
 	if (!triangular) {
-		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
-			die(_("The current branch %s has no upstream branch.\n"
-			    "To push the current branch and set the remote as upstream, use\n"
-			    "\n"
-			    "    git push --set-upstream %s %s\n"),
-			    branch->name,
-			    remote->name,
-			    branch->name);
-		if (branch->merge_nr != 1)
-			die(_("The current branch %s has multiple upstream branches, "
-			    "refusing to push."), branch->name);
+		const char *upstream_ref;
+
+		upstream_ref = get_upstream_ref(branch, remote->name);
 
 		/* Additional safety */
-		if (strcmp(branch->refname, branch->merge[0]->src))
+		if (strcmp(branch->refname, upstream_ref))
 			die_push_simple(branch, remote);
 	}
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
-- 
2.32.0.rc0

