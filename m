Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE5C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47420207C4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5g8iXzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgESSbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESSbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:31:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87360C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:31:55 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r9so313147qtn.20
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8NRW6ne8SCkRzv8mSkxWorADk8k4EhazCy6Lw0VPafk=;
        b=d5g8iXzEecMlPYgo6nXGwEK0v56k8blgPfduS9ge/Inovywy6h36kvenFUXMJqcSYL
         ZcGsmZpcf1adGSupJ9B8cIgLVHBWLh/JhlCD6aaGf/gE4jugIs2CZVlDgS2KsC4Ih2aZ
         0w333qQGEd+Pxbk+6U29+Qj+Ik5YoF+46dfi51KG3e4KUXie5v7OmaFaObbZbbjqcFLm
         R14PhfbSkXy4tg8sH+XlsQ4iAgzx2T8uq06fJirZhs1fgrbikCeZGhr8oKsAp3UPc3xN
         Zc1dlsXUZKxC/W+aletW325bEadzYMRIpi1LfM+guvhhQxbE5O70EKQXpH6yXTqKOHY6
         rwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8NRW6ne8SCkRzv8mSkxWorADk8k4EhazCy6Lw0VPafk=;
        b=NEFQdSPzQ3gnBCcBT9kYGqmrB/hQMp/YAjDFjVvngEBF9u8pSMi9O2InHN5/pz56Dc
         N7bcPEzvsjGfz1WbbxV0k9NxvxnsAqrRyOO9mEKS3F0tXRKD+NU+WhenVt73NxBV0CeY
         zV3IHqi0BeLeAeb4edxihvFA7bLLnU573YSL84epOxVzjJfPhv5n3ypr7RT1QWHc6LBl
         bzAkmMbxdvP9BFgjGTzc1tu0wHRrtlkz+LnWQCoG5BAHApEMswHgweki5gQZ6zxTftLv
         ywrt4XfKPgPTb3jxAtlleju5Vvtre0uJJCG6C8yVVDxjSy9OG20xmNfbhNVm16xr/Pas
         Rljw==
X-Gm-Message-State: AOAM532i6SOXK9Td+bpubxIxPD7VXp2V+CNjhpIFUSAoGKTtjBR95TId
        NQeftmUGvaLwMu2yAuub07WB467LCxAEf1Y6d9uep4tA1NJrUJKnskdp2PbpAvZf38yLAVyIhs5
        MCuctCfKuP6D64D1AQ6dzqenm0fbHm7G7GJPzFmIfVEECTD1EuYDxNKIgqGR01Q1OYgKSgWbWKR
        NX
X-Google-Smtp-Source: ABdhPJzwoHOaJeHZ1iu/SsM78V3Ca/xDNJhjkXdof/8UAqhpoPgUN2wgkJPXYG0qH4QeRlG/Qi+7duJfDjSvX5SgUyO2
X-Received: by 2002:a25:d0d5:: with SMTP id h204mr985989ybg.430.1589913113870;
 Tue, 19 May 2020 11:31:53 -0700 (PDT)
Date:   Tue, 19 May 2020 11:31:51 -0700
In-Reply-To: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
Message-Id: <20200519183151.46138-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] t4067: make rename detection test output raw diff
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

95acf11a3d ("diff: restrict when prefetching occurs", 2020-04-07) taught
diff to prefetch blobs in a more limited set of situations. These
limited situations include when the output format requires blob data,
and when inexact rename detection is needed.

There is an existing test case that tests inexact rename detection, but
it also uses an output format that requires blob data, resulting in the
inexact-rename-detection-only code not being tested. Update this test to
use the raw output format, which does not require blob data.

Thanks to Derrick Stolee for noticing this lapse in code coverage and
for doing the preliminary analysis [1].

[1] https://lore.kernel.org/git/853759d3-97c3-241f-98e1-990883cd204e@gmail.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Stolee. Yes, we were never in a situation where there are any
missing objects at the point of inexact rename detection (despite having
a test exactly for this), but this situation is possible, and I've
updated the test so that we encounter this situation.
---
 t/t4067-diff-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index c1ed1c2fc4..ef8e0e9cb0 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -125,8 +125,8 @@ test_expect_success 'diff with rename detection batches blobs' '
 
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
-	grep "similarity index" out &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD >out &&
+	grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&
 	grep "git> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
-- 
2.26.2.761.g0e0b3e54be-goog

