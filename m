From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible --remove-empty bug
Date: Sun, 12 Mar 2006 21:41:51 -0800
Message-ID: <7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	<7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
	<7vlkvfw3px.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 06:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIfog-0003aB-Hk
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 06:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCMFlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 00:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCMFlz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 00:41:55 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4809 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751430AbWCMFly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 00:41:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313054035.BMHV3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 00:40:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vlkvfw3px.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 12 Mar 2006 17:08:58 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17551>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> It's supposed to stop traversing the tree once a pathname disappears.
>
> Then what we should simplify is the parent commit that does not
> have those pathnames (i.e. remove parents from that parent
> commit).  In other words, currently the code removes the parent
> commit that makes the tree disappear, but we would want to keep
> that parent, remove the grandparents, and then mark the parent
> uninteresting.

Sorry, the last clause in the above comment is wrong, and does
not describe what the code attached does.

It removes the grandparents from the parent, and leaves the
parent still interesting.  As a result, in your example:

    ... if you have

                a
               / \
              b   c
               \ /
                d

    where the pathname disappeared in "b"...

we would get this world view:

                a
               / \
              b   c
                 /
                d

because when inspecting a and finding that "b" does not have any
paths we are interested in, b loses all of its parents.
