From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 14:44:54 -0800
Message-ID: <20091111224454.GA16178@dcvr.yhbt.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net> <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Lvx-00054q-HO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480AbZKKWou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759468AbZKKWou
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 17:44:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48707 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759326AbZKKWot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 17:44:49 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B431F605;
	Wed, 11 Nov 2009 22:44:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AFB32DC.50505@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132716>

Pascal Obry <pascal@obry.net> wrote:
> Eric,
>
>> Also, any chance you have multiple refs with "trunk" in the basename?
>>
>>   git rev-parse --symbolic --all | grep '/trunk'
>
> This reports:
>
> $ git rev-parse --symbolic --all | grep '/trunk'
> refs/remotes/svn/trunk

Pascal,

OK, this is normal.

>> It could be a backwards compatibility issue with git svn looking
>> in multiple places for trunk.
>
> But I have multiple trunk:
>
> $ ls .git/svn/svn/trunk/
> ./  ../  .rev_map.936e1b1b-40f2-da11-902a-00137254ae57  unhandled.log
>
> $ ls  .git/svn/refs/remotes/svn/trunk/
> ./  ../  .rev_map.936e1b1b-40f2-da11-902a-00137254ae57  unhandled.log
>
> Removing all the .rev_map* fix the problem.
>
> Removing only the one in .git/svn/refs/remotes/svn/trunk/ fix the  
> problem too.
>
>> With Adam's commit, it'll try $GIT_DIR/svn/refs/remotes/trunk/* first
>> Then it'll try $GIT_DIR/svn/trunk/* as a fallback.
>
> Does this means that it was looking first in $GIT_DIR/svn/trunk/*  
> before? And the confusion come because now it is looking in  
> $GIT_DIR/svn/refs/remotes/trunk/* first?

Yes, but somehow $GIT_DIR/svn/refs/remotes/trunk should not have
been created since $GIT_DIR/svn/svn/trunk already existed.  Both
of those directories existing at the same time should not

Did you try an early version of Adam's patch before it made it into
git.git by any chance?

Or, did you by any chance start a fresh import with a v1.6.5 and then
rsync $GIT_DIR to one created with 1.6.4 and not use --delete with
rsync?

-- 
Eric Wong
