Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386BAC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1614A61165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhDISLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhDISLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B55C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v70so6712395qkb.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdA8LxFUWNagk/RIX9FVsJyfYnGnBv/1R9IfVNDS8JE=;
        b=GKHOqUmSih9O6LVsI5YzBS9XM7HqXEWoz6I7rwS4Vn8G77woPXCAJYaXVqdBGyd0fu
         oETeIkdFziLWVzlv9prhgdWIWG9/NNZKQP03/pbm7bxsm2fbkXvg954jR0cm4kICGjEY
         pUYBGY5Zl0Qgrt0I4h8iosA3Ce+4xXiV8T+xsef6g59+PP+A2+5APjxUKoYh2WUT4QAN
         alxHywkOd+0LiD6zEVWwt8pF8uENwy2lsRA4qTmYRK3CqKt3WfVwGsBCJHlnCw1WjeRr
         kXpT4q53HcSwnY1wucSwcbW44C0C/2B8Qp5GrNidp4RwfPVydGW3+dZZ01cftFTFU36a
         7+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdA8LxFUWNagk/RIX9FVsJyfYnGnBv/1R9IfVNDS8JE=;
        b=OaDoBoc5Ic9+J4p238s3APopUfZlPU3oTdPM/cw3gPL+oFzvBR3cYFu6qR1DF9cnRr
         Q6AEcqEIkQ/57QS01AC4ZeQ9KtZl0iCko9VQ7Q+GAN4djYB12okmZg8MFPvaex9BKnDK
         yi+3uVSlpGGEFmUd5Nh0OZ28t1vmhrRVRUTESwYwFFlPlYbrdjdQ7/V6xL6bFa77PxlV
         j3ge6mnEeY21xrgvOFAlUThqoRiQPlIcmkVjdyUhAJZomds0F3tf30MAB2qkPRiTtIqb
         djeA0uLjwM27ZUfGP+md/xxtLP4kwz/SkhtdLP2dV5KaX09TJg8D3YdOjxrkowabvtkY
         qtew==
X-Gm-Message-State: AOAM532HVOOyG/ElDC/goEzOd5zf8D5Pbvr+FGCWH8kxy3HRm5TTjkoS
        /xSVIwTutI9asxg9QMt29fOJGpTaW9V5Iceb
X-Google-Smtp-Source: ABdhPJxotrLHFKwIyfi73JqlXmE7B393K1SVjcWwDIjrw3POdjqqyWKBczZ+BV52EmwCA7Q3ZvCjdw==
X-Received: by 2002:a05:620a:16b0:: with SMTP id s16mr14832824qkj.115.1617991883316;
        Fri, 09 Apr 2021 11:11:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id j26sm2374836qtp.30.2021.04.09.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:23 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 07/22] midx: clear auxiliary .rev after replacing the MIDX
Message-ID: <26c3a312f9b2d073b0f50c44b78a7f3eba204eda.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
clean up any auxiliary files (currently just the MIDX's `.rev` file, but
soon to include a `.bitmap`, too) corresponding to the MIDX it's
replacing.

This step should happen after the new MIDX is written into place, since
doing so beforehand means that the old MIDX could be read without its
corresponding .rev file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 5249802326..a24c36968d 100644
--- a/midx.c
+++ b/midx.c
@@ -1076,10 +1076,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-- 
2.31.1.163.ga65ce7f831

