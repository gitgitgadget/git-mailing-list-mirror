From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Mon, 11 Jun 2007 11:54:25 -0400
Message-ID: <20070611155425.GA9316@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133956.GC7008@coredump.intra.peff.net> <20070611150122.GA11020@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxmDz-00054A-B7
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbXFKPya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 11:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbXFKPya
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 11:54:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3779 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156AbXFKPy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 11:54:28 -0400
Received: (qmail 3924 invoked from network); 11 Jun 2007 15:54:39 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 15:54:39 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 11:54:25 -0400
Content-Disposition: inline
In-Reply-To: <20070611150122.GA11020@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49860>

On Mon, Jun 11, 2007 at 05:01:23PM +0200, Jonas Fonseca wrote:

> Thanks for looking into this and making these patches. :)

No problem. I had run it across it before and it was on my "look into
this" list...thank you for providing a test case. :)

> I think you could even get rid of has_ignored with something like this.

Nope, I had originally wanted to do that, but the dir_struct.ignored
list contains _all_ ignored items, not just those that were originally
in the pathspec. The prune_ignored call sets uninteresting ones to
NULL.  That function could compact the list and re-set ignored_nr, but
it doesn't currently do so.

An even more elegant solution would be for read_directory to mark
whether an ignored file comes from a pathspec, or was found through
recursion. That would be more efficient, and it would remove the
prune_ignored thing, which is IMHO a little hack-ish.

I don't have time to work on it now, but I might look at it more tonight
or tomorrow (but please, if you are interested, take a crack at it).

-Peff
