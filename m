From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC/PATCH] git-svn: add support for --first-parent
Date: Thu, 06 Sep 2007 10:05:10 +0200
Message-ID: <85ejhcfccp.fsf@lola.goethe.zz>
References: <1188984929315-git-send-email-hjemli@gmail.com>
	<20070905101929.GB11074@soma>
	<8c5c35580709060018p50398071s32b271d52f4dc7e3@mail.gmail.com>
	<20070906075104.GA10192@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:05:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITCMe-0000S4-0x
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbXIFIFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbXIFIFR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:05:17 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:37647 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752558AbXIFIFO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 04:05:14 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 5DA7B1E5533;
	Thu,  6 Sep 2007 10:05:12 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 4741B28EC4D;
	Thu,  6 Sep 2007 10:05:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id E328A35E71B;
	Thu,  6 Sep 2007 10:05:11 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id F418F1CAD71B; Thu,  6 Sep 2007 10:05:10 +0200 (CEST)
In-Reply-To: <20070906075104.GA10192@hand.yhbt.net> (Eric Wong's message of "Thu\, 6 Sep 2007 00\:51\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57838>

Eric Wong <normalperson@yhbt.net> writes:

> Lars Hjemli <hjemli@gmail.com> wrote:
>> On 9/5/07, Eric Wong <normalperson@yhbt.net> wrote:
>> > Lars Hjemli <hjemli@gmail.com> wrote:
>> > > When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
>> > > messages, it can get confused when local history contains merges with
>> > > other git-svn branches. But if --first-parent is supplied to git-log,
>> > > working_head_info() will only see 'branch-local' commits and thus the
>> > > first commit containing a 'git-svn-id' line should refer to the correct
>> > > subversion branch.
>> >
>> > Ideally, we'd probably stop, say something and give the user the choice
>> > of branches if multiple parents available.
>> 
>> Could you elaborate? (I don't understand how following the first
>> parent of a merge could end up at the wrong svn branch)
>
> Well, if the user didn't know about --first-parent (like me yesterday
> :), they could still end up miscommitting to any branch.  That's been a
> complaint of users for a while now.  Thinking more about it,
> --first-parent should probably be the default.
>
> But, if they want to commit a different branch instead of the one they
> merged into (so the second/third/fourth parent), --first-parent would
> never give them that chance.

If they want to commit to a different branch, they can b****y well
check out that branch and merge to _that_.  That is the way all the
rest of git works and nobody whines that this is a restriction.

Quite the opposite: that git-svn does not feel constrained to actually
commit to the base of the checked-out branch is a complete nuisance.
_Why_ would anybody want to dcommit to a Subversion branch not
associated with the current branch?

Just yesterday, I _again_ had git-svn dcommit to a nonsensical branch
(this time, the commit was to branch instead of the trunk, while more
often the catastrophes happen the other way round).  And it is not
like git-svn gives you a chance to override this bad decision: you
have to rebase -i all of your commit messages from potential
cherrypicks or whatever else and remove the git-svn taglines manually
for every commit before git-svn will deign to dcommit to the same
branch as before.

Eric, this is not "flexibility".  This is madness.  If you think that
it is essential to dcommit to a branch unrelated to the current HEAD,
then create a sane command line interface for it that takes effect at
the time of dcommit.  But the current interface is just throwing dice
as far as the user is concerned, since the addition of git-svn tags to
commit messages happens behind his back, and any merge or cherrypick
or rebase 5 revisions back might come to bite you.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
