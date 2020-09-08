Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DE5C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3891020768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gENVZcoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgIHTsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbgIHTsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B64AC061757
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q130so175305ybb.11
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9bdwFdUqT3DPsyQ1QrJMIauvqEFN4VWAUUcDJ/J9fIo=;
        b=gENVZcookJJIF4TkoOw+1jS1jp6cxZBqvEhPZsw/Cqzpl82v2+JF7jNrcy0UYep5/M
         1RcjoC6MzMDmK/fNoUF9F06VPz9F+p6ucQ6xbhKZIncyN9XwssHR3wYFDKC1ItHBLiFI
         sl9k0dfobGiGrvbagADZDgsW1FLY3ZcUrenK3CrWIjGHhKoWHOzwrSdpHEglEMJJ65uT
         VK+fvwIz0lZAB0W4qwjpGAUP8iOZPIqNBQJiYkHsSB60SpPQWwsYIImF1dJCrGM0Xkze
         hrSUsDtpQa9ElxQhhdVxIVrCa2UrRfwDI9Ys7toqydyNfZ8f6M7NhHEjn1wiy/qQvDV/
         TmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9bdwFdUqT3DPsyQ1QrJMIauvqEFN4VWAUUcDJ/J9fIo=;
        b=eI91NbOwlcZGipfY+a+azRHbUK72LndJV2IP9t9Ix/e36aecqSMF4dfhFhF6s4VvS/
         tj8wntH9ttBval48FCUSeI508VLsNNX3RCa8XVsiuzxPbki5VnePOgnBCUct4U3hSSEe
         anbboPimy0/DCJEa0DKZHKiFErlktNKyvjMP4zzAAu/HVMmCO7kHYumeKjZq1ubECCq0
         ZQuN9qcoSCfjloworda7/CNrHszylaA5ZySlqkykUwlJ7rUAi2TBmsAiX333oDMytG2y
         42IZzwcYB7tB65iLHk8Gricjyd4yhzltK+FVcMPQM612WDHXNUymKIXWiXqpml3TQ+yI
         Oeww==
X-Gm-Message-State: AOAM5306hhuwQ+qMW70iF9s1TtBbfFSLpgqIpiWXXxJs2QyftXPHQao1
        f/f9uqooc1C/mKpJZDevxz0w29U8e0MvbvgF4DzfrPLhhwc2tpcTVyHbJU/t8sQalf+yBv8qS5Y
        qD5uGEyKNyqj2jG9fjUyPAqlDIJbvmY/rpnfAWnUwx/Ejv+P92vPBaM0gKddEld2JH01ff/4vHs
        e/
X-Google-Smtp-Source: ABdhPJxi+k3a+5wyJbIexFuU5c1PEqqedtiJ85WpfLPUjA6GrRlL25ylFeur7KSUXVdfRXJ7FQOsCcCmjZZIfT4s+3cA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b122:: with SMTP id
 g34mr844712ybj.196.1599594525322; Tue, 08 Sep 2020 12:48:45 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:30 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <00502dee35e2d21fda2b240b57381b09b098e198.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 2/7] index-pack: remove redundant parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
the object type is already present in the name of the function. Remove
that parameter from these functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9721bf1ffe..0e0889afc4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -614,7 +614,7 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
 	       0;
 }
 
-static int find_ofs_delta(const off_t offset, enum object_type type)
+static int find_ofs_delta(const off_t offset)
 {
 	int first = 0, last = nr_ofs_deltas;
 
@@ -624,7 +624,8 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 		int cmp;
 
 		cmp = compare_ofs_delta_bases(offset, delta->offset,
-					      type, objects[delta->obj_no].type);
+					      OBJ_OFS_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -637,10 +638,9 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 }
 
 static void find_ofs_delta_children(off_t offset,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ofs_delta(offset, type);
+	int first = find_ofs_delta(offset);
 	int last = first;
 	int end = nr_ofs_deltas - 1;
 
@@ -668,7 +668,7 @@ static int compare_ref_delta_bases(const struct object_id *oid1,
 	return oidcmp(oid1, oid2);
 }
 
-static int find_ref_delta(const struct object_id *oid, enum object_type type)
+static int find_ref_delta(const struct object_id *oid)
 {
 	int first = 0, last = nr_ref_deltas;
 
@@ -678,7 +678,8 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 		int cmp;
 
 		cmp = compare_ref_delta_bases(oid, &delta->oid,
-					      type, objects[delta->obj_no].type);
+					      OBJ_REF_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -691,10 +692,9 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 }
 
 static void find_ref_delta_children(const struct object_id *oid,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ref_delta(oid, type);
+	int first = find_ref_delta(oid);
 	int last = first;
 	int end = nr_ref_deltas - 1;
 
@@ -983,12 +983,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
 		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last,
-					OBJ_REF_DELTA);
+					&base->ref_first, &base->ref_last);
 
 		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last,
-					OBJ_OFS_DELTA);
+					&base->ofs_first, &base->ofs_last);
 
 		if (base->ref_last == -1 && base->ofs_last == -1) {
 			free(base->data);
-- 
2.28.0.526.ge36021eeef-goog

