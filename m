From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 01 Jan 2007 16:21:21 -0800
Message-ID: <7vd55y46ta.fsf@assigned-by-dhcp.cox.net>
References: <20070101214023.GB23857@fieldses.org>
	<182318.86313.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XPC-0001nj-EM
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbXABAVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbXABAVX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:21:23 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34363 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679AbXABAVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:21:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102002122.SIMK15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 1 Jan 2007 19:21:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 60Mb1W00u1kojtg0000000; Mon, 01 Jan 2007 19:21:36 -0500
To: ltuikov@yahoo.com
In-Reply-To: <182318.86313.qm@web31812.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Mon, 1 Jan 2007 16:01:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35756>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> ...
>> -The common `Pull: master:origin` mapping of a remote `master`
>> -branch to a local `origin` branch, which is then merged to a
>> -local development branch, again typically named `master`, is made
>> -when you run `git clone` for you to follow this pattern.
>
> So is this no longer the case?
>
> Can someone please bring me up to date?
>
> What is going on?

What's going on is clean-up towards v1.5.0-rc1 ;-).

 - 'git clone' does not create a file that has a line that looks
   like "Pull: master:origin" anywhere anymore.

 - 'git clone' also does not create the traditional "'master' is
   special and we map that to origin, others are mapped as is
   under refs/heads/, and we have to drop 'origin' from the
   remote side because that name we want to use to store their
   'master'" layout.

So after a clone, you would get:

	[remote "origin"]
        	url = ....
                fetch = refs/heads/*:refs/remotes/origin/*
        [branch "master"]
        	remote = origin
                merge = refs/heads/master

This configuration still causes "git pull" or "git pull origin"
while on "master" to fetch and store the remote side's master as
what you can refer to as 'origin' (because it expands to
'remotes/origin/HEAD' thanks to sha1_name.c::get_sha1_basic()),
and then merges that to your current branch, so there is no
change in the user experience in the big picture, but what is
created to achieve that effect is different from what was
described.
