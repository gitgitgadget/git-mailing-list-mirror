From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sun, 23 May 2010 15:52:40 +0100
Message-ID: <4BF94138.5000007@pileofstuff.org>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	 <4BF7B751.7050704@pileofstuff.org> <1274543552.21346.166.camel@Luffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 16:54:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGCZ1-0006C7-3z
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 16:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab0EWOwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 10:52:46 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:17873 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865Ab0EWOwp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 10:52:45 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100523145242.YDLU10460.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sun, 23 May 2010 15:52:42 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100523145242.OEPQ1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sun, 23 May 2010 15:52:42 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <1274543552.21346.166.camel@Luffy>
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=BxPs6DqL8UcA:10 a=UBIxAjGgU1YA:10 a=IkcTkHD0fZMA:10 a=NpW2XXewAAAA:8 a=anyJmfQTAAAA:8 a=PqUXlY-nkNpPP4ohf9sA:9 a=PVUKuEcJ4ZpMYTp7oWcA:7 a=_JhTVcRnGZV0v5-eELyeUwfGn_0A:4 a=QEXdDO2ut3YA:10 a=iQ7avhN-QijTTsoA:21 a=Z0cQnSqs6iQqmuO7:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147578>

Hi Daniele,

I agree that a lead developer moving a team from graphical SVN is a
different problem.  I don't think git-gui does SVN, I couldn't work out
how to make TortioseGit work with SVN, and I doubt EGit will like SVN
very much.

You're also right that git-svn has limitations with merging and
rebasing.  Specifically, don't use them unless you know what you're
doing - see `man git-svn` for more.  Git-svn is also less
newbie-friendly than either git or svn on its own.

Having said that, I'd still recommend you try moving a few developers to
git during the lifetime of your current project.  In my experience,
those developers most willing to try something new in the middle of a
project are also the ones that want to get hacking right away on a new
project.  Getting even one developer to start migrating now will be good
practice for you, and will double the number of eyeballs looking at git
issues later on.

Slowing down for less than a week is a very ambitious target - I think
we had about 2 weeks of noticeably reduced productivity, even when I'd
done a lot of work to spread the pain over several months.  Starting git
with a new project might reduce that time a bit - for example, there's
no chance of uncommitted work in an SVN checkout failing to make the
switch.  But it can be more expensive in the long-run, because you have
to make all of your architectural decisions based on what you can
explain to SVN users on day one - for example, my team took about 2-3
weeks to understand how a commit is different from a push, and why they
should care.  But because they understood before we made the big leap,
we were able decentralise our workflow as much as we needed.

If you do go via git-svn, I'd recommend you read `man git-rerere` and
set the config option "rerere.enabled" to "true" for all users.  I
needed to blow away a few messy merges to fix rookie mistakes, and
`git-rerere` would have made a painful experience much easier.

Even if you go straight into git, you might think about finding/writing
hooks to synchronise an SVN repository and a git repository.  There will
probably be a few people you can't switch right away - e.g. a sysadmin
that would need months to rewrite all his scripts, or a designer that
doesn't want to learn a different tool just for your team.  Providing a
semi-functional legacy interface for those people will let you raise the
pressure on them more gradually.

I forgot to mention education in my previous post, which was actually
one of the biggest problems during the move.  I was surprised how
everyone had such different learning styles - some wanted to learn the
theory then be left alone, some wanted to be told each solution at the
moment they faced the problem, some wanted to learn by watching how I
worked, etc.  The only real pattern seems to be that the busier people
are, the more they like to feel they're pulling information out of you,
and the less receptive they are when you push information at them.  I
muddled through by trying to give everyone more of whatever they each
reacted best to.

The biggest problem I had with teaching git to SVN users was something I
still have difficulty putting into words.  SVN users focus on branches
as the centre of their development history, and see commits as these
funny little things that punctuate the progress of their branches.  But
git users focus on commits (or even trees) as the centre of their
history, and see branches as one of many handy labels that track them.
The distinction is subtle, but it affects a lot of the expectations
people have.  For example, SVN users like to think of a commit as being
"on a branch", meaning that it marks an event in the lifetime of one SVN
directory.  To this day, I don't think I've really communicated why you
can only say a git commit is "reachable from the tip of zero or more
branches".

Because my team needed time to unlearn a lot of these SVN issues, I
didn't try to push much deep git tech at them early on.  A few months
into the move though, it's starting to seem like a better idea.  One of
my team-mates got me to start reading "Version Control with Git"
(http://oreilly.com/catalog/9780596520137) - from what I've seen so far,
I'd definitely recommend it to people that like book-learning and are
ready to learn git without bringing their old SVN baggage.  On the other
hand, you can cobble the same information together from various online
sources if you prefer (http://book.git-scm.com/ is a personal favourite).

	- Andrew Sayers
