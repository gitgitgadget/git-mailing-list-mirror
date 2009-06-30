From: Jeff King <peff@peff.net>
Subject: Re: Parallell Development / Switching to GIT
Date: Tue, 30 Jun 2009 01:32:54 -0400
Message-ID: <20090630053252.GA29643@sigio.peff.net>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Tue Jun 30 07:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLVwu-0006LB-7t
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 07:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbZF3FbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 01:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbZF3FbE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 01:31:04 -0400
Received: from peff.net ([208.65.91.99]:57120 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbZF3FbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 01:31:03 -0400
Received: (qmail 29653 invoked by uid 1000); 30 Jun 2009 05:32:54 -0000
Content-Disposition: inline
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122487>

On Sun, Jun 28, 2009 at 10:08:45PM +0200, Patrick Neuner - Futureweb.at wrote:

> I read about cherry-picking, but I am not quite sure if that's really
> what we need.  Lets assume, you do a new feature:
>
> /featureX
>
> You will commit it, check it out on the testserver and probably see a
> bug, fix it, commit and push it again. (and probably more commits
> after the testing person ran over other issues).
>
> With cherry-picking, I would need to know all commits I have to pick.
> But as there have been serveral commits, so wouldn't it be a pain to
> check all commits to that file or directory to have the same version?
>
> Just trying to find the right way to handle that.

I don't quite understand what you are asking. You make some commits
pushing a new feature forward. While testing, you see some bugs. You fix
the bugs and make new commits. Now you realize you want those bugfixes
on some other branch. So you cherry-pick them away. Yes, you have to
figure out which commits you want. You can use "git log" or "git log
<set of files>" to look through the list of commits and pick them out.

When you say "wouldn't it be a pain to check all commits to that file or
directory to have the same version?" I can't quite parse what you are
trying to say. Can you rephrase it?

> Do you talk about to different clones of the rep, and give different directory permissions on it, 
> or is there a way to have like to completly different git rep's running and still merge things over (both ways)?
> I just thought this approach would break correct mergin, as it doesn't know where it's comming from. 

No, it doesn't break merging at all. You will have two different
repositories, but they may actually contain quite a similar subset of
commits.  That subset will be the shared part of the history graph, and
then each one will have commits on top. Periodically features from
development will get merged to master, which will make those merged bits
part of the shared history.

To git, two branches in the same repo is exactly the same as two repos,
each with its own branch.

> The only thing I ran over so far is probably doing a hook for that
> (like a pre-pull hook if that exists). didn't get to read too much
> about hooks yet, just did the update hook that checks if the user with
> specific ssh key is allowed to push to a specific branch. That works
> pretty good and is more important in fact.

Yes, that is the hook you would need, but it doesn't exist yet.

> But having 2 completly different repos would be another solution, but
> I kinda wonder that mergin would work correctly this way (if both
> sides have changes). 

Of course it is still possible to have merge conflicts, but it is no
different than merging two branches from the same repository.

-Peff
