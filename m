From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 06:18:42 +0200
Message-ID: <20060923041842.GH8259@pasky.or.cz>
References: <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net> <20060920161825.GR8259@pasky.or.cz> <Pine.LNX.4.64.0609200927260.4388@g5.osdl.org> <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 23 06:18:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQyyY-0002g5-Gt
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWIWESp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIWESp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:18:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24506 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750802AbWIWESo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 00:18:44 -0400
Received: (qmail 12018 invoked by uid 2001); 23 Sep 2006 06:18:42 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200902190.4388@g5.osdl.org> <Pine.LNX.4.64.0609200927260.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27561>

I'm joining several fibres of the thread since we are talking about the
same thing per partes and that's rather confusing.


Dear diary, on Wed, Sep 20, 2006 at 06:26:32PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Think about it. You and somebody else works on a common branch, using a 
> common source repo. When you "fetch", you want to get all the work that 
> the other person has done. But you sure as hell don't want that work to 
> overwrite your own work.
> 
> So what does git do? It notices if you have a local commit on that shared 
> branch (because it no longer fast-forwards to the other end), and it tells 
> you exactly that: it says that branch so-and-so doesn't fast-forward, and 
> refuses to overwrite it.

I'd bite here that if you commit to a branch that you also simultanously
fetch from somewhere else, you're asking for it - but I've never really
used [plain Git]'s branches so perhaps it is a blessed workflow there.
(Cogito won't let you do it.)


Dear diary, on Wed, Sep 20, 2006 at 06:33:42PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> I would be ok with a "anonymous read-only" approach IF GIT ACTUALLY 
> ENFORCED IT. In other words, we could easily have a read-only clone that 
> added the "+" to all branches, but then we should also make sure that 
> nobody ever commits _anything_ in such a repo.
> 
> No merges (because you can not rely on the merge result being meaningful: 
> the sources of the merge may be "ephemeral"), no local commits (because 
> you can never "pull" any more after that, since that now becomes a merge 
> with something you can't trust any more).

Well, yes, it gets bad if you just prepend + to all branches:

Dear diary, on Wed, Sep 20, 2006 at 06:15:04PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> The thing is, if you don't understand how rebasing etc destroys history, 
> you may do things like do a "git pull" or a "git merge" of a branch that 
> the other side WILL THROW AWAY! That will later result in major pain, 
> because when you then try to merge it later, you will get all kinds of 
> nasty behaviour, because the history you merged earlier no longer matches 
> the history you're now trying to merge again, and the work you merged 
> earlier is simply not there any more.

This is a very good point.

But this just means that, as others in the thread noted, there needs to
be a reliable way for marking floating branches in the public
repositories and enforcing the implications of that locally (not letting
the user to merge with those).

When I've said "seamless support for floating branches", generally what
I've had on my mind was that it's seamless for the user, that his the
one who pulls them - the developer can be required to do something small
extra to mark those as such.


When you have that, you can just:

  (i) Disallow three-way merges with +branches

  (ii) Fast-forward of +branches makes you follow the branch' rebase if
the original commit in the branch before fetching equaled your HEAD
commit, and taints your branch against committing unless you switch to
a non-+ branch (or manually untaint your branch)

  (iii) Of course enforce the fast-forward restriction for non-+
branches

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
