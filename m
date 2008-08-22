From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
   everything up-to-date
Date: Fri, 22 Aug 2008 16:09:19 +0200
Message-ID: <g8mhag$i90$1@ger.gmane.org>
References: <1219263969579-736663.post@n2.nabble.com> <8585F10E-C33C-481E-B044-A7125F3316F2@web.de> <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com> <7vbpznpeup.fsf@gitster.siamese.dyndns.org> <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com> <alpine.LNX.1.00.0808201808400.19665@iabervon.org> <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org> <1219332938839-740444.post@n2.nabble.com> <g8k4or$tf$1@ger.gmane.org> <1219337620037-740662.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 16:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWXLd-0001sj-0c
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 16:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYHVOJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 10:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYHVOJh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 10:09:37 -0400
Received: from main.gmane.org ([80.91.229.2]:48926 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYHVOJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 10:09:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWXKT-0007UF-Qg
	for git@vger.kernel.org; Fri, 22 Aug 2008 14:09:29 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:09:29 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:09:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <1219337620037-740662.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93302>

ir0s venit, vidit, dixit 21.08.2008 18:53:
> Hi Michael,
> 
> Here are my results:
> 
> $ git ls-remote origin 
> 138ea08f9680a8def085b793c9cee70eed0e1f3b        HEAD
> 138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/heads/master
> 75290a081feebcc4265825d017d9af07c7646951        refs/heads/remotebranch
> f11c723119cd9938e91e1ed5328ef143fb477f15        refs/heads/mybranch
> f11c723119cd9938e91e1ed5328ef143fb477f15        refs/heads/groups
> ...
> There are a few more
> 
> Is it the case that mybranch somehow became a remote branch?

It means that the repo "origin" has a branch called mybranch. From the
sha1 and the one in your other mail (git ls-remote .) we see that it is
identical with your local branch mybranch. It is most certainly the
result of a command

git push origin mybranch

which (in the absence of any relevant lines in .git/config) just
says that you push that branch into origin with the same name, creating
a branch there if there's none. You can get rid of it using "git push
origin :mybranch".

What you most probably wanted to do was

git push origin mybranch:remotebranch

which pushes your mybranch into the remotebranch of the origin repo.
(You can put this in the config for later pushes, git config
remote.origin.push mybranch:remotebranch).

On the other hand:

git push origin

only compares existing branches with matching names, which is why it
reported "up to date".

On yet another hand (I'm losing count):
When you switch to a tracking branch it is compared to its
corresponding remote, and your mybranch and origin/remotebranch clearly
differ:

> Here are the results for this one: $ git log --pretty=oneline
> mybranch...origin/remotebranch 
> f11c723119cd9938e91e1ed5328ef143fb477f15 Merge branch 'remotebranch'
> of gitosis@sorry.must.obfuscate.url.com:my-repo into mybranch 
> eb41bd8f4f43d483b4a58bc98386c468bb69173c Ticket #1032 
> 5e76a7c9bce92519b308c031357794904bf0f4a6 Ticket #1038 
> cu5ceaf670c83f77c1b48e8d31a23456b744f1af0f Ticket #1044

Now, this

> f11c723119cd9938e91e1ed5328ef143fb477f15         HEAD
> 138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/heads/master
> 75290a081feebcc4265825d017d9af07c7646951        refs/heads/remotebranch
> f11c723119cd9938e91e1ed5328ef143fb477f15         refs/heads/mybranch
> 138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/remotes/origin/HEAD
> 138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/remotes/origin/master
> 75290a081feebcc4265825d017d9af07c7646951       
> refs/remotes/origin/remotebranch
> f11c723119cd9938e91e1ed5328ef143fb477f15        
> refs/remotes/origin/mybranch

from your other e-mail shows quite a zoo of branches you have locally
now. Two of them should probably not be there:

refs/remotes/origin/mybranch is the result of fetching/pulling from
origin after creating mybranch there by mistake.

refs/heads/remotebranch is a local branch named remotebranch. I don't
know where it came from, but git revlog may tell you more.

As a word of comfort: I'm quite new to git and find things confusing
sometimes, myself. But in the end I always found out that thinhs are the
way they are for a good reason.

You're thinking of "two places" to exchange information for a branch,
which is natural and confused me first, too. But realise that for a sane
workflow you need three:
- remotebranch at the other repo origin,
- your remotes/origin/remotebranch which pulls from origin's repo, and -
your local tracking branch mybranch which pulls or rebases from
remotes/origin/remotebranch at the time of your chosing.

You push from mybranch into the remotebranch of the origin repo.
That last one is the one that pushed you off ;) Seriously, that last leg
of the workflow triangle is not setup automatically (because you may not
have push access).

Cheers,
Michael
