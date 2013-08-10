From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 02:47:17 -0400
Message-ID: <20130810064717.GB30185@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V82xi-0001UZ-5H
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347Ab3HJGrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:47:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:54161 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128Ab3HJGrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:47:20 -0400
Received: (qmail 26859 invoked by uid 102); 10 Aug 2013 06:47:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 01:47:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 02:47:17 -0400
Content-Disposition: inline
In-Reply-To: <20130809231928.GY14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232068>

On Fri, Aug 09, 2013 at 04:19:28PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
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
> > We can move some cases from (2) down to (3), like when we use
> > gethostname rather than /etc/mailname.  But we risk breaking people's
> > existing setups. I don't think we know how many people rely on the
> > implicit hostname selection and would be affected. I don't know if there
> > is a good way to find out short of changing it and seeing who screams.
> 
> Yes.  The result from a reverse DNS lookup is almost never the right
> mailname.

Just to nitpick, the name we guess is not necessarily from DNS (and if
the FQDN comes from DNS, it is not a reverse lookup, but rather
following the search rules in resolv.conf, or even /etc/hosts). But I
think the point is the same: we somehow arrive at the hostname through
some accurate means, but that hostname does not reflect the user's
actual email address.

>  * Small installations tend to use a smarthost.
>  * Large installations tend to use more than one machine, and only
>    one machine's name gets the MX record.

I'm not sure the second one is true. Many large installations will MX
all of their workstations names to a smarthost. So mail to
user@randommachine.example.com _is_ deliverable. It has (thankfully)
been a long time since I have been involved in large network IT, but
that was standard practice at one time.

But I think MX records and deliverability is beside the point. Even in a
case where we come up with a valid, deliverable address, is that what
the user wants to have in their commit history for all time?

> So except for cases where someone doesn't actually care about the
> recorded author and just has a script making commits (such users
> already suffer from the ".(none)" heuristic), I don't think this would
> hurt anyone.

I think the other case is "people who actually think the per-machine
information is useful". I recall Linus arguing for this early on, but he
seems to have relented. I am not sure whether anyone else in the world
has that view (or ever did).

There are certainly people in the "I don't care, just make it work"
camp, judging from the repositories I sometimes see on GitHub. Whether
we would be harming them (because their workflow breaks) or helping them
(because they had no idea they had these crappy idents in their history
and we would be letting them know) is not clear to me, though.

> > We can put a deprecation warning in the release notes, but people tend
> > to ignore those.
> 
> Not so much a deprecation warning as an "Here is one of the more
> noticeable changes in this release" announcement.

I meant a warning to give people a chance to comment before the change
comes. Following this mailing list is another source for people to find out
about it, but I suspect most casual users do not read the list. Perhaps
it would be worth taking a straw poll over G+ or another more casual
medium?

-Peff
