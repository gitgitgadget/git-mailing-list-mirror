Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF811F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfG2UMj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:12:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:54652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728931AbfG2UMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:12:38 -0400
Received: (qmail 28249 invoked by uid 109); 29 Jul 2019 20:12:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 20:12:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 562 invoked by uid 111); 29 Jul 2019 20:14:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 16:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 16:12:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Olivier Bornet <olivier.bornet@puck.ch>
Subject: Re: [PATCH] Documentation/git-fsck.txt: include fsck.* config
 variables
Message-ID: <20190729201236.GF14943@sigill.intra.peff.net>
References: <20190729093928.GP20404@szeder.dev>
 <20190729095914.30573-1-szeder.dev@gmail.com>
 <87sgqo6ejk.fsf@evledraar.gmail.com>
 <xmqq36iox2nn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36iox2nn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 08:48:28AM -0700, Junio C Hamano wrote:

> > Before this include let's add:
> >
> >     The below documentation is the same as what’s found in
> >     git-config(1):
> 
> I actually do not think we would want to do that.  I am all for the
> kind of 'include' proposed by this patch, and we should strive to
> make it easier for us to make sure the duplicated text are in sync.
> 
> But that would mean that the readers will have to see the "is the
> same as the other one" over and over.  If our documentation set is
> consistent, they should not have to.
> 
> I think we *must* make such a note in a total opposite case,
> i.e. "here are the summary of the most often used options; for full
> list, see git-config(1)".

I disagree. _We_ know that the content is the same, because we are
looking at the source that says "include". But as a user, how do I know
when I get to one section or the other that it is something I have
already read and can skip over?

Perhaps if Git were entirely consistent here, they could make the
assumption that "CONFIG" sections were always duplicated and know this
already.  But I think even that is asking a bit much. Unless they are
intimately familiar with our documentation, they don't know that we are,
in fact, consistent. And we are in an uphill battle with every other
thing the user has read, which may not agree with our assumptions of
consistency. ;)

So IMHO it's worth leaving a note that guides the reader, as long as
it's short (and I think this one is).


That said, I think an even _better_ solution would be to avoid includes,
and instead make it clear when we are pointing the user to shared
content. Then we get them to the right place _and_ explicitly instruct
them that concepts/content are shared. For config, for example, I've
worked with a previous system that did something like:

  - include fsck.* documentation in the git-fsck manpage

  - make a master table of config options in git-config.1 with _just_
    the names and the associated manpage where the definition can be
    found. This serves as an index if you don't know where to look.

This would probably involve creating new concept-based pages for some of
the groupings (e.g., where does "remote.*" config go?), but I think that
would probably help round out our documentation (if there is a concept
with related config options but we don't explain it anywhere, that is
probably a gap we should fix).

The biggest downside is that chasing down references in manpages sucks.
For the HTML documentation we'd ideally hyperlink from the git-config.1
index into each definition, but there's no way to do that with a regular
manpage.

-Peff

PS This is an approach I've advocated for a while:

    https://public-inbox.org/git/20110120233429.GB9442@sigill.intra.peff.net/

   but haven't actually done much about, so perhaps I should be putting
   my money where my mouth is. ;)
