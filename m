Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E741F428
	for <e@80x24.org>; Sat, 25 Aug 2018 08:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHYL64 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:58:56 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37325 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHYL64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:58:56 -0400
Received: by mail-qk0-f194.google.com with SMTP id f17-v6so7347104qkh.4
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 01:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7CQPo0wt9GP7wxxatYX/sZg0UU8Y8RAdf/zqLlrsdY=;
        b=aAWyqzxHTkms8nex+56AGgidUgt64YQg7deofXZ4EXpoXwZoB7rWaDs/WiTCJmT0Gr
         702Ic32wCdxzMjfOC3xBr2IowCUo3UU4r3yor4EcSbOk0rnlR9Zug08f3IqFhH+hV4WO
         2jmOfKy0pC7LIBgiempHewC4i948xMUSuSfBxOkpeu2JRpMQ3Sy+Ymt2DN6Gpi0BeCtO
         r1nHI5IkoT2O8XN5+PSP76MYGYKWiFhwUOiSltfC0BaEfJk8rtJVgj3PnpoNsDBJi76b
         YS4A8St0vcPftl9DkXPKTH89jNWl1BDVL2LEsUIxz95StOt04Mh6cqu/HPnlfWxX5y8C
         Qotw==
X-Gm-Message-State: APzg51DSj3Gm7KqgBGBSyJXz3S4n3keflFMWjwiuvzxfhAGbiCTaWCvU
        QaJwABb3KULJm6qlHd1WGXubyaEiVPZJU1HCsHo=
X-Google-Smtp-Source: ANB0VdZHUegkBlcszrV+0PcOnLy3W0cYF+HaSdmnh3h1o8BGmtjDPrJSqaAFOrzQHeLH1w/L5PrW7303OgAnTFImWtw=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr5035166qka.314.1535185244496;
 Sat, 25 Aug 2018 01:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180825080031.GA32139@sigill.intra.peff.net> <20180825081731.GI737@sigill.intra.peff.net>
In-Reply-To: <20180825081731.GI737@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Aug 2018 04:20:33 -0400
Message-ID: <CAPig+cTBEWxJsqtAQW0=1-mPZMk4FPXuK0Zj2hdrFzrbjry3-g@mail.gmail.com>
Subject: Re: [PATCH 9/9] show_dirstat: simplify same-content check
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 25, 2018 at 4:17 AM Jeff King <peff@peff.net> wrote:
> We two nested conditionals to store a content_changed

grammo...

> variable, but only bother to look at the result once,
> directly after we set it. We can drop the variable entirely
> and just use a single "if".
>
> This needless complexity is the result of 2ff3a80334 (Teach
> --dirstat not to completely ignore rearranged lines within a
> file, 2011-04-11). Before that, we held onto the
> content_changed variable much longer.
>
> While we're touching the condition, we can swap out oidcmp()
> for !oideq(). Our coccinelle patches didn't previously find
> this case because of the intermediate variable, but now it's
> a simple boolean in a conditional.
>
> Signed-off-by: Jeff King <peff@peff.net>
