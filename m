Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AC81F403
	for <e@80x24.org>; Sun,  3 Jun 2018 22:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeFCWRR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 18:17:17 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41120 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeFCWRR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 18:17:17 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53MHBd2005601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jun 2018 00:17:11 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53MHBPH005600;
        Mon, 4 Jun 2018 00:17:11 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53MGHhg014647;
        Mon, 4 Jun 2018 00:16:17 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53MGGQO014646;
        Mon, 4 Jun 2018 00:16:16 +0200
Date:   Mon, 4 Jun 2018 00:16:16 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603221616.GA14636@helen.PLASMA.Xg8.DE>
References: <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
 <20180603200739.GC1750@thunk.org>
 <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
 <20180603210344.GF1750@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603210344.GF1750@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 05:03:44PM -0400, Theodore Y. Ts'o wrote:
> If you don't think a potential 2x -- 10x performance hit isn't a
> blocking factor --- sure, go ahead and try implementing it.  And good
> luck to you.  And this is not a guarantee that it won't get rejected.
> I certainly don't have the power to make that guarantee.

I do not want or expect a guarantee, or even a probability, of course. 
Just trying to avoid "STRONG REJECT. We could have said you before you 
even started implementing. Why didn't you discuss this beforehand?"

One would simply change something like

author A U Thor <author@example.com> 1465982009 +0000

into something like

author 21bbba8e9ce9734022d2c23df247a2704c0320ad7d43c02e8bdecdfae27e23b4 A U Thor <author@example.com>
author-hash 469bb107e38f8e59dddb3bbd6f8646e052bf73d48427865563c7358a64467f2c
authordate c444f739ca317e09dbd3dae1207065585ae2c2e18cd0fc434b5bde08df1e0569 1465982009 +0000
authordate-hash 199875e5aedb6cb164a2b40c16209dc5bb37f34c059a56c6d96766440fb0fe68

and then compute the commit id without the "author" and the 
"authordate" lines.

The *-hash values were obtained as follows:

echo -n '21bbba8e9ce9734022d2c23df247a2704c0320ad7d43c02e8bdecdfae27e23b4 A U Thor <author@example.com>' | sha3sum -a 256
echo -n 'c444f739ca317e09dbd3dae1207065585ae2c2e18cd0fc434b5bde08df1e0569 1465982009 +0000' | sha3sum -a 256

The hex values here are simply the $huge_random_numbers

Verifying the commit ID by itself wouldn't be any less efficient than 
before. Admitteldly, it wouldn't verify the author and authordate 
integrity anymore without additional work. That would be some overhead, 
sure, and could be done on demand, and would mostly affect clones. I 
don't think it would be that much of a problem. It can be parallelized 
easily. The hashes for each field are independent of each other. They 
can all be verified in parallel in different threads running on 
different cores.

On djb's typical 2015 skylake machine the supercop benchmark tells us 
that sha3-256 (~=keccakc512) has a speed of about 20 cycles/byte for 
blocks of 64 bytes of data, see 
https://bench.cr.yp.to/results-sha3.html#amd64-skylake

Let's say we have 128 bytes of data on average for the author field, so 
conservatively speaking it takes about 3000 cycles (> 128*20) to hash 
and compare the hash.

At 3000 MHz, we can thus do roughly about 1000 verifications per second 
per core.

Let's assume we have 10 anonymizable fields of this kind per commit.

Then the overhead would be one second per 100 x ncores commits.

How many commits are we talking about in a huge repository? And how 
long does a clone of such a huge repository take at the moment? Do you 
have any numbers?

> If you don't have time to implement, why do you think it's fair to
> inflict on everyone else the request for time to do a design review
> for something for which the need hasn't even been established?

I do not request from anyone to even reply to my messages. I just see a 
lot of time being wasted by discussing things about my proposal that 
are technically irrelevant. If that time were put into reviewing the 
design, it would be spent better.

Please don't devalue a proposal. It is not true that the only value is 
in actual code and proposals are "bullshit".

I was not the first to raise the issue, as I clearly showed in my 
initial email.

The demand is in fact high; very high. At present, that demand is 
satisfied by lawyers. Who are writing snake oil disclaimers and such 
for enormous sums of money. In a lot of companies. To "solve" a 
technical issue by pseudo-legal means by finding excuses for why the 
"right to be forgotten" doesn't have to be implemented in specific 
cases such as git. What if all that lawyer money were put into actually 
solving the technical issues as technical issues? Engineers are 
apparently bad at marketing, the lawyers seem more successful in that 
respect.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
