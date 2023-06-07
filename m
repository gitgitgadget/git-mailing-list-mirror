Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D312C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 23:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjFGXCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGXCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 19:02:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD711A
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 16:02:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561b7729a12so17275957b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178930; x=1688770930;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1H+jE11Q8+o2bV6s04e/OVOJr65GRT96Sp/raYakFg=;
        b=f5tfldHjTADU38vUknbaNt9jWXgD5rBQWVyA7eu/p5ilvaWMsZbyTqejJJmnFBdgzh
         SzGh5U+syv+JvMzd8FdidTA8mnr8lyEgA+gm5IRg+hTxpWy+2C+asLtmOKBN0cDO8HN+
         4HTCnFiRkoiw8dKSRZ9Bc/QlaPiVJgngzTOvq45wPrQopVTc9ChdrPYQsT2hdgi/vYqZ
         kIjy9BeRTlgd2V1psfMDMpAa4Lc2WvIAPkGKRSaHtWEZm39M5PNl+vu01xpnnyOTW39c
         uTOHgMoqwpYpC92VDNP1+590IyF5CWYsvMUDGWQBWLXGnIveUIybxgBPxsL3W8i6MqB9
         DqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178930; x=1688770930;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1H+jE11Q8+o2bV6s04e/OVOJr65GRT96Sp/raYakFg=;
        b=Wb75zYvz2ep+o+Hg6NE/fdJ29EyuaYJ7B5EmAhWsYuIqG0a5LE/1ll4KFLhTVpL4F4
         H7wuS/t3xjZpHXsC8NbCt4qphpG/nXaYi7BPqeDi2L5ZFC5uEPT9CkfV2nVmf8Jon5M7
         xVWTbylEVfhxYROUXujpefkv08nSKOY0wMpiT/DgNclcwmTnQhU1yVsFhBGuOGW7BluF
         pbXDTe9kG7k2Z+V+ojor0KDe/MDFJFQ6ryiICEefa6ZWbzPIK7Hj/0vE5wFC7rksFnP3
         216LbIPm9xa4B14XkyITHpvEPgP7tRD2H+rhg3eCSva6BNT+YFDAxSI7S3zbKsYonyJP
         BjgQ==
X-Gm-Message-State: AC+VfDwGiy480AlQIYpgPh6zMuKguRT61cqZp6oV/0/1vPa1jajSWQPP
        +jPAb9stZDFJnR6VtzCFRvFzM+FgXEGjCXNaatYMX2Bh
X-Google-Smtp-Source: ACHHUZ4aFI4+1P2JSzx9Pjk4KMvlFTZwELll9/ua/yc71biU6GqjsbFjUNRY/Eo8wexrCNK7dIuGog==
X-Received: by 2002:a81:6c07:0:b0:569:e92f:72a with SMTP id h7-20020a816c07000000b00569e92f072amr575721ywc.16.1686178929828;
        Wed, 07 Jun 2023 16:02:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k188-20020a8193c5000000b0054f97b52934sm3588ywg.54.2023.06.07.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:02:09 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:02:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] shortlog: introduce --email-only, --group-filter options
Message-ID: <cover.1686178917.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These couple of patches introduce a pair of new options to `git
shortlog`. They are:

  - `--group-filter`, which restricts the output to group(s) of interest

  - `--email-only`, which allows callers to splice emails out of groups,
    which is useful when grouping based on trailers that usually contain
    identities (e.g. "Co-authored-by"), where the search is
    name-insensitive and only cares about a strict match on the email.

Let me know what you think, and thanks in advance for your review.

Taylor Blau (2):
  shortlog: introduce `--group-filter` to restrict output
  shortlog: introduce `--email-only` to only show emails

 Documentation/git-shortlog.txt | 10 +++++
 builtin/shortlog.c             | 53 +++++++++++++++++-----
 shortlog.h                     |  3 ++
 t/t4201-shortlog.sh            | 82 ++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 10 deletions(-)

-- 
2.41.0.1.gf123b68cb8
