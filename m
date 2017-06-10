Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A901F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 06:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdFJGVy (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:21:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:21:53 -0400
Received: (qmail 28062 invoked by uid 109); 10 Jun 2017 06:21:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:21:54 +0000
Received: (qmail 28941 invoked by uid 111); 10 Jun 2017 06:21:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:21:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:21:51 -0400
Date:   Sat, 10 Jun 2017 02:21:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Xie <emilyxxie@gmail.com>, git@vger.kernel.org,
        novalis@novalis.org
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
Message-ID: <20170610062151.fv7d4audrwav2hy3@sigill.intra.peff.net>
References: <20170607033308.33550-1-emilyxxie@gmail.com>
 <xmqq60g56s6x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60g56s6x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 01:28:54AM +0900, Junio C Hamano wrote:

> Emily Xie <emilyxxie@gmail.com> writes:
> 
> > An empty string as a pathspec element matches all paths.  A buggy
> > script, however, could accidentally assign an empty string to a
> > variable that then gets passed to a Git command invocation, e.g.:
> >
> >   path=... compute a path to be removed in $path ...
> >         git rm -r "$path"
> >
> > which would unintentionally remove all paths in the current
> > directory.
> >
> > The fix for this issue comprises of two steps. Step 1, which warns
> > that empty strings as pathspecs will become invalid, has already
> > been implemented in commit d426430 ("pathspec: warn on empty strings
> > as pathspec", 2016-06-22).
> >
> > This patch is step 2. It removes the warning and throws an error
> > instead.
> >
> > Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> > Reported-by: David Turner <novalis@novalis.org>
> > ---
> 
> We started this at v2.11.0 at the end of November 2016, and this
> cycle is expected to complete at around the end of July 2017, so
> this patch makes it a 8-month deprecation cycle.  I think that it
> should be long enough.

That's long enough for people who actually ran the intermediate
versions.  But what about people on distros who jump from v2.10 or lower
straight to v2.14?

I think to catch them we'd literally need years on our deprecation
schedules. Maybe it's not worth caring about. That's an awful long time
for people who _are_ upgrading each version to see the warning. Of
course the end game in this case is that it becomes an error, so they'll
be notified either way. :)

I'm OK with this case being a relatively quick deprecation, but your
"long enough" made me wonder how we would decide that.

-Peff

[1] Debian stable is set to release in a week or so. People doing that
    stable upgrade will go from v2.1.4 to v2.11.0. So they won't
    actually skip the deprecation notice, but they'll probably live with
    the warning for 3 years or so.
