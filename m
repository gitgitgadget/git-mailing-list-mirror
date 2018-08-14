Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58D31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHNWZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:25:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728199AbeHNWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:25:29 -0400
Received: (qmail 2407 invoked by uid 109); 14 Aug 2018 19:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 19:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25474 invoked by uid 111); 14 Aug 2018 19:36:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 15:36:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 15:36:46 -0400
Date:   Tue, 14 Aug 2018 15:36:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit
 planning)
Message-ID: <20180814193646.GC28452@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net>
 <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 01:43:38PM -0400, Derrick Stolee wrote:

> On 8/13/2018 5:54 PM, Jeff King wrote:
> > So I try not to think too hard on metrics, and just use them to get a
> > rough view on who is active.
> 
> I've been very interested in measuring community involvement, with the
> knowledge that any metric is flawed and we should not ever say "this metric
> is how we measure the quality of a contributor". It can be helpful, though,
> to track some metrics and their change over time.
> 
> Here are a few measurements we can make:

Thanks, it was nice to see a more comprehensive list in one spot.

It would be neat to have a tool that presents all of these
automatically, but I think the email ones are pretty tricky (most people
don't have the whole list archive sitting around).

> 2. Number of other commit tag-lines (Reviewed-By, Helped-By, Reported-By,
> etc.).
> 
>     Using git repo:
> 
>     $ git log --since=2018-01-01 junio/next|grep by:|grep -v
> Signed-off-by:|sort|uniq -c|sort -nr|head -n 20

At one point I sent a patch series that would let shortlog group by
trailers. Nobody seemed all that interested and I didn't end up using it
for its original purpose, so I didn't polish it further.  But I'd be
happy to re-submit it if you think it would be useful.

The shell hackery here isn't too bad, but doing it internally is a
little faster, a little more robust (less parsing), and lets you show
more details about the commits themselves (e.g., who reviews whom).

> 3. Number of threads started by user.

You have "started" and "participated in". I guess one more would be
"closed", as in "solved a bug", but that is quite hard to tell without
looking at the content. Taking just the last person in a thread as the
closer means that an OP saying "thanks!" wrecks it. And somebody who
rants long enough that everybody else loses interest gets marked as a
closer. ;)

> If you have other ideas for fun measurements, then please let me know.

I think I mentioned "surviving lines" elsewhere, which I do like this
(and almost certainly stole from Junio a long time ago):

  # Obviously you can tweak this as you like, but the mass-imported bits
  # in compat and xdiff tend to skew the counts. It's possibly worth
  # counting language lines separately.
  git ls-files '*.c' '*.h' :^compat :^contrib :^xdiff |
  while read fn; do
    # eye candy
    echo >&2 "Blaming $fn..."

    # You can use more/fewer -C to dig more or less for code moves.
    # Possibly "-w" would help, though I doubt it shifts things more
    # than a few percent anyway.
    git blame -C --line-porcelain $fn
  done |
  perl -lne '/^author (.*)/ and print $1' |
  sort | uniq -c | sort -rn | head

The output right now is:

  35156 Junio C Hamano
  22207 Jeff King
  17466 Nguyễn Thái Ngọc Duy
  12005 Johannes Schindelin
  10259 Michael Haggerty
   9389 Linus Torvalds
   8318 Brandon Williams
   7776 Stefan Beller
   5947 Christian Couder
   4935 René Scharfe

which seems reasonable.

-Peff
