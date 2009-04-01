From: Andreas Ericsson <ae@op5.se>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:29:22 +0200
Message-ID: <49D317D2.8030403@op5.se>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <m3fxgz2h2n.fsf@localhost.localdomain> <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:31:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Louux-0003N4-5M
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbZDAH33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbZDAH33
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:29:29 -0400
Received: from mail.op5.se ([193.201.96.20]:60045 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbZDAH32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 03:29:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9A2551B80F21;
	Wed,  1 Apr 2009 09:06:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id selQw3K4Ysh9; Wed,  1 Apr 2009 09:06:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id EB4211B80F1A;
	Wed,  1 Apr 2009 09:06:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115344>

Ulrich Windl wrote:
> On 27 Mar 2009 at 7:09, Jakub Narebski wrote:
> 
>> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
>>> On 27 Mar 2009 at 13:49, Michael J Gruber wrote: 
>>>> Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
>>> [...]
>>>
>>>> Keyword substitution and cvs/svn style version numbers are independent
>>>> issues. The sha1 describes a commit uniquely, one could use that as a
>>>> keyword.
>>> However version numbers and time stamps have the property of being at least 
>>> partially ordered in respect of "newer/older". That property does not hold for 
>>> SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft 
>>> Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft 
>>> Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)
>> That is why people use output of git-describe and _tag_ their releases,
>> and make embedding version number in released version (tarball / binary)
>> the job of make: see GIT-VERSION-GEN script in git sources, and how it
>> is used in Makefile.
> 
> OK, but imaginge someone sends you some file that originated from some git 
> version, maybe with minor modifications. Is there a way to find out from what git 
> version that file was derived? IMHO that's where "automatically replaced 
> placeholders" (like $id$) make sense.
> 

Actually, that's where communication makes sense. With the CVS style keywords,
that file could have come from 1.3.7, or 2.9.1 (if it hasn't changed), and
the bug the changes are fixing might be in some other file entirely (such as
a header file on some particular system, but the offending call could well
be made in some other file).

If they build from the version control system, they're most likely quite
competent enough in finding the version number of the project they're using.
If they're building from sources, you can easily put the version number of
the project in every source-file you have with just a simple sed script.
Git makes that quite easy for you. Consider something like this:

--8<--8<-- release.sh --8<--8<--
#!/bin/sh
project=foo
latest_tag=$(git describe --abbrev=0)
version=$(echo tag | sed 's/^v//')
git archive --format=tar $latest_tag --prefix=$project-$version/ | \
	sed s/@@VERSION@@/$version/ | \
	gzip -9 > $project-$version.tar.gz
--8<--8<--8<--8<--

Now, if you put @@VERSION@@ as the keyword in all the source-files, all
the files released as anything but a clone of your version control system
will have a version tag that marks the version of your *project* rather
than some arbitrary number indicating how many times that particular file
has been changed over the course of your project.

I know which I prefer.

>>>> Increasing version numbers are meaningless in a true DVCS world. What is
>>>> your 100th commit may not be someone else's, even if both your master's
>>>> heads are the same! This is why hg version numbers are a local thing.
>>>> They are merely a local shortcut for specifying a revision and serve the
>>>> same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
>>>> work permanently, not even in a local repo, if you allow rebasing.
>>> Maybe I didn't fully understand, but having a version number that is larger than 
>>> any parent's version numbers when doing a merge/commit doesn't look wrong to me.
>> I'm sorry to dissapoint you, but without central server assigning
>> numbers to commits it wouldn't simply work in distributed version
>> control world.  Take for example the following situation: somebody
>> clones your repository, and creates new commit on 'master' (trunk) and
>> it gets version number N.  Meanwhile you also independently create new
>> commit on 'master'... and without central authority it would also get
>> version number N.  Then you would merge (pull) his/her changes, and
>> you would have two commits with the same number; not something you want.
> 
> Anyway the result would have number "N+1". Maybe you misunderstood: I'm not 
> proposing to replace git's internal version numbering (SHA-1), but so introduce 
> some more comprehensible, primitive user-level numbering.
> 

It's been discussed to death and noone has been able to solve all the corner
cases. If you do, feel free to send the patches. In my experience though, the
git notation (HEAD~3) is totally superior to any made-up version numbers.
This is because in 99% of the cases where you're referring to anything but
"latest", you're either interested in some stable release (which should be
tagged, so you get to pick whatever version number you want) for diffing
purposes, or you want a *range* of commits (to send as patches, or to give
as an indication of "I think something happened somewhere here"), and the
backward count notation of git fits that mindset a whole lot better than
having numbers that increment from the start, and therefore quickly become
as unwieldy as the SHA1's for the human brain.

>> Not to mention that you can have multiple roots (multiple commits with
>> no parent) in git repository; besides independent branches (like
>> 'man', 'html' or 'todo') it is usually result of absorbing or
>> subtree-merging other projects.  In 'master' branch there are 5 roots
>> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
>> and subtree-merged gitk and git-gui.  And here you would again have
>> multiple commits with the same number...
> 
> Which would not harm, because it would be version N from committer X. Any if 
> committer X merges from anything else, the next number would be > N. I did not 
> claim that my method makes a total ordering of commits and merges possible.
> 
> I truly believe in unique IDs, but they are just not handy in every situation.
> 

What do they solve that the HEAD~3 syntax does not?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
