From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 14:35:57 +0100
Message-ID: <4983023D.40907@drmicha.warpmail.net>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com> <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStYp-00054V-UG
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbZA3NgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZA3NgF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:36:05 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53446 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbZA3NgE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 08:36:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1E0232574F7;
	Fri, 30 Jan 2009 08:36:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 30 Jan 2009 08:36:01 -0500
X-Sasl-enc: CSqKkRPfHhhxDLppJUzWZsjbKT6ScmQTW8T/OY+ggtiI 1233322560
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 604B82802D;
	Fri, 30 Jan 2009 08:36:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107816>

Pascal Obry venit, vidit, dixit 30.01.2009 13:56:
> Santi,
> 
> Thanks for you reply.
> 
>> I think your definition is not well defined. A, B and C are just
>> branches of you project, technically they are equivalent. Maybe you
> 
> Right. Yet I want to know from which branch a branch as been started.
> 
> You need this to get the proper merge-base for example:
> 
>    $ git merge-base C A
>       1
> 
>    $ git merge-base B C
>       2
> 
>    $ git merge-base B A
>       1
> 
> I always know on which topic branch I'm but, as shown above, depending on the
> parent branch passed to merge-base you do not get the same branch-point. This
> is fine.
> 
> So, when I'm in a topic branch I want to find the name of the parent
> branch. The one given
> when creating the branch:
> 
>    $ git branch B C
> 
> A "stupid" solution whould be to iterate over all branches. Looking
> for the merge-base and
> at the end output the branch having the youngest merge-base. I'm
> looking for something
> more efficient...
> 
>> are thinking that the common commits of, say A and B, really belongs
>> to A, but this is not the case they belong to both branches. In git a
>> branch is really just a pointer to a commit and by extension the
>> history, it is not a series of commits.
>>
>> Just a counterexample, just rearranging you graph:
>>
>>                        o---B
>>                        /
>>                   o---2---o---o---o---C
>>                  /
>>          ---o---1---o---o---o---A
>>
>> From you description: For B I would get C and for C I would get A.
> 
> Don't see this as a counter-example as it is exactly my example.
> 
> Did I missed something?

I think you still haven't *defined* what you mean by "parent branch".
Your example alone doesn't define it, and whenever you have merge
commits things are not clear:

     o---o---o---A
    /     \
---o       o---o---C
    \     /
     o---o---o---B

Now, which one is the "parent branch" of C? A+B? Similarly:

     o---A
    /
---o---C
    \
     o---B

Here it's clear which commit you want, but which branch does it belong
to? A or B?

I really think this is impossible to define unambiguously in git, due to
the nature of git branches, being movable tags, much different from say
hg's hardwired branches (embedded in the commit object).

What you see in gitk is which branch contains a certain commit ("git
branch --contains").

What you want may be the branch which differs from C by the least number
of commits.

Cheers,
Michael
