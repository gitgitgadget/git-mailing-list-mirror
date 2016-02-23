From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 00:02:11 -0500
Message-ID: <20160223050210.GA17767@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 06:02:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY578-0005wQ-4X
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 06:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbcBWFCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 00:02:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:47278 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720AbcBWFCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 00:02:13 -0500
Received: (qmail 6181 invoked by uid 102); 23 Feb 2016 05:02:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 00:02:13 -0500
Received: (qmail 25461 invoked by uid 107); 23 Feb 2016 05:02:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 00:02:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 00:02:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287014>

On Mon, Feb 22, 2016 at 02:45:45PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. Rip out the weird add/add conflict resolution. This gets rid of the
> >      buggy code, makes merge-tree more like the rest of git, and I think
> >      lets us even drop the EMIT_COMMON stuff from xdiff).
> 
> That is a nice bonus.
> 
> git-merge-resolve (rather, git-merge-one-file) attempts the same
> "resolve add/add by taking the common" thing, but it implements it
> in quite a different way.

I suppose the end result of what merge-tree is trying to do makes sense.
It's definitely a conflict, but we are interested in showing the minimal
content-level conflict. But I think xdl_merge() takes care of that for
us, if we simply feed an empty base. And that is what merge-recursive
does.

I do see that merge-one-file tries create_virtual_base(), which does
some magic with diff. But I'm having trouble conceiving of a case where
that would do something different or useful.

> >      That lets people keep using merge-tree if they have found it useful
> >      over the years.
> 
> >   3. Drop merge-tree completely. This deletes even more code, and helps
> >      the people in (2) realize that it is utterly unmaintained. :)
> >
> > I think at this point I am waffling between (2) and (3). I did (1) in a
> > hope that I could avoid looking deeper into the code at all, but now
> > that I have, I do not think (2) would be so bad. I'm happy to work up a
> > patch, but won't bother if we think that (3) is viable.
> 
> Yup, between 2 and 3, 2 would certainly be safer, and I agree that
> it is not too bad (I have this feeling that add-add conflict is not
> the only funny this code has, though).

Yeah, I do not mind doing 2, but I have no idea what else is lurking,
and I have very little interest in digging into it.

> Let's wait and see how many "please don't"s we hear, perhaps, before
> deciding to go 3.?

I'm guessing we won't see much either way. Even Stefan, the original
reporter, does not seem to actively be using it, but rather relaying a
report.

We'd probably get more response by doing 2 for now, then adding a
deprecation warning to the manpage (and possibly the program itself) for
the next release.

-Peff
