X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 19:57:38 +0100
Message-ID: <456F29A2.1050205@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:15:31 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061130170625.GH18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32870>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3Y5-0004GG-IA for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967518AbWLAIPF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967519AbWLAIPF
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:15:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54405 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S967518AbWLAIPE (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:15:04 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 50F586BCC2; Fri,  1 Dec 2006 09:15:02 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Wed, Nov 29, 2006 at 08:00:22PM +0000, Andy Parkins wrote:
>> On Wednesday 2006, November 29 16:03, Martin Waitz wrote:
>>
>> Further, how is the supermodule index going to represent working
>> directory changes in the submodule?  The only link between the two is
>> a commit hash.  It has to be like that otherwise you haven't made a
>> supermodule-submodule, you've just made one super-repository.  Also,
>> if you don't store submodule commit hashes, then there is no way to
>> guarantee that you're going to be able get back the state of the
>> submodule again.
> 
> This is handled in the next paragraph.
> The argument really is: HEAD always points to the checked out branch,
> so it really has a relationship to the working directory.
> 
>>> Contra HEAD:
>>>  - HEAD is not garanteed to be equal to the working directory anyway,
>>>    you may have uncommitted changes.
>> That's the case for every file in a repository, so isn't really a
>> worry.  It's the equivalent of changing a file and not updating the
>> index - who cares?  As long as update-index tells you that the
>> submodule is dirty and what to do to clean it, everything is great.
> 
> Yes, it's not a real counter-argument, but it relativates the previous
> pro-argument.
> 
>>>  - when updating the supermodule, you have to take care that your
>>>    submodules are on the right branch.
>>>    You might for example have some testing-throwawy branch in one
>>>    submodule and don't want to merge it with other changes yet.
>> What is the "right" branch though?  As I said above, if you're tracking one 
>> branch in the submodule then you've effectively locked that submodule to that 
>> branch for all supermodule uses.
> 
> yes, but luckily GIT branches are very flexible.
> 

There's no real technical reason for locking it to a single branch 
though, and in case of a fork in the upstream submodule project, you 
might suddenly decide that "the other team" is heading in a much more 
interesting direction and you want to use their work in your module 
instead. Will you now have to maintain a separate branch just to keep 
the same name as the branch the original team used?

>> Or you've made yourself a big rod to beat yourself with everytime you
>> want to do some development on an "off" branch on the submodule.
> 
> I don't think it is that bad.
> 

It could be, and as has already been stated, there's no real reason to 
limit this to a particular branch, so I don't see why we would want to 
impose such non-real restrictions.

>>> Pro refs/heads/master:
>>>  - the supermodule really tracks one defined branch of development.
>> Why is this a pro?
> 
> You always know which branch in the submodule is the "upstream" branch
> which is managed by the supermodule.

No you don't. The branch-name might be moved to some other tip of the 
DAG, and that's exactly the same as changing the branch you're tracking.

> You can easily have several topic-branches and merge updates from the
> master branch.
> otherwise you always have to remember which branch holds your current
> contents from the supermodule.
> 

No you don't. The only thing you need is the commit-sha.

> When viewed from the supermodule, you are storing one branch per
> submodule in your tree.
> 

Wrong again. You're storing one particular point in the revision history.

>>>  - you can easily overwrite one submodule by changing to another branch,
>>>    without fearing that changes in the supermodule change anything
>>>    there.
>> You can always do that anyway by simply not running update-index for the 
>> submodule in the supermodule.
> 
> Suppose you are working on a complicated feature in one submodule.
> You create your own branch for that feature and work on it.
> Now you want to update your project, so you pull a new supermodule
> version. Now this pull also included one (for you unimportant) change
> in the submodule.

git reset to the rescue.

> I think it is more clear to update the master branch with the new
> version coming from the supermodule, while leaving your work intact
> (you haven't commited it to the supermodule yet, so the supermodule
> should not care about your changes, it's just some dirty tree).
> Then you can freely merge between your branch and master as you like and
> are not forced to merge at once. And perhaps you even do not want to
> merge at all, because you are on an experimental branch which really is
> mutually exclusive with the current supermodule contents.
> 

This is all just policy though. Tools that enforce a certain policy are 
not good tools.

The only problem I'm seeing atm is that the supermodule somehow has to 
mark whatever commits it's using from the submodule inside the submodule 
repo so that they effectively become un-prunable, otherwise the 
supermodule may some day find itself with a history that it can't restore.

The really major problem with this is that now you'll have one 
repository of the submodule that is actually special, so it's not 
certain you can go and use any repository at all of the submodule code, 
since the upstream repo most likely won't be all that interested in 
having all of that meta-data inside it. In reality, I'm sure this will 
be a small problem though, as submodules that are in reality projects 
which the supermodule's maintainer isn't the owner of will most likely 
never rewind their history beyond the supermodules stored commit. It's 
something fsck will have to be taught to watch for though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
