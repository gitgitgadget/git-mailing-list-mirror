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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD9C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4CD613CD
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhE2HrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhE2Hq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B8C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id d21so6658073oic.11
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Suz1pXYdD/5qLCELGGMHE8KS8khHRQaYRqQueRO1Y4M=;
        b=dek8HBvrpTJZxHVf9wX/2SxvSK5iE4N5ahnjYdnUnZFmBhSh8LdWhvOnPW0nsVKRo9
         PnCZQYTu69n9S2rE599I+XuNz8GzMgEqGKMgFXoSxv3eGkaX8ZffC7YFcnuTEkY42Q9X
         hEUQ2XJlF5yhdWdq5EwuWR4o0RUuu1q/hKVs/z/3fe+do5DC7uvbg0UNZoFiN2DXzHfC
         KIdx74rBL784j5exhBRi++ZwfAO2bRatv2U39EllQH4MLKJW/4D+n/pei0fn0z8uXXag
         BlwHliOx3ezlzyV2aqnl2Rlep77+qIK8JE7iSlsLcMlJtG0NEFXd4pt9OSHSgnOjKvZ3
         eaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Suz1pXYdD/5qLCELGGMHE8KS8khHRQaYRqQueRO1Y4M=;
        b=CVkx02X7RDGLUCPJ5ZRLlyTvhsTlmI06VsEJj6w9s5GOqmO5vU8xjmnSFLDB0N4VFl
         0Ie+sVlE6GGByyeFnK34JdG1ENnF6bnRxM5FA9DcP1vnrIUGmzRPWXJwZARIrZh2KYjG
         phWJIRxzY58Py6vqAJPPZHbbCSelIj8KfT7+HMQBrakgz0poRVbuzUjKcmnjpxI+rLxm
         gWpOWFbZWlIPJOoq0nX0bSrAQDKhiAOu4SsC44TI4SBCrFEtL7r6MyUrkvEcbPaCoifO
         D20ysjE3QLagHq/J7G/Xz2DN7gVcHJtiyMpmTqkc/41/lL7hh8KFo4CPFSgo7As9z9uZ
         ROFg==
X-Gm-Message-State: AOAM531gJypMP4k7nagfaMV9diGDZft/VMn+cEAg24nJT7BWr7NCbl1d
        4iyqvy4tT0YFte8EHYLBm+0zq+sIrlCmqg==
X-Google-Smtp-Source: ABdhPJzMQ0wmz17/Gk0q4rSTot4iefOAPuaE6YV8LkCDd0RcI05UPr1+bA3tN/Zd+NnNDEp5lTTs2w==
X-Received: by 2002:a05:6808:f90:: with SMTP id o16mr8118033oiw.163.1622274313391;
        Sat, 29 May 2021 00:45:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d65sm1649512otb.78.2021.05.29.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/15] push: factor out the typical case
Date:   Sat, 29 May 2021 02:44:52 -0500
Message-Id: <20210529074458.1916817-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only override dst on the odd case.

This allows a preemptive break on the `simple` case.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index dbb4f78e61..94cb2eda63 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -230,14 +230,16 @@ static void setup_default_push_refspecs(struct remote *remote)
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
+	dst = branch->refname;
+
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (!triangular)
-			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
-				die_push_simple(branch, remote);
-		dst = branch->refname;
+		if (triangular)
+			break;
+		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+			die_push_simple(branch, remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
@@ -250,7 +252,6 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		dst = branch->refname;
 		break;
 	}
 
-- 
2.32.0.rc0

