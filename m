Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0F11F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeGLSNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:13:18 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41211 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLSNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:13:18 -0400
Received: by mail-yw0-f193.google.com with SMTP id q129-v6so7977894ywg.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvVX1qfSalovS+5B1/HhYvbPA1MXB3TYsp0XM3rpao8=;
        b=tyY5o1IJ9KIY2d46mAl8qbuI1Gv7U/7W4cQSwsuH9jToisvf4JNCCkfsQ2t/E53VlD
         ulswVSXJW4QjjCCTXAwXFy7i6RY9Ff4dZJcrpkQwMcX1ihK9b/VQGL7U/vNQtAlq0BDz
         kU6tP6erQet1tVYT/d85XC4o6oRu+jRMvPF2u1r45KYmt+uqsYtet8UHsicr4vUViKpC
         y0YF2TP1xrcdamGUM6Im5Jmtfw+zZGiyw11VtnJYz9M/JiKgbSVIKB0P0vogMXw2ljXB
         mJ66rij6QOjL2hpV/R/Kw1OoW1TgmrucF5+C4AEuH6RPUQPR742KcLilnyK7BGoqTl7A
         44rQ==
X-Gm-Message-State: AOUpUlE9ku/I5qzZlRlc4vZBRN/sI/ZGSDbisfyKGIC+y0lKACebftHG
        PqqEMR239/yZQUFU7bcfwB0VqE/rfNVJE5RlErw=
X-Google-Smtp-Source: AAOMgpfo0uLni2LfVzipFxzai+ktan6kdCKOkyE3ca04Ovvi/bsT5/ZfbjE+ioImHNi2ukDkh5xMCVZYbKOnjjoB32c=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr1683641ywq.120.1531418559062;
 Thu, 12 Jul 2018 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-8-dstolee@microsoft.com> <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
 <3e82dd51-2e30-291f-8753-c1d711459c1d@gmail.com>
In-Reply-To: <3e82dd51-2e30-291f-8753-c1d711459c1d@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 14:02:27 -0400
Message-ID: <CAPig+cTEcLtvrQ25KDmc4Cmi9C2yCUpLCTWsK9q8SAiZt+N-Jw@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] multi-pack-index: expand test data
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 10:10 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 7/6/2018 12:36 AM, Eric Sunshine wrote:
> > There seems to be a fair bit of duplication in these tests which
> > create objects. Is it possible to factor out some of this code into a
> > shell function?
>
> In addition to the other small changes, this refactor in particular was
> a big change (but a good one). I'm sending my current progress in this
> direction, as I expect this can be improved.

I like the amount of code reduction. A couple minor comments...

> +generate_objects () {
> +       i=$1
> +       iii=$(printf '%03i' $i)
> +       {
> +               test-tool genrandom "bar" 200 &&
> +               test-tool genrandom "baz $iii" 50
> +       } >wide_delta_$iii &&
> +       {
> +               test-tool genrandom "foo"$i 100 &&
> +               test-tool genrandom "foo"$(( $i + 1 )) 100 &&
> +               test-tool genrandom "foo"$(( $i + 2 )) 100
> +       } >>deep_delta_$iii &&

I think this should be: s/>>/>/

> +       echo $iii >file_$iii &&
> +       test-tool genrandom "$iii" 8192 >>file_$iii &&

And this: s/>>/>/

> +       git update-index --add file_$iii deep_delta_$iii wide_delta_$iii
> +}
