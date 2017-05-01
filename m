Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D2E1F829
	for <e@80x24.org>; Mon,  1 May 2017 05:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642637AbdEAFPf (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 01:15:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42917 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S642634AbdEAFPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 01:15:34 -0400
Received: (qmail 25117 invoked by uid 109); 1 May 2017 05:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 05:15:31 +0000
Received: (qmail 8181 invoked by uid 111); 1 May 2017 05:15:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 01:15:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 01:15:28 -0400
Date:   Mon, 1 May 2017 01:15:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170501051528.tpw3zlcpercdwdln@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170428223315.17140-1-marcnarc@xiplink.com>
 <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
 <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
 <xmqqlgqhjs8b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgqhjs8b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 06:11:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
> > index 6154acb45..5f46c0341 100755
> > --- a/t/t4051-diff-function-context.sh
> > +++ b/t/t4051-diff-function-context.sh
> > @@ -72,7 +72,7 @@ test_expect_success 'setup' '
> >  
> >  	# overlap function context of 1st change and -u context of 2nd change
> >  	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
> > -	sed 2p <"$dir/dummy.c" >>file.c &&
> > +	sed "2aextra line" <"$dir/dummy.c" >>file.c &&
> 
> I've never used 'a' (or 'i') command of sed without having it
> immediately followed by a backslash-newline in my scripts.  How
> portable is this addition, I have to wonder.  Can BSD folks give it
> a quick test?

I think you're right that it needs the backslash. It's so rarely used
that I always forget which one is the portable way.

-Peff

PS Outside of our test scripts, I'd probably just have written:

     perl -lpe 'print "extra line" if $. == 2'

   I think we have traditionally preferred sed/awk to perl, but given
   the heavy use of vanilla perl elsewhere in the test suite, I think
   that is maybe just superstition at this point.
