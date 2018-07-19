Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1CB1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 23:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGTAkz (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 20:40:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:10095 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTAkz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 20:40:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w6JNtGQD090487
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 19:55:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>, "'Stefan Beller'" <sbeller@google.com>
References: <20180719203259.GA7869@sigill.intra.peff.net>        <20180719203901.GA8079@sigill.intra.peff.net> <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH 1/2] introduce "banned function" list
Date:   Thu, 19 Jul 2018 19:55:04 -0400
Message-ID: <005801d41fbb$ed885fb0$c8991f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIliP9O6k0H5ey6UZRbONWpVNLRPwJ2K9VaAQRyf0ej2I7v0A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 19, 2018 6:46 PM, Junio wrote:
> Jeff King <peff@peff.net> writes:
> 
> > For enforcement, we can rely on the compiler and just introduce code
> > which breaks compilation when it sees these functions. This has a few
> > advantages:
> >
> >   1. We know it's run as part of a build cycle, so it's
> >      hard to ignore. Whereas an external linter is an extra
> >      step the developer needs to remember to do.
> >
> >   2. Likewise, it's basically free since the compiler is
> >      parsing the code anyway.
> >
> >   3. We know it's robust against false positives (unlike a
> >      grep-based linter).
> >
> > The one big disadvantage is that it will only check code that is
> > actually compiled, so it may miss code that isn't triggered on your
> > particular system. But since presumably people don't add new code
> > without compiling it (and if they do, the banned function list is the
> > least of their worries), we really only care about failing to clean up
> > old code when adding new functions to the list. And that's easy enough
> > to address with a manual audit when adding a new function (which is
> > what I did for the functions here).
> >
> > That leaves only the question of how to trigger the compilation error.
> > The goals are:
> 
> I actually have another question, though.
> 
> Is it a downside that it is cumbersome to override?  This is not a
rhetorical
> question.  I am not convinced there will not be a legit circumstance that
> calling strcpy (or whatever we are going to ban) is the best solution and
it is
> safe.  By "best", what I mean is "you could instead use
> memcpy/strncpy/whatever" can legitimately be argued with "but still using
> memcpy/strncpy/whatever is inferior than using strcpy in this case for
such
> and such reasons".

Putting on my old-guy compiler hat, this sounds like a more complex activity
that something akin to lint might be useful at handling. Having a
post-processor that searches for offending functions but also supports
annotations explaining exceptions (why you really had to use strncpy because
the NULL was hiding in a bad place and you promise to fix it), might be
useful. Personally, I'd rather know that that code compiles first and then
violates rules that I can fix following basic prototyping than getting
yelled at up front - but that's just me. I can't suggest a good thing to
handle this, short of augmenting lint, and if we were in java, annotations
would be the way to go, but this seems like a problem that other products
have solved.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



