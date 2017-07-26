Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643932047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdGZXaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:30:16 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33698 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdGZXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:30:11 -0400
Received: by mail-pf0-f173.google.com with SMTP id d67so8503067pfc.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MUxTlsMgb/gO7vx1mb0MXLlPZeqs1NRvkcjOKz4LTLU=;
        b=CEqRjTTTv+BUi4qMVMW4+9P0ItqjPQtywpWlWoyfbMfIP6autbQAEzTlgoj82XHcon
         W4LRoMynDcbZ0nmKRfU9eZ/UtZr1h+yAL4OCHdR1XIVO0iv2Prg0FFtT8DwvF4HrZz2v
         KORPBTmO0jKOX6S+GToVgAsxS9+jjo93upIM4G88LCDcVcQZWdgf/v+XALmB3aMaw9S9
         yxI/N2s968dG3Aey/dMqxSqiooHAGTslV1W0HTjqMXva6H1BI6ceoBqS6XGt8kRzta+3
         QUOVj0wlVH2kaJJJkPURC3ja4DdMsYfYwvLQsh4HQTS+ZuoLg+xsoVoUCVnbr7F0abDR
         qrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MUxTlsMgb/gO7vx1mb0MXLlPZeqs1NRvkcjOKz4LTLU=;
        b=bvIcjoK8qHiKJEWleKBVn2UrYlXZ1S2jr7AbqUmWb1NMs4Xl6eCmELerX4nymuL4P9
         9D48WZpEhHGmQBUbTalbeHOFnuIqiWpkB9011PTz4AjNuXTQ4a3NSU4oj86hob6KHMfN
         00tw8UGVMDIeOEoRWz0ZHnR/ZSa5FXmjMbJdetIqgvDQVmV1qFGvJXj63a2SFiCBilVc
         Whvl3rjRC1kawrZFH1FFQDu4FoXJonZIHOytT9F4kZ8E0H48lylFwTDQ3+4g8mVbVK4E
         u5xn/KlMU79gW2t3X1dkd+CWwgwRJLp4MAuQ/zr+a4JnAuhWNAe2mOIcCf3AxozwmmPu
         8m+w==
X-Gm-Message-State: AIVw112quPojQORsV02krNGxCWLjZKZfKjhH6Ysl5uibJ9o9JFb2Qzck
        EZszZ6i2+MzNXZM/9314qQ==
X-Received: by 10.84.167.2 with SMTP id c2mr2403100plb.330.1501111810241;
        Wed, 26 Jul 2017 16:30:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e131sm299668pfc.93.2017.07.26.16.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:30:09 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [RFC PATCH 3/4] fsck: support referenced lazy objects
Date:   Wed, 26 Jul 2017 16:30:01 -0700
Message-Id: <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing objects indirectly pointed to by refs as
an error when extensions.lazyobject is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         | 11 +++++++++++
 t/t0410-lazy-object.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e29ff760b..238532cc2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		return 0;
 	obj->flags |= REACHABLE;
 	if (!(obj->flags & HAS_OBJ)) {
+		if (repository_format_lazy_object)
+			/*
+			 * Return immediately; this is not an error, and further
+			 * recursion does not need to be performed on this
+			 * object since it is missing (so it does not need to be
+			 * added to "pending").
+			 */
+			return 0;
+
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
 				 printable_type(parent), describe_object(parent));
@@ -212,6 +221,8 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
+		if (repository_format_lazy_object)
+			return;
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 00e1b4a88..45f665a15 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -49,4 +49,31 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object indirectly pointed to by ref' '
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
+	# missing commit, tree, blob, and tag
+	delete_object repo "$C" &&
+	delete_object repo "$T" &&
+	delete_object repo "$B" &&
+	delete_object repo "$AT" &&
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.0.rc0.400.g1c36432dff-goog

