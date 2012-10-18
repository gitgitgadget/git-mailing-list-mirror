From: Jeff King <peff@peff.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Thu, 18 Oct 2012 02:08:47 -0400
Message-ID: <20121018060847.GB6308@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net>
 <1013956402.20121017125847@gmail.com>
 <20121017220912.GA21742@sigill.intra.peff.net>
 <507F9437.2070501@viscovery.net>
 <20121018053656.GA6308@sigill.intra.peff.net>
 <7vk3uomi0c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOjHw-000075-OE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 08:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab2JRGIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 02:08:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34820 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2JRGIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 02:08:49 -0400
Received: (qmail 2075 invoked by uid 107); 18 Oct 2012 06:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 02:09:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 02:08:47 -0400
Content-Disposition: inline
In-Reply-To: <7vk3uomi0c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207969>

On Wed, Oct 17, 2012 at 11:06:11PM -0700, Junio C Hamano wrote:

> >> -	eval "$(set_ident AUTHOR <../commit)" ||
> >> +	eval "$(set_ident AUTHOR author <../commit)" ||
> >
> > I cringe a little at losing DRY-ness to avoid processes.
> 
> Well, the header field token "author" and the middle word of the
> variable GIT_AUTHOR_NAME _happen_ to be the same modulo case, but
> they did not have to be, so you could argue the updated set_ident
> implementation is more generally useful (you could even argue that
> we should spell the first parameter out as "GIT_AUTHOR_NAME" and
> "GIT_AUTHOR_EMAIL", two separate parameters).

True, though that is even more work for the caller (and *_DATE, too). We
could make it "GIT_AUTHOR", but I don't think there is much point in
being that level of half-way general. The caller can always pick it out
of the variables if they really want to do something tricky.

> > Speaking of repetition, this seems like almost the exact same parsing
> > that happens in git-sh-setup's get_author_ident_from_commit. Maybe it's
> > worth merging them. I suspect you could also avoid another process
> > by parsing out both author and committer information in the same sed
> > invocation.
> 
> Yes, yes and yes.

Working on it now. git-sh-setup works, but chasing an annoying bug in
filter-branch. I'm sure it's something silly and stupid.

-Peff
