Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C71C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527FC64F5E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhBDJcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhBDJcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 04:32:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB44C0613ED
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 01:31:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so2688304wry.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 01:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pbx2zX9Lb4qAnDAabqsCU5n0npMAGZopg3hc8MCT9mM=;
        b=agUdMfAXYvQaBWrmWAtdgfFrHIOGYK52eRvvEn/kAxPOyCIveyE+G4aizaoiRdKhl7
         Gfu+Fe/coE1xJVjIZXK3vxX8DlR6jYdLLBp21HzO6C7kBYg8UhTRABiaoSOf+CB0IsLA
         OdDGIm0HTIF6SQZYeenju5QEeSp3CR6XIZKiQQJffr70rr4/UaKpRSJVpifSq7ogqli+
         XPJ51PDkB0iV9MhYHbFhcPdcVx4Zs2ncsNHNH9DHzxZPsBdM1LK1TxT2dhyj7pEeI7W6
         zjX9kMdT4wb2MNGuboIGjQbVb+mKt2KCQjspPIdf8PCHenscHArT3u7eriL7FHCmra7T
         dQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pbx2zX9Lb4qAnDAabqsCU5n0npMAGZopg3hc8MCT9mM=;
        b=p/BwP/X1IW8Gfv9QpeBAJsnPyfIuMER8AjXi8aH2z6hUVJEcUbK81/xI2ZaV0ScOZr
         AJ+Y3wPpBWZpfJnzx4/5ShJpAbtShfdfmNY5fiqbEeQ8s1nCnerbJXMk0Cj6tfTHeZ5P
         bAZAu9cFElfMY2jDgEHMtwhFLYbFQQLEGe+vDys3tay1yX/BjRa9P32JCF2KCZOLgKan
         u78MExGvVYkNNykmsFMstI7QtZfZuyOy8R9xwvL+fAzKDDMwqkK3uvm90o/gn90EORwA
         SLW2PJYVuafRUHJde6+009xNENXCgCIcy3U/4BJA7y3h8AswLNJmDHWFoNjjfrzVcgSo
         ZPmQ==
X-Gm-Message-State: AOAM533aoVdqzjszvTGPJzxCYedJxJUJhr1PeUT6xaGmfexUs0VPu9sY
        7S74Qp6Jme6e2JXKiCDw1btrpQC/T1U=
X-Google-Smtp-Source: ABdhPJw8K6V+KdBQVC2FyZAHqM9CcWIJCXpiWwSQqlXCPb83fScUC2lcvt37+2ztpa9a0xUeiUcLiw==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr8142593wrn.202.1612431097563;
        Thu, 04 Feb 2021 01:31:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm7271698wrm.52.2021.02.04.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:31:36 -0800 (PST)
Message-Id: <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 09:31:31 +0000
Subject: [PATCH v4 2/3] range-diff/format-patch: handle commit ranges other
 than A..B
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
described to specify commit ranges that `range-diff` does not yet
accept: "<commit>^!" and "<commit>^-<n>".

Let's accept them, by parsing them via the revision machinery and
looking for at least one interesting and one uninteresting revision in
the resulting `pending` array.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c          | 19 ++++++++++++++++++-
 t/t3206-range-diff.sh |  8 ++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 9b93e08e8407..07e212d5bb8c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -11,6 +11,7 @@
 #include "pretty.h"
 #include "userdiff.h"
 #include "apply.h"
+#include "revision.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -567,5 +568,21 @@ int show_range_diff(const char *range1, const char *range2,
 
 int is_range_diff_range(const char *arg)
 {
-	return !!strstr(arg, "..");
+	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
+	const char *argv[] = { "", copy, "--", NULL };
+	int i, positive = 0, negative = 0;
+	struct rev_info revs;
+
+	init_revisions(&revs, NULL);
+	if (setup_revisions(3, argv, &revs, 0) == 1) {
+		for (i = 0; i < revs.pending.nr; i++)
+			if (revs.pending.objects[i].item->flags & UNINTERESTING)
+				negative++;
+			else
+				positive++;
+	}
+
+	free(copy);
+	object_array_clear(&revs.pending);
+	return negative > 0 && positive > 0;
 }
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be0312..e217cecac9ed 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -150,6 +150,14 @@ test_expect_success 'simple A B C (unmodified)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'A^! and A^-<n> (unmodified)' '
+	git range-diff --no-color topic^! unmodified^-1 >actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color master topic reordered >actual &&
 	cat >expect <<-EOF &&
-- 
gitgitgadget

