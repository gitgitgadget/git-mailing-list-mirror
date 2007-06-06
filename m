From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: clarify git clone --local --shared --reference
Date: Wed, 06 Jun 2007 13:50:08 -0500
Message-ID: <466701E0.4000108@nrlssc.navy.mil>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil> <20070606051111.GF9513@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw0aO-0008S9-QE
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 20:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763575AbXFFSuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 14:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758843AbXFFSuT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 14:50:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40694 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763575AbXFFSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 14:50:17 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l56Im9L7011172;
	Wed, 6 Jun 2007 13:48:11 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Jun 2007 13:50:08 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070606051111.GF9513@spearce.org>
X-OriginalArrivalTime: 06 Jun 2007 18:50:08.0767 (UTC) FILETIME=[814DB8F0:01C7A86B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15220001
X-TM-AS-Result: : Yes--12.814000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNTA2?=
	=?us-ascii?B?NzMtMTQ3MDE4LTcwMjU3Mi03MDAwNzUtMTM5MDEwLTcwMDE2MC03?=
	=?us-ascii?B?MDQ0OTYtNzExOTUzLTcwMTU3Ni03MDE3MTktNzAxNDU1LTcwNDky?=
	=?us-ascii?B?Ny03MDc0MTAtNzA4MTc5LTcwNjI0OS03MDk1ODQtNzAyNzYyLTcw?=
	=?us-ascii?B?OTEyNy03MDg1NTgtMTA2NDIwLTcwMjcyNi03MDM3ODgtNzA2NTM4?=
	=?us-ascii?B?LTcwOTE4NS03MDIzNTgtNzAyMDQ0LTcwMTM5NC0xODgwMTktNzA0?=
	=?us-ascii?B?NDI1LTcwMTQzNy03MDI0NzQtNzAxNzM4LTcwMTQ2MS03MDAyNzAt?=
	=?us-ascii?B?MTA1NzAwLTcwNDIxNy03MDU5MDEtNzExNDMyLTcwMTAwNS03MDc4?=
	=?us-ascii?B?MDAtNzAwMDQwLTcwNjE1MC03MDExNjMtNzAzMjgzLTcwNjg5MS03?=
	=?us-ascii?B?MDE4MTctMTA1NjMwLTcwMjYyNi0xMDYyMzAtMTIxODI4LTcwMTgz?=
	=?us-ascii?B?Ny03MDA1NzMtNzA3NDY3LTcwNTQ1MC03MDE5MTQtNzAxNTk0LTcw?=
	=?us-ascii?B?MDU0Ni03MDY0NTQtNzA3MzYxLTcwNzc2MC03MDkwNjUtNzAwMTYz?=
	=?us-ascii?B?LTcwMjU1MS03MDEzMDUtMTEzMjI4LTcwNDQyMS0xMDUwNDAtNzA1?=
	=?us-ascii 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49305>

Shawn O. Pearce wrote:
> Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Shawn O. Pearce wrote:
>>>  b) Don't repack the source repository without accounting for the
>>>  refs and reflogs of all --shared repositories that came from it.
>>>  Otherwise you may delete objects that the source repository no
>>>  longer needs, but that one or more of the --shared repositories
>>>  still needs.
>> How should this be accomplished? Does this mean never run 
>> git-gc/git-repack on the source repository? Or is there a way to
>> cause the sharing repositories to copy over objects no longer
>> required by the source repository?
> 
> Well, you can repack, but only if if you account for everything.
> The easiest way to do this is push every branch from the --shared
> repos to the source repository, repack the source repository, then
> you can run `git prune-packed` in the --shared repos to remove
> loose objects that the source repository now has.
> 
> You can account for the refs by hand when you run pack-objects
> by hand, but its horribly difficult compared to the push and then
> repack I just described.  I think that long-lived --shared isn't that
> common of a workflow; most people use --shared for shortterm things.
> For example contrib/continuous uses --shared when it clones the
> repository to create a temporary build area.
>  

ok. I just want to make sure this is not really about prune'ing.

In the following, source and --shared repos are identical except...
1) Source repo contains loose objects which are new commits.
    --shared repo does git-pull.
    we fast-forward, copying very little.
    success.
2) Source repo contains loose objects which are new commits.
    Source repo does git-gc, which repacks but doesn't prune.
    --shared repo does git-pull.
    success?
3) Source repo deletes a branch that --shared repo also has.
    This deletion creates dangling unreferenced objects.
** --shared repo still ok here, right?
    Source repo does git-gc, which repacks but doesn't prune.
** Is --shared screwed at this point? (This is what I understand
      you to say above) Or do the dangling objects still exist,
      so --shared is still ok?
    git gc --prune
    --shared is fubar, at least on the deleted branch.


The docs (git-repack.txt) seem to suggest that git-repack (without -d) 
does not delete any objects. And if -d is used, then at most objects 
already referenced in other packs will be deleted. This makes me think 
that repack is safe on the source repository.

If the above is wrong, then I'm missing a clue about git-rebase. And 
don't feel like you have to explain it to me. Do feel free to give a 
short *NO!! REPACK IS DANGEROUS ON SHARED REPOS YOU IDIOT!!* or other 
such beating. But if you see what I'm misunderstanding please let me know.

If the above is right, then it seems like the source repo developer 
should be able to go about his developing, and git-gc'ing without
regard for other developers who may be --share'ing. And only when the
source developer wants to do a prune of dangling objects must something 
special be done. git-prune.txt suggests:

     git prune $(cd ../another && $(git-rev-parse --all))

> In my day-job repositories I have about 150 MiB of blobs that
> are very common across a number of Git repositories.  I've made a
> single repo that has all of those packed, and then setup that as an
> alternate for everything else.  It saves a huge chunk of disk for us.
> But that common-blob.git thing that I created never gets changed,
> and never gets repacked.  Its sort of a "historical archive" for us.
> Works very nicely.  Alternates have their uses...

Ahh, now that's interesting.

Could I create something like that by doing something like this:

(in a cloned repository with only a master branch)
git reset --hard HEAD^     # I know, HEAD is still in the history
git gc --prune             # log so it doesn't get pruned, but
                            # it's just an example

(now back in my devel repo)
<add archive repo to alternates>
git prune-packed

Now most everything is likely referenced in the archive repo except the 
last commit. Well, maybe even the HEAD commit due to the history log.

Depending on how you reply above, a periodic pull into the archive repo 
(and a repack?), then a 'git prune-packed' from the sharers could allow 
good sharing? <waiting for a "NO, YOU IDIOT!"> If not, then I guess the 
archive creation steps could be repeated periodically.

-brandon
