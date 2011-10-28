From: Jeff King <peff@peff.net>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Fri, 28 Oct 2011 14:37:04 -0700
Message-ID: <20111028213703.GA1454@sigill.intra.peff.net>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
 <20111028203256.GA15082@sigill.intra.peff.net>
 <20111028212122.GB3966@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 23:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJu73-0001xP-Rm
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 23:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab1J1VhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 17:37:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57317
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755736Ab1J1VhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 17:37:07 -0400
Received: (qmail 16618 invoked by uid 107); 28 Oct 2011 21:42:54 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Oct 2011 17:42:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Oct 2011 14:37:04 -0700
Content-Disposition: inline
In-Reply-To: <20111028212122.GB3966@foghorn.codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184435>

On Fri, Oct 28, 2011 at 04:21:22PM -0500, Andrew Eikum wrote:

> Since we have a program called "mailsplit," wouldn't it make more
> sense to have imap-send use its implementation to split mail instead
> of sharing just the From line detection?

Potentially, yeah. I was thinking of just pulling over the from line
detection (which is the real black magic bit), but it looks like
imap-send's mbox handling could use some general attention (maybe it
would be possible to not read the entire mbox into memory, for example).

> I was hoping it'd be a quick matter of pulling mailsplit's
> implementation out of builtin and into the top level, but I see it's
> got some global variables that are tangled enough that I actually have
> to understand the code before I can pull it apart :)
>
> If no one beats me to it, I'll work on this next week. It's late on
> Friday and I'm moving house this weekend.

No rush. Let us know if you have questions.

> Quick question, since I'm not intimately familiar with Git's code: I
> was thinking of creating a new compilation unit at the top level,
> mailutils.{c,h}, and referencing it from both imap-send.c and
> builtin/splitmail.c. Does that seem like the right approach? Is there
> an existing compilation unit I should be placing splitmail's guts into
> instead?

Yes, I think a new file makes sense here. Make sure to update LIB_H and
LIB_OBJS in the Makefile.

-Peff
