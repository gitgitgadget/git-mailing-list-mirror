From: Jeff King <peff@peff.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 14:13:01 -0600
Message-ID: <20110801201301.GA17111@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnyrQ-0001VW-0q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab1HAUNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:13:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43468
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab1HAUNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:13:05 -0400
Received: (qmail 23203 invoked by uid 107); 1 Aug 2011 20:13:37 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 16:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 14:13:01 -0600
Content-Disposition: inline
In-Reply-To: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178405>

On Mon, Aug 01, 2011 at 08:20:15PM +0200, martin f krafft wrote:

> Instead, I am investigating ways in which I can store additional
> information for a branch, and ideally in a way to make it
> transparent and automatic for all users of a project's repo.
> 
> Hence, if I were to store additional information in the commit
> object headers, this information would by design be correct,
> immutable, and non-redundant. I am going to reply to my own mail
> with some implementation details to feed the curious, with the hope
> to keep this debate focused.
> 
> Are there any strong reasons against my use of commit headers for
> specific, well-defined purposes in contained use-cases? E.g. are
> there tools known to only copy "known" headers, which could
> potentially break my assumptions?

This topic has come up several times in the past few years. I think some
of the relevant questions to consider about your new data are:

  1. Does git actually care about your data? E.g., would it want to use
     it for reachability analysis in git-fsck?

  2. Is it an immutable property of a commit, or can it be changed after
     the fact?

If (2) is no, then git-notes is probably the best choice.

Otherwise, if (1) is yes, then a commit header makes sense. But then, it
should also be something that git is taught about, and your commit
header should not be some topgit-specific thing, but a header showing
the generalized form.

Otherwise, the usual recommendation is to use a pseudo-header within the
body of the commit message (i.e., "Topgit-Base: ..." at the end of the
commit message). The upside is that it's easy to create, manipulate, and
examine using existing git tools. The downside is that it is something
that the user is more likely to see in "git log" or when editing a
rebased commit message.

Just about every discussion on this topic ends with the pseudo-header
recommendation. The only exceptions AFAIK are "encoding" (which git
itself needs to care about), and "generation" (which, as you noted,
raises other questions).

-Peff
