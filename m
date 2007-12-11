From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary
	mode.
Date: Tue, 11 Dec 2007 16:48:41 +0100
Message-ID: <20071211154841.GA29805@elte.hu>
References: <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org> <20071211145709.GB19427@elte.hu> <20071211152412.GB15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <g
X-From: git-owner@vger.kernel.org Tue Dec 11 16:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27Ml-000305-94
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXLKPt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbXLKPt3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:49:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54885 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbXLKPt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:49:28 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1J27Lk-00069S-NX
	from <mingo@elte.hu>; Tue, 11 Dec 2007 16:48:54 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 9DCE73E2193; Tue, 11 Dec 2007 16:48:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071211152412.GB15448@artemis.madism.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67875>


* Pierre Habouzit <madcoder@debian.org> wrote:

> > which is quite a bit confusing to someone who'd like to keep as few 
> > details of command line arguments in his head as possible :-)
> 
> Because git-shortlog insists on you passing a reference first, HEAD is 
> not implicit if you pass something that looks like a path first. This 
> is arguably wrong. What you meant here is:
> 
> $ git-shortlog -n -s HEAD kernel/
> 
> The reason IIRC is that git-shortlog once only read things on stdin, 
> and this keeps backward compatbility to `git-shortlog` without any 
> arguments.
> 
> Sometimes history hurts :) I don't think there is much we can do on a 
> short timescale. Maybe the old way can be slowly deprecated, and then 
> git-shortlog will be able to act like git-log.

if we are growing legacies in git this fast it will turn itself into CVS 
very quickly, give or take 20 years ;-) I think a straightforward usage 
model is paramount, so phasing out such inconsistencies as early as 
possible in the project's lifetime should be a priority IMHO. Git has a 
very, very 'refreshing' approach to information management, and that 
should permeate it all across. It's easy to be "fresh" in the beginning 
of a project - maintaining freshness for years is a lot harder. (i dont 
suggest to break compatibility, but to be aware of such inconsitencies 
and make it a priority to get rid of them. It does not help that such 
inconsistencies are only apparent to git newbies.)

another thing i noticed that bites git newbies is that there are 
commands that do not do the "obvious" thing (to a newbie) and there are 
commands that just dont tell what they are doing. It would be very 
helpful if git was just a little bit more verbose about what it does. 
I.e. use the standard output for ... actual output, and there will be an 
instant and pleasant feedback loop between newbie and tool.

It should basically "teach" the user along the way about what is being 
done, so that it quickly becomes an automatism. Especially where 
concepts differ from legacy SCMs. When is the index updated, when do 
files get modified, how branching works, etc.

for example, if i type "git-checkout" in a Linux kernel tree, it just 
sits there for up to a minute, and "does nothing". That is totally 
wrong, human-interaction wise. Then after a minute it just returns. What 
happened? Why? Where? A newbie would then try "git-checkout -v", using 
the well-established "verbose" flag, but that gives:

 Usage: /usr/bin/git-checkout [-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]

That's what a newbie asks. We are trying to turn the world of SCM's 
upside down with git, and we should do that by teaching things gradually 
and by being very explicit what happens and why, when a command is typed 
;-)

i could go on and on with other examples. (should I ? ;-)

It's small, little details like that and if we fix a few dozen of them 
it will do _wonders_ to user education, really. The best tools are the 
ones that emit just about information to essentially give a tutorial to 
the newbie about the philosophy and workings of the tool - without being 
annoying to advanced users. It flattens the learning curve and increases 
adoption rate enormously. It also helps people learn their way out of 
the mental deformations that CVS causes ;-)

And we could do this by adding a -q "quiet" flag, to restore the current 
'silent' behavior of git. I could then do this in my .bashrc:

   alias git='git -q'

to get the old, quiet behavior. This issue is pretty much the only 
conceptual advantage i can see of the competition like hg/mercurial ;-)

Ok, enough ranting for today i guess =B-)

	Ingo
