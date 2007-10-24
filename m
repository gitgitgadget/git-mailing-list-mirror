From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Wed, 24 Oct 2007 22:13:05 +0200
Message-ID: <471FA751.4000603@op5.se>
References: <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikmbm-00063c-Q4
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbXJXUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbXJXUNM
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:13:12 -0400
Received: from mail.op5.se ([193.201.96.20]:40037 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbXJXUNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:13:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2E8421730694;
	Wed, 24 Oct 2007 22:12:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znxBAozQpeHn; Wed, 24 Oct 2007 22:12:53 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 20192173066A;
	Wed, 24 Oct 2007 22:12:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071024194849.GH29830@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62233>

J. Bruce Fields wrote:
> On Wed, Oct 24, 2007 at 09:41:05PM +0200, Andreas Ericsson wrote:
>> J. Bruce Fields wrote:
>>> On Wed, Oct 24, 2007 at 08:48:54PM +0200, Steffen Prohaska wrote:
>>>> The central shared repo is called project-shared.git and contains,
>>>> for example, the following branches:
>>>>    master
>>>>    next
>>>>    work/topicA
>>>>    work/topicB
>>>>    ...
>>>>
>>>>
>>>> Developers clone the repo and check out the branches they are
>>>> interested in. For example a developer may want to track next
>>>> and work on topicB:
>>>>
>>>>    git clone ssh://central.example.com/project-shared.git project
>>>>    cd project
>>>>    git checkout -b next origin/next
>>>>    git checkout -b work/topicB origin/work/topicB
>>>>
>>>> This is sufficient. No adding of remotes is needed. Neither
>>>> is a private repository on a server required. After cloning,
>>>> developers have all they need.
>>>>
>>>> Later work/topicB has new commits and should be pushed:
>>>>
>>>>    git push origin
>>>>
>>>> The default behaviour of push is fine. Only matching branches
>>>> are pushed.
>>>>
>>>> _But_, origin is a shared repository. Therefore branches may
>>>> have advanced and git push may report
>>>>
>>>> error: remote 'refs/heads/next' is not a strict subset of local ref 
>>>> 'refs/heads/next'. maybe you are not up-to-date and need to pull first?
>>>>
>>>> So here's the problem. The developer didn't do anything wrong.
>>>> But git complaints with an error. Git also recommends to run
>>>> pull, so the developer runs "git pull". But this doesn't help,
>>>> because it's only updating work/topicB and "git push" will
>>>> complain with the very same error.
>>>>
>>>> What you need to do is
>>>>
>>>>    git checkout <local-branch>
>>>>    git pull
>>>>    git checkout <local-branch2>
>>>>    git pull
>>>>    ...
>>>>
>>>> for every local branch.
>>> Or just
>>> 	git push origin work/topicB
>>> since that's all you really wanted to push anyway.
>> git pull. Not git push. git pull operates on one working branch
>> at a time (by default), whereas git push uploads and fast-forwards
>> all the common branches (by default).
> 
> I understand.  I was just suggesting that if the goal was to avoid the
> error message on push, then specifying the branch to push explicitly
> would be a solution.
> 

A better way to avoid that error message is ofcourse to make sure one
always starts development off of the latest version of the particular
branch one wants to work on.

>> I want git pull to work like git push.
> 
> That strikes me as a less complete solution, since it only helps in the
> case where the other branches all happen to be unmodified locally (hence
> can be fast-forwarded).

For a corporate environment with multiple modules, the scenario where the
upstream is modified and the local branches aren't is more common than
anything else. The failure on push happens because developers do

git pull; # Yup, gotta do that to get the latest changes
git checkout whatever; # Here's where I want to work
work work work
git push; # ach crivens! bloody stupid git of a tool to ALWAYS BREAK!

>  In other cases the "git push" will still emit a
> spurious error.
> 

If the tool can make it happen as few times as possible, that's good
enough for me. It's a lot easier to explain to my co-workers that
their push failed because someone else worked on it simultaneously
and pushed before they did, rather than telling them that they did
the pull/checkout sequence in the wrong order.

In the one scenario, it's "oh, I see". In the other, it's "god damn
piece of shit tool". Simple as that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
