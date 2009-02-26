From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Thu, 26 Feb 2009 18:48:21 +0100
Message-ID: <49A6D5E5.8000007@drmicha.warpmail.net>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com> <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net> <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org> <49A66057.1050501@drmicha.warpmail.net> <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LckMz-0003CM-54
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZBZRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 12:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZBZRsc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:48:32 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40049 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbZBZRsc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 12:48:32 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BEDEA2A532B;
	Thu, 26 Feb 2009 12:48:29 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Feb 2009 12:48:29 -0500
X-Sasl-enc: BuMK6A0FAZr4lciJGXq+XVbIK2xySk5nUibj6AgrKHg4 1235670509
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF60E16FBC;
	Thu, 26 Feb 2009 12:48:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090226 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111583>

Junio C Hamano venit, vidit, dixit 26.02.2009 18:09:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> First of all: I define good/bad as matching the documentation.
> 
> Ok, I was primarily working from this:
> 
> commit bcc785f611dc6084be75999a3b6bafcc950e21d6
> Author: Linus Torvalds <torvalds@osdl.org>
> Date:   Mon Oct 30 08:28:59 2006 -0800
> 
>     git push: add verbose flag and allow overriding of default target repository
>     
>     This adds a command line flag "-v" to enable a more verbose mode, and
>     "--repo=" to override the default target repository for "git push" (which
>     otherwise always defaults to "origin").
>     
>     This, together with the patch to allow dashes in config variable names,
>     allows me to do
>     
>     	[alias]
>     		push-all = push -v --repo=all
>     
>     in my user-global config file, and then I can (for any project I maintain)
>     add to the project-local config file
>     
>     	[remote "all"]
>     		url=one.target.repo:/directory
>     		url=another.target:/pub/somewhere/else
>     
>     and now "git push-all" just updates all the target repositories, and shows
>     me what it does - regardless of which repo I am in.
>     
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> If documentation does not match it, we need to figure out why J6t with
> bf07cc5 (git-push.txt: Describe --repo option in more detail, 2008-10-07)
> needed to update the documentation.
> 
> It could be that the behaviour changed (perhaps by accident, perhaps by
> design) after Linus introduced --repo with bcc785f (git push: add verbose
> flag and allow overriding of default target repository, 2006-10-30) and
> J6t documented that updated behaviour.  And since then there was another
> behaviour change (again, perhaps by accident, perhaps by design) that made
> you notice the description does not match the behaviour.
> 
> You will see that:
> 
>  (1) bf07cc5 (i.e. J6t's documentation) passes your tests;
> 
>  (2) somewhere between that and v1.6.2-rc2, there is a regression to make
>      your test fail.

I see. Back then I checked whether there was a change to git-push at or
after J6t's doc commit, and there was none, but I didn't test. I'll do now.

> if the above conjecture is true, and we may want to fix that regression to
> match the documentation.
> 
> On the other hand, if bf07cc5 does not pass your tests, it means that the
> documentation update was the cause of the confusion, and it is not the
> behaviour that needs to be fixed.

>From Linus' description it's not clear to me what should happen when
there is no explicit repo argument but the branch is tracking a remote
and there is a --repo option. And I think this case is the only open
question: Should the option win or the tracking config? Code does
option, doc says tracking config.

[Also, I don't see immediately what's wrong with "alias.push-all = push
-v all", in the current situation where option and arg are equivalent,
but I haven't tried.]

I'm cc'ing Linus to make sure J6t's (current) doc describes the original
intent for --repo and my patch isn't stepping on /some/one's toes...

> Sorry, but I do not have time today to look into this.  Could you help?

Of course. I ursurpated someone else's itch here, but now it's mine ;)

I'll bisect. Seems to be the right thing to do while watching soccer
later in the evening...

Michael
