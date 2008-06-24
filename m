From: Jeff King <peff@peff.net>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 04:16:02 -0400
Message-ID: <20080624081601.GA2692@sigill.intra.peff.net>
References: <20080624072455.GF19224@sigill.intra.peff.net> <willow-jeske-01l5kbGzFEDjCX3J>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3i5-0003pR-Iy
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYFXIQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYFXIQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:16:09 -0400
Received: from peff.net ([208.65.91.99]:1645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbYFXIQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:16:07 -0400
Received: (qmail 1024 invoked by uid 111); 24 Jun 2008 08:16:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 04:16:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 04:16:02 -0400
Content-Disposition: inline
In-Reply-To: <willow-jeske-01l5kbGzFEDjCX3J>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86012>

On Tue, Jun 24, 2008 at 07:31:31AM -0000, David Jeske wrote:

> ..are you saying that if I reset --hard, or delete a branch ref, or do a
> rebase, and then do a GC beyond the GC timeout, that git will NEVER throw away
> any of those DAGs? (the actual source diffs committed)

No. Git keeps the reachable DAG. So if the DAG is part of development
that is merged into one of your long running branches, or if you keep
around the branch that points to it, it will never go away.

> My (possibly flawed) understanding was that it drops any DAG sections
> that are not referenced by valid refs which are older than the GC
> timeout.

Yes. So the way to "forget" about some history is to stop referencing
it. And then, after a grace period, it will be removed.

> Are you saying this GC process will never collect source diffs in the
> DAG?

No, but it will only remove unreferenced things. And things only become
unreferenced through explicit user action. So you don't have to worry
about git GCing your work unexpectedly. You do have to worry about git
GCing things you have explicitly told it to delete.

-Peff
