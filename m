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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FBCC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE93613B5
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhE1UMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhE1UL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:11:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D9C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso4595219otu.10
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4Pp7knWGKefDcDmCwRKPGBRc/O3oKMdEFwnvw+he10=;
        b=QVcEwjbTnLzalKC88kuE6qe5VakCdQWQm7iwS80tzi5QycXIMRnJMSxKfS4hP6hFlG
         FcPkQzmmr6tM+GV9kRAUgf787zhphU8qLDjEk7r3w+cBv1o5mZa08WCJThl8ZteTZp0L
         w+i78SMT6cR8p/U2NDQOgABDpikvD+9zsJMO2n5wHppLJVxYU2ISqQmDi0zybRuMPw9F
         i3ePgk5c9p2gNnHOzOeXrgwUptbkyiqw7suzUzzXcLL+qTtjxI+kXnVABSKfuqGSXNzB
         slUE4ux8MkI+4rKJFNbi5/6hcbqfmz5oGlBhtY4jXmqnM9mFBPFGfOOdYos2ssCmo8+y
         PF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Pp7knWGKefDcDmCwRKPGBRc/O3oKMdEFwnvw+he10=;
        b=Co6f8mh+UHggBzm4PHd8D0YFKPgMx5n/FOjAxHC0fpIyZCgQz6wIkxmtYKoBjkfVhW
         +bMVoyTr0CxPUqngYzIIdw9ujqHy+B5RLhrmjf0TBtuVumm93++Z3jLy9qx2U4RMfDkl
         gA4403XmaZgQS3LAE7J7tTCy2sx/5GjgZZLlDt66AZxYwds7FqiqI+HhcAOUUjxa3pAl
         MXEBtVQyA2/cHaTZzS/agAWdFiTO+LieJpBxLmVxSBL88Qe+h1sHT9f1BShED5lwX0r+
         VTqmdFZBZZsF9lQD/2obuRB9UVPudBlDM1vtimq1xFnQYUOtb3p9p0CNxDGchQT2Y2SN
         /6/w==
X-Gm-Message-State: AOAM533bw6donTsqKMzVzWUgMo4P4aQ8ggS+ZdeqrY5Z+ka3fDe1rrxG
        7js1CSQ4WffyzwoCkxvYcjHMsIC1FGa8qQ==
X-Google-Smtp-Source: ABdhPJwqqfZrZ/PQa3IZ/lvbKnTfiPKZnwc9tyys94kf9y7XEt0cwUtltfLGN9lbdElSseWNFEJoCg==
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr8680939otq.66.1622232621259;
        Fri, 28 May 2021 13:10:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x9sm1318838oto.79.2021.05.28.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:20 -0700 (PDT)
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
Subject: [PATCH 03/11] push: reorganize setup_push_simple()
Date:   Fri, 28 May 2021 15:10:06 -0500
Message-Id: <20210528201014.2175179-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simply move the code around.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d173c39283..9c807ed707 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,13 +225,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
+	const char *dst;
+
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+
 	if (triangular) {
-		if (!branch)
-			die(_(message_detached_head_die), remote->name);
-		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+		dst = branch->refname;
 	} else {
-		if (!branch)
-			die(_(message_detached_head_die), remote->name);
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -243,20 +244,14 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		if (branch->merge_nr != 1)
 			die(_("The current branch %s has multiple upstream branches, "
 			    "refusing to push."), branch->name);
-		if (triangular)
-			die(_("You are pushing to remote '%s', which is not the upstream of\n"
-			      "your current branch '%s', without telling me what to push\n"
-			      "to update which remote branch."),
-			    remote->name, branch->name);
-
-		if (1) {
-			/* Additional safety */
-			if (strcmp(branch->refname, branch->merge[0]->src))
-				die_push_simple(branch, remote);
-		}
 
-		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+		/* Additional safety */
+		if (strcmp(branch->refname, branch->merge[0]->src))
+			die_push_simple(branch, remote);
+
+		dst = branch->merge[0]->src;
 	}
+	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.32.0.rc0

