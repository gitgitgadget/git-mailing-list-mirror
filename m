From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 19:09:34 -0400
Message-ID: <20091014230934.GC29664@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 01:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyD4n-0007Z5-4n
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 01:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762107AbZJNXKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 19:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760154AbZJNXKM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 19:10:12 -0400
Received: from peff.net ([208.65.91.99]:43560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304AbZJNXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 19:10:11 -0400
Received: (qmail 324 invoked by uid 107); 14 Oct 2009 23:13:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 19:13:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 19:09:34 -0400
Content-Disposition: inline
In-Reply-To: <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130349>

On Wed, Oct 14, 2009 at 03:34:05PM -0700, Junio C Hamano wrote:

> > Agreed.  Presumably some expert mode config would imply -f 
> > automatically.
> 
> No, I do not want an expert mode.  I can probably live with "per session"
> setting, that makes me decide to set or not set it when I detach, though.

That makes the most sense to me. If "git checkout" could write metadata
into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
could record an "ok to commit" bit. And could also be used to change it
after the fact. E.g.:

  $ git checkout --detach=commit origin/master
  $ git commit ;# should be ok

  $ git checkout --detach=examine origin/master
  $ git commit ;# complain
  $ git checkout --detach=commit HEAD
  $ git commit ;# ok

I guess something like "rebase" should detach with "ok to commit", since
it is planning on attaching the commits later. I'm not sure about "git
bisect". I guess probably it should be "not ok to commit" to be on the
safe side, and then somebody can "git checkout --detach=commit" if they
want to.

-Peff
