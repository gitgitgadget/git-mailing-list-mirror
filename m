Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE4C04A94
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjHJUhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjHJUhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:41 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77039273C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58411e24eefso15172767b3.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691699858; x=1692304658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsn/XV3KpU9p50eo6y3IvKaLDzhPXSi3l9b0jiM0OSY=;
        b=ppLz83sXXYaSFgfdgYlGJM62xJfMRFUVNRyZueUIEcoAmq8Pw//d4MeRLohp4VXd0r
         F4I8TyRXQGFQxf/hkgAybDcHFHv80CyAqjfI9wDEzjzW6I2W391p6HHCK7Ti1ZGZ1efy
         V0uMFkBNjMlGlQEOF8qibNQISyZhIkYGwrEkxwv8B9ZfLAotgdS/g+oLS2c1/p2NgBcd
         bVBfZAJM6YHPLT/FXsBnSfMTOzfMm4DIPvEUluyABIBvb56uLAIUU5K7DRqKg5Pw//Zs
         SU4EapHBkWIhngXKDx7Z+qJ1vKewk3LPuoaLumm0Zt6qetjlsOTu/+GBE6yblFWA1HHZ
         inRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699858; x=1692304658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsn/XV3KpU9p50eo6y3IvKaLDzhPXSi3l9b0jiM0OSY=;
        b=d+I3FDVEx31re7L2dFXDwgGkW6UTReOaiLWBmH+YKklOfRtphQvsZQT7VnWunq7UBX
         0SEI/FRJCIfzEM5EyH5OaknIMoHQZYGe340SHqiUoU0iK0uTy81m5g9uPOwFVaQI2MT4
         r+kGF0xLTWIUph75DhNHteBF9PWKKkMZJjliIAbrnzSFc4iYr90GMeR8oCo9MeIfjdec
         /V9bxUOz1yLZPWmaJOdP6jDXypty0uwhITyWpoAHiHqa+0tfBIxcHFP1vGgISoGhbXxy
         wkXJMzlFCN3NPhB1XVih5bCODoSaOMcZi8zr5h9EnS/ciIzXR9vGAjBZmZTERgFmy3DP
         a/XQ==
X-Gm-Message-State: AOJu0YyCd4FTc7Hq5K6YgKzYLPwM0oeqj1wdbuoN23rBdqNgoqn6dCaL
        c1uygPRxx/4qaWqvGsalhrkjupBNIDGPr3FGnMOazQ==
X-Google-Smtp-Source: AGHT+IF2KrGEKDa2mPuojfepwXCVrL8zSlcd1q1bVO6uyXe+azhG18HKyPrDChVZDcAHJC2PsPFNZA==
X-Received: by 2002:a25:ac89:0:b0:d4b:7495:6317 with SMTP id x9-20020a25ac89000000b00d4b74956317mr3783243ybi.28.1691699858500;
        Thu, 10 Aug 2023 13:37:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l35-20020a25b323000000b00d0d2c7dbfecsm544970ybj.7.2023.08.10.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:37:38 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:37:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/4] commit-graph: verify swapped zero/non-zero generation
 cases
Message-ID: <9b9483893c072961c5871bd0bae17a7098d73c06.1691699851.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691699851.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In verify_one_commit_graph(), we have code that complains when a commit
is found with a generation number of zero, and then later with a
non-zero number. It works like this:

  1. When we see an entry with generation zero, we set the
     generation_zero flag to GENERATION_ZERO_EXISTS.

  2. When we later see an entry with a non-zero generation, we complain
     if the flag is GENERATION_ZERO_EXISTS.

There's a matching GENERATION_NUMBER_EXISTS value, which in theory would
be used to find the case that we see the entries in the opposite order:

  1. When we see an entry with a non-zero generation, we set the
     generation_zero flag to GENERATION_NUMBER_EXISTS.

  2. When we later see an entry with a zero generation, we complain if
     the flag is GENERATION_NUMBER_EXISTS.

But that doesn't work; step 2 is implemented, but there is no step 1. We
never use NUMBER_EXISTS at all, and Coverity rightly complains that step
2 is dead code.

We can fix that by implementing that step 1.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c68f5c6b3a..acca753ce8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2686,9 +2686,12 @@ static int verify_one_commit_graph(struct repository *r,
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
 			generation_zero = GENERATION_ZERO_EXISTS;
-		} else if (generation_zero == GENERATION_ZERO_EXISTS)
-			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
-				     oid_to_hex(&cur_oid));
+		} else {
+			if (generation_zero == GENERATION_ZERO_EXISTS)
+				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
+					     oid_to_hex(&cur_oid));
+			generation_zero = GENERATION_NUMBER_EXISTS;
+		}
 
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
-- 
2.42.0.rc0.29.g00abebef8e

