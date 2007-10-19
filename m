From: Andreas Ericsson <ae@op5.se>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 11:52:14 +0200
Message-ID: <47187E4E.50006@op5.se>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <47159779.6010502@bluelane.com>	 <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>	 <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com> <4717EF40.6000509@bluelane.com> <4718594A.2070407@op5.se> <47187518.1090007@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Fri Oct 19 11:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IioWw-0007FB-5t
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbXJSJwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 05:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbXJSJwU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 05:52:20 -0400
Received: from mail.op5.se ([193.201.96.20]:34369 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbXJSJwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 05:52:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AF81C173066A;
	Fri, 19 Oct 2007 11:52:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miQIAEicdlge; Fri, 19 Oct 2007 11:52:17 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 7E95E1730657;
	Fri, 19 Oct 2007 11:52:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <47187518.1090007@bluelane.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61682>

Pete/Piet Delaney wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andreas Ericsson wrote:
>> Pete/Piet Delaney wrote:
>>> Johannes:
>>>   I read somewhere in the past week that it was possible to maintain
>>>   our existing CVS environment with git. I though it was a separate
>>>   package to export git back to cvs but I just noticed a git-cvsserver
>>>   and as a std part of git and was wondering about using that.
>>>
>>>   We have a number of build machines with flamebox perl scripts pulling
>>>   out CVS branches for builds. I was wondering what is the best way to
>>>   use git and it's nicer pull/push model and merge facility and possibly
>>>   maintain CVS exports for scripts doing builds if possible the cvsweb
>>>   and bonsai (CVS Query Form) that a number of engineers are currently
>>>   using. I started looking over out flamebox scripts with the intent
>>>   up converting them over to git but I mentioned the git to cvs
>>>   coexistence and we are wondering if that's a better route than
>>>   upgrading the flamebox scripts. Having our existing cvsweb, bonsai,
>>>   and gitweb along with the git utilities seems at least desirable.
>>>   Any thoughts or suggestions?
>>>
>> If you do convert them to git, you can fairly easily do an automatic
>> bisect on build-errors, and the developer can (after some time) get
>> an email of what machines they broke the code on and what the bad
>> commit was.
> 
> Could you explain that a bit more. Sounds like you saying it's worth
> messing with the flamebox scripts to use git instead of using the git
> cvserver and letting them pull the cvs branches as they do now. Is the
> existing flamebox email of build log effected buy switching form cvs
> to git? I hadn't expect it to change.
> 

git has quite a wonderful tool named git-bisect. In short, it helps track
down what particular commit introduced a bug. Let's say your builds fail
for some reason, and the build-scripts send out the build-log to the
developer. The script can then continue to check the repo by running git
bisect on it and finding the commit that introduced the build-error, and
email that too to the developer. In short, when you check things in at
5 o'clock that doesn't build, you don't have to sit there and wrestle with
it. You can go home, have dinner, tuck the kids into bed, and then open
your mailbox and have an email with the exact commit that introduced the
regression.

Now, if you can also convince your developers to make small and isolated
commits, and your build-system is such that it doesn't rebuild *everything*,
but has proper dependency tracking and suchlike (a properly written Makefile
for example), the developer will get pointed to a commit that affects perhaps
10-20 lines of code within a reasonable time, and it should be so trivial to
fix that anyone can do it.

> 
>> Besides that, it's not a black-and-white scenario. If I were you I'd set
>> up git-cvsserver and make sure that works for all the scripts, and then
>> pick one or two auto-build things to convert to git. Preferrably on a
>> separate machine, so everything keeps working the same as always while
>> you're fiddling with the auto-build stuff.
> 
> I get the impression your suggestion to first get git-cvsserver serving
> the repo so that the build machines works without any change and then to
> go to each build machine and update the scripts to use git instead of cvs.
> 

That's the idea, yes.

> Are there any tricks I need to so on the repo to make the branches pull
> out with exactly the same commands that we are currently using. My guess
> is that the branch checkouts should work without any messing around.

I'm not sure what you mean by that. You can tell git to automatically fetch
any new branches (that's the default, I think), but you'll ofcourse have to
switch to using git-pull instead of cvs co (or whatever you're using now),
unless you use git-cvsserver. AFAIK, git-cvsserver mimics a cvs server well
enough that it accepts all commands and the two are interchangeable (assuming
the background repo conversion has been done, ofcourse).

>> Just my two cents.
> 
> Hey, you two cents could easily save me hours of messing getting this
> conversion done.
> 

That's well-invested money then ;-)

> BTW, I don't think anyone is checking into the repo, but if they do
> can I do another git-cvsimport to just update the one I already did?

Yes. It works incrementally, but since cvs commits aren't atomic, you
have to wait 10 minutes after the cvs commit *starts* to be able to
use cvsimport to move it over to git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
