Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B80C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7061157
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhINWHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhINWH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:28 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD34C061764
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w1so744691ilv.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u4HKy7NV11ULIZEUfMYUHNPx8hTvspNv2zuQZqYUx3A=;
        b=d8n/UR8lpiY3juv3WXR63f9NssWwhU0DEIpiESuowBJKFITfVyB1AA6EQ/CdI9OVNH
         j0CQJikuODASqmh0bVFazKK4W/Rgi9GPpyGOhBQBsaATbblHePdAO3NJE17hEZDFnzNa
         PuObzJsguWKxD6rLzQnJ3e4dXC76dmR0W5cbCoVRxgs4tVSY29L13jcda9Rg/CCNqGxZ
         JtT96r9VT3yVEGY6PEk9UBJGVoSHgaHp704AgBuFJJUwRWGOKWikUfnYeOAHx7XKb2/c
         osZP+N85FQzuvI+QYzH3YxTYIOdEmlWGtpN+SJ+m/JO1QmiXV/HrgLDTZ03i/W5ZgsHw
         5ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4HKy7NV11ULIZEUfMYUHNPx8hTvspNv2zuQZqYUx3A=;
        b=cFbxCClAC7FSXqBTv+NUl6ec9UWK/DWk7DdmIreu8GokS38aZO6txrd5i11IPFVOfL
         9bE6YPUB9b3twNQY0J5cjYIMk72607SWn14j7j05jBlQ0z0pUXTaOjtUb3262KJ1ZzpL
         3aCAiRHn3YQRv3RWHJzh+TNVRbDnAqfP8aVRel6LAqJg/PPn8IZRdPCl4DaHo7Lgicog
         gM0FnbOlMqg9lf7psjiQVQmBq6F7lEOoLcOr9fSr4uc8fMPvwKS17Egp3tb+p0TLtLRu
         95C7rAYDYRDGGr8a/vLDx1ahCmjc0wicS9y68wrSdNcyhuzRl8LagT2/z0UkYQh6snLZ
         VLQQ==
X-Gm-Message-State: AOAM530crg2fhfPWAdIczDoeaVdL3rbEFziE1V1b1kd3o+ayL9BIJPJL
        aUZTFu0kL5PJgLBX0xE/bEWkpexsGwwo9dL8
X-Google-Smtp-Source: ABdhPJyISUsaU91gbdP1gRy/McL5ZAcxCraQQcCVOzHvmNHOoccf1uF7kJONA5iDEYIzTeyBbLzQDA==
X-Received: by 2002:a92:c744:: with SMTP id y4mr13246635ilp.288.1631657170067;
        Tue, 14 Sep 2021 15:06:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w1sm5387135ilj.55.2021.09.14.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:09 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 4/7] p5326: create missing 'perf-tag' tag
Message-ID: <a8c6e845adf559a96e37c973fea16da8a42e7cba.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the tests in test_full_bitmap rely on having a tag named
perf-tag in place. We could create it in test_full_bitmap(), but we want
to have it in place before the repack starts.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index 5845109ac7..51b5636259 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -10,6 +10,12 @@ test_expect_success 'enable multi-pack index' '
 	git config core.multiPackIndex true
 '
 
+# we need to create the tag up front such that it is covered by the repack and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message="tag pointing to HEAD" perf-tag HEAD
+'
+
 test_perf 'setup multi-pack index' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap
-- 
2.33.0.96.g73915697e6

