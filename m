From: Jeff King <peff@peff.net>
Subject: Re: publish from certain commit onward, keeping earlier history
 private, but provable
Date: Wed, 9 Dec 2015 17:50:44 -0500
Message-ID: <20151209225043.GC32104@sigill.intra.peff.net>
References: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
 <20151209222041.GB21751@sigill.intra.peff.net>
 <20151209222412.GC21751@sigill.intra.peff.net>
 <CAGZ79kYv0qJ==n3TCxTeNkenzKn5msRtR1jAiKEy1mECwUaAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6nZT-0006qv-6i
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbbLIWur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:50:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:39555 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753568AbbLIWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:50:46 -0500
Received: (qmail 4698 invoked by uid 102); 9 Dec 2015 22:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 16:50:46 -0600
Received: (qmail 14420 invoked by uid 107); 9 Dec 2015 22:50:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 17:50:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 17:50:44 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYv0qJ==n3TCxTeNkenzKn5msRtR1jAiKEy1mECwUaAuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282206>

On Wed, Dec 09, 2015 at 02:29:12PM -0800, Stefan Beller wrote:

> On Wed, Dec 9, 2015 at 2:24 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Dec 09, 2015 at 05:20:41PM -0500, Jeff King wrote:
> >
> >> Of course that is a bitter pill to swallow if you have reasons for
> >> wanting to use the old sha1s. E.g., you have internal development
> >> proceeding against the old tree and want to share a truncated version
> >> with the public.
> >
> > After re-reading your email, it looks like your use case is just to be
> > able to later prove the existence of the original history. You could
> > that by mentioning the original "C" in your truncated "D", but in a way
> > that git does not traverse reachability. For instance, amend D's commit
> > message to say:
> >
> >   This is based on earlier, unpublished work going up to commit C.
> >
> > Then retain C for yourself, and show it only to those you want to prove
> > its contents to.
> 
> I'd rather keep D for yourself and create a D' which is D just without
> parent and
> the note above, such that the tree of D and parts of the commit message
> is obvious by looking at D'. All that is secret is Ds parent and the commit
> information such as exact date. (committer could be guessed easily)

I think the point is that all of this is happening at time t (let's say
2015), and the proof may be needed at time t+N (let's say 2020).

Showing the original D (or C, or whatever) at that point proves nothing,
as you could have created a fake history in 2020 that "ends up" at the
D' tree. You need to publish _something_ in 2015 that says "I know this
thing, but I am not willing to show it to you yet".

The classic way of doing this is to take out a small ad in the
classified section of a print newspaper with a hash of your data.
Libraries keep archives of the paper, so later you can prove that you
have the data that matches the hash, and its timestamp is certified by
the library archives.

Here we're abusing Git as the notary. If everyone spends the years from
2015-2020 building on top of D', then they can all reasonably agree that
the content of D' was written in 2015, and any commit hash it mentions
had to have existed then. Revealing C (or the original D, or whatever
hash you want to mention) proves the data.

-Peff
