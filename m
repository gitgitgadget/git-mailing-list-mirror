Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F99C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C23761157
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhINWHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhINWHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D9C0613E1
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:13 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a20so706608ilq.7
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dViVSMM9wxtKjXJwwl3RE2HtW0ysTkcAVhFYfSvCLx8=;
        b=kFa6OhapByq9+1aD1mKjKvkO1iYesAmoPNm9DTwOQ0PHw0aN4wlsq10gWexd/HtGx7
         iGwjsWu4xlcLU+W9TsMevPU353ObsokUpgR78sOLcsEHLbtCKWeLYpdJF558LRNrhUWM
         Vpd5GVOvjm15WIAVpJp/79FcO5p3+qR8COVIxxtzi1UyYmHtms0cRr2GqP6Z5GY0jqOX
         I8PSp+K65IZcaN9BIZ6aSE6dFex2Cw8JO96kMclCBL9bmhlI7z9Li9zjVAa8OEfqqnYT
         /Gsx8Y5MQkZqmwvPH3HCtMcXTMJm031gHqjz0vFDrkvvy5YixkEwfwoWdIo3WfpQidA4
         zOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dViVSMM9wxtKjXJwwl3RE2HtW0ysTkcAVhFYfSvCLx8=;
        b=BP8dwOBYv83jvF7J9qJZxJzHAgmmVVzsgXi2sYu3fH+zB8scgZ/8CHUpQeSznEEM3d
         KnNG6dP1AOcIY9c5U6cFtyWpu+N1Iybbu/e7aWGLn9T9RAZccnOWF+JA2R7G3C6x5J6v
         fdDIL5sP0g1HK0IlYum1CqHbaUhD7yT8axwAVG/y1TLavI6kv2RSm4GFlQSadBDSpAk1
         minrvY5XloAwV+PF+06ffrSF7SGC58eXxS0xf37u2+IGRNF0ssKlb+IMYiliXHGqZffq
         2Mixrs/Q68AKqEQfBCopIJTtQDtwLKD7raqc1P50ScKQnroFshxU1zyFsfavk3iopSJ4
         hXCw==
X-Gm-Message-State: AOAM530CZmG9u/yBDUjT+VvxxAOwnhRQ0xh4PJrz3qPgp40EaO7nI2wy
        O5DWBrruncHIUU0MHgfuefgsaImZFx1fSIBX
X-Google-Smtp-Source: ABdhPJw1dOae6t6AXCn/qnLPuFFxeFJiXp96oaIjzJJYPFFnQhGcg0q+07U0ujXAGBFAev2KBLOI7Q==
X-Received: by 2002:a92:870b:: with SMTP id m11mr13904531ild.132.1631657172484;
        Tue, 14 Sep 2021 15:06:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11sm1680656ilh.73.2021.09.14.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:12 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 5/7] p5326: don't set core.multiPackIndex unnecessarily
Message-ID: <191922c8f28c338ab3aa4faa57d75770a9eccd02.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this performance test was originally written, `core.multiPackIndex`
was not the default and thus had to be enabled. But now that we have
18e449f86b (midx: enable core.multiPackIndex by default, 2020-09-25), we
no longer need this.

Drop the unnecessary setup (even though it's not hurting anything, it is
unnecessary at best and confusing at worst).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index 51b5636259..a9c5499537 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -6,10 +6,6 @@ test_description='Tests performance using midx bitmaps'
 
 test_perf_large_repo
 
-test_expect_success 'enable multi-pack index' '
-	git config core.multiPackIndex true
-'
-
 # we need to create the tag up front such that it is covered by the repack and
 # thus by generated bitmaps.
 test_expect_success 'create tags' '
-- 
2.33.0.96.g73915697e6

