Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C57C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559046108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbhIIXZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349193AbhIIXZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:56 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D69C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f6so79066iox.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7nqV9WfFtPETODmBhucsE1hvbSzAfz7L/410X/EGp9c=;
        b=UxD5Nju+oP0k4ObG/EVlDN0p+CI/tb/TfMr4JvRRTkM1Qxm6J+uKNXf0WKlHcet9gW
         weq8zsELwA2LtaYIzfyA2RsL+q+EvCCv6KAr2oeXbc0vBFNQcZ2v82h769zG2ZgcpXsB
         MRpGalzX5HC2v/lry8d8G9WQJoHtZ5CDPkYEbRVd/2/OrMKRHFgHQGubF1lD0c69v5hT
         xpsfOHTLLHuE6O1CRO6ijqFSEPGyUTt03kB4wXsAgJmWqh51QkJJCTkyOTX6gY7FY4ZP
         Go8lvM54gFQeAdnrdX2LPKhuXG6XGC5evPfStQE59BQDCKmHSXLQDpdzUvjoXCAmH9K1
         fdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7nqV9WfFtPETODmBhucsE1hvbSzAfz7L/410X/EGp9c=;
        b=JTRJhy38d4Oj0FV3XI5chEtc+j7kkhQHeNviL640eJcCswBzGeHKBr7OwBVZRqdVBq
         NGbCm0RB/gdi609prYmGx/tQSwuKkc2CHcKxKRROCWvONtMgADYK+lZwj0wAx4JV5uIE
         KugdkiMdctZzo+K5yZQw8jDGWjnQ7MQWlx+gKzV1iqUptqpfZrPwFzmXQPWP547oRF6I
         HMlIcolmtHgfU6LBfG3hHEaAuGbus/yuzBDCdZt9jtx+0od4BEWPn0J+7ueNUMO7anKX
         w4AvHXB12disKFkZI5FaOZzNyTDejH4QNQET0FcJT7IfGG4OzmroCb/kO3395KD+3Cq7
         +ILw==
X-Gm-Message-State: AOAM531pJF9xA4eEGrb8hhnu1z5tq707qW0MX0ZX1A3W9E1LFSYijsyp
        rdqs57ix75CBckNU8HXd0MQBwuAJkBBZfQAB
X-Google-Smtp-Source: ABdhPJw2ZZ4SRIwYCLBWeTKO5FOD1XHaIjKKZx7KtUHqqF2IwgitleJ5cL1hnuSGWhFc9wu/a9jnkQ==
X-Received: by 2002:a5e:a81a:: with SMTP id c26mr4668245ioa.15.1631229885645;
        Thu, 09 Sep 2021 16:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a16sm1662614ili.64.2021.09.09.16.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:45 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 5/9] builtin/repack.c: move `.idx` files into place last
Message-ID: <6b340b7eba1509ac12291d2d1a20c146a2800f80.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous patch, fix the identical problem
from `git repack` (which invokes `pack-objects` with a temporary
location for output, and then moves the files into their final locations
itself).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..c3e4771609 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -208,10 +208,10 @@ static struct {
 	unsigned optional:1;
 } exts[] = {
 	{".pack"},
-	{".idx"},
 	{".rev", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
+	{".idx"},
 };
 
 static unsigned populate_pack_exts(char *name)
-- 
2.33.0.96.g73915697e6

