From: Jeff King <peff@peff.net>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 16:04:42 -0400
Message-ID: <20080907200441.GA26705@coredump.intra.peff.net>
References: <20080907103415.GA3139@cuci.nl> <20080907172807.GA25233@coredump.intra.peff.net> <20080907195626.GA8765@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:05:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQW4-0007aI-Dv
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbYIGUEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627AbYIGUEo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:04:44 -0400
Received: from peff.net ([208.65.91.99]:1872 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603AbYIGUEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:04:43 -0400
Received: (qmail 14242 invoked by uid 111); 7 Sep 2008 20:04:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Sep 2008 16:04:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Sep 2008 16:04:42 -0400
Content-Disposition: inline
In-Reply-To: <20080907195626.GA8765@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95168>

On Sun, Sep 07, 2008 at 09:56:26PM +0200, Stephen R. van den Berg wrote:

> >Parents mean something different than just a link. If A is a parent of
> >B, then that implies that at point B, we considered all of the history
> >leading up to B (including A), and arrived at a certain tree state.
> 
> That implication is not a technical one, but merely a convention in the
> mind of the git-user.  Relevant, of course, but maybe we can accomodate
> both uses.

I'm not sure I agree. I believe that property is part of the definition
of the commit DAG as originally conceived (but somebody like Linus could
say more). Obviously there is no formal definition, but I already
pointed out one thing that will break in that instance. I don't know if
there are others.

> What if the merge-base determination code is modified to behave as
> if --first-parent is specified while searching for the merge-base?
> In that case it *will* find A as the merge-base, even in the presence of
> "sideportlinks".

But then it will fail to find legitimate merge bases. So yes, you _can_
come up with a merge algorithm that handles this situation. But is it
then up to the user to say "Oh, this parent link means something else.
Use this other algorithm"? In that case, it really seems we are abusing
the "parent" link and it would be more appropriate to have some _other_
type of link.

Though I think if you look through the archives, people have argued
against having any git-level link to cherry-picked commits. The history
leading up to that cherry-pick is not necessarily of interest (though I
think you are proposing that it be optional to create such a link via
-x).

> Does that resolve all technical issues?

I really don't know. I think you are proposing changing a core
assumption of the data structure, so I wouldn't be too surprised if
there is other code that relies on it.

You can use the script I posted in my last email as a basis for a
cherry-pick that does what you want (cherry-pick -n, write-tree,
commit-tree, update-ref). You might try a few experiments with that.

-Peff
