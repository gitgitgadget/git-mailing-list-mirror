Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjHJUhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjHJUhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:45 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5682738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:44 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5768a7e3adbso35194357b3.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691699863; x=1692304663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp8HVkrkFJaxoMxwM1nWT97ItGYpT0fKmOAQGws37dI=;
        b=fv1YPpc6kHfnC0FduMPPXf1x5flesiuEP1gUMlkPJe5e9XuQl/m4P3u862t6s4c3+q
         PuFmfr8b3LPbbM7tq7nu6yI5zfXvnsgPVGzvKzbeltmhR0+50M0iArXWovIacXGHPy4Q
         VPto1dAf5QG6lxXxV8ghy442rC8G3/1s69oItvphFfbAGeZKgli5GB0TFaHjZNoZC5fU
         ROfihiojRWD4YAr+uGFSdvfbuNRCfIrxR5DLT+IlI8jhkJufV0nZV/11CAueQdAwpC8H
         jL2RyQVp/d1w66lsRieTQ2isVzkP7WcNGkv3mPd5SvYXhScU9nYE3TwFLaLpI0PnrDHM
         ncuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699863; x=1692304663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp8HVkrkFJaxoMxwM1nWT97ItGYpT0fKmOAQGws37dI=;
        b=HnijZ9lVESSfkbZE9OSvEa6eYU/7/6VdVAsBEbXyRDa3bzMAhX1aL/7FXf/IJy3ugu
         T+2mN79k/fEm1TnB1l/kTuR2XYrlx9lKvXWxXN2CG7ur+mm1HRDCckyViIUcv3KlnkfJ
         CVlR0lU4BW61OK2qhxXQ6tx/LxB/ItEWB+BZZ93QC8k5HP+N0wEyUa9Dnu9iSfj8tuJx
         K2xoYzYGa3ZTxOf2sAp8vOtfBVzsmWj4GfMBwLzF/YRFcciYlYfubo0A95u1WM+F5ps+
         fo1P6TT7k5GRymkNOkHo9dDlhqKEczm9mLu3BINa3kZtl63W+Wn6Nse+lasdGik8+WlD
         tl3w==
X-Gm-Message-State: AOJu0Ywpgzgofa17Ra3RxU+OxObzg9wCLdVB3xbJxTUqSnF6BTH/PD62
        ToMfd6s4z6RwOEhJawwAS67gLTQjngfGCS3qhL8Njg==
X-Google-Smtp-Source: AGHT+IHnyy6H7qgOCbH9br8cT4VrUXOzAOKXe3r88Ajoi4HoIdfg2aRFMiYZ8lDlSfaPqk9J/ChNdg==
X-Received: by 2002:a81:8482:0:b0:586:a680:250 with SMTP id u124-20020a818482000000b00586a6800250mr7113ywf.5.1691699863558;
        Thu, 10 Aug 2023 13:37:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f184-20020a0ddcc1000000b0057a44e20fb8sm570773ywe.73.2023.08.10.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:37:43 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:37:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/4] commit-graph: invert negated conditional
Message-ID: <6ea610f7d2faf77d1984d641d1b857a9c4b1214d.1691699851.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691699851.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're using `commit_graph_generation_from_graph()` (which can
return a zero value) and we have a pure if/else instead of an else-if,
let's swap the arms of the if-statement.

This avoids an "if (!x) { foo(); } else { bar(); }" and replaces it with
the more readable "if (x) { bar(); } else { foo(); }".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index acca753ce8..b2cf9ed9d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2681,16 +2681,16 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!commit_graph_generation_from_graph(graph_commit)) {
-			if (generation_zero == GENERATION_NUMBER_EXISTS)
-				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
-					     oid_to_hex(&cur_oid));
-			generation_zero = GENERATION_ZERO_EXISTS;
-		} else {
+		if (commit_graph_generation_from_graph(graph_commit)) {
 			if (generation_zero == GENERATION_ZERO_EXISTS)
 				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
 					     oid_to_hex(&cur_oid));
 			generation_zero = GENERATION_NUMBER_EXISTS;
+		} else {
+			if (generation_zero == GENERATION_NUMBER_EXISTS)
+				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
+					     oid_to_hex(&cur_oid));
+			generation_zero = GENERATION_ZERO_EXISTS;
 		}
 
 		if (generation_zero == GENERATION_ZERO_EXISTS)
-- 
2.42.0.rc0.29.g00abebef8e
