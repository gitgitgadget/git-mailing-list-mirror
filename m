From: Jeff King <peff@peff.net>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Wed, 2 Nov 2011 19:27:35 -0400
Message-ID: <20111102232735.GA17466@sigill.intra.peff.net>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net>
 <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:27:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLkDg-0005oR-KN
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 00:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab1KBX1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 19:27:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60498
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab1KBX1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 19:27:38 -0400
Received: (qmail 17448 invoked by uid 107); 2 Nov 2011 23:33:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 19:33:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 19:27:35 -0400
Content-Disposition: inline
In-Reply-To: <7vwrbigna7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184681>

On Wed, Nov 02, 2011 at 03:41:36PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Which is all a roundabout way of saying that the git protocol is really
> > the sane way to do efficient transfers. An alternative, much simpler
> > scheme would be for the server to just say:
> >
> >   - if you have nothing, then prime with URL http://host/bundle
> >
> > And then _only_ clone would bother with checking mirrors. People doing
> > fetch would be expected to do it often enough that not being resumable
> > isn't a big deal.
> 
> I think that is a sensible place to start.

OK. That had been my original intent, but somebody (you?) mentioned the
"if you have X" thing at the GitTogether, which got me thinking.

I don't mind starting slow, as long as we don't paint ourselves into a
corner for future expansion. I'll try to design the data format for
specifying the mirror locations with that extension in mind.

Even if the bundle thing ends up too wasteful, it may still be useful to
offer a "if you don't have X, go see Y" type of mirror when "Y" is
something efficient, like git:// at a faster host (i.e., the "I built 3
commits on top of Linus" case).

> A more fancy conditional "If you have X then fetch this, if you have Y
> fetch that, ..." sounds nice but depending on what branch you are fetching
> the answer has to be different. If we were to do that, the natural place
> for the server to give the redirect instruction to the client is after the
> client finishes saying "want", and before the client starts saying "have".

Agreed. I was really trying to avoid protocol extensions, though, at
least for an initial version. I'd like to see how far we can get doing
the simplest thing.

-Peff
