From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Wed, 22 Feb 2012 02:09:57 -0500
Message-ID: <20120222070957.GB17015@sigill.intra.peff.net>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
 <7vobstjfcs.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
 <7vehtoiqae.fsf@alter.siamese.dyndns.org>
 <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com>
 <7vsji3eoqs.fsf@alter.siamese.dyndns.org>
 <1AD297DA-6E85-4808-94F8-907BA890E7F6@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jnareb@gmail.com, philipoakley@iee.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 08:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S06LH-0000eB-PO
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 08:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab2BVHJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 02:09:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45758
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2BVHJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 02:09:59 -0500
Received: (qmail 25812 invoked by uid 107); 22 Feb 2012 07:09:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 02:09:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 02:09:57 -0500
Content-Disposition: inline
In-Reply-To: <1AD297DA-6E85-4808-94F8-907BA890E7F6@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191233>

On Tue, Feb 21, 2012 at 06:59:38PM -0500, Dave Zarzycki wrote:

> > I think that question should be "warn before pushing out a commit that the
> > user may later regret to have pushed out" ;-)
> 
> Why limit this proposal to just the commits that are reachable from
> upstream? What if somebody pulls from your repo?
> 
> In other words, wouldn't it be better to have a git track "unshared"
> commits and only let those be rewritten? The theory being that if the
> given commits haven't been pushed or pulled anywhere, then they are
> safe to rewrite.

You don't necessarily know who has read from you. Depending on your
setup, the user running git code may not have write access to the
repository (e.g., Alice runs "git pull ~bob/project.git"). Where would
Alice write the list of commits she pulled so that when Bob later runs
git, he knows that she has pulled them?

There is also the issue of "dumb" transports in which no git code is
running on the remote repo at all (e.g., Alice fetches from Bob via dumb
http; Bob's server doesn't even have git at all).

There may be clever or complex ideas to tackle those problems, but I
suspect that handling push would cover most practical cases (e.g., in
the dumb http case, Bob's commits probably ended up on the server via
push). So perhaps it is a good place to start.

-Peff
