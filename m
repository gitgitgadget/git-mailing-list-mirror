Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB9C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B524656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBZUjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:39:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:55458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727379AbgBZUjd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:39:33 -0500
Received: (qmail 21672 invoked by uid 109); 26 Feb 2020 20:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 20:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29171 invoked by uid 111); 26 Feb 2020 20:48:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2020 15:48:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Feb 2020 15:39:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Greg Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: git-shell default working directory
Message-ID: <20200226203931.GA288832@coredump.intra.peff.net>
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
 <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
 <20200226201121.GA287048@coredump.intra.peff.net>
 <xmqqeeuhhz3a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeeuhhz3a.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 12:29:13PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Feb 26, 2020 at 10:10:05AM +0100, Andrei Rybak wrote:
> >
> >> > I've not yet found a way to get this to work without keeping the
> >> > repositories in the git user's home folder.
> >> 
> >> Disclaimer: I'm not at all familiar with git server setup. Would it make sense
> >> to change git user home directory to be the required dedicated directory?
> >
> > Yeah, that's what I would suggest. git-shell does explicitly cd to
> > $HOME, so any chdir you do before then will be lost (though you could
> > perhaps just set $HOME in ~/.ssh/rc).
> 
> I didn't suggest it because the original request did not sound like
> building a dedicated machine that is used only to push into without
> interactive shell access.  If $HOME is moved to such a git centric
> place, that would make it almost impossible to use the account for
> shell interactive access, I would imagine, and if that is acceptable,
> perhaps something like gitolite would fit the bill better?

I took the mention of /home/git to mean it was a dedicated "git" user.
But yeah, that would be an awful suggestion for a regular user. :)

And I second the notion of gitolite for a dedicated setup like this (I
haven't really used it much myself, but the design always seemed quite
sane to me).

I _do_ keep git repositories on a host accessible by my normal user.
It's a mild inconvenience to have to clone "git.peff.net:git/foo.git"
instead of just "git.peff.net:foo.git". We could allow a config or
environment variable to re-root a relative path given to upload-pack. As
long as it was clear this isn't a security feature (it's for people who
already have shell access, and could be overridden by an absolute path),
I think it would be OK.

-Peff
