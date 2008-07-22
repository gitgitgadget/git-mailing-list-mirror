From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 02:46:04 -0400
Message-ID: <20080722064603.GA25221@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBeM-00062S-Vh
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYGVGqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYGVGqG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:46:06 -0400
Received: from peff.net ([208.65.91.99]:1185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbYGVGqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:46:05 -0400
Received: (qmail 3080 invoked by uid 111); 22 Jul 2008 06:46:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 02:46:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 02:46:04 -0400
Content-Disposition: inline
In-Reply-To: <20080722061807.GA6714@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89447>

On Tue, Jul 22, 2008 at 08:18:07AM +0200, Mike Hommey wrote:

> > We already do that (see pager.c:53). The original poster still had a
> > problem, but I don't know if it was for actual usage or simply a toy
> > 
> >   $ git status
> >   $ echo $?
> >   $ echo "why don't exit codes work in status?" | mail git@vger
> > 
> > question.
> 
> As you said in another branch of the thread, this part would be solved by
> having parent/child being reverted.
> 
> Now, for the case where diff-files can have a pager if the user shoots
> himself in the foot, if the output is not a terminal and pager.c already
> does the right thing, I don't see where diff-files having a pager will
> be a problem.

Ah, OK. I misunderstood your original post. Yes, there are two ways
paging can screw you: munging the data in a pipeline and munging the
exit code. We already deal with former, so it is really just the latter
that is posing a problem in this thread.

I am tempted by the "order switching" I mentioned, but that would entail
the git process waiting to clean the pager, during which time it may be
consuming memory. But maybe that isn't worth worrying about.

-Peff
