Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FCC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B351D20842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJAIoUTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgHEBVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgHEBU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:20:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACDC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:20:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a5so38104998ybh.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NGOwp5Ax/Dj/W31vyP2rRIH9UgY9nuf4W9Gq8qSK26Y=;
        b=EJAIoUTW9EVPZ3QgbGtxzAYNKR7lvALo17R6amFNM8eeXBGZ2zhw+HtZa/JYT0+cA4
         8iP8OmkarwIJ7Bf+0MA5AgF6NOgYNKSoHJfLvm+Y2A+klw06HGqGV9wCNn7ync2JYEer
         jH2MJnLlnzap9pTtIWSHnsAxKJ/HJHaIa8WFV9oyGftvyfAPedusAynNHMiXe9Ze1Idv
         3V/pR2BeZ/5UrLwxbaJR5kAfgSY3+HsgSvntXevjTo8NbnIePjB4KcjTM1w6d/mOK0Bm
         KB16d4omE+VhaWL9Q3VQO/RQORaP/oMTmMhCUC2+UQsA/SX6wy62vQZI0AGcBb6470VK
         Czig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NGOwp5Ax/Dj/W31vyP2rRIH9UgY9nuf4W9Gq8qSK26Y=;
        b=VPrcRdE8z8VjAV5WHX1cFUiioJjrR5YTtoPm2kj9oyFQuFYdYPhCNzOF3JwAXES3eK
         OUUBOKCvg2aQ/6RXNtbf3CVLLaz1aSAOvrBBLKpk2JIR+sv06uahY7E8V6BmTTxt4Cj7
         0bsMsqQd7HH0AcziTq9QHIbkqseYePXKeedgiCPgG5vGR9lFmNDjrGjah8qBawy6pXZQ
         9wBdeUvODCwb2n2KR5vLPelIlB9qPE0Ps8QXPxngERJfuz/UDj6hvj1OiMrR1nEc9TMc
         rDemt2l5+OcaonxJH77kcQOs+9GfbpOk5qYq0SDf87K6XicXUo9d6/cqY17K0Muu4/8v
         qgfg==
X-Gm-Message-State: AOAM532Z6prfZ14WavvAUxaTmG5KKQFZ4Ft5S+5ipNTlj5t2rpZnJHKF
        1+8bjvoeLFridK8Vgz55IEOOMx5mXlJVsYgrutBIlti4L4S9iduEuzoAlsvku/8QpL+0l3VE3WU
        d5YqiKpcFEMjFKrYa/gAFoZG3E/SrNobxpllVroS9iNDHVvi8cQ64zGkII4UOlMcXJdwbO0NcG1
        b6
X-Google-Smtp-Source: ABdhPJy5kn1PUCyTyggXJt6+Ee8Y+rZPi/WDTzcgg6R2MopNIsae6/n5hHicEZLuZg/nEdgzvtM8sYRzjEqQEmRkFplc
X-Received: by 2002:a25:3446:: with SMTP id b67mr1161420yba.460.1596590457393;
 Tue, 04 Aug 2020 18:20:57 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:44 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <044a782863dd690ed4e430b3793538f701a850c6.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 1/7] fetch-pack: allow NULL negotiator->add_tip
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, a null fetch negotiator will be introduced. This
negotiator, among other things, will not need any tip information and
will have a NULL add_tip.

Teach fetch-pack to allow this, and to take advantage of this by
avoiding a ref and alternate traversal when it can. To do this, this
patch combines all invocations of functions that invoke add_tip into one
function, and that function first checks whether add_tip is NULL.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 80fb3bd899..6c786f5970 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -240,6 +240,16 @@ static void mark_tips(struct fetch_negotiator *negotiator,
 	return;
 }
 
+static void add_tips_and_alternates(struct fetch_negotiator *negotiator,
+				    const struct oid_array *negotiation_tips)
+{
+	if (!negotiator->add_tip)
+		return;
+
+	mark_tips(negotiator, negotiation_tips);
+	for_each_cached_alternate(negotiator, insert_one_alternate_object);
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -262,10 +272,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if (!args->no_dependents) {
-		mark_tips(negotiator, args->negotiation_tips);
-		for_each_cached_alternate(negotiator, insert_one_alternate_object);
-	}
+	if (!args->no_dependents)
+		add_tips_and_alternates(negotiator, args->negotiation_tips);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -1575,9 +1583,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				else
 					state = FETCH_SEND_REQUEST;
 
-				mark_tips(negotiator, args->negotiation_tips);
-				for_each_cached_alternate(negotiator,
-							  insert_one_alternate_object);
+				add_tips_and_alternates(negotiator, args->negotiation_tips);
 			} else {
 				filter_refs(args, &ref, sought, nr_sought);
 				state = FETCH_SEND_REQUEST;
-- 
2.28.0.163.g6104cc2f0b6-goog

