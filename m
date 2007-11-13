From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 18:16:11 +0100
Message-ID: <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrzMd-00077i-Gw
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689AbXKMRPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbXKMRPF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:15:05 -0500
Received: from mailer.zib.de ([130.73.108.11]:58666 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757689AbXKMRPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:15:01 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lADHEuiH019359;
	Tue, 13 Nov 2007 18:14:56 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lADHEtbO000364
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 13 Nov 2007 18:14:55 +0100 (MET)
In-Reply-To: <200711131703.16357.jnareb@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64813>


On Nov 13, 2007, at 5:03 PM, Jakub Narebski wrote:

> Sergei Organov <osv@javad.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Sergei Organov wrote:
>
>>>> I want to get rid of origin/pu remote tracking branch. What do I  
>>>> do?
>>>> I RTFM git-branch. What does it suggest?
>>>>
>>>> git branch -d -r origin/pu
>>>>
>>>> So far so good. However, it doesn't seem to work in practice:
> [...]
>>>> $ git branch -d -r origin/pu
>>>> Deleted remote branch origin/pu.
>>>> $ git remote show origin
>>>> * remote origin
>>>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>>>   Remote branch(es) merged with 'git pull' while on branch master
>>>>     master
>>>>   New remote branches (next fetch will store in remotes/origin)
>>>>     pu
>>>>   ^^^^^^^^^^^^^^^^^^^ What???
>>>>   Tracked remote branches
>>>>     html maint man master next todo
>>>
>>> Check out what do you have in .git/config file, in the
>>> [remote "origin"] section. Most probably (if you cloned this
>>> repository using new enough git) you have wildcard refspec there,
>>> which means that git would pick all new branches when
>>> fetching / pulling from given repository.
>>
>> Sure, I've cloned git.git using rather recent git, so .git/config  
>> has:
>>
>>       fetch = +refs/heads/*:refs/remotes/origin/*
>
> [...]
>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>> get rid of the remote branch? Currently it seems like a bug  
>> introduced
>> by addition of wildcards refspecs, right?
>
> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
> the '-d' option removes branch locally. It is meant I think to remove
> tracking of branches which were dropped in remote, as I think that
> wildcard refspec does create new branches, but do not delete dropped
> branches.

"git remote prune origin" should be used to clean up stale
remote-tracking branches.

BTW, what's the right name for this type of branch.
I found "tracking branch", "remote tracking branch", and
"remote-tracking branch" in the manual. The glossary only
mentions "tracking branch".  Or is it a "tracked remote branch"
as the output of "git remote show" suggests.  I remember,
there was a lengthy discussion on this issue.  Does someone
remember the conclusion?


> So I'm not sure if it is a bug, misfeature or a feature.

It doesn't make sense to delete remote-tracking branches
locally if they are still present at the remote.  The main
purpose of a remote-tracking branch is to be identical to the
real remote branch.

In my opinion its a misfeature.  "git remote prune" does the
same in a sane way.


	Steffen
