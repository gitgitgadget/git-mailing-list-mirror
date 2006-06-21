From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Wed, 21 Jun 2006 04:01:33 -0700
Message-ID: <7vac8622nm.fsf@assigned-by-dhcp.cox.net>
References: <1150599735483-git-send-email-normalperson@yhbt.net>
	<7vd5d63k7f.fsf@assigned-by-dhcp.cox.net>
	<20060619213951.GA6987@hand.yhbt.net>
	<7vbqso95f3.fsf@assigned-by-dhcp.cox.net>
	<20060621100138.GA15748@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 13:02:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0So-00007C-A5
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWFULBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWFULBf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:01:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65001 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751495AbWFULBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:01:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621110133.JUQC6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:01:33 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22260>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>>
>> >> 	git-merge-$strategy $cmt^ -- HEAD $cmt
>> >
>> > Changing the 'git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt"'
>> > line in call_merge() to this seems to have broken more tests.
>> 
>> Oh, that is to be expected if you changed git-merge -s recursive
>> with git-merge-recursive without other changes.  The former
>> makes a commit (which your original patch later used to create a
>> separate commit chain and discarded); the latter does not make a
>> commit but expects the caller to create a commit out of the
>> resulting index file.
>
> Oops, *smacks head*

Well, but you used it to do the right thing after all ;-).
The patch looks quite good.

>> I was originally hoping that rebasing would just be a matter of
>> listing sequence of commits to be ported onto a new base and
>> running "git-cherry-pick" on each of them in sequence.  Now
>> cherry-pick does not use merge machinery (hence does not use
>> git-merge-recursive), but if we change that then updating rebase
>> would be pretty much straightforward.  It just needs a UI layer
>> to guide the user through recovery process when the merge does
>> not resolve cleanly in the middle, no?
>
> Sounds workable right to me. But then again, a cherry-pick is also a
> case of rebase on a single commit, so we could be using rebase (and its
> recovery code) in cherry-pick, too, right?

Revert and cherry-pick are quite similar operation (the only
difference is that you swap his and pivot when doing revert), so
when you implement cherry-pick as an atomic operation you can
have revert almost for free.  If you have a rebase like you did,
it would be a bit more involved to make it do revert as well.
