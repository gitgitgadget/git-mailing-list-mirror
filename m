Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88AC43381
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C65A64DE9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhBKTsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhBKTsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:12 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FBC061793
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t26so4652854pgv.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtjTTuv28XJm8KEZjofRguQM+wLkCkrKwrMZQquxBO0=;
        b=p01VwDO/+IOYyLcLHwoKCJKzaFu1g/2ukEVLA3/VbifiK7XvDwM5lmjX64KObMm6KP
         YhsNQm6su6Lm7i20FXiM9jJhL/tZSQbNdrK1jFY0joI1pdeoFzNlQuOHfYjUbiIYMbPG
         KFc6xLcB6cQfwShiCJWU0a2sO6PVHBvCunNqUxUw8YGDcmgNqtQNcTVPJLcPv8y0heyw
         XX4h54WTeL1pfaj8UoeQ4JeQUXgnz9NAzh4mklgCLVru6LT2HiKA40ymC6CrSwPmNah4
         va/ldPVPN85jZiVWqaqOiSfywBzUf4dUcfdLmmABpH+fZslQIluVWgs0CNFaWOpGstpU
         WnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtjTTuv28XJm8KEZjofRguQM+wLkCkrKwrMZQquxBO0=;
        b=ANvK58OtalOhDQ4DmZJp4hpN36YLxilXjhZfOu6ayZ0nBoBxT2snUAPRt5DBuqWHbq
         PvVAyITvJyP2MLkLuRWEHiMnUmfjUCbm8ii1o5Pjuf8qrVup5COjKlZ82AfvJukyJMeQ
         JQ6gwRU/SgKUA7uRJQOnmSrYYe7MTQn3zgYBvpp4E61L1taG2pau3OjAncPqQx/6TE8g
         23jfxxgG7sCwUUzhzFj3aq9covorUUpjrkgHlpWylyNRUEwrtCU4mtAPK16wR5XdNKJx
         KUEWyiA8VJA8lkGfzT6us6+zvZwuyA2uZ9x8vcFID/Ol4CB5x7NZbL5Fy19Cqjft7rFA
         iQgw==
X-Gm-Message-State: AOAM533tN6dA8o+Juc/G1QtrReHgKNqxvoJ3qqQovp+rjSweJzEei7DD
        BROaxeJvGR5KsT2fybU1MEPWRGRs70j46g==
X-Google-Smtp-Source: ABdhPJzp4rsYgUsPlNOX7Ap/4Vow+JpHn80MZWTaBv7BIJSUKJfW6WOp/QGhoPNw1HDMR3QmHJkwrw==
X-Received: by 2002:a05:6a00:22d1:b029:1b4:9bb5:724c with SMTP id f17-20020a056a0022d1b02901b49bb5724cmr9710547pfj.63.1613072831286;
        Thu, 11 Feb 2021 11:47:11 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:10 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 00/10] Modernizing the t7001 test script
Date:   Fri, 12 Feb 2021 01:16:54 +0530
Message-Id: <20210211194704.28913-1-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch series modernize the t7001 test script by changing the
style of its tests from an old one to the modern one and by cleaning
up the test script.

Changes since v2:

- Correct the author name spelling

Thanks everyone for your feedback and suggestions.

Shubham Verma (10):
  t7001: modernize test formatting
  t7001: indent with TABs instead of spaces
  t7001: remove unnecessary blank lines
  t7001: modernize subshell formatting
  t7001: remove whitespace after redirect operators
  t7001: avoid using `cd` outside of subshells
  t7001: use '>' rather than 'touch'
  t7001: put each command on a separate line
  t7001: use here-docs instead of echo
  t7001: use `test` rather than `[`

 t/t7001-mv.sh | 420 ++++++++++++++++++++++++--------------------------
 1 file changed, 199 insertions(+), 221 deletions(-)

-- 
2.25.1

