From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 02:17:20 -0400
Message-ID: <20130810061720.GA30185@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V82Uj-0005V4-Oh
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab3HJGRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:17:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:53963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498Ab3HJGRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:17:23 -0400
Received: (qmail 25375 invoked by uid 102); 10 Aug 2013 06:17:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 01:17:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 02:17:20 -0400
Content-Disposition: inline
In-Reply-To: <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232065>

On Fri, Aug 09, 2013 at 04:06:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, there are basically three levels of ident:
> >
> >   1. The user told us explicitly (e.g., $EMAIL, user.email). Trust it.
> >
> >   2. We guessed and it looks reasonable (e.g., hostname is FQDN). Warn
> >      but use it.
> >
> >   3. It looks obviously bogus (e.g., we do not have a domain name).
> >      Reject it.
> >
> > We can move some cases from (2) down to (3), like ...
> 
> Judging from Thorsten's earlier response, I am afraid no amount of
> autodetection would help the users of that site.  If we were to do
> something, /etc/gitconfig as you outlined below would be the way to
> go, even though it makes me feel dirty.

It was not clear to me whether his site has /etc/mailname. If it does
not, then the new rule could be to leave "/etc/mailname" in group 2, and
put "gethostname/gethostbyname" into group 3 (right now we do so only
when the results from those functions are obviously not
fully-qualified).

But from his description, the machine may even have a split-horizon name
in /etc/mailname, and we can do nothing at all about that.

Even if it worked, though, I am not sure it would be worth such a rule.
The /etc/mailname file is not a standard, so you would effectively be
cutting off the auto-ident behavior for people on every other system. If
we are going to do that, we might as well do it uniformly.

-Peff
