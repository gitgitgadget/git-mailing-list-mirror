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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD91C4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E45F208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ3ewDWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgKATeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgKATeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:07 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BEC061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:07 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id x6so12678723ljd.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APfTNBqeu4NGszmHhOTAYqEdziEeMIGvS7s1xDEERjc=;
        b=PJ3ewDWulAm8L6GXthjR8i0tTiNio8Qrr3gmwovopoGTR3QqCM5ZbabZh2VYHD3MBA
         qxcV8fYORwPzMr4OqVGdnK3H0kQGau4/eCEThV+TLWbgnqOf70JZs78sh5lT2jKaTAx7
         J/gMo4zd8C85KTTr6rr9FDK4VDNvc0+pUTHp4nUvkgsOhiquREn7X9p0xs00/DJwWV3s
         AUoayCM8R/IgNQbTlzf7pe8iv95Cu07PNM5t0otGktFWUoN1H3CLqRqf+gYu9lW6Y+dL
         Pk9DRvLc+wfsSxsJm/dZP+yEJaZwiO55P0iioAOxwB/fy/8Wbb9pne4MC3jKLmwC2zL5
         1ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APfTNBqeu4NGszmHhOTAYqEdziEeMIGvS7s1xDEERjc=;
        b=SjZJcaKkaQ4bUbRzJZEXKqJgx1Tntm1A+5fNsczUTqzKF4xhs2ezoGhKDRQZb0P6Ih
         l6syI7V/L/Pv5oaWhmDNFPPVKq1VPQPJXqWI7cd2oCLvJSiU57xp3wBwGkjBITqANyu1
         bGXl69hVY8AG2yAK7k/V8GA8x3Wnl1JiyQogj55RSTQYYEM/lsBYPPhGvKC3qjgBzq2c
         sAH+q07gUW+05bOKWi2yMAo2PQTXn8xKqjXxumQDTBpGIR4aYt+QzCJnXiuAXVa+bX7s
         20P+argF/TWD+EWDeuu8IraWK4fWt+fasfc4y5quaUUq0SCUEwF00gRpboFHvqZLn7Ib
         f1jw==
X-Gm-Message-State: AOAM531xBd3vVSD8kUBrhGT0e41bsvY9DN+2GLDkwkrlkIRW0lXEZP/E
        5HkHpPOX6EYRRaXeGaUP/nM=
X-Google-Smtp-Source: ABdhPJwxM96xB3FvUH1oHOMP01Ds/98HjO5uuXRkqfznBjFLTZCANVcZh4xQ2O1Uj+yqMMFJEni3aQ==
X-Received: by 2002:a2e:b530:: with SMTP id z16mr5472534ljm.245.1604259246159;
        Sun, 01 Nov 2020 11:34:06 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:05 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 03/26] revision: factor out initialization of diff-merge related settings
Date:   Sun,  1 Nov 2020 22:33:07 +0300
Message-Id: <20201101193330.24775-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move initialization code related to diffing merges into new
init_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 739295bb9ff4..bc568fb79778 100644
--- a/revision.c
+++ b/revision.c
@@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
+static void init_diff_merge_revs(struct rev_info *revs);
+
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = -1;
+	init_diff_merge_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2153,6 +2155,10 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static void init_diff_merge_revs(struct rev_info *revs) {
+	revs->ignore_merges = -1;
+}
+
 static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	int argcount;
 	const char *optarg;
-- 
2.25.1

