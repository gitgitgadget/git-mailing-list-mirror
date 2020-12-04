Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02DC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E97F22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgLDUt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgLDUt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8DCC08E9AA
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:30 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x6so2636898wro.11
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uj/TZ3jFHMQeuQ7H4VVBYYgj6awrEN/LKO888rYPk+0=;
        b=ZQjr345rkCagPf3DKoL8kITcI5UcVWLs6NFIClRmmVhjbZDwgMj0m3ChvaK+UtUiO+
         HWy02GWn+QMrjVRMskgya3GL8nQleFhK6NDqU97ekjeo32hktjTADRAsTNLG8CKAkotF
         4H1rsS703Ej2yrfMqXneFfKjc7i/bfbWDOqqcJvI3tlHi3Rv7kXrukxFsw+R3RQiYRPz
         NHYHAip5vTCsgf+Q9CyCqA9EBunppr81xnfu0LVvMFtmrIXIBHo9dXGLhLkStocshNEq
         jtgScIS0uLLBa0rxRe4hZ38TVPKDR58M1Um8c+U5vTRRt2wY8NOU+ku+Y1VQr3Unte4L
         gicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uj/TZ3jFHMQeuQ7H4VVBYYgj6awrEN/LKO888rYPk+0=;
        b=MEdCuwz55xxKFdEGeXzB7dAJsbGArCp4vcbcTnUMDqjPEIOQY7hM1YRc8vtgchfDwd
         qebZzbWuaOdZmfqhb+Glz5VjV8TcJnMdTfop+/cIwTckNUpKdG8JUEAGNPf8Vd66nkwE
         kCSMToR2oRAA7e3OtSLaOMjAv6Eutmo+0aatIXrfkBiXLvlf+zHZtC2IkXF8MXWglwOS
         PUeHuPKhPMHFcA/aT9/TKzIXkWfn8TB++f3dPYd2qwsTnw/HsAzlVlXnbVjNTgNA+cBk
         Qysd0lL2vZ7U2zKGpDDrWwExQzWIQcu/D2ys84QJmPjZSJ6hZ21yE3t5OPe3AdUqbmpe
         MSfA==
X-Gm-Message-State: AOAM53203m/NexulyB57r35hrMYi3pggGsuJB/b2PM9bTnH0tODYg3zX
        4uA6ln+Rw0JzJLHpApWiZG47ZTjAmjA=
X-Google-Smtp-Source: ABdhPJzjynF8SUk1N+Gzx16oKB8Ls1dJCWcA4rGZ77d73FS1pbarWHZI5pE699jkiNo/9h/7v+3XVA==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr6843233wro.281.1607114909169;
        Fri, 04 Dec 2020 12:48:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm4860291wrv.61.2020.12.04.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:28 -0800 (PST)
Message-Id: <8e90d211c5dd5fd62dcd2f3500c47b37ab2b9abf.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:06 +0000
Subject: [PATCH v2 16/20] merge-ort: basic outline for
 merge_switch_to_result()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds a basic implementation for merge_switch_to_result(), though
just in terms of a few new empty functions that will be defined in
subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index cf6f395c69..fe22751d22 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -944,13 +944,53 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+static int checkout(struct merge_options *opt,
+		    struct tree *prev,
+		    struct tree *next)
+{
+	die("Not yet implemented.");
+}
+
+static int record_conflicted_index_entries(struct merge_options *opt,
+					   struct index_state *index,
+					   struct strmap *paths,
+					   struct strmap *conflicted)
+{
+	if (strmap_empty(conflicted))
+		return 0;
+
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
 			    int update_worktree_and_index,
 			    int display_update_msgs)
 {
-	die("Not yet implemented");
+	assert(opt->priv == NULL);
+	if (result->clean >= 0 && update_worktree_and_index) {
+		struct merge_options_internal *opti = result->priv;
+
+		if (checkout(opt, head, result->tree)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+
+		if (record_conflicted_index_entries(opt, opt->repo->index,
+						    &opti->paths,
+						    &opti->conflicted)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+	}
+
+	if (display_update_msgs) {
+		/* TODO: print out CONFLICT and other informational messages. */
+	}
+
 	merge_finalize(opt, result);
 }
 
-- 
gitgitgadget

