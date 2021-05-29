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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA5C47092
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4223613D1
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhE2HNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhE2HNA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:13:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663FC061760
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w127so6610419oig.12
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hCVT5xI6KfZrQua/CgZL6pamP/sC/G72IthpphwsZk=;
        b=aJ1HhYk0oZM3aXI1maZu8vUOQNeujHKCfFtOFyLYOtX96pC1xjWDfuOJIKgZhQww/+
         aoFf7ew51Kiq3gmCeSYdqC1x0o0NjOSXjasciEhSmG30BvkpgyxvR5H1bR6BWHVyyiqz
         DEaTBOD5Rng9GFAv0wbWMo/TWIDfIHlWQkwcOB+3iLoiPnGZaIBcf13AzHKQO5tLGmJn
         2Ywe3MWy/J0tq8EtgjuSu7XuBH8KBrJ60atgiRwc2HNCc/C89Tm1MjjsjPlA9EZrq3mr
         lZ2l8RPtOkXwGMxFd+H7UhlLwSsS5m7S+G8pAzlwyyOXdHHSgdoGTMt3hYhWSa5EVKr1
         lZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hCVT5xI6KfZrQua/CgZL6pamP/sC/G72IthpphwsZk=;
        b=lxIQyxV3Bra4pXobBpD3EZ2Np37izp0y4+UhRcm8wcqIgRWxsZPwwMUNB5ErEHQOMr
         sghrqHl22XRO5G0EPcpB7mUiiDmxX88w2462uXDLM/2d7MIXfE9R/5tVzygmVCt5aobU
         9/aksFjVMsP1UGBXVDoHtERFwx0WzkKV99IjLP0/R7maa3Ow/9B9GKz8Y634BqXDNS/a
         HuzUUezSmtiBeTcggRoI5PcJmDvZHpUELbTYGAcB2ZJo0zCHGgKLapTM5mZCirTFygMd
         uqv/l5+PYHUhtYwr3XMglyf4pDvcCRn3mQmklWrPkd+u0PFT0JuUrnwuuTqAOq7K8+QC
         w5iw==
X-Gm-Message-State: AOAM530cKhX8edsiVreg77vV2EOyj2O5j7o1BJKSw7/i0K+CSPmSDPjZ
        PqBpBJVz7NTJBDDdSYurVtHlEw0eOuzzfg==
X-Google-Smtp-Source: ABdhPJwJAPW8uOKIe6nQyNkJOymbjjoImGTpOzQVMkzqLrIyrs4v2szD3khSMkQ93EV4OTe2b0GTMw==
X-Received: by 2002:a05:6808:14c:: with SMTP id h12mr8558795oie.164.1622272283705;
        Sat, 29 May 2021 00:11:23 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i11sm1706716otk.70.2021.05.29.00.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:23 -0700 (PDT)
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
Subject: [PATCH v2 4/6] push: simplify setup_push_simple()
Date:   Sat, 29 May 2021 02:11:13 -0500
Message-Id: <20210529071115.1908310-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a safety check to make sure branch->refname is not different
from branch->merge[0]->src, otherwise we die().

Therefore we always push to branch->refname.

Suggestions-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 9c807ed707..73fe083682 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,14 +225,10 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	const char *dst;
-
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-	if (triangular) {
-		dst = branch->refname;
-	} else {
+	if (!triangular) {
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -248,10 +244,8 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		/* Additional safety */
 		if (strcmp(branch->refname, branch->merge[0]->src))
 			die_push_simple(branch, remote);
-
-		dst = branch->merge[0]->src;
 	}
-	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
+	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.32.0.rc0

