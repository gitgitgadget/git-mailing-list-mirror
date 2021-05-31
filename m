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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C1C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0461661263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhEaTes (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhEaTed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F7C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:51 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso11956503otl.13
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThdkgamF/ZZ4I+WkruSIFYBRX9tPYzooqx/S+C7HF20=;
        b=MPgFnPquYkQF15XCukY7gbuUG/yOUQIwA9potYN7NXG4ACRda1rN8oo2NFH6HJQWOZ
         L3ELdvk8qAwypWQm6+be3mlu01Ln8bnHJnyQL4QZ6IVUvbtCOz0zgAe57mBERgwxxawu
         DCKriWZwGVwHrYcJZaLeqEcrtbPUD6zIHpAm5STWQ2nUx5srNzG9fcTIyF05KVefjNcv
         KDau/78qlD1u98MDkus8eP1Y6kppNEOu17yTn73jrRKwxWsWU4rpW3iETUlCAygSn6yt
         t27mnkkisyS/zlY3L1IkFARxiReOJPJ8j0oLm/gainFGJctyKicYU/kleMcOTdAiXXFb
         vj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThdkgamF/ZZ4I+WkruSIFYBRX9tPYzooqx/S+C7HF20=;
        b=M5eNGNbpi25VGnurvMV+ydI1hK9i888jNunkC/uZYClBfsGw1ylYw7Z+jsSKiIvvC3
         VHf30O1kHMecpeeyk25TXjfXGx3d65qKIYhL+GlNzVIQbSXNTBwI3ZTRyLUWXQnBv8aZ
         owt7WEAiZ1iR/xCL5FL9TrtDzgTIEsnjij9TOkNYimHtwJ8ezu9kquiwEqH1k+9GI6nt
         asjTR9mDAGNGcHNtqJzGsVZy6XNuynOjPInbdop+vC8HEezz+Neu3g260u4xTAmc+Bgl
         XMXcFcgkBtYCNrVfBi8vbiZba3a5FVtW+siiCACMx062rANDE+XLIF8E6a6tt9p2bQg0
         DBkQ==
X-Gm-Message-State: AOAM532Xxmda25NE1+bOrHjwQA7JmDt4Svd+dpY8nBspNEwI1+QIWuZT
        wXScHlC/FWXnMSDzKqroHs+OSyIt8vAxWQ==
X-Google-Smtp-Source: ABdhPJyebuzugF75aOR9OaE84GTPDfl5rQ0D4vAwAJkMRCRVJLr+Mlod6AObYyOxM7msm1Y8hSGdtA==
X-Received: by 2002:a9d:5c16:: with SMTP id o22mr467275otk.319.1622489570861;
        Mon, 31 May 2021 12:32:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y7sm3258964oto.60.2021.05.31.12.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/7] push: remove unused code in setup_push_upstream()
Date:   Mon, 31 May 2021 14:32:36 -0500
Message-Id: <20210531193237.216726-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now it's not used for the simple mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e37c751268..29fea70ff1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int same_remote, int simple)
+				int same_remote)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
@@ -207,12 +207,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
-	if (simple) {
-		/* Additional safety */
-		if (strcmp(branch->refname, branch->merge[0]->src))
-			die_push_simple(branch, remote);
-	}
-
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }
 
@@ -271,7 +265,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, same_remote, 0);
+		setup_push_upstream(remote, branch, same_remote);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
2.32.0.rc0

