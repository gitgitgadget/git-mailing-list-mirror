From: Luke Diamand <luke@diamand.org>
Subject: Re: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 07:30:56 +0100
Message-ID: <4E7C27A0.9030900@diamand.org>
References: <loom.20110923T064720-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 08:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6zHw-0005hj-Pu
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 08:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab1IWGbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 02:31:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49084 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1IWGbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 02:31:01 -0400
Received: by wyg34 with SMTP id 34so3648608wyg.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 23:31:00 -0700 (PDT)
Received: by 10.216.230.89 with SMTP id i67mr3231252weq.51.1316759460437;
        Thu, 22 Sep 2011 23:31:00 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fa7sm14818607wbb.26.2011.09.22.23.30.58
        (version=SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 23:30:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <loom.20110923T064720-366@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181946>

On 23/09/11 05:48, Jon Forrest wrote:
> I'm just now starting to use git for more than trivial things.
> Today I got myself in trouble. Here's what happened:
>
> 1) I pulled the master branch from the IT repository from our
> main git server.
>
> 2) I created a branch from this called "J" and started making changes.
>
> 3) Other people pulled master from IT and then pushed changes back.
>
> 4) I merged J with my master branch.

Someone will be along soon to correct me, but I think you should have 
rebased against the master branch rather than merged. Something like:

% git rebase origin

That way your changes would remain appended to the tip of the master 
branch. That will in general make your life much easier for all sorts of 
reasons.

>
> 5) I tried pushing my master back to origin but this failed with
> the usual message saying I first needed to pull from origin.
> So, I pulled and then pushed. This worked.
>
> 6) On another server where I was going to use my changes I pulled
> master from IT.
>
> 6) It turned out that my changes were incorrect. So, I tried to revert
> using various methods I found by googling "git revert". What happened
> was that when I tried to revert back to the commit before the one I
> made, the files I had modified *and* the files that apparently were
> modified by other people in #3 above were reverted. This wasn't what
> I wanted. I only wanted to revert the changes I had made.

At a guess, git revert created a commit that undid your _merge_, rather 
than your commit. The merge included all those other changes....

It's a good idea to take a look at what a commit does before pushing it 
- "git show HEAD" is your friend.

>
> With the help of someone more experienced than me we were able to get
> things back to normal but this experience left me wondering what I
> should have done in the first place. There's a chance I'm going to
> have to go through all this again as I try to fix the problem with
> my changes.

Use git rebase (*) to keep your changes nicely arranged at the top of 
the main branch.

Use git show to check the sanity of what you're about to push upstream.

I think you could award yourself a nice cup of tea after an experience 
like that though, having been on both sides of it, I can imagine you 
need it :-P

Regards!
Luke


(*) But note that rebasing can cause problems for people who are 
downstream of _you_. See the  git-rebase(1) man page.
