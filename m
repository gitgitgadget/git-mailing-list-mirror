Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1276420281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbdI2UMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:24 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:53763 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdI2UMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id x78so328563pff.10
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ioYDx7FKmC+8q21mXaVLoRtbYGWqP7GT+h8COqjasDA=;
        b=BcMIVBlq5ZaRs+LC+/KKC6KRlySYX307iHYAe0+3Q5JsW2LWy0xjC/1aXXzA7oUPv+
         BDGCuvjj1t7RVyDuCAVoMR6cgJM3wZctVErrxqk0jQBWTSca6AztwX5GKilWrszPMb0i
         35OYtao2xJbbgnoMdpOK4Z0dst4yaxwha2hlgYrqzyYrdETvRq/J+2PH0WbGSj0ZzCEQ
         4W58Ia5e4RhB+KhKcggm0+spE425fgmcn5L9uDpZu8ZoJaCaySXVrOu+QOqMObG5KIHQ
         DduojcTvA7tpY+zILjGD1M3fBTd+raJNjTsWXEaohJjKA5kJyhQK9ITe3kJc8kaprKab
         GkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ioYDx7FKmC+8q21mXaVLoRtbYGWqP7GT+h8COqjasDA=;
        b=SHCeZN2iX5CMiKPjWtuZKTrtA2+FbCHcodqszhbBLLJL5m58ehB5EkO7mgi2uv4eir
         JZDE81RL380G7e09etdxO4MPzX9XI8J2iz1U//S9wPIP32QdcdQ7EMQHppp5sZitT7Tr
         C1M5sxPZ+5aGBYiwJWuS9NPdv+bscNWdVtnUB23gC+4PeuQpmyhioLdSgdmVg1PhfDuR
         AwcfmnZmVGJJ4Pl0ZeartnTwA99WQRje3AEWnNclNqzY3Q8n9j5SJTroLCbkCYh6WVr7
         WOoTkUMWovbbuqTtskJsYh67Tl4+e7t418nyLywB2bhCNrGLCETwN520QUdVh51XoqLY
         ZAiw==
X-Gm-Message-State: AHPjjUiNcAoNsaAzY+ZwcntyT9sD3oB9mnVm0ZmeSJp5lVVZXABC9TkR
        oxI9dDiW6Fu3HaeWzgD3R+4bAQ2gkMg=
X-Google-Smtp-Source: AOwi7QC47yvEMlNuyZ5g2uiq1L39MFDveFPesV30x6euRtRYsGjY+HpIMvjjhUqfiBtKNyaUdbVyKw==
X-Received: by 10.98.68.82 with SMTP id r79mr8924359pfa.184.1506715931816;
        Fri, 29 Sep 2017 13:12:11 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 03/18] fsck: support referenced promisor objects
Date:   Fri, 29 Sep 2017 13:11:39 -0700
Message-Id: <5e5806e020a639560bca397d77045cc5286c1655.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing promisor objects indirectly pointed to
by refs as an error when extensions.partialclone is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c           | 11 +++++++++++
 t/t0410-partial-clone.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f1529527b..4492a4fab 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (obj->flags & REACHABLE)
 		return 0;
 	obj->flags |= REACHABLE;
+
+	if (is_promisor_object(&obj->oid))
+		/*
+		 * Further recursion does not need to be performed on this
+		 * object since it is a promisor object (so it does not need to
+		 * be added to "pending").
+		 */
+		return 0;
+
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
@@ -213,6 +222,8 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
+		if (is_promisor_object(&obj->oid))
+			return;
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bf75162c1..4f9931f9b 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -102,4 +102,27 @@ test_expect_success 'missing ref object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+	test_commit -C repo 3 &&
+	git -C repo tag -a annotated_tag -m "annotated tag" &&
+
+	C=$(git -C repo rev-parse 1) &&
+	T=$(git -C repo rev-parse 2^{tree}) &&
+	B=$(git hash-object repo/3.t) &&
+	AT=$(git -C repo rev-parse annotated_tag) &&
+
+	promise_and_delete "$C" &&
+	promise_and_delete "$T" &&
+	promise_and_delete "$B" &&
+	promise_and_delete "$AT" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.2.822.g60be5d43e6-goog

