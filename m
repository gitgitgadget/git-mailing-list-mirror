From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: commiting while the current version is in conflict
Date: Thu, 16 Oct 2008 16:00:35 -0700
Message-ID: <20081016230035.GC9877@spearce.org>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com> <20081016224808.GO536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:01:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqbqr-0000Cz-Jm
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbYJPXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757097AbYJPXAh
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:00:37 -0400
Received: from george.spearce.org ([209.20.77.23]:42595 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928AbYJPXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:00:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BAAF73835F; Thu, 16 Oct 2008 23:00:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081016224808.GO536@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98432>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Oct 17, 2008 at 12:10:55AM +0200, Richard Hartmann <richih.mailinglist@gmail.com> wrote:
> > all changes were submitted. Of course, I now have a
> > file with the conflict markers inlined in my repository. Not
> > a good thing, imo. Is there a way to make git block all
> > conflicting versions?
> 
> Write a pre-commit hook that checks for conflict markers?

The sample pre-commit hook checks for these.  Its really hande to
have enabled.
 
> > Also, I would be interested in the design decissions
> > behind the current behaviour. Any pointers?
> 
> Not sure, but in general blocking conflict markers by default would be a
> bad idea IMHO, several markup language (asciidoc, for example) makes use
> of the >>>, === and such character sequences.

Not only that, but "git commit -a" did exactly what you asked it to do:

	git add -u
	git commit

and git add -u is basically a faster way to do something like this pseudo-shell:

	for path in $(git status | grep modified:)
	do
		git add $path
	done

and merge conflicts are "resolved" by you running "git add $path"
after you have finished fixing that path.

Moral of the story is, don't use "git commit -a".  Use only "git commit"
and stage files individually.  That way when you are in a merge conflict
you won't be in the habit of writing "git commit -a" and staging everything
from the working tree implicitly.

-- 
Shawn.
