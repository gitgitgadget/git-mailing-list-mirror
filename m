Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BAC56201
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F42098B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URlyQxEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3Dmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E0C0613DB
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z23so5411923oic.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYf/QaTh48jEgR1wqxr56L7b2jjhLlekH2WhA065ZxM=;
        b=URlyQxExhWxgyKJ/xFQLdCEWB1kcQLyRxGj7aQaap8f3+0Pt5cdjPkbFfTTYp9aF79
         34eZ2xuL/x/dIyzWN6JRii8Qpj9vV3ReSNwaaWJrfNT8g/JS6upRvyPl8ZXMGu1R6NZk
         TzPudKenU2TTp8mPMwXI0tEuCHuXIgEeS/qi6B6o0wrDlzV4vRGP+VhPTKm1oNa1Hhcu
         S3UlqQlFz2BvtjuCyiTHvj/CbSzytXqrJDlAz5uJzkYVDmD9LzhyrlRmu3xVFTV2WklG
         spINgb/hyqYYTzhKs25fG2/aeQJ7U0RrgmRNnrZogBYEYV485E6pRLAPb4A7EmF+fMHj
         4dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYf/QaTh48jEgR1wqxr56L7b2jjhLlekH2WhA065ZxM=;
        b=XjIiinWVXTLXYJi9FDw4IMuoIZlaLa0TBQevb26wkPxrA6jfacjT7NIEYBwUQAiRSG
         b15ZJv1uciu4bwl5mjF0/ss9muQcFQZvoBn44qY47RZBAp0YAMCW0ijCpRSoJwaEdIaJ
         ICRoiGilS7RJfXEI3MxO6/EC0RKEnVHUopwYLghdYxB6ShFIGh5Oq6j/lVbvdKiNEy4S
         cRB8LUiccxDODZUS6FYd18nZirGVuHgSDAf9gcHd/uK8PJVElzODTNOWvBUUPQU2lLV/
         ZM6AZQinyQyhFf12APnPuzEqi9eCmtQZEsjrIKAkSiXj0cUwMsjhR/6qixN2w6kl05OF
         w4Gw==
X-Gm-Message-State: AOAM53268N3KaYdlsqj0st7aEMwk2UdfKKr5oV3ZJHaJunSu9MHEfagr
        IeiMwTtnbe/0P9EPYZidwKktrkKvP+siuQ==
X-Google-Smtp-Source: ABdhPJwS7/b/yma7/64yHyBVw/bXAd97KqMqUoIBOm2aFk3bcyHCi+dYBj6vyIVrSiEPdxWdXDmKIg==
X-Received: by 2002:aca:d6d5:: with SMTP id n204mr306856oig.2.1604029313131;
        Thu, 29 Oct 2020 20:41:53 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/20] merge-ort: avoid recursing into identical trees
Date:   Thu, 29 Oct 2020 20:41:21 -0700
Message-Id: <20201030034131.1479968-11-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When all three trees have the same oid, there is no need to recurse into
these trees to find that all files within them happen to match.  We can
just record any one of the trees as the resolution of merging that
particular path.

Immediately resolving trees for other types of trivial tree merges (such
as one side matches the merge base, or the two sides match each other)
would prevent us from detecting renames for some paths, and thus prevent
us from doing three-way content merges for those paths whose renames we
did not detect.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 60e2b78e2d..2a402e18ed 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -202,6 +202,20 @@ static int collect_merge_info_callback(int n,
 	fullpath = xmalloc(len+1);
 	make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);
 
+	/*
+	 * If mbase, side1, and side2 all match, we can resolve early.  Even
+	 * if these are trees, there will be no renames or anything
+	 * underneath.
+	 */
+	if (side1_matches_mbase && side2_matches_mbase) {
+		/* mbase, side1, & side2 all match; use mbase as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+0, mbase_null, 0,
+				filemask, dirmask, 1);
+		strmap_put(&opti->paths, pi.string, pi.util);
+		return mask;
+	}
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
2.29.1.56.ga287c268e6.dirty

