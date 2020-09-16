Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23116C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 03:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D257921D1B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 03:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIPDQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 23:16:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIPDQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 23:16:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id d6so3120213pfn.9
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 20:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvXhb0xlAKdxvTW8UxnjMzmdXUw1vfopjKmIE23UJ3M=;
        b=dyAoti3JSgREHtDpruU5zfnLbR8sTqYYBXFMpjxAgfB2jbRxS5w2iOa7sfJKaXhLJ1
         c/AGzFSdyFG5/tGusE8G1CYcuC4IK1LIqhD/ExuePm1nlU2fLjw8NQht8OZmkD5jUhsk
         UtfAXf/rofC1Axs4pPiJhQ8uImuLX3JXH7vRWWWPbnR1XxYKdaOux5uOhj4djBPetZAk
         /yl0WnpqFAaUQOBZnm1u1yfoQIMe1ws4JwYABFlEkcYQ2F8tHxNLvubL4xoJXLfJJl7S
         EJCrNOwK0na3d5szyxg6rWi1ztlZM2lfdVZ3idTGqm47ADjjgrs7ksAfttve2O576Npz
         UEEg==
X-Gm-Message-State: AOAM532EVa3S6iKqvS64P1yT3DWGf1VsC+bBvj+md17JdLzWE7WRaBSv
        QrvTPMjCFpuS24Zqg1W09KQ=
X-Google-Smtp-Source: ABdhPJyBRPkQh0pOSFihd+ASfWSLUJ4VZH7QRB8gDVIGwEiNuxWCTQSoZgt5Seo/LIgFLfnho1a2Bg==
X-Received: by 2002:a62:5bc2:0:b029:13e:d13d:a090 with SMTP id p185-20020a625bc20000b029013ed13da090mr20349217pfb.39.1600226176590;
        Tue, 15 Sep 2020 20:16:16 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id a27sm14884817pfk.52.2020.09.15.20.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:16:16 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net, sean@barag.org,
        stolee@gmail.com
Subject: Re: [PATCH 0/4] clone: allow configurable default for -o/--origin
Date:   Tue, 15 Sep 2020 20:15:49 -0700
Message-Id: <20200916031549.815253-1-sean@barag.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAPig+cTNjkOSRbP6sQMAhr-etXMt7ejJo3Zm2gu=nvpF00CMvw@mail.gmail.com>
References: <CAPig+cTNjkOSRbP6sQMAhr-etXMt7ejJo3Zm2gu=nvpF00CMvw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A couple more observations related to a few of the subsequent tests.
> This:
>
>     template="$TRASH_DIRECTORY/template-with-config" &&
>
> probably doesn't need $TRASH_DIRECTORY since that happens to be the
> current working directory anyhow, so:
>
>     template=template-with-config &&
>
> should suffice (unless you had a problem doing it that way). Or you
> could drop the variable altogether and use the literal name where you
> need it.

I hadn't realized $TRASH_DIRECTORY was the pwd, but it makes perfect
sense.  Will update for v2.

> Also, instead of:
>
>     (cd clone-template-config && test "$(git config --local foo.bar)"
> = "from_template")
>
> would probably be written these days as:
>
>     echo from_template >expect &&
>     git -C clone-template-config config --local foo.bar >actual &&
>     test_cmp expect actual

Oooh `test_cmp` looks much better.  Thanks for the tip!
