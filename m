Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B6C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34820756
	for <git@archiver.kernel.org>; Mon, 18 May 2020 21:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgERVAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 17:00:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726250AbgERVAq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 17:00:46 -0400
Received: (qmail 21710 invoked by uid 109); 18 May 2020 21:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 21:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6758 invoked by uid 111); 18 May 2020 21:00:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 17:00:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 17:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Force Charlie <charlieio@outlook.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] remote-curl: ensure last packet is a flush
Message-ID: <20200518210045.GA67802@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
 <20200515210245.GA3278654@generichostname>
 <20200515214102.GE115445@coredump.intra.peff.net>
 <xmqqeerh5hi5.fsf@gitster.c.googlers.com>
 <20200518165206.GE42240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518165206.GE42240@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 12:52:07PM -0400, Jeff King wrote:

> > I vaguely recall talking with somebody (perhaps it was Shawn Pearce)
> > about my long-time complaint on the on-the-wire protocol, in that
> > the protocol sometimes uses flush to merely mean "I've finished
> > speaking one section of my speech" and sometimes "I've done talking
> > for now and it's your turn to speak to me" (the receiving end needs
> > to know which one a particular flush means without knowing the
> > context in which it is issued---which makes it impossible to write a
> > protocol agnostic proxy.  
> > 
> > If the above proposal means that we'll have an explicit way to say
> > "Not just I am done with one section of my speech, but it is your
> > turn to speak and I am going to listen", that would be wonderful.
> 
> I think we already have that now in v2 because of the "0001" delim
> packet. All of the flushes are (I think) really "this is the end of my
> speech", and any inner "my list is ending, but I have more to say"
> delimiters are "0001".

Sadly, this is only _mostly_ true. See my response in:

  https://lore.kernel.org/git/20200518205854.GB63978@coredump.intra.peff.net/

-Peff
