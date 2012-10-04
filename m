From: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Thu, 04 Oct 2012 10:56:04 +0200
Message-ID: <k4jiv4$5k9$1@ger.gmane.org>
References: <k4hj91$4tt$4@ger.gmane.org> <m2bogja46v.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 03:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJwkI-0001Jn-85
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 03:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab2JEBaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 21:30:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:41155 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab2JEBaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 21:30:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TJwjw-0000xo-32
	for git@vger.kernel.org; Fri, 05 Oct 2012 03:30:08 +0200
Received: from 99.1-241-81.adsl-dyn.isp.belgacom.be ([81.241.1.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:30:07 +0200
Received: from ge0ffrey.spam by 99.1-241-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:30:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 99.1-241-81.adsl-dyn.isp.belgacom.be
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <m2bogja46v.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207061>


Op 03-10-12 18:52, Andreas Schwab schreef:
> Geoffrey De Smet <ge0ffrey.spam@gmail.com> writes:
>
>> Suppose this case:
>>
>> git clone .../blessedRepo.git
>> // do changes
>> git commit -m"bad1"
>> // do changes
>> git commit -m"bad2"
>> git reset --hard HEAD^4 // Why does it let me do this?
> Because there is nothing wrong with that.
>
>> // I just "broke" my local repository, because if I continue
> No you didn't.
>
>> // do changes
>> git commit -m"good1"
>> git push origin master // fails because the history disrespects the remote
>> repo's history
> You may just as well want to push it to a different branch (or even a
> different repository).
In most cases (probably more than 90%?), the developer will want to get 
his changes into the remote branch where it came from.

What do you think of the -respectRepository flag idea? If you want to 
push to different branches/repo's you can not use it, turn it off or 
-force those commands.

A remote repository can be optionally flagged with -respectRepository.
That means that git should prevent the user from making local changes in 
the history that will prevent a normal push to that remote repository.

If a remote repository is flagged as such, git keeps track of a 
"pointOfNoReset" commit:
Every time a branch merges or rebases with a remote repository, it's 
flags the last commit of that remote repository as the pointOfNoReset 
commit.
If local branches merge or rebase with a local branch, the 
pointOfNoReset commit is transitively applied (only the last one wins).
git reset will fail to reset beyond the pointOfNoReset commit, unless 
forced.
git rebase and other git commands will also fail accordingly, unless forced.

>
> Andreas.
>
