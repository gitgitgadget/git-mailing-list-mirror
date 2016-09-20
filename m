Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A7D1F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 03:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbcITD7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 23:59:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:45401 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbcITD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 23:59:50 -0400
Received: (qmail 22411 invoked by uid 109); 20 Sep 2016 03:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 03:59:50 +0000
Received: (qmail 16808 invoked by uid 111); 20 Sep 2016 04:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 00:00:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 20:59:47 -0700
Date:   Mon, 19 Sep 2016 20:59:47 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH v2 1/2] t5100-mailinfo: replace common path prefix with
 variable
Message-ID: <20160920035947.nicx55ql4xlue66m@sigill.intra.peff.net>
References: <20160919185440.18234-1-me@ikke.info>
 <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-2-me@ikke.info>
 <xmqqzin3d1zs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzin3d1zs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 02:16:23PM -0700, Junio C Hamano wrote:

> Kevin Daudt <me@ikke.info> writes:
> 
> > Many tests need to store data in a file, and repeat the same pattern to
> > refer to that path:
> >
> >     "$TEST_DATA"/t5100/
> 
> That obviously is a typo of
> 
> 	"$TEST_DIRECTORY/t5100"
> 
> It is a good change, even though I would have chosen a name
> that is a bit more descriptive than "$DATA".

The name "$DATA" was my suggestion. I was shooting for something short
since this is used a lot and is really a script-local variable (I'd have
kept it lowercase to indicate that, but maybe that is just me).
Something like "$root" would also work. I dunno.

> > -	test_cmp "$TEST_DIRECTORY"/t5100/msg$mo msg$mo &&
> > -	test_cmp "$TEST_DIRECTORY"/t5100/patch$mo patch$mo &&
> > -	test_cmp "$TEST_DIRECTORY"/t5100/info$mo info$mo
> > +	test_cmp "$DATA"/msg$mo msg$mo &&
> > +	test_cmp "$DATA"/patch$mo patch$mo &&
> > +	test_cmp "$DATA"/info$mo info$mo
> 
> make me wonder why we don't quote the whole thing, i.e.
> 
> 	test_cmp "$TEST_DATA/info$mo" "info$mo"
> 
> as leaving $mo part unquoted forces reader to wonder if it is our
> deliberate attempt to allow shell $IFS in $mo and have the argument
> split when that happens, which can be avoided if we quoted more
> explicitly.
> 
> Perhaps we'd leave that as a low-hanging fruit for future people.

Yeah, I agree that quoting the whole thing makes it more obvious (though
I guess quoting the second info$mo does add two characters).

-Peff
