From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 18:23:01 -0400
Message-ID: <20130411222301.GA11283@sigill.intra.peff.net>
References: <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 00:23:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQPte-0001Xn-4n
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 00:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab3DKWXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 18:23:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41023 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab3DKWXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 18:23:04 -0400
Received: (qmail 20456 invoked by uid 107); 11 Apr 2013 22:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 18:24:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 18:23:01 -0400
Content-Disposition: inline
In-Reply-To: <7vip3shfpd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220937>

On Thu, Apr 11, 2013 at 03:20:46PM -0700, Junio C Hamano wrote:

> "W. Trevor King" <wking@tremily.us> writes:
> 
> > As one of the less experienced folks tripped up by this issue, I think
> > that setting HOME explicitly before invoking the daemon is simple
> > enough (which is why I just fixed my invocation and didn't post to the
> > list).
> 
> Sounds like we need a documentation update somewhere.

Yeah, I'd be happy to drop my patch if somebody wants to write a
documentation update instead.

> > The difficulty was figuring out why the daemon was dying in
> > the first place (which involved bisection for me as well).  Maybe
> > there could be an additional note about HOME to flesh out:
> >
> >   fatal: unable to access '/root/.config/git/config': Permission denied
> >
> > when there's an EACCES error for the per-user config?
> 
> Doesn't access_or_die() say
> 
>     die_errno(_("unable to access '%s'"), path);
> 
> already?  I am puzzled...

I think the point is that it could add

  ...and I was looking in /root, because that is where your HOME points.
  Shouldn't you be able to read your own HOME directory?

which should make it painfully obvious to the user what is going on.

-Peff
