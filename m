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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E5C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59ED60232
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEaTxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhEaTx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:27 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB5C06138C
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:39 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso12036949otu.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBv9Ocb3RpnLTQOyYiLEiqCMsnvb/2lKPrHee59KIfw=;
        b=Co4O2XkUOSwRXEFSuhdJNGaE1LnKOgMr0J1msObPmV/XGjFH9oL1RJRhIqMXoRvkxd
         UODZZ9yeb6EonK4uZw5dghtJNfjVV5WMRUZzRxXkcGCGcPe5ua1arZHUs6+Ur/sylu82
         p32J3Tz85kCdG/XO8w+ebsTTeDE42241q3pMxe1hW55N81GjwEwn/JO8vb5Soap9Uccn
         rlMpRmGd7ahHERYJRUHpW3xcdfGKCl8mR1meO3QIN9Ot4MGvqECFzCMNMNGLmKH2tv4y
         Xngatwh/tWuctLDE/1w6iRRa3vTakvmIQbUlUyHSLOfreUKoSBB0BaQnkDbI5fKvieFh
         QXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBv9Ocb3RpnLTQOyYiLEiqCMsnvb/2lKPrHee59KIfw=;
        b=fwu+ihJODhJaIHl39PGu3dxo4GpTIbSg9e/TjpKErYbaQdz1Te176OsdlphTJCkBNb
         Eaaf8FTg8bHEnHRo7tmNqy2NTmHJPNL4iSoaXGodbAYMyA/kQHeTrA7Kv6zKzXBwBVok
         5x2668VpMu6kUQWUntp3wZu1Zp6/kpFf7mLWd6GPBdQJL/YkaI3/1lfwYKJ6vVM4uKne
         kCf0AAg4ZCWqFdKaQeg9kyW6utBNPJ7SujG11MqDm2UgLvFycZGB/KrbNpDE2ZC7y9R/
         Jm9gqrHHsFD81P2i+vDAIzXxsH0f/i7eL+Bu5lsANpJjyLLhChwVE/y/Ns5MmKJEmnex
         q8XQ==
X-Gm-Message-State: AOAM531jTgD9uMz1ox1FPTBf3WOreH2JE0W/KNBE9Ym6G7hMuCWBSd5n
        vZQY+a4sFcpCibt1/V++QHxo73Lo8rEJOg==
X-Google-Smtp-Source: ABdhPJxbXxbiLySOPmahGsZO2z/Vy7m5YUFDIbp0KA/mhWDGzwQ1HQY4haFPRMW9KKxV1Z5AXIDGLw==
X-Received: by 2002:a9d:7747:: with SMTP id t7mr18668417otl.96.1622490699106;
        Mon, 31 May 2021 12:51:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f13sm3391455ote.46.2021.05.31.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/13] push: get rid of all the setup_push_* functions
Date:   Mon, 31 May 2021 14:51:19 -0500
Message-Id: <20210531195124.218325-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Their code is much simpler now and can move into the parent function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 43c039a2e3..da406fc890 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,30 +202,6 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
-	int same_remote)
-{
-	if (!same_remote)
-		die(_("You are pushing to remote '%s', which is not the upstream of\n"
-		      "your current branch '%s', without telling me what to push\n"
-		      "to update which remote branch."),
-		    remote->name, branch->name);
-	return get_upstream_ref(branch, remote->name);
-}
-
-static const char *setup_push_current(struct remote *remote, struct branch *branch)
-{
-	return branch->refname;
-}
-
-static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
-{
-	if (same_remote)
-		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
-			die_push_simple(branch, remote);
-	return branch->refname;
-}
-
 static int is_same_remote(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -259,15 +235,23 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		dst = setup_push_simple(remote, branch, same_remote);
+		if (same_remote)
+			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+				die_push_simple(branch, remote);
+		dst = branch->refname;
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		dst = setup_push_upstream(remote, branch, same_remote);
+		if (!same_remote)
+			die(_("You are pushing to remote '%s', which is not the upstream of\n"
+			      "your current branch '%s', without telling me what to push\n"
+			      "to update which remote branch."),
+			    remote->name, branch->name);
+		dst = get_upstream_ref(branch, remote->name);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		dst = setup_push_current(remote, branch);
+		dst = branch->refname;
 		break;
 	}
 
-- 
2.32.0.rc0

