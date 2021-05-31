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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17BC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D061260
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhEaTeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhEaTe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF7C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so12020003otl.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iuHSOXaVNuPRkfSna9vWOqFx/khxAn9ZQMqAl0QnuJI=;
        b=IcmpTWH5z2zjua2mqEQ32pJvipWcBFjjZsSwFft0uYILckAFUIu8oBmTHxUOF3ZuS/
         JEzNk6S24u/JrCa6U1S6gWBF7vfkjW9eCe/xf4xTHtXKQApOJSVt8INsf7QDbOe1Abyc
         OhFSvEEtAoZWbiPGi/V+IBLGrEoSVBIdwKmi1Notm9TZATHxnIfyxAepMzH/Rb5JvpVk
         +8ZIEKIGkHQxUFQvXrWdUKJs/BhqJRB+tnImjcPIP2sIHOjJWLcblzfTvQMh/el81Xyy
         4nACunc8lkpg34qQ2lboQS4uZzsQL/eOEBAbUXElveyimA1jUr+vSROnF9sKpXlIw7Fq
         RLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuHSOXaVNuPRkfSna9vWOqFx/khxAn9ZQMqAl0QnuJI=;
        b=Bl5DHQBdmh9SspNvn68SHbTYSJ0NwTkgyR6X/0Sq4oKeUTX94xAAxpi507VBPGSjha
         na+kOJLJN/mqCKEweYB9Psk8tc14dgUhuzOv31hI+nTh1Vjo+h2y0MEYaa4KRqurAyrX
         atpYrOS8OPM1i8jBgKeNHQ9ypYQZZuKtlhguJvRKN1YHzaeyG5e8fYnzDqyYskkcD1Sz
         ky2nVCr0neQel0HJPEmgAOJ/5Fix8Sjj7E3fIPZYL5zcblDJnod26m1K8RnxdlEr+AGK
         eizOdu3u5IwPDZ4LHkcovPcWC6KAHxLpUIzKQceFphkmUbmJ8bWyei3Fe78v3sLB9eCO
         FkZA==
X-Gm-Message-State: AOAM530NBb2A3NLUMB032C3eFcxTj9dQtm4qEt7rV9v7MClOR6+LaMj1
        NS3L8OS1HQH7tFZaT77xpcKdm1nVo/zc9A==
X-Google-Smtp-Source: ABdhPJxgckzuAQMDg6YVWKm3xPNARnlvi8EkIB4X5A0Hbm0DeMWuplisYItySURIKvfyL8V84amfDg==
X-Received: by 2002:a9d:6244:: with SMTP id i4mr17507824otk.182.1622489566332;
        Mon, 31 May 2021 12:32:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f80sm1924127otf.32.2021.05.31.12.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/7] push: copy code to setup_push_simple()
Date:   Mon, 31 May 2021 14:32:33 -0500
Message-Id: <20210531193237.216726-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid doing unnecessary things and simplify it in further
patches. In particular moving the additional name safety out of
setup_push_upstream() and into setup_push_simple() and thus making both
more straightforward.

The code is copied exactly as-is; no functional changes.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 48c38fe25a..6a620a90e3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,10 +225,38 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
-	if (!same_remote)
-		setup_push_current(remote, branch);
-	else
-		setup_push_upstream(remote, branch, same_remote, 1);
+	if (!same_remote) {
+		if (!branch)
+			die(_(message_detached_head_die), remote->name);
+		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	} else {
+		if (!branch)
+			die(_(message_detached_head_die), remote->name);
+		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+			die(_("The current branch %s has no upstream branch.\n"
+			    "To push the current branch and set the remote as upstream, use\n"
+			    "\n"
+			    "    git push --set-upstream %s %s\n"),
+			    branch->name,
+			    remote->name,
+			    branch->name);
+		if (branch->merge_nr != 1)
+			die(_("The current branch %s has multiple upstream branches, "
+			    "refusing to push."), branch->name);
+		if (!same_remote)
+			die(_("You are pushing to remote '%s', which is not the upstream of\n"
+			      "your current branch '%s', without telling me what to push\n"
+			      "to update which remote branch."),
+			    remote->name, branch->name);
+
+		if (1) {
+			/* Additional safety */
+			if (strcmp(branch->refname, branch->merge[0]->src))
+				die_push_simple(branch, remote);
+		}
+
+		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+	}
 }
 
 static int is_same_remote(struct remote *remote)
-- 
2.32.0.rc0

