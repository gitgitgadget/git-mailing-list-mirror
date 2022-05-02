Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F8C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386569AbiEBRNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381800AbiEBRNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84A5F76
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:09:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso13608680ybs.20
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRPEd1jdsVWBIW/HZyF5sMLEXA3CuDpuEK/14caxkEs=;
        b=j9VEGXp8W8KUzC4fagOoBaldQUWj7Z7LjbgaCvj5HnzEfbdkRAO0sxpTE09xXKsNkM
         DcEKVe6donu4131ag0ERNWUVxdbY8jKTxY6n3N4ANnUskn3sC+cqC0uNtAsrCXjva5bK
         udr6q6vle/vO/VjCMWx7PB5kTuMfBkimMWqwXweuABnX2wvUl9z90ko7ZWjTcHxp13lK
         hg0aU8NvZH5tqaazyY8py1gSNPVs4/m3DaP6ruA8oogQPof5o+3/8yPEQ02F2WIFKXFn
         Kr95BzY88+ezR3OzvVVZoKJPgQszmr6hMF8oI+IAztW+PisAKTBeF8VRp3HY7M5WkgmN
         f6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRPEd1jdsVWBIW/HZyF5sMLEXA3CuDpuEK/14caxkEs=;
        b=F/e5mRNhhcDmxET+dbeUS8B9uZM/Yvy0dkm0JbmRzPTvQtbxVwDzKGZDB3RLOzvTNT
         FoYqyktavMHmkSvRGH7dHVyzEEg0rZDFga9cYqbjjatiu52ZJNeiTZ3l4d/EgCaMjZKR
         g19mFEdky9HldAVgER5xlrgNWxV4QpLtwzwbK8nRJ0PPrNaQqcDaoicdO7XWRF9m46c9
         QS6wHaExhch+qBELpZN7a3tnlW33qHnnFfIkB78PDRLzLggP+GNMjnzLUPNqANMAw2VU
         CxBYyx7qPlnt+3QWpnoAfdxvi+ZTtmBe5cGXi6Nr/8DmuDMQsUhVWFkC8P0AqnjwrWhy
         oVWA==
X-Gm-Message-State: AOAM533Lbb78GZRv7gzIwLQOgW3f46BBeqf/irAe6ysBTcfrdVW+zL/Z
        3gffDhMj5jbQhp/cg6wn7rBEfdN+MuDH/u/DDBzntYD9I1nU8uKquwe4h6YrXaj/OeumZHsLDOo
        w/lhe3K5mN6+lHflvu4UK5ckB0PwafNhBhxrZL5fy8UPrHqbksWwlqWEKvZ70c+wyXg==
X-Google-Smtp-Source: ABdhPJz1m6WMB1esuo53zcHOAO1Pkv221pE43FHaoJ9MmP9Mmstt6dUFKmswCmvp4K5vhaem0j13XZrBYICG7nM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:841:0:b0:641:960f:c47f with SMTP id
 62-20020a250841000000b00641960fc47fmr10742725ybi.607.1651511398341; Mon, 02
 May 2022 10:09:58 -0700 (PDT)
Date:   Mon,  2 May 2022 17:08:58 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 2/8] fetch-pack: move fetch default settings
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the state machine in do_fetch_pack_v2() is in FETCH_CHECK_LOCAL, we
set a few v2-specific defaults. It will be helpful for a future patch to
have these defaults set if the initial state is not FETCH_CHECK_LOCAL.
This is a safe change since the initial state is currently always
FETCH_CHECK_LOCAL, so we're guaranteed to hit that code whether it's in
the state machine or not.

---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index e06125c90a..45473b4602 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1610,18 +1610,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.36.0.rc2.10170.gb555eefa6f

