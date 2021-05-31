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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E01C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EE4610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhEaTxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhEaTx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734FC06138D
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso5111504otu.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arkdH6h0iHEweocugnM6/TEXI4DmhTzrnJKQs8rHWos=;
        b=WOZTxPrtpmm7TBUWj/43WzzWEnlr5cdar2bENWA9Ozavn6pxNrtOkRh/7IbYlaP5OB
         Luz490rvHh6gJMGeXnbarRfQZGVUu/SjynfAYi5U0XuM9DLGBHTrISCN5JQ6iZi8GdMy
         aXE0PCwke1na75f20kjMGdZ3WnCAvnAcWLTuALfTqHYuuxMohCNow6mmKlHSLwsnwCCj
         SYfUEsx4iWDnqygsGJgrqymWCHgl19yTpv/0BTKjDLb0UEzkJ7Bhu68cpEbDwgipKSPM
         5HSRVkDtmuKahWZIKz4vkPMcPhgWWwwo3QtFKUaQkkWNTgYBzgChGA6zEiTpz/sk4Eo7
         3DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arkdH6h0iHEweocugnM6/TEXI4DmhTzrnJKQs8rHWos=;
        b=q4MSvRIqNv7wscJnAWdvvxdTKVAhT3j/IR6XArIyrdKtoSMmO2Whr9bG8mGyvCM1sR
         HBbxI3Kz2AD4BdxTmuuWQU2GUekCAeMgg2+YZXEV+IxcCPQlA5WlwadWnwpj1TWKUo8g
         evVBI9fQ7WUgf60VKRIeAQUmBUldQiQAXv6EZgHKSQh5vjdi6lhiGOKNGfItp22PX31W
         VzuF6c0hv81AEikWwMbvQqGp8xD/B8HRyPkjLc2SD5nOqmvi4mVc1fIqAPJDWtpWNg6y
         6V33seXbR7jPmIeZMpNdjS7N795Ed3Fq085pyx9gVgUn6kb4+8j6+lOZjvjWigRYkqSf
         acBg==
X-Gm-Message-State: AOAM5311KPDf3ZhjFQ+5Db9LtQB/4sm+eXpjcDf0zzZqElSBKc1cWy7+
        4dg/9fvoHnCZ7+QXo4unXgfTaLz6QJBK+A==
X-Google-Smtp-Source: ABdhPJzCaGW35OLy7PFGmhNkE8/90T3aTYdBClgUqqiheYxXaiDAYlnASIuxhXPwXjV/6mCOvTq1Uw==
X-Received: by 2002:a9d:51c7:: with SMTP id d7mr17549982oth.51.1622490700533;
        Mon, 31 May 2021 12:51:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e83sm2949893oia.40.2021.05.31.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/13] push: factor out the typical case
Date:   Mon, 31 May 2021 14:51:20 -0500
Message-Id: <20210531195124.218325-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
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
index da406fc890..b5e951bf59 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -231,14 +231,16 @@ static void setup_default_push_refspecs(struct remote *remote)
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
+	dst = branch->refname;
+
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (same_remote)
-			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
-				die_push_simple(branch, remote);
-		dst = branch->refname;
+		if (!same_remote)
+			break;
+		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+			die_push_simple(branch, remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
@@ -251,7 +253,6 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		dst = branch->refname;
 		break;
 	}
 
-- 
2.32.0.rc0

