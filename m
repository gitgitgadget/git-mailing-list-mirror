From: Daniel Wagner <wagi@monom.org>
Subject: Re: 'git log' numbering commits?
Date: Thu, 12 Apr 2012 11:15:56 +0200
Message-ID: <4F869D4C.8090108@monom.org>
References: <4F868A24.9090004@monom.org> <20120412084122.GG31122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 11:16:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIG8J-00053i-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 11:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762207Ab2DLJP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 05:15:58 -0400
Received: from hotel311.server4you.de ([85.25.146.15]:37651 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2DLJP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 05:15:57 -0400
Received: from candlejack.bmw-carit.intra (mail.bmw-carit.de [62.245.222.98])
	(Authenticated sender: wagi)
	by hotel311.server4you.de (Postfix) with ESMTPSA id 6A510CBE0A8;
	Thu, 12 Apr 2012 11:15:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120131 Thunderbird/10.0
In-Reply-To: <20120412084122.GG31122@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195323>

Hi Jeff,

On 12.04.2012 10:41, Jeff King wrote:
> On Thu, Apr 12, 2012 at 09:54:12AM +0200, Daniel Wagner wrote:
> 
>> My workflow involves a lot of "git rebase -i". For figuring out which
>> commit id to use I do first a 'git log --oneline'. Then I do copy past
>> the id to the 'git rebase -i'. The reason why I don't use relative
>> id such as HEAD~4, because I keep miscounting the commits.
>>
>> So my question is there a magic option to have git log to enumerate the
>> commits, e.g.
>>
>> 1: 2fcd2b3 network: Remove unused function
>> 2: b376b2a session: Fix introspection for Change()
>> 3: 15c9cd0 wifi: Refactor desctruction of network object
>> 4: a9c699f network: Remove device pointer in network_remove()
> 
> No, there is no such feature. You can do this:
> 
>   git log --oneline | nl "-s: "

Obviously, I tend to forget the power of the pipes :)

> but that will just give you the count of commits shown. If the history
> is not a single line of development, then those numbers will become
> meaningless quickly. Also note that there is an off-by-one in this
> scheme; HEAD~2 will be numbered as "3".
> 
> If you wanted to simply decorate each commit with a more readable name,
> you could do this:
> 
>   git log --format='%H: %s' |
>   git name-rev --stdin --name-only
> 
> though for simplicity, you may find that you prefer to name only based on
> the current tip. You can do that like this:
> 
>   git log --format='%H: %s' |
>   git name-rev --stdin --name-only \
>     --refs `git symbolic-ref HEAD`
> 
> which yields output like:
> 
>   your-topic: network: Remove unused function
>   your-topic~1: session: Fix introspection for Change()
>   your-topic~2: wifi: Refactor desctruction of network object
>   your-topic~3: network: Remove device pointer in network_remove()

Didn't know about name-ref. Very cool :)

> However, if you really just want this to make "rebase -i" easier, have
> you considered setting the upstream branch config for your branches?
> When I create a topic branch, I do:

Maybe I should have mentioned that on those project I am mostly working,
we don't have branches (ConnMan, BlueZ, oFono). So we have a very simple
history.

>   git checkout -b topic origin/master
> 
> And then "git rebase -i @{upstream}" rebases everything up to my
> upstream branch (origin/master). That may be slightly more than I want,
> but it lets me see the whole series in the "rebase -i" sequencer. Recent
> versions of git even default to "@{upstream}", so you can just say "git rebase
> -i".

The main reason I avoided branches is that I have several topics at the
same time and having a single branch and maintaining them by hand was so
far easier.

> How do you usually create your branches? What version of git are you
> using (the "@{upstream}" default is in v1.7.6 and later)?

Normally I only have for big changes branches but for a few independent
fixed I just use the master branch and fix the patches. But I see, I
should over think my workflow here :)

I am using git trunk :) I'll try the @{upstream} trick.

Thanks a lot for this elaborate answer.

cheers,
daniel
