From: Peter Williams <peter_ono@users.sourceforge.net>
Subject: Re: [HELP] Adding git awareness to the darning patch management system.
Date: Fri, 02 Dec 2011 09:32:50 +1000
Message-ID: <4ED80EA2.80805@users.sourceforge.net>
References: <4ED59232.3000807@users.sourceforge.net> <20111130072248.GG5317@sigill.intra.peff.net> <4ED6D0DB.3060800@users.sourceforge.net> <20111201062733.GB22141@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 02 00:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWG7g-00081W-Dl
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 00:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab1LAXcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 18:32:55 -0500
Received: from nskntmtas05p.mx.bigpond.com ([61.9.168.149]:56363 "EHLO
	nskntmtas05p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754210Ab1LAXcy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 18:32:54 -0500
Received: from nskntotgx01p.mx.bigpond.com ([60.231.88.110])
          by nskntmtas05p.mx.bigpond.com with ESMTP
          id <20111201233252.LMBG23624.nskntmtas05p.mx.bigpond.com@nskntotgx01p.mx.bigpond.com>;
          Thu, 1 Dec 2011 23:32:52 +0000
Received: from mudlark.pw.nest ([60.231.88.110])
          by nskntotgx01p.mx.bigpond.com with ESMTP
          id <20111201233251.BSYQ23205.nskntotgx01p.mx.bigpond.com@mudlark.pw.nest>;
          Thu, 1 Dec 2011 23:32:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
In-Reply-To: <20111201062733.GB22141@sigill.intra.peff.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at nskntotgx01p.mx.bigpond.com from [60.231.88.110] using ID pwil3058@bigpond.net.au at Thu, 1 Dec 2011 23:32:50 +0000
X-SIH-MSG-ID: qBozGdTuHEetmGd63m2VY14jglO69W91tNsMCpZ0rxoGTkXCp8nWXcuic7Mlmcv2oGsfJgqELmMjaa/mV4rTotuwIL1r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186197>

On 01/12/11 16:27, Jeff King wrote:
> On Thu, Dec 01, 2011 at 10:56:59AM +1000, Peter Williams wrote:
>
>>> I'm not exactly sure what this means.
>>
>> If you look at the screenshots at sourceforge (which were produced on
>> top of a Mercurial repo) you'll notice that file names in the left
>> most tree have letters in front of them and appear in different
>> foreground colours.  These letters are the same as those returned by
>> Mercurial's status command and, hence, give a Mercurial user an easy
>> to understand snapshot of the status of the files in the playground.
>> The colour coding is (relatively) arbitrary (and chosen by me) and is
>> intended to make it easier to detect the different file statuses.
>>
>> My main problem is that I can't find a git file status command (and
>> there are a lot of them to choose from) that gives a snapshot of the
>> statuses of all files in a directory (including those not tracked or
>> ignored).
>
> Thanks, that helps. You probably just want to use "git status
> --porcelain", which will show you the state of file modification with
> respect to the index and the prior commit, as well as any untracked
> files. See the "porcelain format" section in "git help status".
>
> Note that "git status" will not print files which are not modified. You
> may want to also run "git ls-files" to get the full listing of files,
> including unmodified ones.
>
>> A secondary problem is that, if I could cobble together statuses from
>> various commands, mapping git statuses to the Mercurial ones for
>> display would not be a good solution as they would not necessarily
>> make sense to a git user.  (It's fairly clear to me from my inability
>> to make sense of git's CLI that git users think differently to me, a
>> Mercurial user, and it's unlikely that I can, without help, make a
>> file tree display that makes sense to a git user.)
>
> I'm hoping that "git status --porcelain" will give you a fairly close
> mapping of the basic "what happened to this file" concept, based on what
> I see in the second screenshot you mentioned.
>
> The trickiest thing is the index, which represents an in-between state
> that is not usually exposed by other version control systems. If your
> tool does not make use of the index, then it probably makes sense to
> just consider a path as modified if it has modifications staged in the
> index or in the working tree, which maps to other VCS's idea of
> "modified" (because for them, marking something as to-be-committed and
> commiting it are part of the same step).

Yes, I think your right.  For most of my purposes, I think that it's 
irrelevant whether a change is staged or not and the choices that I 
offer allow the user to do what he thinks is right for a file with 
changes that are staged but uncommitted.  For me to automatically do 
something based on whether the file was staged for a commit would be a 
mistake as I would be reducing the user's options.

However, the distinction might be worth making in the file tree display 
to remind the user what's staged and what's not?

