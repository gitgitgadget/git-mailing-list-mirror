From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 12:03:12 -0700
Message-ID: <4627BCF0.3000004@midwinter.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com> <200704190408.59595.jnareb@gmail.com> <Pine.LNX.4.64.0704191043140.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 21:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HebuZ-0008RB-7H
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161511AbXDSTDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbXDSTDP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 15:03:15 -0400
Received: from tater.midwinter.com ([216.32.86.90]:59111 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161511AbXDSTDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 15:03:14 -0400
Received: (qmail 28310 invoked from network); 19 Apr 2007 19:03:14 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Gl55l5/280mo92/WATBa1wu0v/KmkNfCX3iPiW0Rd1wiVCm0AStoGsTBnpplbwPE  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Apr 2007 19:03:14 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <Pine.LNX.4.64.0704191043140.8822@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45036>

Johannes Schindelin wrote:
> Let me pick up the ball here. Once you did your share of conflicting 
> merges, you _will_ realize how much better it is to merge when you are at 
> a relatively stable state, i.e. you can test things (if only to make sure 
> that the merge did not introduce strange side effects). And guess what, at 
> such a stage I would commit anyway.
>   

That's a great workflow if you're working on relatively discrete, 
standalone changes. A lot of the time, when I'm working on an isolated 
change, I do just that, and I merge when I'm stable just like you 
describe. That's probably the vastly most common mode of operation for 
distributed open-source projects, which obviously were git's initial 
target audience.

However, it is frequently NOT the mode of operation for development at a 
company where two or more people are working on implementing the same 
new feature in a highly collaborative way, often sitting across the room 
from one another. In that situation, it's frequently the case that, for 
example, I'm coding and discover I need some new utility method that Joe 
can easily factor out of the code he just checked in. So he does his 
quick refactoring, commits that change, and I pull it into my sandbox 
where I am *not* yet at a stable stopping point because I was waiting 
for his change in order to finish and/or test my change. Or, more 
commonly, I discover a bug in his code and he checks in a fix I want to 
pick up.

That's the use case for dirty working-copy merges. It is extremely 
common in my experience. Actually I can't think of a single company I've 
worked at in ~20 years of professional programming, from huge ones to 
small startups, where that wasn't a frequent working style, especially 
during crunch times or initial implementation.

The XP people even have a name for it: "continuous integration." 
(Granted, that's not *exactly* what that term means, but "update early 
and often" is a pretty important part of the CI workflow.)

> It is so much easier to resolve conflicts if you can look at both sides, 
> and can actually go to both sides to test things out, or even just 
> generate the diff to one side. This is just not possible with a dirty 
> merge. Exactly because you knowingly lost the current state, you cannot do 
> diffs with it.
>   

I don't disagree, but that's only an issue given the underlying 
assumption that you will be integrating only occasionally, and thus will 
tend to pull massive numbers of changes with lots of conflicts. If you 
know there will be at most one or two conflicts (or more likely none at 
all) because your last pull was twenty minutes ago and there have only 
been three other pushes since then, it's not an issue. That's the 
typical situation in a continuous-integration shop. I'd say 95% -- to be 
ridiculously conservative -- of the "svn up" commands that are run at my 
company result in no conflicts at all.

When a large conflict is a once-every-couple-of-months event because 
you've resolved all the trivial conflicts as they've appeared along the 
way, optimizing your daily workflow for the "what if I need to resolve a 
big hairy conflict?" case just doesn't make much sense.

> Needless to say (but I do it nevertheless, since I am in a chatty mood), I 
> _never_ can be seen doing the 4-command equivalent of `svn up`. I only 
> pull when I have a clean state. (Note: this also leads to a more 
> structured way of working, which does prevent errors.)
>   

And out of curiosity, are you using git for distributed, relatively 
autonomous development, or for collaboration with a high level of 
interdependency between developers?

-Steve
