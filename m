From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 15:55:29 -0500
Message-ID: <49C948C1.2070404@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <alpine.LFD.2.00.0903232056520.26337@xanadu.home> <49C91F87.3050105@brainfood.com> <alpine.LFD.2.00.0903241404080.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:58:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmDhd-0005gN-Hb
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 21:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZCXUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 16:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZCXUzi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 16:55:38 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:60742 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbZCXUzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 16:55:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id 77017F88A9;
	Tue, 24 Mar 2009 15:55:34 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id df9AUiycmS+a; Tue, 24 Mar 2009 15:55:30 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id ACA41F8868;
	Tue, 24 Mar 2009 15:55:29 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.LFD.2.00.0903241404080.26337@xanadu.home>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114489>

Nicolas Pitre wrote:
> Because it is way more complex for git to do that than for ssh to keep 
> the connection alive.  And normally there is no need as git is supposed 
> to be faster than that.

Sure, I'll buy that.

>>>> So, to work around that, I ran git gc.  When done, I discovered that
>>>> git repacked the *entire* repository.  While not something I care for,
>>>> I can understand that, and live with it.  It just took *hours* to do so.
>>>>
>>>> Then, what really annoys me, is that when I finally did the push, it
>>>> tried sending the single 27G pack file, when the remote already had
>>>> 25G of the repository in several different packs(the site was an
>>>> hg->git conversion).  This part is just unacceptable.
>>> This shouldn't happen either.  When pushing, git reconstruct a pack with 
>>> only the necessary objects to transmit.  Are you sure it was really 
>>> trying to send a 27G pack?
>> Of course I'm sure.  I wouldn't have sent the email if it didn't
>> happen.  And, I have the bandwidthd graph and lost time to prove it.
> 
> As much as I would like to believe you, this doesn't help fixing the 
> problem if you don't provide more information about this.  For example, 
> the output from git during the whole operation might give us the 
> beginning of a clue.  Otherwise, all I can tell you is that such thing 
> is not supposed to happen.

First off, you've put a bad tone on this.  It appears that you are
saying I'm mistaken, and it didn't send all that data.  "It can't
happen, so it didn't happen."  Believe me, if it hadn't resent all
this data, I wouldn't have even sent the email.

In any event, we got lucky.  I *do* have a log of the push side of
this problem.  I doubt it's enough to figure out the actual cause tho.

==
ofbiz@lnxwww10:/job/@anon-site@> git push bf-yum
Counting objects: 96637, done.

Compressing objects:   6% (2413/34478)   478)
Read from remote host @anon-site-dev@.brainfood.com: Connection reset
by peer
Compressing objects:  27% (9458/34478)

Compressing objects: 100% (34478/34478), done.
error: pack-objects died with strange error
error: failed to push some refs to 'ssh://bf-yum/@anon-site@'
ofbiz@lnxwww10:/job/@anon-site@>
ofbiz@lnxwww10:/job/@anon-site@>
ofbiz@lnxwww10:/job/@anon-site@>
ofbiz@lnxwww10:/job/@anon-site@> git push bf-yum
Counting objects: 96637, done.
Killed by signal 2.:   5% (1866/34478)

ofbiz@lnxwww10:/job/@anon-site@> git gc
Counting objects: 96637, done.
Compressing objects:  27% (9453/34478)

Compressing objects: 100% (34478/34478), done.
Writing objects: 100% (96637/96637), done.
Total 96637 (delta 48713), reused 88929 (delta 43905)
Removing duplicate objects: 100% (256/256), done.
ofbiz@lnxwww10:/job/@anon-site@>
ofbiz@lnxwww10:/job/@anon-site@>
ofbiz@lnxwww10:/job/@anon-site@> du .git -sc
26797788        .git
26797788        total
ofbiz@lnxwww10:/job/@anon-site@> git push bf-yum
Counting objects: 96637, done.
Compressing objects: 100% (29670/29670), done.
Writing objects: 100% (96637/96637), 25.49 GiB | 226 KiB/s, done.
Total 96637 (delta 48713), reused 96637 (delta 48713)
To ssh://bf-yum/@anon-site@
 * [new branch]      master -> lnxwww10
==
ofbiz@lnxwww10:/job/@anon-site@> ls .git/objects/pack/ -l
total 26762436
-r--r--r-- 1 ofbiz users     3452052 2009-03-21 23:11
pack-0d7b399006ae0a57ff3df07fdcaedbaeb7e63d0a.idx
-r--r--r-- 1 ofbiz users 27374508409 2009-03-21 23:11
pack-0d7b399006ae0a57ff3df07fdcaedbaeb7e63d0a.pack
==

I have a bf-yum remote defined, that pushes to the remote branch; once
it gets there, I then do a merge on the target machine.

The 'killed by signal 2' is when I ctrl-c.

The second group was done from another window.  There's only a single
pack file now.

The @anon-site@ stuff is me removing client identifiers.  It's the
only editting I did to the screen log.

> 
>> After I ran git push, ssh timed out, the temp pack that was created
>> was then removed, as git complained about the connection being gone.
> 
> On a push, there is no creation of a temp pack.  It is always produced 
> on the fly and pushed straight via the ssh connection.

No.  I saw a temp file in strace.  It *was* created on the local disk,
and *not* sent on the fly.

>> I then decided to do a 'git gc', which collapsed all the separate
>> packs into one.  This allowed git push to proceed quickly, but at that
>> point, it started sending the entire pack.
> 
> If this was really the case, then this is definitely a bug.  Please take 
> a snapshot of your screen with git messages if this ever happens again.

See above.

> 
>> It's entirely possible that the temp pack created by git push was
>> incremental; it just took too long to create it, so it got aborted.
> 
> The push operation has multiple phases.  You should see "counting 
> objects", "compressing objects" and "writing objects".  Could you give 
> us an approximation of how long each of those phases took?

Well, counting was quick enough.  compression took at *least* 2 hours,
might have been 4 or more.  This all started friday evening.  I was
watching it a bit at the beginning, but then went out, and it died
after I got back to it.

>> I forgot to mention previously, that the source machine was running
>> git 1.5.6.5, and was pushing to 1.5.6.3.
>>
>> I've tried duplicating this problem on a machine with 1.6.1.3, but
>> either I don't fully understand the issue enough to replicate it, or
>> the newer git doesn't have the problem.
> 
> That's possible.  Maybe others on the list might recall possible issues 
> related to this that might have been fixed during that time.

Well, I looked at the release notes between all these versions.
Nothing stands out, but I'm aware that the changelog/release note
entry for some change doesn't always describe the actual bug that
caused the change to occur.

>> Um, if it's missing documentation, then how am I supposed to know
>> about it?
> 
> Asking on the list, like you did.  However this attribute should be 
> documented as well of course.  I even think that someone posted a patch 
> for it a while ago which might have been dropped.

What I'd like, is a way to say a certain pattern of files should only
be deduped, and not deltafied.  This would handle the case of exact
copies, or renames, which would still be a win for us, but generally
when a new video(or doc or pdf) is uploaded, it's alot of work to try
and deltafy, for very little benefit.
