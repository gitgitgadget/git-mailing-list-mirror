From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 05 Jan 2007 15:32:28 -0800
Message-ID: <7vr6u9cann.fsf@assigned-by-dhcp.cox.net>
References: <7vtzz9usyp.fsf@assigned-by-dhcp.cox.net>
	<826.67287.qm@web31809.mail.mud.yahoo.com>
	<7vvejlcb6z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yY8-0000N1-Qa
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXAEXca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXAEXca
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:32:30 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62866 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXAEXc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:32:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105233229.ZEPE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:32:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7bXg1W00s1kojtg0000000; Fri, 05 Jan 2007 18:31:41 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <7vvejlcb6z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 Jan 2007 15:20:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36048>

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> --- Junio C Hamano <junkio@cox.net> wrote:
>>> 
>>> Because [remote] is NOT about mapping.  It asks the fetch
>>> mechanism to fetch from that remote, so the primary thing you
>>> should look at is .url, not RHS of colon on .fetch lines.  Use
>>> of tracking branches is strictly optional.
>>
>> [remote "origin"]
>>         url = http://blah/bleah.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> This basically says: "Get it" from such and such url, where
>> on the repo at that url, i.e. the remote side, you will
>> find stuff in "refs/heads/", and when you get it here, locally,
>> put it in refs/remotes/origin/.
>
>         [remote "origin"]
>                 url = http://blah/blah.git
>                 fetch = refs/heads/master
>
> is also fine.  The point is that you do not have to use tracking
> branches.  ", and when you get it here, ..." part is optional.

In other words, remote.*.fetch could be spelled as mapping to
cause them locally stored in tracking branches, but the storing
in tracking branches is merely a side effect of a fetch, not the
primary one.  The primary effect is to fetch the necessary
objects and leave what was fetched in .git/FETCH_HEAD to
communicate with later 'git pull'.  The side effect is optional,
so is spelling remote.*.fetch as a mapping.

>> Yeah, but by default "refs/heads/branchA" doesn't exist (see
>> my previous email).  It doesn't have to, since it specifies
>> the "remote part", but that has already been handled by
>> "[remote]".
>
> Obviously fetch needs to handle the remote part because that is
> the only name it exists at the remote.  branch.*.merge is used
> by pull, not fetch, and fetch communicates with pull by using
> the remote name, because use of local tracking branches is
> optional.

In other words, the remote name is the only thing that can be
used between fetch and pull to communicate.  Fetch tells pull "I
fetched these from the remote", and pull uses that information
to make a merge, and the merge comment says "this merges the
branch xyz from that repository", using the 'xyz' name used at
the remote side, not your local tracking branch, which you may
or may not be using.
