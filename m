Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F2C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA806103C
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhHZP7Z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 26 Aug 2021 11:59:25 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41960 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhHZP7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 11:59:24 -0400
Received: by mail-ej1-f52.google.com with SMTP id t19so7335068ejr.8
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 08:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNKejcRZTFTKdjJjAAXqi8TAI/WB4zVod1CoTHJjfs4=;
        b=PtIJTO0xWwHjg92HliQUaZM4//XhEfSCYVfuSJVmvuO0Flnlwr4Kq9XxTKQAWPrr14
         8xC2zH8kv9bO7jL3FE6CirZ/6XuP4AfNsWzYYEj/mRbftHenixrgftKzx/i5GQJTzp6T
         O6+YH87tikdj3I9auCA5HOZxsNIw5fvRXo9o6pqv5TKYBA2Qa2dmXRsBgYyRR3HS16S4
         9k8YV/wyt6IM+dvjn8HCmfjzKDka7lqvOIiJyl3SFnVPH+Yhild3J/nHJkU6FtlKE0SB
         R17VlpZ+k2PmHKJ696boVr5jM3jX3pnHY9GAPL244genarFzjwke8XshYHwNy8qf09L2
         MMBg==
X-Gm-Message-State: AOAM532V78BmG/xPhkzEHfzrObCLWmo968OTbAtLaDrEcKE8HB9nxYzB
        Q5EbOVcsHnGO9gNZ1OkyhIjbL34HovP5GGoZhAA=
X-Google-Smtp-Source: ABdhPJwNVendHznzMYRdjsSGwUpJnWc+zlBWYQSYootq2sAX3GDDMGv84g1NO9cC1izwjum258PZS6Y5PQEs/btEbik=
X-Received: by 2002:a17:906:2acc:: with SMTP id m12mr5218480eje.231.1629993516354;
 Thu, 26 Aug 2021 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <patch-v2-4.6-1aa0dbc394e-20210826T121820Z-avarab@gmail.com>
In-Reply-To: <patch-v2-4.6-1aa0dbc394e-20210826T121820Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Aug 2021 11:58:25 -0400
Message-ID: <CAPig+cSXQGbOMCNNF84aMA4MDFMbRc0z5xuKVoVJUQou6c1GkA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tr2: fix memory leak & logic error in 2f732bf15e6
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 8:22 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> Let's move all the freeing of the memory to the end of the
> function. If we're still at STRBUF_INIT with "name" due to not haven

s/haven/having/

> taken the branch where the strbuf_read_file() succeeds freeing it is
> redundant, so we could move it into the body of the "if", but just
> handling freeing the same way for all branches of the function makes
> it more readable.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
