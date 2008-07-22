From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 03:10:09 -0400
Message-ID: <20080722071009.GA3610@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC1g-0003EC-5b
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYGVHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYGVHKM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:10:12 -0400
Received: from peff.net ([208.65.91.99]:3482 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbYGVHKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:10:11 -0400
Received: (qmail 3192 invoked by uid 111); 22 Jul 2008 07:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:10:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:10:09 -0400
Content-Disposition: inline
In-Reply-To: <20080722064603.GA25221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89450>

On Tue, Jul 22, 2008 at 02:46:04AM -0400, Jeff King wrote:

> I am tempted by the "order switching" I mentioned, but that would entail
> the git process waiting to clean the pager, during which time it may be
> consuming memory. But maybe that isn't worth worrying about.

It feels very wrong proposing this during release freeze, but here is
the "pager is child of git" implementation.

Patch 1/1 adds a bit of necessary infrastructure to run-command, and
patch 2/2 does the deed. The nice thing is that it unifies the Windows
and Unix implementations of setup_pager, so we get a nice line
reduction.

 pager.c       |   49 ++++++++-----------------------------------------
 run-command.c |    2 ++
 run-command.h |    1 +
 3 files changed, 11 insertions(+), 41 deletions(-)
