Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D97D1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391362AbeIVCIp (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:08:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38310 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391251AbeIVCIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:08:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id z13-v6so3000444qts.5
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgwprXWmdF+dveZgZBg7O9PYEllIhagLD4ClN2ix06M=;
        b=sv6K5XNuIDst9ghv2zdzexTt51MX3WYGFr+KadNJUYbqS2w84XBeLX5ThPDh0eF1uB
         G1wcToqD3Jtm/zn4IoO5gxj2obFbhKZ8RByejrX1VSY7ZXJ3AzDHXCx8xJm8QTlSlFO5
         eDZGVmv2k6W0O9r6nDHR51p9vxbtsOhxQ3LJS9DC7mKAqi3Jzd+8vsjzWFSrdYy7RA47
         Y/vhFdlHiJ/sJev+F7vBb7XY/ha4BKobu//ossM3M0er9owPhfg/MPtC9ua5AWuJLDPR
         q7RkLuUttbQ63pxrZdOjlkCfk5OUh7iloAoElTzqN/LUDhk2WeZI5UrDzJvPnbawRkr8
         0Rkw==
X-Gm-Message-State: APzg51CBm9J3WHMF/+4M08VK29Ye+C9SOwh8NWLAgPJ21urbWwH/YW3G
        M8bnUoSt897L/n92XhpusKPQ21NLgDxX76ABC3g=
X-Google-Smtp-Source: ANB0VdaC6iXYubqctBuMuEKmGNWyXsFUXKICKhWY2k5JKVwLfm1DLuidtBTJfKWjrh/naND66r2WJr2Meeu2J3oeK9Y=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr33278550qtc.50.1537561095836;
 Fri, 21 Sep 2018 13:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537466087.git.me@ttaylorr.com> <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
In-Reply-To: <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Sep 2018 16:18:03 -0400
Message-ID: <CAPig+cSx0vxegy+ENtiYgV=x-A=0upFZGuFbW-=cwwknko_f4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 2:47 PM Taylor Blau <me@ttaylorr.com> wrote:
> When in a repository containing one or more alternates, Git would
> sometimes like to list references from its alternates. For example, 'git
> receive-pack' list the objects pointed to by alternate references as
> special ".have" references.
> [...]
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> @@ -0,0 +1,54 @@
> +expect_haves () {
> +       printf "%s .have\n" $(git rev-parse $@) >expect
> +}

Magic quoting behavior only kicks in when $@ is itself quoted, so this
should be:

    printf "%s .have\n" $(git rev-parse "$@") >expect

However, as it's unlikely that you need magic quoting in this case,
you might get by with plain $* (unquoted).
