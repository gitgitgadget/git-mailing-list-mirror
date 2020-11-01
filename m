Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD1C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F27208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTZeLBbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgKATeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKATeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:07 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E4C061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:06 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so14659056lfc.7
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ima11YA7gg76Alny1FeAIaABExYxDCs74Kr9jE0Z4FA=;
        b=HTZeLBbwupak8N6UgYHM0k+RTl3gQ+lw3BIjnRAdHkFdWPl5MgKetNbGRfF1jfml33
         n164tGo7OGnCsew7qc5q0IhQUfOI56R1IWnEtvMChuRP2+E73WcCV+WzUGZs+SfuVMTa
         vYJbOYbojEQOYzthIu8BidAnfo6oQmPvzeVRqvLaJwT1tRsT7iSlmBA+ttPy0s8sSbkn
         +wsK937RTK5IYhRTb5Hn1dAz/8fnPDmRcIJA2WBLUJHzkNHtTkKzNXBSbSKWmZWhsZju
         mV8tD+ycEvY+ibVsCf2qhXCRwDd/Ae+XGnHm9eTYiHiqflqQFxk1epoOIw2qTq37ThXx
         g6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ima11YA7gg76Alny1FeAIaABExYxDCs74Kr9jE0Z4FA=;
        b=I7I7wfI4ukpZBljedJ9ZjLHhzyVcophIc5FDp9yKiFjxFjY7pdJCRcaudNk16ymbF4
         tujyekab0GRTJN1XEq5dvXe6sU1MihTUS4m0GxWzj0tvgE9lnHMFkmkTQpVKfvYfLP5R
         49JMg3yRN0OYrHvnwrQOO5LYMSyT1WJqBg07SUfQlPyK8QYAFxRXFfHBOZsTE6M/2iqq
         vhk2ht31GOUosiANhWwfs0zUDiv+wdPw6kDMmpBA+tOGGfM1b9y4uGEm8/BSKL+D0tYP
         AC3pZc5RQnOuP4uHbNU4ocJyUSt4tD4MVZTlOJsfi47lJKJTgQXrhmzsWcMCeXeymOZv
         JYYw==
X-Gm-Message-State: AOAM5311+UFlnRSWp1a2+xsC2GSqA8WAXGC+6JuI/s6ld78uxgvDpXai
        sD90JTVJSzcSHWrvqwYrPd8=
X-Google-Smtp-Source: ABdhPJyUyIy1B2SyCp4uw/GYqx3HBLBwTIuKTgqcTPZNjya2Crrz9q39GfSlLenosnJv/Ur0Ejrt6A==
X-Received: by 2002:a19:88c6:: with SMTP id k189mr4292129lfd.416.1604259245157;
        Sun, 01 Nov 2020 11:34:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:04 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 02/26] revision: factor out setup of diff-merge related settings
Date:   Sun,  1 Nov 2020 22:33:06 +0300
Message-Id: <20201101193330.24775-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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

