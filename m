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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58362C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D622583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLDGRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGRN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:13 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA38C061A54
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:32 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so5029528oij.6
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bpb4AW0FnDSITGZhGs/OZ8d0SJ4KUvBeaZzOGwKSBtE=;
        b=uPtU30LFyOq7PQ7iAkjRCEgWdZ3hRBGxFIYhN/fKNCC3NFveojBvNw81y5Iebct2PF
         UmVJ5+m1JgiMDHS0bVQ3UAMiSOtir+hDtOtZeVKRSv4AiwsiQ5975XSIZS75kCwg7mCb
         8RDGTZlRycCbUXonhxWD3BGvn2iOzkh+wtVqkTK84qiEXU5EZ/XdtZeWUNXVs29K0h+L
         zV6AL+o4fgIn3JOSHtg1NqrWmq1NLL5/nvEiuKACekqPUzmQFQttsMjzttqtZfhvqD6F
         h7WzB3TA0urilZ0Bxm/YBiAfQqZVjM10HS5PiZdA8XuYwg/8ZcyVyEdNDXanbEL+i7qL
         d63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpb4AW0FnDSITGZhGs/OZ8d0SJ4KUvBeaZzOGwKSBtE=;
        b=ihlpMFkETSHMn6C2glfa9Fvsq3Su0rPAROshTbaIH/ed2JW6LN8VP0kRsgWIO6Llxi
         /4m0zaT/pyG1GTgK+tCjU6J+BXcRd31gC+haNNULbBGPTVDcIEJWamdyt+1/xq0J5Fwh
         IYGyLx2kdN3IEI30z+Y2Pi3i79bFUYFodxzFasqc74j+QvevwBvQapvNAIdABCDQPbJl
         4rYVhLwU2z5jP2i/KpRZU2wID2+9F4uEUS9tINttcY9r+obVA4FTR1e/DInmC39uQovW
         pzpIhBBCAkRP80bMDRK812kfutt5G1Vxlu9tmFzXhYY+P5LG3ZIeaDqFVIRqDkr/J5ao
         WJPQ==
X-Gm-Message-State: AOAM532jBbvLjIjl+top46OSOsHksTNZKnEcXqHaMLsxgVjuiVoVK3SG
        xqs184vSyMmAPjKzAfyODMSSbjPykQKQWg==
X-Google-Smtp-Source: ABdhPJwlTraRtx2IeMlrWmEp/8QJH3doPGAZi5pBE9kz//g53rM9I429AY//yuJq/hD71lPcSzeXlw==
X-Received: by 2002:aca:b108:: with SMTP id a8mr2183907oif.108.1607062592034;
        Thu, 03 Dec 2020 22:16:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k1sm426351ood.4.2020.12.03.22.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:31 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/14] pull: cleanup autostash check
Date:   Fri,  4 Dec 2020 00:16:13 -0600
Message-Id: <20201204061623.1170745-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This essentially reverts commit f15e7cf5cc.

Once commit d9f15d37f1 introduced the autostash option for the merge
mode, it's not necessary to skip the fast-forward run_merge() when
autostash is set.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 6279e9ee37..c38548dab8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -927,7 +927,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -960,8 +959,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1030,13 +1029,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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

