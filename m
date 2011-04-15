From: Jeff King <peff@peff.net>
Subject: Re: capturing the packfile from git-upload-pack
Date: Fri, 15 Apr 2011 15:25:19 -0400
Message-ID: <20110415192519.GA5332@sigill.intra.peff.net>
References: <1302837720729-6275146.post@n2.nabble.com>
 <BANLkTimAt_gcp1uBR_0H7LJHUdFGqHbRvA@mail.gmail.com>
 <7vy63bcsqz.fsf@alter.siamese.dyndns.org>
 <20110415190908.GA4093@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: madmarcos <fru574@my.utsa.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAodz-0002SC-3t
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 21:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1DOTZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 15:25:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37471
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab1DOTZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 15:25:21 -0400
Received: (qmail 12759 invoked by uid 107); 15 Apr 2011 19:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 15:26:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 15:25:19 -0400
Content-Disposition: inline
In-Reply-To: <20110415190908.GA4093@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171633>

On Fri, Apr 15, 2011 at 03:09:08PM -0400, Jeff King wrote:

> On Fri, Apr 15, 2011 at 10:46:28AM -0700, Junio C Hamano wrote:
> 
> > Shawn Pearce <spearce@spearce.org> writes:
> > 
> > > On Thu, Apr 14, 2011 at 23:22, madmarcos <fru574@my.utsa.edu> wrote:
> > >> is there a git command that can capture in a separate file the packfile that
> > >> is generated and transmitted from a "want"ed branch during the
> > >> git-upload-pack command? I need a good sample to study.
> > >
> > > No.
> > >
> > > But you can create an input file yourself, the pkt-line format is
> > > pretty simple. Pipe the input to git-upload-pack, and it will spit
> > > back the response. :-)
> > 
> > If you are running 1.7.5-rc0 or newer, GIT_TRACE_PACKET may also be of
> > help.
> 
> Sadly, no. I punted on outputting the actual pack since it is big and
> binary, and I was only interested in the ref negotiation. My eventual
> plan was that you could do:
> 
>   GIT_TRACE_PACKET=2 GIT_TRACE_PACKET_PACK=/tmp/foo.pack \
>     git clone ...

Actually, thinking on it more, this is kind of stupid. The pack that we
fetch will end up in .git/objects/pack, so it's not that interesting to
dump (though I suppose in a fetch setting, you might want to actually
peek at the thin pack before it gets resolved).

More interesting is for the sender to dump the pack they send, which
would mean instrumenting pack-objects.

Or, as Shawn suggested, poking upload-pack yourself using a conversation
you read from GIT_TRACE_PACKET. Which is probably what you meant when
you suggested it in the first place. So I'll shut up now.

-Peff
