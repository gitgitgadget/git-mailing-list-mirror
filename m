From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 12:44:39 -0400
Message-ID: <20120605164439.GA2694@sigill.intra.peff.net>
References: <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	ecryptfs@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwsA-00074b-UI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab2FEQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:44:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43951
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377Ab2FEQol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:44:41 -0400
Received: (qmail 21518 invoked by uid 107); 5 Jun 2012 16:44:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 12:44:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 12:44:39 -0400
Content-Disposition: inline
In-Reply-To: <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199261>

On Tue, Jun 05, 2012 at 09:31:54AM -0700, Junio C Hamano wrote:

> >>   setfacl -m m:rwx .
> >>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
> >>   umask 077
> >>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
> >>   getfacl a b
> [...]
> >
> > Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
> > clear that if a default ACL is present, it should be used, and umask
> > consulted only if it is not (so the umask should not be making a
> > difference in this case).
> >
> > The reproduction recipe above shows the minimum required to trigger it;
> > adding a more realistic default ACL (with actual entries for users) does
> > not seem to make a difference.
> 
> Thanks; so combining the above with your earlier patch to 1304 we
> would have a good detection for SETFACL prerequisite?

Yes, I think we can detect it reliably. I'd like to hear back from
ecryptfs folks before making a final patch, though. It may be that there
is some subtle reason for their behavior, and I want to make sure before
we write it off as just buggy.

-Peff
