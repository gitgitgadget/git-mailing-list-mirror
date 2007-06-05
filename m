From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: clarify git clone --local --shared --reference
Date: Tue, 05 Jun 2007 11:30:16 -0500
Message-ID: <46658F98.6020001@nrlssc.navy.mil>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvbvW-0008Se-Pj
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbXFEQaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764139AbXFEQaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:30:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44230 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbXFEQaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 12:30:24 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l55GSNas001797;
	Tue, 5 Jun 2007 11:28:26 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Jun 2007 11:30:17 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070605045008.GC9513@spearce.org>
X-OriginalArrivalTime: 05 Jun 2007 16:30:17.0200 (UTC) FILETIME=[CD207700:01C7A78E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15218000
X-TM-AS-Result: : Yes--12.590100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNTA2?=
	=?us-ascii?B?NzMtMTQ3MDE4LTcwMjU3Mi03MDAwNzUtMTM5MDEwLTcwMDE2MC03?=
	=?us-ascii?B?MDE3NDYtNzAxNzE5LTcwMDM5OC03MDk5MDgtNzA1MTY3LTcwNTkw?=
	=?us-ascii?B?MS03MDI3MjYtNzA1MTAyLTcxMTI0OC03MDcxMTktNzAxNTc2LTcw?=
	=?us-ascii?B?MTA5OS03MDIzNTgtNzEwOTg5LTcxMTk1My03MDQ5MjctMTA1NzAw?=
	=?us-ascii?B?LTcwNDQ5Ni03MDQ0MjUtNzAwMDU3LTcwMTQ2MS03MDIwMDMtNzAz?=
	=?us-ascii?B?Nzg4LTcwNzQxMC03MDkwMTgtNzAxNDU1LTcwNzMyNS03MDgxNzkt?=
	=?us-ascii?B?NzA2MjQ5LTcwOTU4NC03MDI3NjItNzA1MjQ5LTcwNDQzNS03MDU0?=
	=?us-ascii?B?NjEtNzAxNDM3LTcwODY1NS03MDI0NzQtNzAxNzM4LTcwMTQzMy03?=
	=?us-ascii?B?MDY1NjQtNzAxMDA1LTcwNzc2MC03MDM3MTItNzAxMTQ2LTcwMDg2?=
	=?us-ascii?B?OS03MDQ0MjEtNzAwNDcwLTcwNzEzNi03MDU1ODQtNzA0OTM0LTcw?=
	=?us-ascii?B?NDQzMC03MDAxMDctNzAyMDIwLTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49204>

Shawn O. Pearce wrote:
> Brandon Casey <casey@nrlssc.navy.mil> wrote:

[snip]

>> 2) Does --shared imply shared write access? Does --local?
>>    I'll point out that git-init has an option with the same name.
> 
> No.  --shared means something entirely different in git-clone
> than it does in git-init.

This did cause the thought that git-init --shared and git-clone --shared
may be pairs to be used together in some special way.

ok. Rather selfish "sharing" in my opinion :)

--reference did not cause any confusion and implied to me exactly
what it does: Use supplied repository as a reference for objects
which cannot be resolved locally.

> The --shared here implies adds the source repository to the new
> repository's .git/objects/info/alternates.  This means that the
> new clone doesn't copy the object database; instead it just accesses
> the source repository when it needs data.
> 
> This exposes two risks:
> 
>   a) Don't delete the source repository.  If you delete the source
>   repository then the clone repository is "corrupt" as it won't be
>   able to access object data.
> 
>   b) Don't repack the source repository without accounting for the
>   refs and reflogs of all --shared repositories that came from it.
>   Otherwise you may delete objects that the source repository no
>   longer needs, but that one or more of the --shared repositories
>   still needs.

How should this be accomplished? Does this mean never run 
git-gc/git-repack on the source repository? Or is there a way to
cause the sharing repositories to copy over objects no longer
required by the source repository?

[snip]

>> 4) is space savings obtained only at initial clone? or is it on going?
>>    does a future git pull from the source repository create new hard
>>    links where possible?
> 
> Only on initial clone.  Later pulls will copy.  You can try using
> git-relink to redo the hardlinks after the pull.

How about with --shared? Particularly with a fast-forward not much
would need to be copied over. Do later pulls into a repository with
configured objects/info/alternates take advantage of space savings
when possible?

If the answer above is "yes", then this brings up an interesting use 
case. I assume that clone, fetch, etc follow the alternates of the 
source repository? Otherwise a --shared repository would be unclone-able 
right? And only pull-able from the source repository? So if that is the 
case (that remote alternates are followed), then a group of developers 
could add all of the other developers to their alternates list (if 
multiple alternates are supported) and reference their objects when 
possible. To the extent that it is possible, each developer would end up 
only storing their commit objects. This would then create a distributed 
repository.

Of course, this new distributed repository may be somewhat fragile since 
the entire thing could become unusable if any portion was corrupted. 
Just because you can do a thing, doesn't mean you should.

thanks for your excellent reply,
-brandon
