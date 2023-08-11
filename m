Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7544EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjHKRFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjHKRFr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:47 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084FE5B
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so2035293276.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773546; x=1692378346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pITeeHPnJR6EsFQ38mVnOv4QdNog3hmYkvlpL+W7US4=;
        b=UPcR8wDIeBKV3bHzzpEGJaR00Dda2pEG/skLIwyJVZbG5czipRUGM/y1r+DDW6hAbK
         O8YiveUUsoAzCfV9sXodQLlCwD6iQoigfceN31WzRYSKlFrS8VkUtx2W8OoC05iNDIcL
         hthKXh877nNo6/aymWaQSNnMLo9f98rYQ66ahsZhAVBLCppoNXR+14X1MDRxuxywU8uG
         YqheXXGxtYXSuPyZyZSIXQrZS9pMm9BEusLOot5ijvOWTGqKkQPqhaSujWZ1gbvksnqv
         KLsNS2B7Y1C+dW3B51KOK7NS2V0+s6EGT/0qqL3a7TFBqqn7QjdoCPJp0SGH2nqPU7vr
         jlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773546; x=1692378346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pITeeHPnJR6EsFQ38mVnOv4QdNog3hmYkvlpL+W7US4=;
        b=VGwIksGXlgIr44clKdCyiY9jGCwkJy7q9XgJ8OGGUX8c5RZQ78LBC0SqPFiWckLbti
         eJKgrXR+j/ts+GY/yZFj0T8HsZe4PW/jc2Fw20T893YsC0GrqM4Qyhr76G4m5F+4CAlp
         rL6PgphAZaWiVR20vGd0hGQc5n8UUQUrygcOTVK6qtKx3wMXi/0rFomhteQT1rkI77sx
         1aWbIYRNQGW0tomVTGCink0M2Do5Epvf+VU9+vPU3Xv+LZ/6rT+T7JnsJHDjYnSY1Lr9
         0UPUfVx9xf88FJMsrNWQx6JrX+n1YrFEft3aZBI3Sm1sakjY96zcdTzYTDnu+tN3d+Kz
         sHGA==
X-Gm-Message-State: AOJu0YxZDZ/TJWt+ffyiqClu0fntE2ITe7XSd5D5zBlZQ3/cL/9U+Rb4
        jwcUiaiL3BMHarUiREZChOqbItvOUy8zA8v45o+3Gw==
X-Google-Smtp-Source: AGHT+IG0vSOExw/dczmtkCH/b0DbnPKbU8+srWuzfqgfkp/vKGvEQlY7eneudbhzvnzFllYHhV/Hgw==
X-Received: by 2002:a25:296:0:b0:d1b:3392:b376 with SMTP id 144-20020a250296000000b00d1b3392b376mr1887532ybc.51.1691773546533;
        Fri, 11 Aug 2023 10:05:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b8-20020a25ae88000000b00d66f152bb94sm451275ybj.61.2023.08.11.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:46 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 2/5] commit-graph: verify swapped zero/non-zero generation
 cases
Message-ID: <9b9483893c072961c5871bd0bae17a7098d73c06.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
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
2.42.0.rc0.30.gb82b15ebc8

