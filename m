From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 09:19:15 -0400
Message-ID: <20070621131915.GD4487@coredump.intra.peff.net>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1MZG-0002Z6-8R
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbXFUNTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXFUNTS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:19:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbXFUNTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:19:17 -0400
Received: (qmail 28941 invoked from network); 21 Jun 2007 13:19:33 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jun 2007 13:19:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2007 09:19:15 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706211248420.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50623>

On Thu, Jun 21, 2007 at 12:52:11PM +0100, Johannes Schindelin wrote:

> When there are several candidates for a rename source, and one of them
> has an identical basename to the rename target, take that one.

That's a reasonable heuristic, but it unfortunately won't match simple
things like:

  i386_widget.c -> arch/i386/widget.c

You really don't care about "is this a good match" as much as providing
an order to potential matches. I think something like a Levenshtein
distance between the full pathnames would give good results, and would
cover almost every situation that the basename heuristic would (there
are a few exceptions, like getting "file.c" from either "file2.c" or
"foo/file.c", but that seems kind of pathological).

Sorry to post without a patch, but I don't have time right this second.
I'll add it to the end of my (ever-growing) todo list if you think it's
a good idea and don't do it yourself. :)

-Peff
