From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How-to combine several separate git repos?
Date: Mon, 10 Dec 2007 01:51:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712100137250.5349@iabervon.org>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home>
 <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
 <475C7DD5.9040209@saville.com> <Pine.LNX.4.64.0712091942520.5349@iabervon.org>
 <475CA476.6070507@saville.com> <Pine.LNX.4.64.0712092130560.5349@iabervon.org>
 <475CDE73.9010505@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1cUi-0005ov-54
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXLJGvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXLJGvj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 01:51:39 -0500
Received: from iabervon.org ([66.92.72.58]:39085 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbXLJGvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 01:51:38 -0500
Received: (qmail 21574 invoked by uid 1000); 10 Dec 2007 06:51:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2007 06:51:32 -0000
In-Reply-To: <475CDE73.9010505@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67686>

On Sun, 9 Dec 2007, Wink Saville wrote:

> Daniel,
> 
> Worked like a charm, someday maybe I'll understand why it works:)

I should probably explain (now that I know it's actually relevant).

> > # Add a project "foo"
> > $ git fetch ../foo refs/heads/master:refs/heads/foo

Get the history and data, as an extra branch, so we can deal with it 
easily.

> > $ git merge --no-commit foo

We want to generate a merge commit, but we want to mess with it, so we use 
merge to set it up, but --no-commit to not actually commit it. (The commit 
below will generate a merge commit if we don't cancel stuff entirely.)

> > $ git read-tree --reset -u HEAD

Replace the index (--reset), updating the working directory (-u), with 
HEAD (the commit on the local side before the merge we're in the middle 
of).

> > $ git read-tree -u --prefix=foo/ foo

Read into the index, updating the working directory, "foo" (the branch we 
fetched above), but with the prefix "foo/" so everything is stuffed into a 
subdirectory.

> > $ git commit

And commit the result, which has the tree as constructed above (everything 
from the local parent, and everything from the branch in a subdirectory), 
and has the parents as for the merge we started: first parent is the local 
line without the additional branch, and the second parent is the added 
repository.

And git doesn't care about global structure, so the fact that this commit 
is obviously just what you'd ideally like, while the history as a whole is 
a bit odd (like, it doesn't have a unique start, and development didn't 
start in subdirectories, and...) doesn't matter.

	-Daniel
*This .sig left intentionally blank*
