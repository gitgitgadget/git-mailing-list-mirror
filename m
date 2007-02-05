From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What did I just fetch?
Date: Mon, 5 Feb 2007 13:21:15 +0100
Message-ID: <200702051321.17297.jnareb@gmail.com>
References: <17856.37307.324767.617892@lisa.zopyra.com> <epq4nl$ui7$1@sea.gmane.org> <17857.61923.464433.454148@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 13:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE2pD-0000Mo-Ve
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 13:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXBEMT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 07:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXBEMT4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 07:19:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14425 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbXBEMTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 07:19:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1276461uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 04:19:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pa/UhucppWshmbJ7po6H7rgNpz2lq0W/kd+9OEamkY+WrMeVPqLW+re9MQRKSIehwrRsKEnXmaPQDziR4KjZydMY+pzauG5AveYGwfc7Iajxqmkk54mE8iDKcTFkkSZJa4f07xhYFe2ywjS3sfjpie6l8btl8tgks4RoZerfK4A=
Received: by 10.66.244.11 with SMTP id r11mr8683095ugh.1170677993893;
        Mon, 05 Feb 2007 04:19:53 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id m1sm10296939uge.2007.02.05.04.19.52;
        Mon, 05 Feb 2007 04:19:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <17857.61923.464433.454148@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38748>

On 01.02.2007, Bill Lear wrote:
> On Wednesday, January 31, 2007 at 14:15:49 (+0100) Jakub Narebski writes:
>>Bill Lear wrote:
>>
>>> When updating in cvs, I get a list of files changed by the update.
>>> 
>>> How can I do this in git when fetching into a bare repo?
>>> 
>>> % GIT_DIR=. git fetch git://source/project
>>> remote: Generating pack...
>>> remote: Done counting 18 objects.
>>> remote: Result has 10 objects.
>>> remote: Deltifying 10 objects.
>>> remote:  100% (10/10) done
>>> Unpacking 10 objects
>>> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
>>>  100% (10/10) done
>> You should have also something like below:
>> * refs/remotes/origin/master: fast forward to branch 'master' of git://source/project
>>   old..new: 1732a1f..73a2acc
>>
>>> So, I'd like to see the files, perhaps the differences, etc.
>>
>> $ git diff --summary 1732a1f..73a2acc
>> $ git diff --summary ORIG_HEAD..HEAD
> 
> BTW, this is with git 1.4.4.1...
> 
> I don't see the refs/remotes/origin/master line you refer to:

git 1.4.4.1 if I remember correctly didn't use "separate remotes"
configuration by default. Besides, your repo might have been cloned
without separate remotes, and if it is bare repo it probably have
been (and should been) cloned 1:1.

So instead of refs/remotes/origin/master you should see refs/heads/origin
if you are in "live" repo, and refs/heads/master if you are in bare repo.

> %  git --bare fetch git://source/project
> remote: Generating pack...
> remote: Done counting 18 objects.
> remote: Result has 10 objects.
> remote: Deltifying 10 objects.
> remote:  100% (10/10) done
> Unpacking 10 objects
> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)

But the problem here (namely no refs update info) is that you use URL
but provide no refspecs. Git downloads something, but doesn't update
refs because you didn't requested that. This case is usually used _only_
to *pull* (not only fetch) some spurious repo without need for tracking
branch.

If you want to download changes since clone (or last fetch), you should
use "git --bare fetch origin" (or even "git --bare fetch"). Note: with
git 1.4.4.1 this would not pick up _new_ refs.

> And no refs/remotes file:
> 
> % ls refs
> heads  tags

I forgot that bare repos got cloned 1:1, and not using separate remotes
layout. Besides git 1.4.4.1 didn't use separate remotes layout by default,
if I remember correctly.

> I can get a commit id by using -v:
> 
> % git --bare fetch -v git://source/project
> remote: Generating pack...
> remote: Done counting 18 objects.
> remote: Result has 10 objects.
> remote: Deltifying 10 objects.
> remote:  100% (10/10) done
> Unpacking 10 objects
> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
> 
> * fetched git://source/project
>   commit: 89f0bd4

Hmmm... I wonder what you have fetched. Probably remote HEAD.

> And, why do repeated fetches seem to fetch something instead of
> saying "I've got nothing to do, you stupid git!"?

Because even that you download objects, you don't store _references_
to those objects (no refs gets updated because of no refspecs in git-fetch
invocation), besides FETCH_HEAD. And FETCH_HEAD is used by git-pull
only; it looks like it is not considered in checking what you have when
negotiation on fetch.

> Well, I'd just like to see what is in this commit, I guess, then.
> 
> So, I try git cat-file, and notice what looks like an error in
> the usage message:

You should use git-show instead. In 1.5.0-rc3 it can be used
for pretty much anythong git-cat-file was used/

> % git --bare cat-file 89f0bd4
> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
> 
> It seems to indicate the switches and the type are optional (square
> brackets), but it's not doing anything, so it must want one of the
> switches.

Fact. I'm not sure how this usage string should be written...

> % git --bare cat-file commit 89f0bd4
> tree d9421c9d3079dc48a3b3c5938a6a29e1404bd322
> parent 0624063622c793d5812bdf84c909eaf17abf4f2d
> parent 069596712287564e2e6d45207cb5f5b4069ed7ac
> author John Smith <jsmith@myco.com> 1170168752 -0600
> committer John Smith <jsmith@myco.com> 1170168752 -0600
> 
> Merge branch 'master' of ssh+git://source/repos/git/project
> 
> So, then I find git show:
> 
> % git --bare show --pretty=fuller 89f0bd4
> [98 blank lines suppressed!!]
> commit 89f0bd43b21431c70fe22e099b8c0fc11b190b0e
> Merge: 0624063... 0695967...
> Author:     John Smith <jsmith@myco.com>
> AuthorDate: Tue Jan 30 08:52:32 2007 -0600
> Commit:     John Smith <jsmith@myco.com>
> CommitDate: Tue Jan 30 08:52:32 2007 -0600
> 
>     Merge branch 'master' of ssh+git://source/repos/git/project
> 
> So, still no "content" here.  Should I be expecting some?
> 
> And, what does "Merge: 0624063... 0695967..." mean?

It means that it is a merge commit. And merge commits (unless you enable
merge.summary) by default consist only of "Merge branch '<name>' of <repo>"
nessage. Merge commit diff is not shown by default: you have to use --cc
for that (as ordinary diff doesn't work with more than one parent).

-- 
Jakub Narebski
ShadeHawk on #git
Poland
