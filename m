From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 00:22:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706132224580.5848@iabervon.org>
References: <18031.64456.948230.375333@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 06:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hygqu-0005oL-3o
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 06:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXFNEWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 00:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbXFNEWK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 00:22:10 -0400
Received: from iabervon.org ([66.92.72.58]:1644 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbXFNEWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 00:22:08 -0400
Received: (qmail 6252 invoked by uid 1000); 14 Jun 2007 04:22:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Jun 2007 04:22:05 -0000
In-Reply-To: <18031.64456.948230.375333@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50163>

On Wed, 13 Jun 2007, Bill Lear wrote:

> We have some CVS users who complain that they cannot do a pull
> into a dirty working tree, as they could under CVS.  Here is
> their scenario: they make a few changes to their code and want
> to test it out; someone else pushes changes to the central repo
> that they then want to add to their working tree to test also;
> they then want to pull in these changes and test everything, as
> if they had done 'mv stuff stuff-; git pull; mv stuff- stuff'.
> 
> They would like an option (perhaps a config option) to do a "dirty
> pull".
> 
> The git-merge documentation states:
> 
>   You may have local modifications in the working tree files. In other
>   words, git-diff is allowed to report changes. However, the merge uses
>   your working tree as the working area, and in order to prevent the
>   merge operation from losing such changes, it makes sure that they do
>   not interfere with the merge. Those complex tables in read-tree
>   documentation define what it means for a path to "interfere with the
>   merge". And if your local modifications interfere with the merge,
>   again, it stops before touching anything.
> 
> But my colleagues are still wondering: why can't git just do it as
> CVS does?
> 
> I know there are workarounds: I myself documented a set of commands
> to "put things on a shelf", but they still are whining.
> 
> I need a convincing argument: not a technical one, but one that is
> practical (e.g. where CVS would do harm that git is preventing).

Where CVS would do harm that git is preventing is if they did something 
brilliant, forgot how they did it, got other people's changes from the 
central repository, and got complicated merge conflicts, and lost their 
change trying to resolve them. (Or, for that matter, if the merge 
algorithm screwed up the file without reporting conflicts.)

What git refuses to do is overwrite a file you've changed when you haven't 
committed it, because something could go wrong, and you'd lose the work.

It would be possible to tell git that you're okay with it accidentally 
losing your work, but people tend not to like this idea quite so much when 
it's phrased like that.

The git sequence for this situation is:

$ git commit -a
$ git fetch
$ git rebase origin

The operation they want to perform is "rebase", which puts the changes 
they made on top of other people's changes instead of where they were 
written. It also wants the changes committed, so that it doesn't have to 
worry about losing your work, but afterward you can use "git commit 
--amend" to add fixes and the rest of your changes, because your work is 
the top commit and hasn't been pushed out. Alternatively, "git reset 
HEAD^" at the end of the sequence will turn the commit into uncommitted 
changes.

	-Daniel
*This .sig left intentionally blank*
