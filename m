From: Jeff King <peff@peff.net>
Subject: Re: How to merge in different order?
Date: Fri, 3 Apr 2009 12:31:50 -0400
Message-ID: <20090403163150.GD8155@coredump.intra.peff.net>
References: <20090403161208.GC28619@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 18:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpmKq-0005R0-Ez
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765466AbZDCQcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764152AbZDCQcH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 12:32:07 -0400
Received: from peff.net ([208.65.91.99]:51953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZDCQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 12:32:06 -0400
Received: (qmail 425 invoked by uid 107); 3 Apr 2009 16:32:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 12:32:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 12:31:50 -0400
Content-Disposition: inline
In-Reply-To: <20090403161208.GC28619@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115546>

On Fri, Apr 03, 2009 at 06:12:08PM +0200, Josef Wolf wrote:

> Given a branch that looks like
> 
>   A1  A2  A3  A4  A5
> 
> I would like to merge into another branch in the order
> 
>   A1  A3  A4  A2  A5
> 
> When I merge A3, then A2 is merged also.  git-merge don't seem
> to have an option to omit slurping older commits?

Right. Remember that git represents history as a directed graph, so a
merge is really just another commit saying "I include all history
leading up to these two commits". There is no way to say "I include the
history leading up to these commits, minus some other commits".

If you just want to throw away A2, you can "git revert" it, then merge.

But what you probably want to do is rewrite the history of your branch
to re-order the commits. You can do this with "git rebase -i". Like any
history rewriting, this can cause difficulties for people who you have
already shared the branch with (because it will replace the commits that
they already have with 5 _new_ commits that just happen to do more or
less the same thing).

If you have already shared the branch, you may just want to cherry-pick
the changes you want (using "git cherry-pick") onto your other branch.

-Peff
