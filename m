From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Thu, 22 Sep 2005 10:53:27 +0100
Message-ID: <tnxpsr12zu0.fsf@arm.com>
References: <20050921164015.GC21971@pasky.or.cz>
	<20050922083142.GA6866@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, kkeil@suse.de
X-From: git-owner@vger.kernel.org Thu Sep 22 11:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINme-0005FV-2R
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 11:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVIVJyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 05:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVIVJyZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 05:54:25 -0400
Received: from [63.80.46.197] ([63.80.46.197]:59807 "EHLO
	incsun1.losgatos.arm.com") by vger.kernel.org with ESMTP
	id S1751445AbVIVJyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 05:54:24 -0400
Received: from ASHWA.Asiapac.Arm.com (localhost [127.0.0.1])
	by incsun1.losgatos.arm.com (8.12.6/8.12.6) with ESMTP id j8M9qbdF000311;
	Thu, 22 Sep 2005 02:53:38 -0700 (PDT)
Received: from ZIPPY.Emea.Arm.com ([10.1.255.57]) by ASHWA.Asiapac.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 22 Sep 2005 15:23:36 +0530
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 22 Sep 2005 10:53:29 +0100
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050922083142.GA6866@kroah.com> (Greg KH's message of "Thu,
 22 Sep 2005 01:31:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Sep 2005 09:53:29.0138 (UTC) FILETIME=[7BE3C120:01C5BF5B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9101>

Greg KH <greg@kroah.com> wrote:
> On Wed, Sep 21, 2005 at 06:40:15PM +0200, Petr Baudis wrote:
>>   His situation is that he has some patches in the ISDN subsystem, a
>> public repository, but sends the patches over e-mail to Linus. So he is
>> something between the subsystem maintainer and individual developer in
>> the categories listed out in the tutorial. What should be his merging
>> strategy?
>
> Not to use git for this.
>
> Seriously, that's what I have switched to doing, and it's so much
> easier.  I use quilt to manage patches from the community, and Andrew
> pulls them into to the -mm releases, and all users can test them.  I
> keep them up to date with the git snapshots, which handles the different
> merge and fuzz issues very well.

You might want to try StGIT as well, unless you have a huge number of
patches and rebasing them takes too much time. It follows the quilt
ideas but it does a three-way merge instead of patch+fuzz. This allows
it to detect patches accepted by Linus and also see whether they were
not fully applied or were modified. You can run 'stg export' to
generate a patch series to send to Andrew.

> Then, when it's time to merge with Linus, I pick and choose the patches
> that I want to send off, create a git tree, add them to the tree, and
> send them off.

With StGIT, you can either use 'stg mail <patches...>' or re-organise
the stack with push/pop so that you only keep the patches to be merged
by Linus and tell him the HEAD value to merge. Even if you modify the
stack afterwards, the HEAD value still represents the stack state at
that moment (unless you run 'git prune' and the value is not saved in
a file under refs/heads/).

StGIT also support cherry-picking via 'stg import --commit=...' if you
want to create a separate branch.

But what I understand from Petr's e-mail is that re-basing the patches
is not acceptable for a repository which is public. One option would
be to keep a private tree where the patches are re-based and a public
one which periodically pulls from Linus' tree and your private
one. Not sure how complicated the commit graph would look.

> It's ended up saving me a lot of time (I used to do what Karsten is
> trying to do with bitkeeper, and it had the same issues that he is
> running into) and would recommend this situation for anyone who wants to
> keep patches from being merged immediatly (like he is trying to do.)

I only maintain a small set of patches (< 20) and send some of them
upstream via RMK. I would recommend StGIT :-) as an alternative to
quilt (I don't say a better one but some people might like it).

-- 
Catalin
