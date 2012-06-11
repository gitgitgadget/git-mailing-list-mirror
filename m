From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 13:04:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch> <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 19:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se82R-0007Lo-AM
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab2FKREK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:04:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2FKREJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:04:09 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5G00G7YQ2V0G50@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jun 2012 13:04:08 -0400 (EDT)
In-reply-to: <20120611160824.GB12773@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199678>

On Mon, 11 Jun 2012, Jeff King wrote:

> As a workaround, it might be worth lowering the default pruneExpire from
> 2 weeks to 1 day or something. It is really about creating safety for
> operations in progress (e.g., you write the object, and then are _about_
> to add it to the index or update a ref when it gets pruned). I think the
> 2 weeks number was pulled out of a hat as "absurdly long for an
> operation to take", and was never revisited because nobody cared or
> complained.

Absolutely.  I think this should even be considered a "fix" to lower 
this value not a "workaround".

IIRC, the 2 weeks number was instored when there wasn't any reflog on 
HEAD and the only way to salvage lost commits was to use 'git fsck 
--lost-found'.  These days, this is used only as a safety measure 
because there is always a tiny window during which objects are dangling 
before they're finally all referenced as you say.  But someone would 
have to work hard to hit that race even if the delay was only 30 
seconds.  So realistically this could even be set to 1 hour.


Nicolas
