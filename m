From: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Wed, 03 Oct 2012 17:12:34 +0200
Message-ID: <k4hkl1$jag$1@ger.gmane.org>
References: <k4hj91$4tt$4@ger.gmane.org> <CALkWK0mP36OXZ7kXZnA-KH3HB2mCLJuvx6iX2=LQawSCgM-ujA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 17:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQeE-0006uz-4l
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 17:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503Ab2JCPNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 11:13:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:37831 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932497Ab2JCPNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 11:13:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TJQdW-00021s-Ig
	for git@vger.kernel.org; Wed, 03 Oct 2012 17:13:22 +0200
Received: from 99.1-241-81.adsl-dyn.isp.belgacom.be ([81.241.1.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 17:13:22 +0200
Received: from ge0ffrey.spam by 99.1-241-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 17:13:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 99.1-241-81.adsl-dyn.isp.belgacom.be
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CALkWK0mP36OXZ7kXZnA-KH3HB2mCLJuvx6iX2=LQawSCgM-ujA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206906>


Op 03-10-12 16:59, Ramkumar Ramachandra schreef:
> Hi Geoffrey,
>
> Geoffrey De Smet wrote:
>> [...]
>> The following commands are ok to do (because I have 2 unpushed commits):
>>   git reset --hard^1
>>   git reset --hard^2
>> but these are not and should be prevented (unless forced):
>>   git reset --hard^3
>>   git reset --hard^4
>>
>>
>> Is there any way to make git idiot proof by enabling that the local repo
>> should always respect the history of the remote repo (unless forced)?
>> Is there any way to make this a default for anyone who clones our 
>> blessed
>> repo?
>> No one that clones our blessed repo wants to come into the situation 
>> above.
>> And if they do, they can always force it.
> This makes little sense.
> Which remote?
To all remotes which have a relationship to this repo with the 
-respectRemote flag.
Normally, only the blessed remote will have this.
> What if I have multiple remotes?  Which branch? (Many
> of my branches are behind `master`).
Everytime a branch merges or rebases with a remote repository, it's 
flags the last commit of that remote repository as the pointOfNoReset 
commit.
If local branches merge or rebase with a local branch, the 
pointOfNoReset commit is transitively applied (only the last one wins).
git reset will fail to reset beyond the pointOfNoReset commit, unless 
forced.

Branches that are behind master, will have a pointOfNoReset commit in 
their history, if master goes forward afterwards, that won't affect 
those branches, not until they are merged.
>    What if I want different
> histories on different remotes?
Don't use the -respectRemote flag in the relationship between those 2 
repo's.
>   What about more advanced operations
> which implicitly 'reset' like rebase?
Them too. All operations would need to follow the -respectRemote flag's 
limitations, unless forced.
>    What if I want to rewrite
> history?
Don't use the -respectRemote flag in the relationship between this repo 
and any other repo.
Or force it.
>
> Ram
