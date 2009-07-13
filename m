From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Mon, 13 Jul 2009 15:41:11 +0200
Message-ID: <h3fdjg$770$1@ger.gmane.org>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net> <h37lh2$q3s$1@ger.gmane.org> <4A57639D.4020305@drmicha.warpmail.net> <h3eqap$cov$1@ger.gmane.org> <4A5B13FB.4040203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 15:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQLo5-00016Y-4f
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 15:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbZGMNmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833AbZGMNmX
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 09:42:23 -0400
Received: from main.gmane.org ([80.91.229.2]:51467 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829AbZGMNmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 09:42:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MQLnQ-0004CZ-PW
	for git@vger.kernel.org; Mon, 13 Jul 2009 13:42:21 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 13:42:20 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 13:42:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A5B13FB.4040203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123194>

Michael J Gruber wrote:
>> is only used for syncing svn -> our server -> github, I had to add a new 
>> commit which represents the svn-ignore meta data to a .gitignore file. I 
>> noticed I had to manually to a 'git checkout master' & 'git merge 
>> remotes/trunk' to pull in new updates. I thin pushed that to github.
> 
> You didn't tell us *that* before... Exactly this is why I asked whether
> you want to do own work on those branches or just push a git-svn mirror.

When we last spoke, I did not have a .gitignore file. :)
That is the only change I plan to make in that repository (on our server).

I have cloned that repository (on our server) to my local PC. The one on 
my PC is a true Git repository and that is the one I'll be making 
changes to and emailing patches back to the FPC mailing list.


> the only change you will make to the original branches. It keeps you
> from doing a simple fetch and forces you to set up merging.

OK, so seeing that I already done that and pushed it to GitHub, I now 
need to always do the following on our server git repository.

  $ git svn fetch
  $ git checkout master
  $ git merge origin/trunk
  $ git push github            <-- updates remotes/* to heads/*
  $ git push github master     <-- updates remote master branch


So 'git push github' as I have show above should do the trick for all 
refts/remotes/* branches. I gather that excludes the "master" branch, so 
I still need to push that one manually as well. Correct?

In the newer Git v1.6.x versions there is a new default setting that can 
be set for push.

   $ git config push.default <type>

If I set that to "matching", then I should be able to only need one 'git 
push github' command, and that should push remotes/* and the "master" 
branch. Correct?

In my local repository on my work PC (not the server), I normally set 
the push.default to "current" so I don't accidentally push something 
that has an incomplete feature.


> Also, svn-metadata may change over time. Do you intend to keep
> .gitignore up to date with those changes?

No, just the initial setup.



> - Push the git-svn converted branches as is, using the suggested refspec
> (or having it in config and doing "git push github"). "git svn fetch"
> will have fetched all svn refs you need.

OK, I haven't added a .gitignore to the fixes_2_2 local branch, so that 
one is still exactly as it was in SubVersion. And my local "fixes_2_2" 
has not been pushed to Github yet. So I should be able to just delete 
the local "fixes_2_2" branch. The normal refspec will push changes to 
Github as it should. So if anybody clones the Github repository, they 
can manually create their local "fixes_2_2" from the 
refs/remotes/fixes_2_2 branch. Correct?


I think I'm starting to see a little white light in the end of the 
tunnel. :-)


> - Set up local branches and do your merge thing. In this case you
> probably also want to keep up with svn metadata changes (mind that

I think I will leave the local "master" branch (mapped to SubVersion 
Trunk) as-is. I'll then modify my cron script to do a manual merge after 
the 'git svn fetch'.

I'm not going to bother updating the .gitignore again. So from now 
onwards the merge should be a simple fast-forward merge I take it and 
should never get conflicts again.


> consists of .gitignore (and possibly other things) only. "git show
> svnhelper:.gitignore > .git/info/excludes" will set up each user. You
> can also use a tag for that (i.e. instead of a branch).

Very clever indeed - pity I did not think of it before. I'll make a note 
of this and if I ever clone another SubVersion repository, I'll do it 
with a tag or separate branch.



Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
