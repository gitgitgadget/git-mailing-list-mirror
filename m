Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26CC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D643D61369
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhGVLjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhGVLjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:39:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCEC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l7so5713438wrv.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvqZv+X/1sGH7nlxi/FXHqn2HkaMIRy6+JFaticc0eo=;
        b=Ap0yWaKMVOBdSzDAh7LLxUn1IX+HP7GEvwL0JVlHr2J94zv/LK071VBdMe6HJnWJ1Q
         VefBbyp4K5VOcD1L8am6/PON2DPtmdn9EnKKzb5L8c3z3l9mRBbQHU3EoFUlOOD3rS3/
         3QPc+aCDfx/vtZNYhfMIO8GaZ84a6AIASdJUCCznZUcCm+cRPWq9FxK3OrdB6zP3uK+I
         1UP+7uiZ4JQ1DopA4/jz7EPHbADCB+GQEy5dQPYFLEZo+twIxLvQUSTyrmfQ4gv71jYW
         w8eYHzt0+T39Csn2pHrSk/BqPBDRYmHyILAIHraozGwJf/yoqt6Lrg9HputF3ssFafkL
         tPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvqZv+X/1sGH7nlxi/FXHqn2HkaMIRy6+JFaticc0eo=;
        b=MzXr616cQAOW9NJThywusUsXDPWddSwrCTZ8l7AiEScfrF73V5VidichoDB5x1LzGu
         HtAzGqNIpQjQYzo86YsyvvNIhpB7F5geTGHVVhRVhZ3gUtVF7MrwYkCbaEKh965nYF4g
         IdaI3FEkvVdlBquUwOu6XSBRSJTO5uQ8rGAA9ewHnHzcs/PvxOzfq/R5TgvfrVA3BxO2
         +mSgXyvRgHiAzZdkMBH7DRCU6u+69uXXcHVXFfy4oeERZuXc/QMLx3Md8CELis/wcMI2
         +qFgf2FpWB//NabQPFtdXHe4vcS9K/nPPlTAzBt4CjuCxP5BFKliDoamD903OOLc/PU7
         f4tA==
X-Gm-Message-State: AOAM532iIAR4zhFSBv+QFJ+ERdnB0Ds63VZ4wQF4V+2ZeJKyivIA9He0
        U7YeUWxJx8QWUCYuOy9wigoIYRu1CPSTEg==
X-Google-Smtp-Source: ABdhPJxghXniZkRjIAmbXvNrPTaMjOPsa/lSLDR1fhEhQGgjf1o4hceIjOY6uMiUs66v7tZKGDKF6Q==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr13077809wrv.208.1626956419373;
        Thu, 22 Jul 2021 05:20:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n23sm23506991wms.4.2021.07.22.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:20:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] progress.c API users: fix bogus counting
Date:   Thu, 22 Jul 2021 14:20:14 +0200
Message-Id: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a split-off from the larger topic these were submitted as part of
[1] and which didn't get picked up. As I pointed out in [2] that
larger topic had some hidden untested-for flaws.

But these patches are just fixes to bogus progress bar output from
that topic. Let's consider them in isolation...

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
2. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/

SZEDER Gábor (2):
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line

Ævar Arnfjörð Bjarmason (1):
  midx: don't provide a total for QSORT() progress

 commit-graph.c | 2 +-
 entry.c        | 7 +++----
 midx.c         | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.32.0.957.gd9e39d72fe6

