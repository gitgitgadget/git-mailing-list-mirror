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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B8C47091
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32C2613F4
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhE2HNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhE2HNA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:13:00 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D08C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:23 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so5763583oto.0
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00WTZNHAP0OkRIH1LtSnJF2K7Acw8lm71/cgExdXMiY=;
        b=RiSdQBJ/HZfSaLbHITXWMOWSmyF2Xho1buZz3iOEcOBrNBz7mFVY6CHN6YdFkPV1Ez
         ZRoBOH6ZoKZySvPyLo2+2ETbdru0PajoqNMuqzPvfKXEiQTInjGx18xqx/2UVGp0Fpu7
         qV3Q/0yVKDS2pHH0DOlawWPaJ5ducOQraA0WYpHucw6rKb+jqmd0TtGXXiPXwbq9T08T
         ivg38IRokpJBgzNorkarX+dxcGNPlQQNxP+NMasE/gD58O3CvdOfELrmp5xmiuiGUkiR
         S6yN0/5SrQetPjwiOUkD/q9IRYYNc8a2RIQJDus4YWHa3iU5DEVZQ0poJl04sqG+M4Nn
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00WTZNHAP0OkRIH1LtSnJF2K7Acw8lm71/cgExdXMiY=;
        b=A63U+TEdsZNjeDz7vhr0STxmTt1zOFcTVzWbOGh76rb5PQFyTCZMhKgOGsOCWSbphv
         qqL8aIzcAcmuR63t6uSW5lXU7imEhjsGw57bOlu2NP7n59PAcA8fAyHAntfpwO349YXv
         PzzGRmGecZAqf2HJntSjrQ/xD83aRPtZU9M290X/f6OfbxIBkBZpNAUubiB9tsh6QcJe
         8SroSdpPq4VO6iGUMBiuRiFAnK/PgfsPSoYqSdC82hrs0evHF3rVoc1PmshGKuiaVf8N
         M2zOFFma+JY929k8ahz+Qvj+l30SKBvmN0dhc41R3szbY8FTrpICERgqL8Hrz00SdpWI
         rlzA==
X-Gm-Message-State: AOAM531bxJBqIhx/+JOmRT0gEvxGRR5R7BCFYCu7qk7+R2Sppvq1bqpd
        MPp1HL+sYuEzOcL8ZwYwshVWOJPOznaw1Q==
X-Google-Smtp-Source: ABdhPJxNUBHxfF7k54VG6Xasv+aTzgbul2EPxs+tzBJBHDZULvsQopl/91aX/ZjXVZKISyd42iDxBA==
X-Received: by 2002:a9d:404c:: with SMTP id o12mr9828100oti.113.1622272282265;
        Sat, 29 May 2021 00:11:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i23sm1562806oik.22.2021.05.29.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:21 -0700 (PDT)
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
Subject: [PATCH v2 3/6] push: reorganize setup_push_simple()
Date:   Sat, 29 May 2021 02:11:12 -0500
Message-Id: <20210529071115.1908310-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simply move the code around and remove dead code. In particular the
'trivial' conditional is a no-op since that part of the code is the
!trivial leg of the conditional beforehand.

No functional changes.

Suggestions-by: Elijah Newren <newren@gmail.com>
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

