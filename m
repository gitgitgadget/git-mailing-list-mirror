Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6EC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A638161263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhEaTe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhEaTe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:26 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364D5C06174A
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso5071422otu.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNW1CO3yTysZoyRYWMhyqqzDakdJbw5uPmBrNjCnOY8=;
        b=sEDbUL7ZLNEwvId9wRaIwldk02rb+T/7h3WwCjjCbDmaB8yaguI5dZAWkajc6k71nx
         zTq4AMsYNBG3mmc97SInNcxdgHsn3uA7A6J5d6ssju0dCiF4akomc9kHy5v9YPABn07q
         DDNCvywWC4+0For5trZ+YUsyPVBGdfSs+goWLnxu42a8aDw5zyr0LuDo+5E4atEZoZkE
         xrhhuYdaL22RZJrH/dIIHHjBqem+HR5n1ZoyYk364bKElRXFIOtt20hWf30rSOvIdJiB
         sYuAnz/E55S4TP2BEn0USoP6BoKpTffY/WMTPW1s8KPp568eB/TXj0sWJY6zrHjOn5Fp
         Cztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNW1CO3yTysZoyRYWMhyqqzDakdJbw5uPmBrNjCnOY8=;
        b=Fn93OKm98/OuC9IG1z3GoDO2tL4VU4m/+j/VV+gpk4tXS4wXsKDN7tVvFNSayaQjhQ
         wkNqI2XJWuIleGMp5X8Hzc9dzMnfujuNrMnbWDsAdPAO2ApHrbuQoNrfPoKJIb/QF5j6
         e0H2FIvHE1xISjhPcL5flmnblSFMLz5uvXv7OEIiMYB561r0PooOVaX1kat8DncZpbPi
         xsRJKC3ArIVKd87S2CnQg7xarsmNDJdRMx55PzY5bBbzXxSd+FoAIhmM06AGYN1XS0dY
         hqjBh4OLi2QkRuzop+0kp8hXF1Xf/Oy7zN5GA0C6/9dM2yzQqIcIqaXhVt2zaenNOXzf
         xSnw==
X-Gm-Message-State: AOAM531AgJZgj+MNu3hcvF7/GwT1QAPoImzaQy4Y11gNU2+6oo7vIIvR
        K+iovp6t0DvSwZDrNt5U1cpPjU24VUcajA==
X-Google-Smtp-Source: ABdhPJx3TY021C93dg9pmlHqwGJ18R7zB0mHTxmno0efRpiNZTSNv8UwmWSGcZdF+VREwf/8GCsEmA==
X-Received: by 2002:a05:6830:244e:: with SMTP id x14mr19068797otr.138.1622489563315;
        Mon, 31 May 2021 12:32:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a5sm3478412otb.41.2021.05.31.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/7] push: rename !triangular to same_remote
Date:   Mon, 31 May 2021 14:32:31 -0500
Message-Id: <20210531193237.216726-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The typical case is what git was designed for: distributed remotes.

It's only the atypical case--fetching and pushing to the same
remote--that we need to keep an eye on.

No functional changes.

Liked-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 194967ed79..06406353ce 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular, int simple)
+				int same_remote, int simple)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
@@ -201,7 +201,7 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (triangular)
+	if (!same_remote)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
@@ -223,16 +223,16 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
-static int is_workflow_triangular(struct remote *remote)
+static int is_same_remote(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
-	return (fetch_remote && fetch_remote != remote);
+	return (!fetch_remote || fetch_remote == remote);
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
-	int triangular = is_workflow_triangular(remote);
+	int same_remote = is_same_remote(remote);
 
 	switch (push_default) {
 	default:
@@ -242,14 +242,14 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (triangular)
+		if (!same_remote)
 			setup_push_current(remote, branch);
 		else
-			setup_push_upstream(remote, branch, triangular, 1);
+			setup_push_upstream(remote, branch, same_remote, 1);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular, 0);
+		setup_push_upstream(remote, branch, same_remote, 0);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
2.32.0.rc0

