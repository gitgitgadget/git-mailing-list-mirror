From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 03:14:07 -0400
Message-ID: <20130810071407.GA32038@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
 <20130810061720.GA30185@sigill.intra.peff.net>
 <20130810064056.GA3165@elie.Belkin>
 <20130810065252.GC30185@sigill.intra.peff.net>
 <20130810070300.GB3165@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Thorsten Glaser <tg@mirbsd.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83NP-0002qB-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab3HJHOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:14:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:54350 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757511Ab3HJHOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:14:10 -0400
Received: (qmail 28292 invoked by uid 102); 10 Aug 2013 07:14:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 02:14:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 03:14:07 -0400
Content-Disposition: inline
In-Reply-To: <20130810070300.GB3165@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232075>

On Sat, Aug 10, 2013 at 12:03:00AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Sorry to be unclear. I meant that treating /etc/mailname and gethostname
> > differently might be justified on Debian under the logic "if you have
> > /etc/mailname, that is a trustworthy address, and if you do not, then we
> > cannot guess at a trustworthy address (because putting it in
> > /etc/mailname is the accepted way to do so on Debian)".
> >
> > But such logic would not extend to other operating systems, where
> > /etc/mailname does not have such a status.
> 
> I thought that on other operating systems people typically don't have
> an /etc/mailname.  How does trusting the file when present hurt?

I guess I am not explaining myself well. Trusting the file when present
does not hurt at all. But the logic above is making assumptions about
the state when the file is _not_ present (i.e., the "if you do not..."
clause above). On Debian, we might assume that if /etc/mailname is not
present that this is a clue that the machine cannot produce a useful
address.  But on other operating systems, that is not a useful clue (it
is simply that /etc/mailname is not used on that system). Dying on such
a system when /etc/mailname is not present would be a regression.

Does that make more sense?

> I *am* a bit worried about what people might put in /etc/mailname on
> Debian systems when there is no appropriate host to put there (as on
> Thorsten's machine).

Yeah. Or even in a split-horizon setup where the mail is deliverable but
does not reflect the public identity of the user. I think we are getting
down to the question I mentioned elsewhere: it is not about whether we
have a deliverable address or not, but what users want to cement in
history for all time as their identity.

So thinking too much about /etc/mailname versus gethostname is probably
not useful. Either it is worth breaking the few (if any) users who
depend on the auto ident in favor of fewer accidental implicit idents
making their way into the wild, or it is not.

-Peff
