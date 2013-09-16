From: Jeff King <peff@peff.net>
Subject: Re: Git rebase dies with fatal: Unable to create
 '.../.git/index.lock': File exists.
Date: Mon, 16 Sep 2013 17:47:20 -0400
Message-ID: <20130916214720.GA6195@sigill.intra.peff.net>
References: <20130916182852.GA14513@obsidianresearch.com>
 <20130916211501.GA5477@sigill.intra.peff.net>
 <20130916212159.GA16437@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
X-From: git-owner@vger.kernel.org Mon Sep 16 23:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLgdn-0003mP-5H
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 23:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab3IPVr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 17:47:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:38810 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab3IPVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 17:47:26 -0400
Received: (qmail 22365 invoked by uid 102); 16 Sep 2013 21:47:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Sep 2013 16:47:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Sep 2013 17:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20130916212159.GA16437@obsidianresearch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234845>

On Mon, Sep 16, 2013 at 03:21:59PM -0600, Jason Gunthorpe wrote:

> > I'm not clear on which git commands are being run. If they are actually
> > mutating the index, then isn't this more than a lock contention issue?
> > In other words, "git rebase" is assuming nobody is mucking with the
> > index while it runs; if emacs is doing so, then the results could be
> > quite confusing, even if we retried the lock acquisition.
> 
> I'm not sure what commands vc-git mode in Emacs is actually running
> automatically, but I'd be surprised and alaramed if they were mutating
> command..
> 
> I agree retry on the lock is hackish, holding the lock continuously
> rather than release/reaquire during operation would be much stronger
> prevention.

If it is not mutating the index in a way that marks content to be
committed, but only "refreshing" it (i.e., updating the stat cache),
that should be OK. So the question there would be: what refresh strategy
does emacs use? Does it do so intentionally, or is it doing so
accidentally by calling a porcelain command that auto-refreshes? So
again, it comes down to figuring out exactly which commands emacs is
running.

-Peff
