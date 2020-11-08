Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6CC4741F
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A0E20657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/76scVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgKHVlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKHVlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:23 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ACEC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:23 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p15so7836403ljj.8
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ima11YA7gg76Alny1FeAIaABExYxDCs74Kr9jE0Z4FA=;
        b=l/76scVy/KCrGqVXJY2w8EPxHfj469N6EZ1tPlW7D90CIv86a+/cCAt8VRJVQ6jELE
         R29rQlccf3DfZTkBQ2cvQABgvH59zR8flY07uFLwQDPAdpUI6QGhcT0LXhg9PfV16TzY
         /l7dl5yKruwPyaOr0EpS85l1a4zxVcqgBWAA+xSwKoBUzmm/XiNCIHjrTOn7F7890HDr
         h3Rqrlb90bAMWQ3POg6BsiVAKVLZYvxomwvLM+54yZvGIMx7wfvwAMD3lkIuipGP0cx4
         qE3H39r1duN2haYL2NbyLxi93h5PUjcAgaXmzFbV2mQfdQDOy8Uptxs40VIqu3+TmUwp
         uXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ima11YA7gg76Alny1FeAIaABExYxDCs74Kr9jE0Z4FA=;
        b=AScZOYWVhASo0RO0ykrhAAs2YLho4hJPQYR/93IVSwg8lKgJZc7le3k4nd8i0+d04Z
         vlKdktFkdXd+RgBkD6nzIK/lCWCj6+msl5L+tLgi1tY5fj8k4ZD1QZQzsyrLsV8VzBHL
         NizvXaV05K9204FOvQD826d2kf+gFQjLE1MDgd217mFVTjJkdCefetLQmFKFBQMBuy41
         VwRnwLJO4RuuzpmSqXOAdYsyklXhUxGfCuKEHD/V4B+AjaVQ/jxNx4+N7PMXZQMRInKf
         YvId09IAFbX3BQnzMLsq5D1UC6coUSbVIexJObi8KKQ79UJKzEjtiLgMAGhuBrDFD9u1
         X4MQ==
X-Gm-Message-State: AOAM533qOvyed9ov5vFS+lakXJtyT0vionL8SrwIeeVcH+WZMNK3pXk4
        B7iU/vppO+EzC2V+ypvv5rI=
X-Google-Smtp-Source: ABdhPJzl0pT4IU/SS+OFc0PWvuCIXJpWeV2KxFpAyPQ6nF2YOLlNRJexTZsLy6XDqCCSswcQyd4hfA==
X-Received: by 2002:a2e:924e:: with SMTP id v14mr5142593ljg.264.1604871681779;
        Sun, 08 Nov 2020 13:41:21 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:21 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 02/27] revision: factor out setup of diff-merge related settings
Date:   Mon,  9 Nov 2020 00:38:13 +0300
Message-Id: <20201108213838.4880-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the setting code related to diffing merges into new
setup_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index a09f4872acd7..739295bb9ff4 100644
--- a/revision.c
+++ b/revision.c
@@ -2191,6 +2191,16 @@ static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	return 1;
 }
 
+static void setup_diff_merges_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2885,12 +2895,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
+
+	setup_diff_merges_revs(revs);
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-- 
2.25.1

