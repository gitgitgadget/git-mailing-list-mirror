Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D8C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD56561165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhHYCXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbhHYCX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE90C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so3105311pjb.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZB5IVxJr55R2SVGW0MxVUnPARFLsT2THBJI8tenPhM=;
        b=jKu7j9jTzyvCvTJ30Nsrz4fhchwOw2FxlBsbIJjQq2nfo1CL0ZApey5iu4BgzzDdlq
         Ox2m4Vhypr/gXeZLeV/kbI8/mSpHTWPV+UE2xZhWJ32CYv2uOaX7lXImMpiyVNfTAlmS
         Gm485WFY4wREUydqULJPRnWRybdfQGc2UnJN45BfGrfLU9C3DM30x2QN+a08C+XSricR
         oWneSROnuFDSpGAMjFY5NvVsl3i09VYF0/mTeqEITwoGcGY99gkE6XGXDMmrSf6aWClD
         Q1w6om4IyJfvRJWIHuhvl3zYCUNRJd3jCvLnSSpSBdQ2BH9eG+Kp4STUmFJpocy5Jqhb
         HWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZB5IVxJr55R2SVGW0MxVUnPARFLsT2THBJI8tenPhM=;
        b=TmlX+Z924ZscrHsYUQKOTVJWKIc+MAO8xkgbgYECnUSmvTebG0o+vPw6VJdwFhdiO3
         MiPCu8BKLj0xYv1tRTEqAdOvaHMAZlHAwtg1XtR1aqJ+7LIKAoGbNVF4uC1bacAXOlSw
         ooIKo9KC5dRK7r/dXH9LKfrbBSmK1iA8ri77AGApyNqjOaCzmsxrBTiDuIUV1iY8ha7q
         FYMZVnlpyE1LoaCqZx5SQEHJcLAHLEp6iUz18H/WfZnWtPFryj2p/tWrrfRffXdT8Cpv
         pppo5ovh1hYJxVEoleLhhTlA/hixwOg7eJ3fNHEp6OyynubU02LltaxLbGbbPpY9lz9X
         PJgg==
X-Gm-Message-State: AOAM5329T/HCe8FTmQdCkIqHwTNL4h9qk6bLJg0G4E2MB3Rg1xSRDnei
        ZB4bQTUSChisiIJxIqhL2yI=
X-Google-Smtp-Source: ABdhPJx41FK0ZGUNFq/Kqx9ICCjwvZKd5nICfM8qqPefCMBNFd045ERD+orndpdRs94XOCy+vk770A==
X-Received: by 2002:a17:90a:14e4:: with SMTP id k91mr7786680pja.3.1629858163028;
        Tue, 24 Aug 2021 19:22:43 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:42 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 14/14] pack-objects.c: introduce `want_exclude_object` function
Date:   Wed, 25 Aug 2021 10:21:58 +0800
Message-Id: <1a7c4c58946cc6aefe07021f366d95f174c7da21.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 52 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d5e3f2c229..503f8a5746 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1206,6 +1206,21 @@ static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
 	return 0;
 }
 
+static int want_exclude_object(struct object_list *objects)
+{
+	struct object_list *p;
+	struct configured_exclusion *ex;
+
+	if (!objects)
+		return 0;
+	for (p = objects; p; p = p->next) {
+		ex = oidmap_get(&configured_exclusions, &p->item->oid);
+		if (match_packfile_uri_exclusions(ex))
+			return 1;
+	}
+	return 0;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
 			     struct packed_git *p)
 {
@@ -1317,11 +1332,8 @@ static int want_object_in_pack(const struct object_id *oid,
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
-	struct configured_exclusion *tag_ex;
 	struct configured_exclusion *commit_ex;
-	struct configured_exclusion *tree_ex;
 	struct configured_exclusion *ex;
-	struct object_list *p;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1357,41 +1369,27 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
-		if (referred_objs && referred_objs->tags) {
-			for (p = referred_objs->tags; p; p = p->next) {
-				tag_ex = oidmap_get(&configured_exclusions, &p->item->oid);
-				if (match_packfile_uri_exclusions(tag_ex))
+		if (referred_objs) {
+			if (referred_objs->commit) {
+				struct commit *commit = (struct commit *) referred_objs->commit;
+				commit_ex = oidmap_get(&configured_exclusions, &commit->object.oid);
+				if (match_packfile_uri_exclusions(commit_ex))
 					return 0;
-			}
-		}
-
-		if (referred_objs && referred_objs->commit) {
-			commit_ex = oidmap_get(&configured_exclusions, &referred_objs->commit->oid);
-			if (match_packfile_uri_exclusions(commit_ex))
-				return 0;
-			struct commit *commit = (struct commit*) referred_objs->commit;
-			for (p = commit->wraps; p; p = p->next) {
-				tag_ex = oidmap_get(&configured_exclusions, &p->item->oid);
-				if (match_packfile_uri_exclusions(tag_ex))
+				if (want_exclude_object(commit->wraps))
 					return 0;
 			}
-		}
+			if (referred_objs->tags && want_exclude_object(referred_objs->tags))
+				return 0;
 
-		if (referred_objs && referred_objs->trees) {
-			for (p = referred_objs->trees; p; p = p->next) {
-				tree_ex = oidmap_get(&configured_exclusions, &p->item->oid);
-				if (match_packfile_uri_exclusions(tree_ex))
-					return 0;
-			}
+			if (referred_objs->trees && want_exclude_object(referred_objs->trees))
+				return 0;
 		}
-
 		ex = oidmap_get(&configured_exclusions, oid);
 		if (match_packfile_uri_exclusions(ex)) {
 			oidset_insert(&excluded_by_config, oid);
 			return 0;
 		}
 	}
-
 	return 1;
 }
 
-- 
2.31.1.456.gec51e24953

