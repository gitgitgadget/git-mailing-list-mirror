Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380E41F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeGBVaS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:30:18 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38809 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeGBVaR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:30:17 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so2025422ybo.5
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 14:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImYD6UCUbW8OeZHr4HK+mKiLpe/k7He7adWBOMn4Sbo=;
        b=BnDmaCcs/hSCrtnoDqRRGR1kVAWeXecX1mP9BEcZbLB0xvuWuQN6K1zhmaP1fufQQ2
         XitfQTkvTWi6FDz8UGbsbgcD4OABKtic9fpm5lqB8ZWAUtrybYHkGXcD3UemN7uxXxQ3
         R39xAcMnaPqyjwam7gycXfD5oUwGFJxeQuE10oYagJMmyuT1jQRW9NtwMezQgnxMYLhx
         o4+4Gnyw2Mvm3KusYVYI6ML7dkTz7d9btlcShkT7bEvRTc0wQeLq7wfRPYziT5/Ueazq
         bLxuqLwosRjc3JtSUnxlIrAKlqILJltDKTeFylCowRq7qwpYc36U6p+/rDiTyhflXrJl
         Gorw==
X-Gm-Message-State: APt69E0e1bXKP0W3UhgFbYS/65i+cdl5igwNb3W3tPM5OBtVlqmJeonu
        KmF10zyh+umlBhwyVlBHl+GSoREVuH7URPnFwzM=
X-Google-Smtp-Source: AAOMgpfqC7J/MszxYR2vriYokt6DILomukwlUzbP8n2EE3GN1uuLruQL7uV7WSIQAA085MTDG4o9H86x9L5yxXzWexY=
X-Received: by 2002:a25:c04b:: with SMTP id c72-v6mr10564205ybf.12.1530567017370;
 Mon, 02 Jul 2018 14:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180702211100.GA20885@sigill.intra.peff.net> <20180702211242.GC23324@sigill.intra.peff.net>
In-Reply-To: <20180702211242.GC23324@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Jul 2018 17:30:05 -0400
Message-ID: <CAPig+cSJrZi+rVgJp3Yhbc=F2yyooGw7a046e-KKiE++3CiP3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ref-filter: avoid backend filtering with --ignore-case
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, aleksandr.o.makarov@gmail.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 5:12 PM Jeff King <peff@peff.net> wrote:
> When for-each-ref is used with --ignore-case, we expect
> match_name_as_path() to do a case-insensitive match. But
> there's an extra layer of filtering that happens before we
> even get there. Since commit cfe004a5a9 (ref-filter: limit
> traversal to prefix, 2017-05-22), we feed the prefix to the
> ref backend so that it can optimize the ref iteration.
>
> There's no mechanism for us to tell the backend we're
> matching case-insensitively. And nor is there likely to be

Perhaps: s/And nor/nor/

> one anytime soon, since the packed backend relies on
> binary-searching the sorted list of refs. Let's just punt on
> this case. The extra filtering is an optimization that we
> simply can't do. We'll still give the correct answer via the
> filtering in match_name_as_path().
>
> Signed-off-by: Jeff King <peff@peff.net>
