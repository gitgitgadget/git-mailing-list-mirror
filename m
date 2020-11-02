Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42B6C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C254206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VThpurWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKBUoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgKBUoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:02 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBFC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:00 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 9so16034132oir.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8o3sAg1zpz+tjQUlz9e4oByVDbFxIiaVgYiFPH3mUzE=;
        b=VThpurWw1efvpu3RmBccfY+dDl465zIhfpsu7TRKGETsDQXnGT0DyLjEY5dM3Bj7/8
         Z3M5MV78B8aRIYsjrXfvVM9ZbJruIgFP0uTlRWfJOaV4UYnCtCX+lTMo1XITHgq5e13B
         lWYOHcor376WyjFiXDHM01WsfsB1LlZgIpayLiXjupjHqZ85XFxmnbxsx4exXsjKCBGX
         FxRkwYpBRYqJJdkpXKNKoBK7aSU0VQ8stnhYmiHq2ttolu67H3Wsdb08Pm+siEhYfN8f
         rR5q2FZybmMg0XwHvLye89pBCRJTZknS+qfSRUX3KlQ0Kk4elAoUwQbfV8mh3JkEBl7A
         i37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8o3sAg1zpz+tjQUlz9e4oByVDbFxIiaVgYiFPH3mUzE=;
        b=Ui9XJxRAT3urpSRby7iVwloZtHDr4qivujOBI02m6ivq8bEWII7pW00k+3eYROr3u3
         u66wOC+mrrohEMPyvl/ROLC7SaaG8gh6uZHdhr0Ds4Fp8yjQxn0z395doOF7z9fU3qR3
         OW36PSREsLJvJWebUMwM6tfClx1potB1RK3hy0VHzE1DSreN/AU8fpgRRxpHuE2bOdMW
         DKWmsW1d14lEhftonlNL1MHd29tUxj1vz6KN3NB3TaySzAKt90gjc3xKphdhlF/wJNiS
         yknlpuSyCGWcKqfcLvajLSlnoffS3n0k0M0zKHXj+SYWiizH9bPjYcCnSE8yCbwh1ZCD
         cwmA==
X-Gm-Message-State: AOAM532KPuK2Mg/LjcwTKqluD48jT7k4wollQ/HE4ZSyKAA7RpgNnbs1
        G/O9wE5ahe7N8q+h1iuPWiXRddhanC+Seg==
X-Google-Smtp-Source: ABdhPJyQixbM9t1z9+F7WlPdX2VPyQfJS2irQmhfTOMBoiTYh8BmdTSnCc8xiRKJtj4BXPSw3tf+XQ==
X-Received: by 2002:aca:bad4:: with SMTP id k203mr6334oif.16.1604349839791;
        Mon, 02 Nov 2020 12:43:59 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 10/20] merge-ort: avoid recursing into identical trees
Date:   Mon,  2 Nov 2020 12:43:34 -0800
Message-Id: <20201102204344.342633-11-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
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
 merge-ort.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index bef3c648a0..9900fa1bf8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -203,6 +203,19 @@ static int collect_merge_info_callback(int n,
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
+		return mask;
+	}
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
2.29.0.471.ga4f56089c0

