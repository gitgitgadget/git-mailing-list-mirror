Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510181F403
	for <e@80x24.org>; Fri,  8 Jun 2018 04:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeFHEub (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 00:50:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:38570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750970AbeFHEua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 00:50:30 -0400
Received: (qmail 27051 invoked by uid 109); 8 Jun 2018 04:50:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Jun 2018 04:50:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24677 invoked by uid 111); 8 Jun 2018 04:50:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Jun 2018 00:50:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jun 2018 00:50:28 -0400
Date:   Fri, 8 Jun 2018 00:50:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180608045028.GA17528@sigill.intra.peff.net>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180103053516.GB87855@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 09:35:16PM -0800, Jonathan Nieder wrote:

> > bturner@ubuntu:~$ ssh -V
> > OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.8, OpenSSL 1.0.1f 6 Jan 2014
> >
> > bturner@ubuntu:~$ ssh -G -p 7999 localhost
> > unknown option -- G
> > usage: ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
> [...]
> > Is it possible to adjust the check, somehow, so it doesn't impact
> > older OpenSSH versions like this? As it stands, it seems likely a fair
> > number of users who have an SSH command that does support -4, -6 and
> > -p are going to end up getting "penalized" because it doesn't also
> > support -G, and have to manually set their SSH variant to "ssh" (or
> > something other than "auto") to avoid the automatic detection.
> >
> > I'd love to say I have a brilliant idea for how to work around this,
> > oh and here's a patch, but I don't. One option might be trying to
> > actually review the output, and another might be to run "ssh -V", but
> > both of those have their own flaws (and the extra process forks aren't
> > "free").
> 
> I have tomorrow off, so I've filed https://crbug.com/git/7 to make
> sure I remember to follow up the day after.  Of course I'll be happy
> if someone updates that bug saying they've fixed it in the meantime.

It doesn't look like we ever applied anything to deal with this
regression. Just FYI, this bit me today when upgrading my git on a
system that has an ssh wrapper that understands "-p" just fine, but not
"-G". So the behavior described in [1], namely to just fallback to
assuming some basic openssh-ish options, would have worked for me.

To be honest, I could easily see an argument that I _should_ be setting
GIT_SSH_VARIANT to explain what my wrapper is expecting, even though it
happened to work before. But it seems like this discussion ended in
favor of calling this a regression that should be fixed, and AFAICT
nothing happened after. So I thought I'd ping and mention one more data
point.

-Peff

[1] https://public-inbox.org/git/xmqqk1wyhcey.fsf@gitster.mtv.corp.google.com/
