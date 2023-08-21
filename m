Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F1EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHUVeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHUVef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:34:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3715010E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58dfe2d5b9aso52315107b3.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653673; x=1693258473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cE95bbpsdR2zZ8SrI1KoEGBDnNEV4nxKf+hk5/G+hE0=;
        b=likkc8usuuk9002oELOt/EmVi0nzfPeXfwQEbRXofpg3MWArTTClBmN3XoUGkrw4ju
         O1f4QeRuZSIPYyowSKX6+VMR7kbb6CIxM8g77BexffnkxrM22xfys7v5xGOkVJWbHXrf
         Ud6ziMUIpQbLSt/ktZI291VFMqIIM9V197r5LbuB7Dl3nMY6+8vn42IX9GP/RyR6yWp1
         iafbS7QAEFbwe8I0v6WPscTcrZ9DmQr9vnFfEQ2tloJK9+sxRMnWkCsMv0vnwIf2rDot
         T9OC8ghIEl+ayeRpIv0VbwCpMM9KJBEe+9fACG2kuEZbVCN64uaCDZIpWZAFuoB2lE2Y
         2htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653673; x=1693258473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE95bbpsdR2zZ8SrI1KoEGBDnNEV4nxKf+hk5/G+hE0=;
        b=EO/zlWy3dpznQwh+Rna0QsTk7VGRY7zRWxuT+sGD4R9LqbdxEJUhr6whBrIvaNt2vK
         nAVTRO8q4mibvrMs9Ue6kG+rIG5yZuBKx3Ff2nXFDAUcHP2ISUhazjizCtxRa3sNXQFd
         lf1Q9OM9VwstN8C0bH5SA5QN47cVE9mjQ24E4wrMEFYA61TFBZGQKMQyC46FnmCXM9u9
         bQbHaMutVTgcxczifjXdpJL1gJSzOjjPIh89NmZgqsszLKOES40yDZr0etpzVO+bhYa7
         esgaLimecTh2n22kypj26SnvsAexA4gVM6Cn3+D4qlqz27B4DaipuueAVPEOuZi49LGd
         H07A==
X-Gm-Message-State: AOJu0YxHReqxHCwZgZ0pKAnxKoa3opkNXseylfd8/oPw85m9Lc04CNJw
        MsbAB6ooVmGBnRqUCTH+GqiOhlhrcJfEl8nBqFfFRw==
X-Google-Smtp-Source: AGHT+IGDy2/rt3xcJVpAkghRw0kpKUl2sHd1WaHV6n6wBsmH+f4l0E/Z8zRP5hq7zhWMRYlnIN5nWQ==
X-Received: by 2002:a81:48c6:0:b0:58f:ae25:6689 with SMTP id v189-20020a8148c6000000b0058fae256689mr6229919ywa.8.1692653673316;
        Mon, 21 Aug 2023 14:34:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a13-20020a81bb4d000000b005732b228a83sm2391855ywl.140.2023.08.21.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:34:32 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:34:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 0/4] commit-graph: fsck zero/non-zero generation number
 fixes
Message-ID: <cover.1692653671.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNUiEXF5CP6WMk9A@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a(nother) small reroll of a series that I sent which expanded on
a patch that Peff sent earlier in the thread to remove a section of
unreachable code that was noticed by Coverity in the
`verify_one_commit_graph()` function.

The first few patches are the same, but the fourth (now final) patch is
modified to track a single example of a commit with zero and non-zero
generation to only emit the warning once at the end of processing.

Thanks as always for your review!

Jeff King (1):
  commit-graph: verify swapped zero/non-zero generation cases

Taylor Blau (3):
  commit-graph: introduce `commit_graph_generation_from_graph()`
  t/t5318-commit-graph.sh: test generation zero transitions during fsck
  commit-graph: commit-graph: avoid repeated mixed generation number
    warnings

 commit-graph.c          | 38 ++++++++++++++++++++++++--------------
 t/t5318-commit-graph.sh | 18 ++++++++++++------
 2 files changed, 36 insertions(+), 20 deletions(-)

Range-diff against v2:
1:  a1cc22297e = 1:  c88f945a54 commit-graph: introduce `commit_graph_generation_from_graph()`
2:  38b8cd5e9f = 2:  8f8e0b6644 commit-graph: verify swapped zero/non-zero generation cases
3:  d14f3ca840 = 3:  34a505dd4b t/t5318-commit-graph.sh: test generation zero transitions during fsck
4:  e378fd6f93 < -:  ---------- commit-graph: invert negated conditional, extract to function
5:  23bcb7d270 < -:  ---------- commit-graph: avoid repeated mixed generation number warnings
-:  ---------- > 4:  52b49bb434 commit-graph: commit-graph: avoid repeated mixed generation number warnings
-- 
2.42.0.4.g52b49bb434
