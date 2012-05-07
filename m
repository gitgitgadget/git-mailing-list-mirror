From: Jeff King <peff@peff.net>
Subject: Re: Arguments to git hooks
Date: Mon, 7 May 2012 03:21:23 -0400
Message-ID: <20120507072123.GB19874@sigill.intra.peff.net>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
 <20120506191202.GB5725@moj>
 <CAH-tXsBpfXkr-qWdSBhPu6CcSZbm3f=3i1xJVtk6OkHz1NKCfA@mail.gmail.com>
 <20120506211120.GC5725@moj>
 <CAH-tXsDe7Hsacz19egdeW2sDV3SoPkJpJLPAmk_pCoEiR3wvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marcus Karlsson <mk@acc.umu.se>,
	git mailing list <git@vger.kernel.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIGf-0007ak-9t
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab2EGHV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:21:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60427
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab2EGHV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:21:26 -0400
Received: (qmail 17628 invoked by uid 107); 7 May 2012 07:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 03:21:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 03:21:23 -0400
Content-Disposition: inline
In-Reply-To: <CAH-tXsDe7Hsacz19egdeW2sDV3SoPkJpJLPAmk_pCoEiR3wvcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197237>

On Mon, May 07, 2012 at 03:10:07AM +0530, jaseem abid wrote:

> On Mon, May 7, 2012 at 2:41 AM, Marcus Karlsson <mk@acc.umu.se> wrote:
> > There are many different reasons to use hooks. If everything that a hook
> > could potentially need was passed to it as an argument then a lot of
> > data would often end up unused. Better to supply as little as possible
> > and only do more work when it's actually needed.
> 
> That seems like a good reason not to pass all of the data, but isn't
> the file names the most primary thing somebody can ask for?

Yes, although keep in mind that the list of files does not necessarily
fit onto the command line. We would have to feed it over stdin, and then
you would have parsing/quoting issues.

But you can get the exact same list from "git diff-index --cached
--name-only", and it is exactly as hard to parse as stdin would be (and
you can even decide to use "-z" to eliminate the quoting issues).

So asking the user to call the plumbing command is more efficient and
more flexible, but not actually any harder to use.

> > I wouldn't go as deep as the plumbing, I think git status --porcelain
> > should work just fine, the output is fairly easy to parse.
> 
> I have always wondered why 'git status --porcelain' is giving a
> 'plumbing' style output. Any docs on this somewhere?

It is plumbing. The porcelain is meant to be "output suitable for
reading by porcelains". Although I was the person who named "git status
--porcelain", it is not a convention I think is particularly good; I
named it to be consistent with other git commands which have a
"--porcelain" mode.

-Peff
