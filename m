From: Jeff King <peff@peff.net>
Subject: Re: Git log follow question
Date: Fri, 14 May 2010 00:37:04 -0400
Message-ID: <20100514043704.GC6075@coredump.intra.peff.net>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Albert Krawczyk <albert@burgmann.anu.edu.au>
X-From: git-owner@vger.kernel.org Fri May 14 06:37:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmeG-0001s4-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0ENEhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:37:12 -0400
Received: from peff.net ([208.65.91.99]:34393 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0ENEhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:37:08 -0400
Received: (qmail 28407 invoked by uid 107); 14 May 2010 04:37:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 00:37:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 00:37:04 -0400
Content-Disposition: inline
In-Reply-To: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147044>

On Fri, May 14, 2010 at 10:57:34AM +1000, Albert Krawczyk wrote:

> I'm having an issue understanding the way git log --follow works with git
> log --parents
>
> When I run
> git log --parents --pretty=format:Commit:%H%nParent:%P%n%n alloc.c
> I get:
> Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
> Parent:100c5f3b0b27ec6617de1a785c4ff481e92636c1
>
> [...]
>
> When I try to run git log --parents --follow I get this:
> git log --parents --follow --pretty=format:Commit:%H%nParent:%P%n%n alloc.c
>
> Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
> Parent:75b44066f3ed7cde238cdea1f0bf9e2f1744c820

Hmm. The actual parent is 75b44066. You get 100c5f in the first case
because basic revision path-limiting simplifies the history graph to
remove uninteresting commits (and rewrites the parents).

So the answer isn't _wrong_ exactly, but it is less useful. Seeing the
simplified graph is generally what we want. This is a limitation of the
way --follow is implemented. It turns off history pruning because our
list of what to prune will be changing over time.

Probably we would have to special-case the FOLLOW_RENAMES code to
rewrite the parent list before display.

I'm cc'ing Linus, who has more of a clue in both of those areas than I
do.

-Peff
