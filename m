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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E33C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29C6613EB
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2HNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2HM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:12:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3426C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so5763550oto.0
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rREcBbsV05T6arn3ojBo1xuxHiGi0ePkc4YwsDcrJlU=;
        b=Q+3Na51yCPGPkxY0qWamK1bzd7Nb8k93hymlHfq2wlvevdTtREwipff4Yez4Ep+HvC
         DIfPhhfOTv1dMVgzqol6afs/xPygNEB0dmSys7XcIaX9jMxujifEdZHEs+Ko4dV0Zhon
         QpMCm/6g2DY4VYEURGP5QfIB5e2gH7d3s8CtTflhRi3VnlcX0WvTvmBbHMMddc3USEFi
         BY9TgsONTKCHqE0CIaVNZ5PH42nPSDU/Xr+Xtup8tScdGvHplZLDZ+/VNSCLDgEBrQK+
         Jxl4bB+hcCm3MZziKlG5UL5eWVLBPnqktBo/l0Skyvu1Fr2wa9/E1Ij3ytQQ05OuZEV9
         +Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rREcBbsV05T6arn3ojBo1xuxHiGi0ePkc4YwsDcrJlU=;
        b=Pcube3DKDfVmQSCLzM1zsVs7OXC7kFpSVFUw4q01pLTfogdjNxm/vp9HCzvZeCHNeZ
         qeBaI4MzHEFdvIZPFHzm0Ian0l/0nEg6xViNdIjYxgO9LneTVSwYN6sI0AE680dCB8Yt
         Dx5r3VGcua+O1a0150n9NFJtaWkBGwzuVSBCbiHIybXaSNPi5E+1h0ftGfeceutDTjgP
         qLNiEnZJgZlnXG+I97yuMsaLWeATAKAmEu6dBEJAkBAI9vy3+9qZgi8//iCmePbN0E2N
         rAvuWaB2ZGQJQdsnOSzfZ9s232JUZPTYrjyQIZYKpba8VvQRmoVLESYPiiLJgqgHGiDC
         XY9w==
X-Gm-Message-State: AOAM533jFYOz1Gd77qw4LR94++t5CmS6favP0M5cMDsnm1GLazuIyeP0
        RIirbyA4/A5pGgw+4dQzCJEFuM708f1VKQ==
X-Google-Smtp-Source: ABdhPJxY75YNB0W5jI7wDHVj1+3NoKTg1qIMb7dDEhUh8GxrtYP4EeQqZTGKGU4Eg0k9Y+EHRC7NSA==
X-Received: by 2002:a9d:3436:: with SMTP id v51mr10177582otb.346.1622272280833;
        Sat, 29 May 2021 00:11:20 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e83sm1558113oia.40.2021.05.29.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:20 -0700 (PDT)
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
Subject: [PATCH v2 2/6] push: move code to setup_push_simple()
Date:   Sat, 29 May 2021 02:11:11 -0500
Message-Id: <20210529071115.1908310-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid doing unnecessary things and simplify it in further
patches.

The code is copied exactly as-is; no functional changes.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7045e4ef0c..d173c39283 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,10 +225,38 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	if (triangular)
-		setup_push_current(remote, branch);
-	else
-		setup_push_upstream(remote, branch, triangular, 1);
+	if (triangular) {
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
+		if (triangular)
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
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.32.0.rc0

