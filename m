From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 12:22:37 +0100
Message-ID: <0456DF67-E0CB-4048-BB19-397D0C559F23@zib.de>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com> <20080209024636.GE2572@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 12:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnml-0007Rt-6l
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 12:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbYBILVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 06:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbYBILVo
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 06:21:44 -0500
Received: from mailer.zib.de ([130.73.108.11]:55822 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584AbYBILVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 06:21:42 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m19BLb3G016902;
	Sat, 9 Feb 2008 12:21:37 +0100 (CET)
Received: from [192.168.178.21] (brln-4db92967.pool.einsundeins.de [77.185.41.103])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m19BLZXC028833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 9 Feb 2008 12:21:36 +0100 (MET)
In-Reply-To: <20080209024636.GE2572@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73210>


On Feb 9, 2008, at 3:46 AM, Jeff King wrote:

>>> Another way to "solve" this issue, of course, is to use the  
>>> remote layout.
>>> I did the switchover myself some time ago; it was hard at first,  
>>> since I
>>> was so used to just check out the branches I just fetched.  But  
>>> in the
>>> long run the distinction between local and tracking branches made  
>>> life
>>> much easier for me.
>>
>> What do you mean with "the remote layout"? I am using
>> "remotes"+tracking branches as far as I can tell...
>
> I think he means something like "if I have 'next' and 'origin/next',
> then I should check whether 'next' is a subset of 'origin/next'" and
> just say "nothing to send." But that suffers from the same "silently
> ignoring rewinds" as above. You could ignore the push if you have
> next exactly equal to origin/next, but that implies that you  
> haven't done
> any fetching (which is unlikely in the scenario you described).


A similar proposal was discussed last October/November and we
already had patches.  We decided against it.  The reason is
that the post-condition of "git push" is that all heads that
are considered by the push shall be identical locally and
at the remote.  If "git push" does not achieve this it should
report the branches for which the post-condition is not met.

I think Dscho means: do not duplicate remote branches as local
branches.  Keep the number of local branches as low as possible.
Only if you want to work on a remote branch, create a local
branch, commit you work, push, and *delete* the local branch.

However, I often use local branches as a reminder which remote
branches I am actively monitoring.  If I start to work on them
I first review what's new with "gitk origin/topic --not topic"
and then do the fast forward "git push . origin/topic:topic"
before I actually start working "git checkout topic". For
these branches, Dschos proposal does not work for me.

	Steffen
