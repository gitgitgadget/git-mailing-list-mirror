From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 23:08:26 -0500
Message-ID: <20141125040826.GC19301@peff.net>
References: <6997784.RuzRO1AFsK@al>
 <1660121.8PEbpzfRYH@al>
 <20141124225457.GA9942@peff.net>
 <283403992.8FOSVk7RPR@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Tue Nov 25 05:08:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt7QW-0006gm-I1
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 05:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaKYEI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 23:08:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:44621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbaKYEI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 23:08:27 -0500
Received: (qmail 28136 invoked by uid 102); 25 Nov 2014 04:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 22:08:27 -0600
Received: (qmail 26510 invoked by uid 107); 25 Nov 2014 04:08:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 23:08:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 23:08:26 -0500
Content-Disposition: inline
In-Reply-To: <283403992.8FOSVk7RPR@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260190>

On Tue, Nov 25, 2014 at 12:27:31AM +0100, Peter Wu wrote:

> On Monday 24 November 2014 17:54:57 Jeff King wrote:
> > On Mon, Nov 24, 2014 at 11:47:30PM +0100, Peter Wu wrote:
> > > I can understand that --fetch sounds a bit weird, what about this
> > > natural translation:
> > > 
> > >     "git remote: set the URL (only the fetch one) for NAME to URL"
> > >     git remote set-url --only=fetch NAME URL
> > > 
> > >     "git remote: set the URL (only the push one) for NAME to URL"
> > >     git remote set-url --only=push NAME URL
> > >     (obsoletes --push)
> > > 
> > >     "git remote: set the URL (both) for NAME to URL"
> > >     git remote set-url --only=both NAME URL
> > >     (it would be nice if --only=both (weird!) can be removed in the
> > >     future such that the option is more natural)
> > > 
> > >     "git remote: set the URL for NAME to URL"
> > >     git remote set-url NAME URL
> > >     (current behavior: YOU git guru knows what I do right?)
> > 
> > Yeah, I think that addresses my concern (because it explicitly leaves
> > no-option as a historical curiosity, and not as an implicit version of
> > "--both").
> 
> Ok, I will make a clear note about the default (without --only) behavior
> having weird behavior for historical reasons. Are you really OK with
> --only=both? It sounds a bit odd (mathematically speaking it is correct
> as fetch and push are both partitions that form the whole set if you
> ignore the historical behavior).

Maybe "--operation={push,fetch,both}" would be less odd (though
"--operation" is rather clunky, I could not think of a better word). It
is the conjunction of "--only" an "both" that makes little sense.

However, I think what removed the confusion for me in your --only=both
proposal was the presence of a "both" option, since it made it more
clear that is not what no-option means. So what about just "--push",
"--fetch", and "--both"? Explain the current behavior of no-options in
the documentation as a historical oddity.

That also gives us an easy path forward for changing the behavior.
During the transition period, people should use --push, --fetch, or
--both. Using no-options provides a warning. After a settling period,
the no-option behavior will switch to one of those (presumably --both),
and drop the warning.

You do not have to do the migration path if you don't want to. Adding
"--fetch" and "--both" scratches your itch and sets us up to migrate
later.

> What about the translations? Should I send a separate patch for that or
> can I update all translations at once?

You do not have to update the translations. When we near a release, the
l10n coordinator will run "make pot" to update po/git.pot with the
strings marked for translation, and then the translators will write
translations for the new strings. You are of course welcome to help with
the translation effort at that stage. :)

Details are in po/README.

-Peff
