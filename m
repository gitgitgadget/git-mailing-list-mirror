Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B5FC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5826660EB5
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhH0SiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:38:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:60840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhH0SiT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:38:19 -0400
Received: (qmail 9115 invoked by uid 109); 27 Aug 2021 18:37:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 18:37:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15528 invoked by uid 111); 27 Aug 2021 18:37:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 14:37:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 14:37:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: git log --encoding=HTML is not supported
Message-ID: <YSkw6DSHenXHGx0b@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
 <xmqq5yvsgqt7.fsf@gitster.g>
 <3883941.fE8Og5qy2N@localhost.localdomain>
 <xmqqk0k6c1zn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0k6c1zn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 08:59:40AM -0700, Junio C Hamano wrote:

> Krzysztof Żelechowski <giecrilj@stegny.2a.pl> writes:
> 
> > Dnia czwartek, 26 sierpnia 2021 17:37:40 CEST Junio C Hamano pisze:
> >>         git log --html \
> >>                 --format='<tr><td>%h</td><td>%s</td>...</tr>'
> >
> > I would like to be able to say:
> >  { git config i18n.logOutputEscape HTML; }
> >
> > What do you think?
> 
> It depends on what it does.
> 
> If the configuration means that "git log" output (with any supported
> options, like "-p") will be given with '<' written to '^lt;' etc. so
> that it becomes safe to dump it in HTML, it fails to interest me at
> all.

Yeah, I think things get pretty weird when you start thinking about
dumping whole filenames and diff contents.

I wouldn't be opposed to an option for the pretty formatter to have
encodings. Something like:

  git log --format='%(authorname:quote=html)'

I'd probably put off implementing that until we actually unify the
for-each-ref and pretty formats, though (we do not even have
%(authorname) at this point!). The latter already has a quoting
mechanism for shell/perl/python/tcl (though it is not per-atom, and I
wouldn't be opposed to a --format-quote option that quoted all pretty.c
placeholders).

-Peff
