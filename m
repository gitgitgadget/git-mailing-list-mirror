From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Thu, 18 Nov 2010 12:58:11 -0500
Message-ID: <20101118175810.GB26505@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:58:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8kY-0004La-3m
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab0KRR6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:58:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab0KRR6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:58:15 -0500
Received: (qmail 17496 invoked by uid 111); 18 Nov 2010 17:58:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 17:58:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 12:58:11 -0500
Content-Disposition: inline
In-Reply-To: <20101118175007.GA26505@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161697>

On Thu, Nov 18, 2010 at 12:50:08PM -0500, Jeff King wrote:

> >     [remote "backup"]
> > 	url = /mnt/server/path/to/repo.git
> > 	fetch = +refs/*:refs/*
> > 	mirror = true
> 
> I think we don't want to be doing the opportunistic update in this case.
> But what is the correct rule for deciding not to do it? I can think of a
> few possibilities:

Thinking on this more, perhaps it really is the fetch refspec there that
is the problem (as you initially suggested).

It seems to me there are really two kinds of mirrors: one where you will
fetch everything from the remote, and one where you will push everything
to the remote.

You have the latter kind, and the fetch refspec is just causing
problems. Removing it would solve not only this issue, but also the fact
that you would never want to run "git fetch backup", even accidentally,
in your repo, as it would overwrite your local work.

So I think we need --mirror=push, or something similar.

-Peff
