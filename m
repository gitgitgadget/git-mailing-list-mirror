Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F9A20285
	for <e@80x24.org>; Wed, 30 Aug 2017 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdH3T5g (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 15:57:36 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36263 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdH3T5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 15:57:34 -0400
Received: by mail-pf0-f176.google.com with SMTP id r187so1411915pfr.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lQl0n+K2t11lq4cLUap3cu87pTpW59YC6XroRy+LdcA=;
        b=dql5mG5ag/XZbOjA8ZMMY7jN8q6TH0jekczFlGNlb/QM1Hv4h/+oDrjLixB79aDpeP
         hj1n0XZE2/zOuGTLL/XlqREN20iXzmd1tiQGPs1nSm5ABuJ8rBIpEN3PM19J1YZdC5JZ
         oz4fGaaMi8z0+g5d91ZqREBeEAS8hSqd9Om0CBgKJMl+TeQDacK6bLMO8uipywQR4W6g
         DsaNOCKYnI89vrEWX0YRtBjAP7N/astDd7fr/YU7sqaUxbNWNnnvC+7jTGPkLAugkVYO
         e7Sh7SjKIKyhTw3PDz4u9CqK/T43kcv2EfboW8MdqHrptCyGkg41YsT3MDKUkW2PMhUY
         Pk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lQl0n+K2t11lq4cLUap3cu87pTpW59YC6XroRy+LdcA=;
        b=FY+/lA4t/DT+Xv408hXUzpjI/27ZVThonvgWOTrm6XYNOwyfLo8Hvek8BKGYBorOQK
         naRtsZsFKlAk/oG91CKOFCuPqbzcu47j7eg03xLumZsCBcGomgvuyukQNYwyBpTj7yaQ
         EHOF25gzt9N5ZWSDWgdz6rJ63Lsfbvc4bs8XzJB1tJ8Ryon+I1uUVspN0y50c7DLk8A6
         RS3ZTt848tZqA6gCN+SMJBUcLrcRNHLi8yerGwj0E1KhXSd39YG6go98FQ1E7JjgAEXC
         VQanV56NCWvC1ijvZ6kNuIj4uRRjRH/yVM2dR2yK4c1yympXPoWWXT34rUxqxvqguxrT
         +SIQ==
X-Gm-Message-State: AHYfb5i33rl6GSzuzGr6YXmB6MeJLJUo7Vpw3yxy33aq4cwiQ35vnY37
        38zPuJlYntg6saHu
X-Google-Smtp-Source: ADKCNb7Ib1Gw1f8dRr6Rrz3GwKX/yNjnsoEhZc7KJDwZbp2Gt8X5NaXrAOM1SVP1pJpzFQ6XCBVZdw==
X-Received: by 10.99.54.12 with SMTP id d12mr2639270pga.370.1504123053729;
        Wed, 30 Aug 2017 12:57:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55:9408:3387:8e7e])
        by smtp.gmail.com with ESMTPSA id p64sm10309717pfi.168.2017.08.30.12.57.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 12:57:32 -0700 (PDT)
Date:   Wed, 30 Aug 2017 12:57:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830195731.GB50018@google.com>
References: <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
 <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, Jeff King wrote:
> On Wed, Aug 30, 2017 at 08:55:01AM +0200, Michael Haggerty wrote:
> 
> > > +	tempfile->active = 0;
> > > +	for (p = &tempfile_list; *p; p = &(*p)->next) {
> > > +		if (*p == tempfile) {
> > > +			*p = tempfile->next;
> > > +			break;
> > > +		}
> > >  	}
> > >  }
> > 
> > `deactivate_tempfile()` is O(N) in the number of active tempfiles. This
> > could get noticeable for, say, updating 30k references, which involves
> > obtaining 30k reference locks. I think that code adds the locks in
> > alphabetical order and also removes them in alphabetical order, so the
> > overall effort would go like O(N²). I'm guessing that this would be
> > measurable but not fatal for realistic numbers of references, but it
> > should at least be benchmarked.
> > 
> > There are three obvious ways to make this O(1) again:
> > 
> > * Make the list doubly-linked.
> 
> Yeah, I noticed this when writing it, and the doubly-linked list was my
> first thought. It's much more straight-forward than making guesses about
> traversal order, and we already have a nice implementation in list.h.

I agree that a doubly-linked list is probably the best way to go in
order to solve the performance issue.

> 
> What made me hesitate for this demonstration was that it turns the
> removal into _two_ pointer updates. That made me more nervous about the
> racy case where we get a single handler while already deleting
> something. Specifically when we have "a <-> b <-> c" and we've updated
> "a->next" to point to "c" but "c->prev" still points to "b".
> 
> But even with the singly-linked list we're not fully race-proof
> (somebody could set *p to NULL between the time we look at it and
> dereference it). What we really care about is not two versions of the
> function running simultaneously, but one version getting interrupted by
> another and having the second one see a sane state (because we'll never
> return to the first signal handler; the second one will raise() and
> die).
> 
> And I think we're fine there even with a doubly-linked list. It's still
> the single update of the "next" pointer that controls that second
> traversal.
> 
> -Peff

I know it was mentioned earlier but if this is a critical section, and
it would be bad if it was interrupted, then couldn't we turn off
interrupts before attempting to remove an item from the list?

-- 
Brandon Williams
