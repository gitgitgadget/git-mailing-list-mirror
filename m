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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07337C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BBD610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEaTxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:28 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D8C0613ED
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v22so13270755oic.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5y+1hcx5nAvL0NKZ8rJGO72mGkp0ylm1nXlnVS7QB8E=;
        b=BOHkJfcFV4/d7Is9l32tfUEPbnQagNLJVa0mfAwY8e01bJ0ek+fYrojsqjrekXio1p
         oA4qVweLSBYBP9aRqKRKGx6d72gcd/yq4+MH8W5JEjI8A3o+wRjMrcC6gkAb2vYFBwWK
         hWcWFfduwiGnbiCml4z/zgiXK3T/rL+UhUpcl+/dorBDxL2TNigeOE2Ibshylt8g4DQ4
         QH3uxqS1RY9IFBLewtBWbnKgJMY1WH5FeyACDEUQE38/AGtvEAx4ZfJ267S45/+UIONP
         Mak3QpAfTBjmo7IGUfdmqPcmjDL3eA3irbYVIFln6DT+a0ZXinB2yEFf3MIt4v174uly
         fmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5y+1hcx5nAvL0NKZ8rJGO72mGkp0ylm1nXlnVS7QB8E=;
        b=DWyv7EDmLxN1op6dUT8Tiv9KGRW/KYKOjJU0WMvTQY+rPUtT6TlkLym+vLxRHrykb4
         aFVOOEUZv6Yw9rWg2/nnq2HkrGXP+dQjLHhIoXMHTVo2wYcJ44yGq+B4Vxp4HjmhO6nr
         6mVLxpWUQfGhvmsASRKC9+HEpg8aD+L98FVuZOk9eJTJXIwVbk3AdnI5/J844q65j8Fa
         7DyKWuJ5Vr8YyKGvDCggYOZ/y9g/fmkb33JG9+ser3KOXMBkjJEe+hKrZHBWBygiG5+o
         ooTwpbDHdpaB9tWLrp3fmgnJleFyWazRHfw/JB2oxLTKBChCre6u7bDfKvCCUjzsiZ4K
         7pjA==
X-Gm-Message-State: AOAM531urcYtxI9Mc4+Lf1ptd6KAgKc/Vm1IqzcBtWdSU3eYHjJ1AKpn
        f/Xvt3nLIgyq5RSglBmBNYXlK36KmzIWmA==
X-Google-Smtp-Source: ABdhPJwH3Xzw0GWbXPQPjENc16R6scLN2HGvZVDCCQZSTe+9GZS2cGELM+OA3yZgytTYfeeYeXGVLQ==
X-Received: by 2002:aca:6505:: with SMTP id m5mr14551980oim.93.1622490695825;
        Mon, 31 May 2021 12:51:35 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c17sm3396825otn.45.2021.05.31.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/13] push: make setup_push_* return the dst
Date:   Mon, 31 May 2021 14:51:17 -0500
Message-Id: <20210531195124.218325-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the setup_push_* functions are appending a refspec. Do this only
once on the parent function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d9f9d20f39..933b1cc6c0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,8 +202,8 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int same_remote)
+static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
+	int same_remote)
 {
 	const char *upstream_ref;
 	upstream_ref = get_upstream_ref(branch, remote->name);
@@ -212,16 +212,15 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-
-	refspec_appendf(&rs, "%s:%s", branch->refname, upstream_ref);
+	return upstream_ref;
 }
 
-static void setup_push_current(struct remote *remote, struct branch *branch)
+static const char *setup_push_current(struct remote *remote, struct branch *branch)
 {
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	return branch->refname;
 }
 
-static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
+static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
 	if (same_remote) {
 		const char *upstream_ref;
@@ -232,7 +231,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		if (strcmp(branch->refname, upstream_ref))
 			die_push_simple(branch, remote);
 	}
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	return branch->refname;
 }
 
 static int is_same_remote(struct remote *remote)
@@ -245,6 +244,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
 	int same_remote = is_same_remote(remote);
+	const char *dst;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -267,17 +267,19 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_simple(remote, branch, same_remote);
-		return;
+		dst = setup_push_simple(remote, branch, same_remote);
+		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, same_remote);
-		return;
+		dst = setup_push_upstream(remote, branch, same_remote);
+		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, branch);
-		return;
+		dst = setup_push_current(remote, branch);
+		break;
 	}
+
+	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
 static const char message_advice_pull_before_push[] =
-- 
2.32.0.rc0

