From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] refs.c: replace write_str_in_full by write_in_full
Date: Wed, 21 Jan 2015 18:52:13 -0500
Message-ID: <20150121235213.GF11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
 <1421882625-916-4-git-send-email-sbeller@google.com>
 <20150121233843.GB11115@peff.net>
 <CAGZ79kaTUraVYc1Th0-8ajw4kMuU-Sir2e9dW1uy90CuQRzgeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE54N-0002eH-DS
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbbAUXwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:52:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752001AbbAUXwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:52:14 -0500
Received: (qmail 2948 invoked by uid 102); 21 Jan 2015 23:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:52:14 -0600
Received: (qmail 2096 invoked by uid 107); 21 Jan 2015 23:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:52:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:52:13 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kaTUraVYc1Th0-8ajw4kMuU-Sir2e9dW1uy90CuQRzgeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262789>

On Wed, Jan 21, 2015 at 03:44:36PM -0800, Stefan Beller wrote:

> On Wed, Jan 21, 2015 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Jan 21, 2015 at 03:23:42PM -0800, Stefan Beller wrote:
> >
> >> There is another occurrence where we could have used write_str_in_full
> >> (line 3107: write_in_full(lock->lk->fd, &term, 1)), so the current state
> >> is inconsistent. This replaces the only occurrence of write_str_in_full
> >> by write_in_full, so we only need to wrap write_in_full in the next patch.
> >
> > I had to read the first sentence a few times to figure out what you
> > meant. But I am not sure it is even relevant. We do not care about the
> > inconsistency.
> 
> You're not the first who needs to reread my stuff :/
> I have the impression my English worsened since coming into the USA.

Actually, it was my fault in this case. I read it as "_this_ is another
occurrence", and then I scratched my head wondering what the first
occurrence was (was there a previous change that you should have been
referencing?). I finally got it on the third try. :)

> We do not care about the inconsistency, but we may care about the
> change itself: "write_str_in_full is way better than write_in_full, so
> why the step backwards?" And  I am trying to explain that this is not
> a huge step backwards but rather improves consistency.

But you could improve consistency by going the other way, too. :) I
think the point is that you should lead in with the _real_ reason for
the change, not justifications. You can put in the justifications, too,
for the people who say "wait, but couldn't you do this other thing...".

> > It is just "we are about to change how callers of
> > write_in_full in this file behave, the wrapper gets in the way, and it
> > does not add enough value by itself to merit making our future changes
> > in two places".
> 
> That's actually true. Though that sounds as if we'd be lazy ("we only
> want to make
> one change, so let's bend over here")

It's not laziness. It's avoiding duplicating logic, which would end up
costing more lines and providing worse maintainability than just
dropping the wrapper, which is after all only saving us a few characters
(and not anything conceptually hard).

> I'll rethink the commit message.

Everything I said above is rather subjective, of course. I do appreciate
you breaking your commits apart and explaining each one in the first
place. IOW, while I have thoughts on improving them (obviously), the
current iteration is not so bad that I would be upset to see it go into
git. Don't waste too much time on it.

-Peff
