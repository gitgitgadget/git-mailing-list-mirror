From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 21:36:49 +0100
Message-ID: <4377A3E1.7070003@op5.se>
References: <4376C797.3050600@matysik.co.nz> <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org> <437788A0.6030103@op5.se> <Pine.LNX.4.64.0511131137470.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 13 21:38:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbOau-0004SY-JT
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 21:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVKMUgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVKMUgv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 15:36:51 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36797 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750903AbVKMUgv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 15:36:51 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5B02C6BCBE
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 21:36:49 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511131137470.3263@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11749>

Linus Torvalds wrote:
> 
> If there's some way to "suggest" ssh when installing git, that would be 
> good, but I don't think rpm has that.

It hasn't. It was designed to update software non-interactively.

> And if somebody doesn't have ssh 
> installed, they probably don't have a network, so maybe even that is 
> unnecessary.
> 

I *think* the ssh transport should work nicely over rsh as well. I don't 
have the slightest idea of where to find an rsh installation to test it 
with though.

> So depending on the curl _program_ would fall under the same harmless case 
> as depending on ssh and rsync, but the thing is, we depend on it as a 
> library, which is why we should split things up.
> 

True. But HTTP is a very simple protocol and git only uses a very small 
portion of curl's capabilities so it wouldn't be rocket-science to hack 
up some micro-replacement and always use the shipped stuff.

> 
>>Moving out the {cvs,arch,svn}-import scripts made sense because they 
>>were only faintly related to git day-to-day operations and forced some 
>>really ridiculous dependencies down users throats (git requiring 
>>subversion was a funny one...).
> 
> 
> Yes. 
> 
> NOTE! Git does actually require the "merge" program,

That depends on how it's used. If some script expects 'merge' to be 
there and does things that might break the index if it isn't, then it's 
required.

> which sometimes comes 
> with the diff3 package, and more often comes with rcs.  As with ssh and 
> rsync, it's an external program and only really required if you do 
> development (you can fast-forward something that you're only tracking 
> read-only without it), so in theory you don't absolutely need it, but we 
> do have a dependency on RCS right now due to that.
> 

It could require /usr/bin/merge instead. Seeing as people who install 
packages usually installs other things as packages too this would 
probably make more sense.

> Which is a bit strange, and sometimes wrong (the same machine that doesn't 
> have curl installed also doesn't have rcs installed, but I compile git on 
> it anyway, and it works fine, since I use that machine only as a backup 
> thing to receive git packs - in case kernel.org goes down _and_ all my 
> home machines magically turn into pumpkins, I'll still have another site 
> I can get my git repos from).
> 

Still though, be kind to the fairy godmother. ;)

> 
>>While we're on the subject of confusing; How about not naming non-core
>>packages git-core? It feels wrong to have git-core-http, git-core-cvs and
>>git-core-svn since they, strictly speaking, aren't required for core
>>operations.
> 
> 
> Yeah, that "git-core-xxx" thing is a bit strange, but on the other hand, 
> it does make it clear that they all come from the same SRPM (the 
> "git-core" SRPM) so in the end I think it's actually a good idea.
> 

The change would only mean that all packages will come from the "git" 
SRPM rather than the "git-core" SRPM so this point is moot unless there 
will ever be such a thing as the "git" SRPM to contend with (which will 
be less likely if we're it, so to speak).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
