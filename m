Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF7C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF342085B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB6JIY0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgIRAtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAtX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:49:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D6C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:23 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id f11so2025564qvw.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKlZb9XbL/KWSOzNenWg/bCHtCa6VYkgjyoolO+V9hs=;
        b=MB6JIY0gEFJITvkN7V1OlB4i7AdKNWV3g95/y2Bi7AOf3IOQ6xYT9svqjSKZeiXU/g
         7u+ey6kkuTl4lak7xk4WqXs7aEqJTXNNLsy/db8FwsqpBWckvDTtsLczK64x9e67PHyz
         0D4lSgGJhk+8TlfqCSCeYo1m9bLRyG2UNxxy/HqjUgnu1EVB21giL3qwB63bnp2P19q3
         CKjiQ9XqHaYi+D+JSDUunjTlXIUM2i5zBXvrqhn1f/zqo4p42bS/pd6E4n5s/UllDKfQ
         PkWyqY1rknvCNXx4UCz6qNRLNarzW27mSjYdTPLa4qs++4fjdvbeOTxSCN46QvCoJb0l
         9Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKlZb9XbL/KWSOzNenWg/bCHtCa6VYkgjyoolO+V9hs=;
        b=d1WYmBpN01+OaFzBI6vI4DpEbu3i7nw77M7KZ1VbJq9Lw9ZP1XikiBi4X8Fhg86JuH
         MZ8BbnuK3Q5Et1CruKzzCWtsxtJo5lv0SYdWDo455cO4jmMi8Ze8le94ac8ezfj5Oz+V
         k+pJ6vpULoYLXyeixnY4BYxBsBkvg8QHMLybJrAU06ZsoKrC60IQswoEYneimecU0Rp/
         ANEDRvkvVfn7bUHWI0bvKd15dd7NuYVSiMTiO38NufcHYS0A/X2CosGTYAAgw4zGui+u
         4fBZ/9id4/gToyUMbzQIkG2mGriCOo8L8PU3rPUNpqE2XgRGlajqyQ49H768lj7apmay
         rtfQ==
X-Gm-Message-State: AOAM530DiJT7k+AeB7z84o6xl+ddVSbVwVP7if/LZhncgaIn8v8YHBdE
        mT/A0tTxWqdmQvAb91vU41l1l3tIfHSniGaW
X-Google-Smtp-Source: ABdhPJxu5oS2/UOF6ImGrdAAXJ5yd9JWec+XM5wRj4zsTsVnXx5WUc0JfrgFBSbfq3zZ0IEkb/o7SQ==
X-Received: by 2002:a0c:d443:: with SMTP id r3mr31729966qvh.17.1600390162264;
        Thu, 17 Sep 2020 17:49:22 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id o13sm1003686qtq.41.2020.09.17.17.49.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 17:49:21 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] ref-filter: merged & no-merged touch-ups
Date:   Thu, 17 Sep 2020 20:49:07 -0400
Message-Id: <20200918004909.32474-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200916020840.84892-1-alipman88@gmail.com>
References: <20200916020840.84892-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Even if we are not renaming
> > things that much, a locally defined preprocessor macro with shorter
> > names, defined just before the callee, would be more appropriate for
> > a case like this, with a single callee called by only one caller.

> Thanks for stating what I was planning on saying, with particular
> emphasis on keeping these #defines in the .c file rather than the .h
> file since they are not part of the public API.

Thanks for the insight into defining macros in source vs header files-
I'm still in the process of learning C and figuring out how to convey
purpose & encapsulation without relying on features of higher order
languages I'm used to (e.g. keyword args).

Since this got moved to next, I'm not entirely clear on whether folks
want me to keep tweaking this, or if the last set of comments were
general advice for future contributions.

But in the interest of diligence, I'd like to offer a couple touch-ups
applying Junio's suggestions.

Aaron Lipman (2):
  ref-filter: refactor do_merge_filter()
  Doc: prefer more specific file name

 Documentation/git-branch.txt                  |  2 +-
 Documentation/git-for-each-ref.txt            |  2 +-
 Documentation/git-tag.txt                     |  2 +-
 ...lters.txt => ref-reachability-filters.txt} |  0
 ref-filter.c                                  | 29 +++++++++----------
 ref-filter.h                                  |  3 --
 6 files changed, 17 insertions(+), 21 deletions(-)
 rename Documentation/{filters.txt => ref-reachability-filters.txt} (100%)

-- 
2.24.3 (Apple Git-128)

