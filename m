From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Re* [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 10:36:14 -0400
Message-ID: <33AA0978-99F2-4BF0-840B-BB4781A23217@silverinsanity.com>
References: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <20080707151401.6117@nanako3.lavabit.com> <7vvdzi5fl5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrq8-0002cd-4F
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYGGOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYGGOgS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:36:18 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41703 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYGGOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:36:17 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 4A98E1FFC023;
	Mon,  7 Jul 2008 14:36:12 +0000 (UTC)
In-Reply-To: <7vvdzi5fl5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87613>


On Jul 7, 2008, at 3:16 AM, Junio C Hamano wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Doesn't this make the behavior of the command inconsistent between
>> "git-rebase" and "git-rebase -m"?
>
> Hmm, it makes "rebase -i" different, too.  Luckily, I haven't pushed
> anything out, so I can rewind and all I lose is just a few dozens of
> minutes.

Ah, I missed the exit in the $do_merge conditional.  Bah.  I had  
considered rebase--interactive a completely different beast and didn't  
consider it at all.  We've moved a little beyond my goal of "always  
get git-pull to set ORIG_HEAD."  However, consistency is a higher  
goal.  :-)

I originally only set ORIG_HEAD if rebase was operating on the current  
HEAD.  Now we're setting it to the original state of the branch rebase  
is operating on.  Thinking about it, I'm not certain this is what we  
want.  Should ORIG_HEAD refer the the previous state of HEAD, or to  
the previous state of the current branch?

> The one from Brian has another serious issue.  That patch does not  
> allow
> you to refer to ORIG_HEAD during conflict resolution, which is quite
> different from how "merge" lets you use ORIG_HEAD.  We need to set
> ORIG_HEAD upfront if we want to tell user that ORIG_HEAD can be  
> reliably
> used across workflows the same way to name where we were before.

I was under the impression that this was not desired.  I originally  
get ORIG_HEAD up front, and was told that it should happen much later  
in the process so that a reset during conflict resolution wouldn't  
blow it away.

> When we correctly update "rebase" to do this, because one codepath  
> of it
> uses "am" as its backend, we cannot use the patch I sent out  
> earlier.  We
> probably need to do something like this (minimally tested).


The patch looks correct to me, other than my question of what  
ORIG_HEAD should be set to after "git rebase upstream other_branch".

~~ Brian
