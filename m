From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: newb questions: post-cherry-pick status cleanup, shared local
	repository permissions
Date: Mon, 30 Mar 2009 06:30:09 +0200
Message-ID: <20090330043009.GB12907@vidovic>
References: <c4e763ac0903292003j22934e7ax9f9ae986bdcd6abb@mail.gmail.com> <20090330042226.GA12907@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Davies <aaron.davies@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 06:32:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9AI-0007aj-2r
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 06:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbZC3EaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 00:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZC3EaT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 00:30:19 -0400
Received: from out2.laposte.net ([193.251.214.119]:41810 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbZC3EaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 00:30:18 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8209.laposte.net (SMTP Server) with ESMTP id 7F94D7000084;
	Mon, 30 Mar 2009 06:30:10 +0200 (CEST)
Received: from ? (88-121-127-66.rev.libertysurf.net [88.121.127.66])
	by mwinf8209.laposte.net (SMTP Server) with ESMTP id 11E5F7000083;
	Mon, 30 Mar 2009 06:30:09 +0200 (CEST)
X-ME-UUID: 20090330043010733.11E5F7000083@mwinf8209.laposte.net
Content-Disposition: inline
In-Reply-To: <20090330042226.GA12907@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 31.600000
X-me-spamcause: OK, (-210)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeeiucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmdenlhhinhhugiculddquddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115063>


On Mon, Mar 30, 2009 at 06:22:26AM +0200, Nicolas Sebrecht wrote:
> 
> 
> On Mon, Mar 30, 2009 at 11:03:28AM +0800, Aaron Davies wrote:
> > 
> > hi, i'm new to git, and have a couple questions which are probably
> > very stupid and/or indicate that i've been doing it wrong.
> > 
> > first, a couple words about my setup/workflow: i'm currently sole
> > developer on a project which may at some point get some other coders.
> > the environment is three linux boxes, one for development and two for
> > production, and three accounts, mine, dev, and prod. all homedirs are
> > hosted on the network and are accessible from all three boxen.
> > 
> > i have a "central" (i.e. bare) repository stored in dev's homedir, and
> > regular copies in all three homedirs. the language involved is
> > interpreted, so the code tree is the deployment.
> > 
> > my main workflow is to hack on a branch in my homedir, then merge and
> > push when i have a feature ready. then i go to the dev account and
> > pull, which constitutes dev deployment. once it's thoroughly tested, i
> > do the same in the prod account.
> 
> Looks sane. 
> 
> That said, you could also work on branches (all in "homedir") for the
>     'working on feature' -> testing (dev) -> ready (prod) 
> workflow.
> 
> > now, the questions: an exception to this workflow occurred a couple
> > months ago, when i made some urgent bugfixes that needed to move to
> > prod before other stuff that was currently being tested in dev. this
> > was done via cherry-picking some specific commits into prod. now, in
> > prod, when i do "git status", it says "# Your branch is ahead of
> > 'origin/master' by 8 commits." is there an easy way to get rid of
> > this?
> 
> What I would do is working on "TOPIC" branches. By this way, the bare,
> dev and prod repositories would not "know" of all the commits from mine
> but only the urgent fixes.
> 
> in "mine":
> - step 1
>     $ git checkout -b bugfixes master
> 
> - step 2
>     $ git cherry-pick blabla
>     (and/or <hack, hack, hack>)
> 
> - step 3
>     $ git checkout master
>     $ git merge bugfixes
> 
> - step 4
>     $ git push origin master:master (to the bare repo)
> 
> - step 5
>     $ git branch -d bugfixes
>     $ git checkout myworking
>     $ git rebase myworking master

My bad:
     $ git rebase master

> At step 1, we create the new bugfixes branch from master:
>       (bugfixes)
>      /
> o-o-o          (master)
>      \
>       a-b-c-d  (myworking)
> 
> At step 2, we fix the bugs (cherry-picking and hack):
>       a-c-y-z  (bugfixes)
>      /
> o-o-o          (master)
>      \
>       a-b-c-d  (myworking)
> 
> At step 3, we merge the urgent fixes into master:
>       a-c-y-z  (bugfixes)
>      /
> o-o-o-a-c-y-z  (master)
>      \
>       a-b-c-d  (myworking)
> 
> At step 4, we push the urgent work as usual pushes.
> At step 5, we come back to the usual work:
> 
> o-o-o-a-c-y-z  (master)
>              \
>               b'-d'  (myworking)

Then, you update dev and prod as usual from bare.

-- 
Nicolas Sebrecht