>
>>> For this, you probably want "git diff-files --name-only", which will
>>> show files with differences in the working tree. Keep in mind that git
>>> has an "index" or "staging area", which means that you have three states
>>> of content for a given path:
>>>
>>>    1. the state of the prior commit (i.e., HEAD)
>>>
>>>    2. the state that is marked to be committed when "git commit" is run
>>>       (i.e., the index)
>>>
>>>    3. the state in the working tree
>>
>> This is a prime example of the different mindset of the git user to
>> the hg user.
>
> You don't have to use those features, of course. It's just that
> something like "git status" is going to report on the differences
> between those states, so as a tool writer you need to know they are
> there (and as I said above, you are free to simplify if it fits into the
> mental model of your tool).
>
>>> You can compare the first two with "git diff-index", and the latter two
>>> with "git diff-files". You can also use "git status --porcelain" to get
>>> a machine-readable output that shows how the three states match up, with
>>> one line per file.
>>
>> This is an example of why I'm confused.  There are too many ways to
>> do (similar) things and it's hard to know which to use.
>
> Git is made of little building blocks. The original way to see the
> differences between the index and the working tree was via diff-files.
> But then people build bigger building blocks out of the smaller ones.
> "git status" is really just a shorthand for:
>
>    git diff-index HEAD&&
>    git diff-files&&
>    git ls-files -o
>
> and is in fact implemented using those building blocks (originally as a
> shell script, though these days it is written in C). So you can choose
> either and get the same information. Choosing a higher-level building
> block may save you some work, if the abstraction matches what you want.
> Otherwise, you can compose what you want from the lower levels.
>
> I know it sometimes leads to an overwhelming number of commands, and I'm
> not trying to excuse git's tendency to confuse people. I'm just hoping
> to unconfuse you in this particular situation.

As an aside, I found it easier to delve into git's innards to find out 
how to implement git binary patches than I did finding out how to do 
things from the CLI :-).

>
> In your case, I think "status" is the most convenient level of
> abstraction for you, because you are interesting in looking at
> differences to both the index and HEAD (i.e., the prior commit). But if
> you find as you implement that want more flexibility, you can switch to
> using the lower-level commands yourself.

I'll investigate this approach.  How easy is it to distinguish low level 
commands from high level commands?

>
>> Maybe an example of why I think the feature is useful might help.
>> Say that you start editing a file and then decide that you want to
>> put this change into a patch rather than committing it.  If you were
>> using quilt you would have to do this manually by any of a number or
>> ways such as:
>>
>> $<git diff command>  file>  temp.patch
>> $<git revert command>  file
>> $ quilt new one.patch
>> $ quilt add file
>> $ patch -p1 file<  temp.patch
>> $ rm temp.patch
>>
>> In darning, you just do:
>>
>> $ darn new one.patch
>> $ darn add --absorb file
>
> Sure. We have stgit and topgit, which do similar patch management things
> on top of git. I don't personally user either, though, so I don't have
> much to say on how they compare to darning, or whether it is worth
> looking at their implementations.

And there's MQ on top of hg.  I find the idea of doing "temporary" 
commits (which is what these tools are essentially doing) a little risky 
(e.g. what happens if you do a push with temporary commits in place). 
With MQ, I use its hook system to prevent this happening and I imagine 
git provides something similar.

Of course, these tools have the advantage that it's easier to promote a 
patch to a full blown commit than it is for quilt or darning in its 
current form (I'm thinking about how to do this).  At this stage, 
darning is targeted at the user who has to maintain a set of patches on 
top of a third party source tree without the need to eventually commit 
the changes themselves (i.e. distribution managers).

I've never used stgit or topgit but I have used both quilt and MQ a lot. 
  I find them both quite usable but each with their own set of 
advantages and disadvantages hence my attempt to make a tool as much 
like them as possible but with a smaller set of disadvantages.

>
>> The interface to the SCM to support this is two functions:
>>
>> 1: get_files_with_uncommitted_changes() which called with no
>> arguments returns a list of the paths of all files with uncommitted
>> changes or when given a list of file paths (the more common case)
>> returns the subset of that list which have uncommitted changes; and
>
> "status" will do this for you, modulo the simplification of the concept
> of the index, as we discussed above.
>
>> 2. copy_clean_version_to(filepath, target_path) which makes a copy of
>> the file as recorded in the prior commit and places it at the
>> target_path (usually where darning stores the "original" for
>> reference when creating diffs).
>
> You probably want:
>
>    git cat-file blob HEAD:filepath>target_path
>

I think I might do this in two stages.  First, just do the bit about 
adding files and pushing (as that is the most useful) and leave the file 
tree as a vanilla tree for the time being (as it looks like it may be 
more complicated).


Thanks for your help,
Peter
