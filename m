X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 09:46:05 +0000
Message-ID: <455055DD.2090903@shadowen.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <45503553.3020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 09:46:26 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <45503553.3020605@gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31058>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhNX7-0001KJ-9g for gcvg-git@gmane.org; Tue, 07 Nov
 2006 10:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753328AbWKGJqO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 04:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbWKGJqO
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 04:46:14 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:7182 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1753328AbWKGJqN
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 04:46:13 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GhNWK-0008I5-Je; Tue, 07 Nov 2006 09:45:28 +0000
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:
> Linus Torvalds wrote:
>>
>> On Mon, 6 Nov 2006, Liu Yubao wrote:
>>> Then, what bad *logical* problem will happen if a merging that is
>>> really a
>>> fast forwarding creates a new commit?
>>
>> You MUST NOT do that.
>>
>> If a fast-forward were to do a "merge commit", you'd never get into
>> the situation where two people merging each other would really ever
>> get a stable result. They'd just keep doing merge commits on top of
>> each other.
> They can stop merging a fake commit with a real commit that point to same
> tree object, here they reach a stable result: we have same tree content.
>>
>> Git tracks history, not "your view of history". Trying to track "your
>> view" is fundamentally wrong, because "your wiew" automatically means
>> that the project history would not be distributed any more - it would
>> be centralized around what _you_ think happened. That is not a
>> sensible thing to have in a distributed system.
> It's not my view, it's branch scope view, I can see how a branch evolves
> relatively independently. In git, branch scope view is more or less
> neglected.
> After fast forwarding merge, I can' tell where a branch come from -- I mean
> the track of a branch.
> 
> If Junio publishes his reflog, I don't see what conflict will happen
> between
> his local view (but now public, and naming it branch scope view seems more
> sensible) and git's global view.
> 
> If this won't lead to problems, it seems also ok to use fake commit for
> fast forwarding style merge, so we can follow HEAD^1 to travel through a
> branch without reflog.
> 
> I hope I have expressed my thought clearly.
>>
>> For example, the way to break the "infinite merges" problem above is
>> to say that _you_ would be special, and you would do a "fast-forward
>> commit", and the other side would always just fast-forward without a
>> commit. But that is very fundamentally against the whole point of
>> being distributed. Now you're special.
> No one is special as everybody can create fake commit, any branch (almost
> a tag) will never be overwritten to point to a commit object in
> another branch, branches are relatively independent, that's to say
> 'git log' will reflect what has happened really in current branch (a CVS
> semantical branch, not only a tag that always points to a tip commit).
>>
>> In fact, even for "you", it would be horrible - because you personally
>> might have 5 different repositories on five different machines. You'd
>> have to select _which_ machine you want to track. That's simply
>> insane. It's a totally broken model. (You can even get the same
>> situation with just _one_ repository, by just having five different
>> branches - you have to decide which one is the "main" branch).
> What's the mean of upstream branch then? I have to know I should track
> Junio's public repository.
> 
> When does one say two branches reach a common point? have same commit(must
> point to same tree) or have same tree(maybe a fake commit and a real
> commit)?
> I think git takes the first way.
> 
> Fast forwarding style merge tends to *automatically* centralize many
> branches,  in CVS people merge two branches and drop side branch to
> centralize them, they all have central semantics.
> (I don't want to get flame war between CVS/SVN and GIT, I think
> git is better than them really:-)
>>
>> Besides, doing an empty commit like that ("I fast forwarded")
>> literally doesn't add any true history information. It literally views
>> history not as history of the _project_, but as the history of just
>> one of the repositories. And that's wrong.
> Something like 'git log --follow-all-parent' can show history of the
> project
> as 'git log' does now.
>>
>> So just get used to it. You MUST NOT do what you want to do. It's stupid.
> Yes, I have understood the git way and am getting used to it, I like
> its simple but powerful design and great efficiency, thank all for your
> good work!
>>
>> If you want to track the history of one particular local branch, use
>> the "reflog" thing. It allows you to see what one of your local
>> branches contained at any particular time.
>>
>> See
>>
>>     [core]
>>         logAllRefUpdates = true
>>
> Thanks, it's a pity I can't pull Junio's reflog :-(

One thing to remember, when you merge the destination into which you
merge will be HEAD^1, so by just following that you can get junio's view
of his branch as he made it.

This is doesn't terminate properly, sucks the performance of your
machine and generally should be erased rather than run; but you get the
idea:

let n=0
while git-show --pretty=one -s "next~$n"
do
        let "n=$n+1"
done | less

