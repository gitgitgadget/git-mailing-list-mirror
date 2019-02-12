Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CDB1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBLAhh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:37:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:40966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727863AbfBLAhh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:37:37 -0500
Received: (qmail 20114 invoked by uid 109); 12 Feb 2019 00:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19694 invoked by uid 111); 12 Feb 2019 00:37:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:37:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:37:35 -0500
Date:   Mon, 11 Feb 2019 19:37:35 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes
 function
Message-ID: <20190212003735.GH13301@sigill.intra.peff.net>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
 <20190209185930.5256-2-randall.s.becker@rogers.com>
 <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 09, 2019 at 09:05:04PM -0500, Eric Sunshine wrote:

> On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> > t5318 and t5562 used /dev/zero, which is not portable. This function
> > provides both a fixed block of NUL bytes and an infinite stream of NULs.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > @@ -116,6 +116,19 @@ remove_cr () {
> > +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> > +# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
> > +# whichever comes first.
> 
> This is a somewhat unusual API. A (perhaps) more intuitive behavior
> would be for it to emit an infinite stream of NULs when given no
> argument, and a limited number of NULs when given an argument.
> Redefining the behavior like that also fixes the "problem" with the
> current implementation erroring-out if no argument is provided.

Yeah, I agree that'd be a little more idiomatic for our code base, but
I'm fine with it either way.

> > +generate_zero_bytes () {
> > +       perl -e 'if ($ARGV[0] == "infinity") {
> 
> s/perl/"$PERL_PATH"/

This shouldn't be necessary. perl() is a function that uses $PERL_PATH
(so you only need $PERL_PATH when you're writing out another script that
doesn't run in the same process space as the rest of the test code).

-Peff
