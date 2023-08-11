Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148BEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjHKRFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjHKRFn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E42D7F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:42 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so1500650fac.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773541; x=1692378341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAnEo/+HwaZTBrm6tqoEq6J6hm7ykRBBGq/QJQ38ZcM=;
        b=hi3soYKq9qtdE+RPzcNn59AIQSTbuHkiVUHAMYokj+zcXrpc4YOL+vG0hRdG5qFJ2d
         Eg6AIRvY5MDam3qNspwJAuDflaXCWxlsq/i4uR32S3lVps7GW2hexmef9mAO8Ip+RhiW
         XpIT6X5HpyWPoxTvl5BvKBllWJG0XWlu7adEcazyq86snIpWil1hS4BOsoUQaKBoqSNL
         +99BaifFXvYBAJv6JlA7Xaar/Los/Sr49q+qjXdibQI9uCwqPzrrE0taHPl/gi1qPMD1
         TEFhYWBJXpPxfj3CV3XK5xq/MjQ2J0nlp3Bdu2rI7wB/qwH1BkGLp2tPgHLX7QJj0cMQ
         OA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773541; x=1692378341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAnEo/+HwaZTBrm6tqoEq6J6hm7ykRBBGq/QJQ38ZcM=;
        b=RXmniByRsyIgPhugaU7D2GmFmXVPwHlJE20wnObHfxsdEA4unELIMus/eiD1A9S8Y+
         w2tfEAlL5fxw1IAgFYWB3qvlTOEmf7fWnOjyLkKmSjYIKe+XK5JpIB3CXByJk4P3Z/XD
         PvNtSYFPxWP+PSlT6u9g7BGZIhAqYebBAy+Lk5LEEYxXdTGhKJYYO6+hVZnUrCwqB7+9
         Q5kri0oVXrVNEUXm3+KjObsRsxknoKuF0e4gX/eddP+tllTQ3bfH8YmT0HQifKjb/lz+
         0DNfumAgB+SVZVvXUReYYVxZ23aRHI0hJ0VytH96NL3o7uNZuAa3alh+dHkGJl01+/Hr
         4K2A==
X-Gm-Message-State: AOJu0YwVxDl785oKwcSvdRfdZNeMLNvtHbwTvSmoXe+iC09DnHlBcAdA
        bNULgmM03EOwkNtAslQ3Pk2Z29Dm3bkMLxV061G8bQ==
X-Google-Smtp-Source: AGHT+IG9HE4VRaAupXlzw9eSGs0A/JUxzXPkycRLOknS2vGEDtZhYHp6l2x9tEjVkE11QAuV9W6irw==
X-Received: by 2002:a05:6870:392c:b0:1bf:1c49:7455 with SMTP id b44-20020a056870392c00b001bf1c497455mr2801187oap.6.1691773541196;
        Fri, 11 Aug 2023 10:05:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a0dc606000000b0054f50f71834sm1095440ywd.124.2023.08.11.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:40 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 0/5] commit-graph: fsck zero/non-zero generation number
 fixes
Message-ID: <cover.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNUiEXF5CP6WMk9A@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a small reroll of a series that I sent which expanded on a patch
that Peff sent earlier in the thread to remove a section of unreachable
code that was noticed by Coverity in the `verify_one_commit_graph()`
function.

Everything is the same in the first three patches. The fourth patch is
slightly modified to (in addition to flipping the conditional) extract
the mixed zero/non-zero generation number checks out to its own
function.

The fifth patch is new, and avoids repeatedly warning about mixed
generation numbers by treating `generation_zero` as a bitfield.

Thanks as always for your review!

Jeff King (1):
  commit-graph: verify swapped zero/non-zero generation cases

Taylor Blau (4):
  commit-graph: introduce `commit_graph_generation_from_graph()`
  t/t5318-commit-graph.sh: test generation zero transitions during fsck
  commit-graph: invert negated conditional, extract to function
  commit-graph: avoid repeated mixed generation number warnings

 commit-graph.c          | 48 ++++++++++++++++++++++++++++++++---------
 t/t5318-commit-graph.sh | 32 +++++++++++++++++++++------
 2 files changed, 64 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  6ea610f7d2 < -:  ---------- commit-graph: invert negated conditional
-:  ---------- > 1:  701c198e19 commit-graph: introduce `commit_graph_generation_from_graph()`
-:  ---------- > 2:  9b9483893c commit-graph: verify swapped zero/non-zero generation cases
-:  ---------- > 3:  8679db3d0e t/t5318-commit-graph.sh: test generation zero transitions during fsck
-:  ---------- > 4:  32b5d69ebe commit-graph: invert negated conditional, extract to function
-:  ---------- > 5:  b82b15ebc8 commit-graph: avoid repeated mixed generation number warnings
-- 
2.42.0.rc0.30.gb82b15ebc8
