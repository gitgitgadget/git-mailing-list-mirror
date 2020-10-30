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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79EAC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1A720738
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g023wwbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgJ3Dmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7BC0613D8
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:50 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z23so5411845oic.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQ3dGlZGxZVT3M098u1YqkVcMHlVyY9FmXORDjr2ygk=;
        b=g023wwbFKFlGCpSNe/GP2WXHloR3InzR6EiM4JGSQq+gPGr49xCdIsKD4ill0EM0Vl
         2sZsnxQfy1vARzNV91MyBGejeug5V2yOajbAvpUOGxun4HSV40xrV/Sn6OuijWFGTBfO
         L7Xv6sLPcrNPmOZXg3edb1vgxuSAjzbX4AQ88uKmkKH7V7beWG9vfX8qTK74A24RjR+P
         5DrOCqaVeG85JbQ0syotLyxQUZ3biJ4ZmNVgaD+xxrGsmQrPlbhHd51gc44dAfRILhfJ
         K8h0T3ZI+Abrwc5Ileeb3zaxSeYDH8yJDqNfV7JiAUsn2pFIK2/G7FcXOxJVG8P8ibAc
         ermw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQ3dGlZGxZVT3M098u1YqkVcMHlVyY9FmXORDjr2ygk=;
        b=LolllxYnUnh0gU7LIp0wOSZq1lBQu3UgfKBvK6R01xljNFBJSIUbESsc1ZlUnntN4n
         LhwuTHJapbrTQbIkKn4yDkHp2JRb/XN7Hdriw0s2X8BMI/4JFXrC145o0DefgmNiiZgi
         VoeXXdGB+XaA9lJqBjQSeohrImKqAfLc3oiVytd49db3oJoZ76FrzfnYCOzpqWuhnHe2
         VJTuxihqsf8WfFEf18T7jttF2vwwmoladQqAf+/MzRc1M2X9t3qESyzpmtX/OQ0WGMgk
         OCsYolK4BeaEoz9O7Zmfr7XIKFBaoKMdMECm7ACERORzD3bGcTnaMDGWe4AmQPS0mArC
         9l6w==
X-Gm-Message-State: AOAM530ybKjUk6QBh80WcTYjLGK9qLZGU2LRXZXnzDNEfU2s6SIMqoR0
        pKpDDEsSnq+WDf3zYbU5l3z+mnV+L2RM9w==
X-Google-Smtp-Source: ABdhPJwKcJ2a8c0oPH5Yh7sPgY1YWheGHB6PqWys2FCmRHY/O1bfelKjahd/7dyWUKnqUS1ydz2L5Q==
X-Received: by 2002:aca:7592:: with SMTP id q140mr279044oic.87.1604029309845;
        Thu, 29 Oct 2020 20:41:49 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/20] merge-ort: avoid repeating fill_tree_descriptor() on the same tree
Date:   Thu, 29 Oct 2020 20:41:18 -0700
Message-Id: <20201030034131.1479968-8-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three-way merges, by their nature, are going to often have two or more
trees match at a given subdirectory.  We can avoid calling
fill_tree_descriptor() on the same tree by checking when these trees
match.  Noting when various oids match will also be useful in other
calculations and optimizations as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d652f1f062..7083388a47 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -99,6 +99,15 @@ static int collect_merge_info_callback(int n,
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
+	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
+					names[0].mode == names[1].mode &&
+					oideq(&names[0].oid, &names[1].oid));
+	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
+					names[0].mode == names[2].mode &&
+					oideq(&names[0].oid, &names[2].oid));
+	unsigned sides_match = (!side1_null && !side2_null &&
+				names[1].mode == names[2].mode &&
+				oideq(&names[1].oid, &names[2].oid));
 
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
@@ -154,10 +163,19 @@ static int collect_merge_info_callback(int n,
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
 
 		for (i = 0; i < 3; i++, dirmask >>= 1) {
-			const struct object_id *oid = NULL;
-			if (dirmask & 1)
-				oid = &names[i].oid;
-			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			if (i == 1 && side1_matches_mbase)
+				t[1] = t[0];
+			else if (i == 2 && side2_matches_mbase)
+				t[2] = t[0];
+			else if (i == 2 && sides_match)
+				t[2] = t[1];
+			else {
+				const struct object_id *oid = NULL;
+				if (dirmask & 1)
+					oid = &names[i].oid;
+				buf[i] = fill_tree_descriptor(opt->repo,
+							      t + i, oid);
+			}
 		}
 
 		original_dir_name = opti->current_dir_name;
-- 
2.29.1.56.ga287c268e6.dirty

