From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use pathexpand to preparse the relative pathnames in
	blob references
Date: Wed, 19 Dec 2007 09:37:04 -0500
Message-ID: <20071219143704.GA13942@coredump.intra.peff.net>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home> <20071218204947.GE2875@steel.home> <20071218205253.GF2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J503A-0000TU-8R
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbXLSOhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbXLSOhI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:37:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3772 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbXLSOhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 09:37:07 -0500
Received: (qmail 31641 invoked by uid 111); 19 Dec 2007 14:37:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Dec 2007 09:37:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2007 09:37:04 -0500
Content-Disposition: inline
In-Reply-To: <20071218205253.GF2875@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68911>

On Tue, Dec 18, 2007 at 09:52:53PM +0100, Alex Riesen wrote:

> This, OTOH, is a bit intrusive and changes the current behaviour a bit
> too far. git-show cannot use the absolute pathnames in blob locators
> at all now, which I consider bad. An obvious way to use rev:/path is
> blocked by Johannes' get_sha1_oneline. It would have worked, though.

IMO, this is backwards. The default should be absolute naming (after
all, you have already rooted it at a tree by saying HEAD:), and you
should treat '.' as a short-hand for "my current prefix". IOW, this
works as before:

  cd t && git show HEAD:t/test-lib.sh

but this would now work:

  cd t && git show HEAD:./test-lib.sh

and of course supporting '..' could be added, as well.

This works under the assumption that you don't have tree entries of '.'
or '..'; I don't think the data structure enforces any such assumption,
but I doubt you could easily create such a tree without hacking the git
tools (and you would have to be insane to do so anyway).

-Peff

PS I didn't just think of this...I'm pretty sure this discussion came up
sometime in the past year and somebody more clever than I thought of it.
