Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB1EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHUVeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHUVen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:34:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB921116
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7485d37283so2209763276.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653679; x=1693258479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlb4stkDk/YPWFDkKIlLo1/NLXcPj/5xIHz7ofLlxvg=;
        b=He1yqnlO/zL5Vib4tg8yfnNUi9vVlyGoCgGDxln/hSFxN7XmIVOSF4DnQfZ4tMnZCx
         jDOO2Vw+ZVe5w9AOvFtj1ilXWMG/4pVqR1T6qMdi8PJE6YnJoiMpMo3sVTmi+n5z1pWH
         +mq/4vflRs2+g70awCO5gzayoMykLBWfTUKSlfo7vY/tjWvZzN9mUYzevjqD0yeEZmoA
         G3OWDaHEgDzGhdJOwt247iA2ylmLOu7OKUqOPL0oB1pN6IRIOfsvoi879BVwHhlM6+e6
         q3FEJoyD/C0obMDrtju6e9O9QMYJFJMdXuy4tnU8pSw4MV8CVcz8KxpAgaGIQH7PEWV/
         ZHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653679; x=1693258479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlb4stkDk/YPWFDkKIlLo1/NLXcPj/5xIHz7ofLlxvg=;
        b=Pz7NmJrjfxaT6SpiG1W3sOAgrL1cF+C/6nQCZMlv0qDpTr6VxpkPMjQrCPcFiWleqv
         xFLNuyCIsbd597Mi6OI0GxiLSudG3YdVVSE4agurZx3ocWcBiTdCZhPmsto8sf//5mbc
         eH5zPP21IOeirEh0GuMUNGSpDCiMywRvKxKlBt+Yr1cv6XcdNxP7/d/c1jM6HFpSgubb
         NSvMKNf47BelgHhIAiBuRt69wLwLNHqOgVrjsq3/X5HRokDY5J5Z/ybse2XCKJk5O9aR
         qSZnEKze85AnQx34iZAm0uncrqmlUdX6LsuldJQgAbLbhNFIfu0nBk7MvjDLbZXBmfSR
         wH/Q==
X-Gm-Message-State: AOJu0YwkjKzQCfH9WPqpLKE32ZenogBja0InYGpb+ZLhtx8ZULxei62O
        Zji41r6+PMrM7YwGUDCXI/CA+1RAWvs4JhzQT3+mrA==
X-Google-Smtp-Source: AGHT+IFUDOxYFlncthPvrlv1bCqWAsi103QMo6kD5djBMY6JQvezjTJ8oJKRAUyoEseaxjO1PkV/rw==
X-Received: by 2002:a25:8689:0:b0:d0c:ceef:c668 with SMTP id z9-20020a258689000000b00d0cceefc668mr9214609ybk.25.1692653678785;
        Mon, 21 Aug 2023 14:34:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e191-20020a2537c8000000b00d6861b49f01sm2053449yba.65.2023.08.21.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:34:38 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:34:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 2/4] commit-graph: verify swapped zero/non-zero generation
 cases
Message-ID: <8f8e0b6644135717e0035ffbcb18446a5d83d192.1692653671.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692653671.git.me@ttaylorr.com>
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
2.42.0.4.g52b49bb434

