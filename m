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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2DC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CD62076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbFiJA6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbgKXNap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388258AbgKXNao (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:44 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15BC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:44 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id s11so3957200oov.13
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8TR9CXxovhFgUmDZOL3LJSPyrt2FqATKBTfuUSfEPI=;
        b=jbFiJA6yQxb1+N8+VUrJLqlbuBx4bMZCwNnnvN9Hv6z2jOV8qIfbb4oaKbZn8SQh7t
         DhdmMmbWTQF3ZjIC7xaTKtYsTITjsBEyw2jI5b/Rt7Cw9CZNdV1nbg/ZrLGCYArd/Kq/
         OmfygLqNsemKitpbUk0L1YJ7a1k089AWFRgISni4BiLvBQdniFJ2Z1nUgeiMQxM7b1/x
         kUCnwKDlhXSy0QK7N/s5MbexBJ5kvM9I71ZskhCg+YKotJ+7B0tnn8GJL1+9GFT0Jmxf
         sAtkAIYiYp4LBhWliLh0WcBdtvTrCUDEjVm5Np8hmMzIX4FyRWtaLfYMIp2986jZlWTw
         HysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8TR9CXxovhFgUmDZOL3LJSPyrt2FqATKBTfuUSfEPI=;
        b=HHZ1MkYjYHuRbao3ua1pXr7ayX0Id8AvuSzJXTCm/ywnU71YaUd0Al2VYLheArMgxh
         2UQl3Tt3PY/j1bpgvxL5bo/jXLUX4erjVTrsivb1Wfw/Ovg/K9j0nexu6aYTNhaf5EIx
         Ih0lZnzfTbDF/JN61uThsEHD4vo6XaVE9H2Z8q7Chpk5OnO6TLeSV7P7Kw4X8wbrnRYx
         LeT+8VswZN/gv2a3Y7Qs0wxPJO1TsgE35VsIiah4q6KVN+JEkm7Je+XmO+pZHm4+w97w
         pDHe8isVE9A7y0mP+VAPCg4R5mnePEkkNvDQcy3n9XBow9nRjbqIt+vsTRjnucPtgOdX
         ZI3w==
X-Gm-Message-State: AOAM533fwtlE/MrCq2EfvgGLIJ/aNTplQKPYhs69cB7DQryDekMmRpLE
        OeYmrWyoxMPOfcQe+NketMl236qYsVZccA==
X-Google-Smtp-Source: ABdhPJzhETd5PS5uPdEqF+oaxrX66HGP4poqWpdqp1Ww42Hc82ilYgSMYP6NLJ8slx+/FpsuExBtIw==
X-Received: by 2002:a4a:3e91:: with SMTP id t139mr3158776oot.90.1606224643562;
        Tue, 24 Nov 2020 05:30:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b23sm9338660ooa.13.2020.11.24.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] pull: cleanup autostash check
Date:   Tue, 24 Nov 2020 07:30:33 -0600
Message-Id: <20201124133037.89949-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This essentially reverts commit f15e7cf5cc.

Once commit d9f15d37f1 introduced the autostash option for the merge
mode, it's no necessary to skip the fast-forward run_merge() when
autostash is set.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e2de0d4c91..eaa268c559 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -926,7 +926,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -959,8 +958,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1029,13 +1028,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

