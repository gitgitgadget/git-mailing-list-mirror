Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4176C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiHBVwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHBVwY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:52:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8613AB22
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:52:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w7so14627862ply.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=StKVl2zWTA0ZZcxZFbccn3wEEz9AKO+lC+vWMubDILI=;
        b=V9sZLaq707mXzqYnPSaVCrTAc59OrU90T46Vr78XAgQuX/EAovezrnn3X10+aPuO5K
         l9l83SHd/omAiBRl2x9MpDTVpBm6meWyK9kTOPTSTPuNZxjbne/zTIwIz53E37d860aq
         HhO/76/RRaWTK7QJJpFGLQe3z79tHV5I++Opvd81CltZJ4LgaqcmpJQBcWv2JUuYhARR
         Z6+1/eZRjNzs7/CwHS81OP/aQcQH9DxAzNL1dLHwPVXqc2ZN3nU1DDJ8bbvX8/izX8I9
         MSWfHhtG4XxY+q5XiZnkbgYKV1GJRWH/RIB1EURs9ckpZBd0vZBUt95ZBtzqtYKkv6of
         rUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=StKVl2zWTA0ZZcxZFbccn3wEEz9AKO+lC+vWMubDILI=;
        b=hRoTDeG1L6YyhyTUUdJp1ip2hXOxmAR6F1DKyHeOf9pwisc46Oy0M2rPyai2hcpmBC
         mTxFC2zZoipHOa5syeE0u0yDeA2mbfO63ZIVclWCpYStyVN+1EUR9PYQollnkjcK9bEs
         cyWKKZy0DAWExyfgaG10sHUmq9h9nKOFQDeQxubt298spv4+N/FF53afWCTS7DAoVkZg
         b0L1ejOR5kSLkb/bnDnao8tMIAY9j6NHW72soRLK/Q7/AJQjyFExWnWq5N7IwBiJZGIT
         eVbm1k76O3TOzUuETH4WEjR1SuG7mChGZpPo4h7erN09yzSYueqJrBZnizGwMmb1UYct
         8ZDA==
X-Gm-Message-State: ACgBeo2JLxS0hqBZax5WPnB9aP/puXlJLgdOpsSHQrxe7h0570LsGC4H
        9IfbuKea0ZPzLjKqvvhKtekPSazfCuBwww==
X-Google-Smtp-Source: AA6agR5yYx8FjBZja1b88NQpcCH9Ps/QD2r3W8eyxRje4JZFaCG+WdA13Rg+Un6C4IMNaD5DtJDRMA==
X-Received: by 2002:a17:90a:d155:b0:1f2:4741:3b74 with SMTP id t21-20020a17090ad15500b001f247413b74mr1517429pjw.201.1659477142563;
        Tue, 02 Aug 2022 14:52:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e494:e2de:c190:f480])
        by smtp.gmail.com with ESMTPSA id 13-20020a62140d000000b0052ce4074fddsm9129178pfu.145.2022.08.02.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:52:21 -0700 (PDT)
Date:   Tue, 2 Aug 2022 14:52:15 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: add tracing for negotiation rounds
Message-ID: <Yumcj1oD9grwF7ZV@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
 <16998c06-8394-1c8a-06d1-0f7ac4034cf4@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16998c06-8394-1c8a-06d1-0f7ac4034cf4@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 20:04, Jeff Hostetler wrote:
> 
> 
> On 7/25/22 6:13 PM, Josh Steadmon wrote:
> > Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
> > the entire negotiation process. However, we'd like additional data, such
> > as timing for each round of negotiation or the number of "haves" in each
> > round. Additionally, "independent negotiation" (AKA push negotiation)
> > has no tracing at all. Having this data would allow us to compare the
> > performance of the various negotation implementations, and to debug
> > unexpectedly slow fetch & push sessions.
> > 
> > Fix this by adding per-round trace2 regions for all negotiation
> > implementations (V0+V1, V2, and independent negotiation), as well as an
> > overall region for independent negotiation. Add trace2 data logging for
> > the number of haves and "in vain" objects for each round, and for the
> > total number of rounds once negotiation completes.  Finally, add a few
> > checks into various tests to verify that the number of rounds is logged
> > as expected.
> 
> I've been wanting to add data like this around the negotiation
> code for a while now.  Thanks!
> 
> > 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >   fetch-pack.c                       | 62 +++++++++++++++++++++++++++++-
> >   t/t5500-fetch-pack.sh              |  4 +-
> >   t/t5516-fetch-push.sh              | 10 ++++-
> >   t/t5601-clone.sh                   |  6 ++-
> >   t/t5703-upload-pack-ref-in-want.sh |  6 ++-
> >   5 files changed, 81 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index cb6647d657..01a451e456 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -299,6 +299,7 @@ static int find_common(struct fetch_negotiator *negotiator,
> >   {
> >   	int fetching;
> >   	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
> > +	int negotiation_round = 0, haves = 0;
> >   	const struct object_id *oid;
> >   	unsigned in_vain = 0;
> >   	int got_continue = 0;
> > @@ -441,9 +442,19 @@ static int find_common(struct fetch_negotiator *negotiator,
> >   		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
> >   		print_verbose(args, "have %s", oid_to_hex(oid));
> >   		in_vain++;
> > +		haves++;
> >   		if (flush_at <= ++count) {
> >   			int ack;
> > +			negotiation_round++;
> > +			trace2_region_enter_printf("negotiation_v0_v1", "round",
> > +						   the_repository, "round-%d",
> > +						   negotiation_round);
> 
> I'm wondering here if the "round-%d" should have some number
> of leading zeros so that multiple rounds will sort correctly
> when you have a bunch of them.
> 
> I'm also wondering (and this is more of a style thing, so feel
> free to ignore) if we could just use trace2_region_enter()
> and make the "label" field be the "round/%04d" and not need
> the extra args.

Junio suggested just dropping the prefix altogether, so that's what I've
done for V2, but if you feel strongly about it we can discuss further
for V3.


> > +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> > +					   "haves_added", haves);
> > +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> > +					   "in_vain", in_vain);
> > +			haves = 0;
> 
> Thanks,
> Jeff
