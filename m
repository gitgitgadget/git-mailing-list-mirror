From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Wed, 09 Nov 2005 02:20:22 -0800
Message-ID: <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<20051109003236.GA30496@pasky.or.cz>
	<Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
	<7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
	<7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 14:09:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZpf2-0002I5-P6
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 14:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKINFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKINFs
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 08:05:48 -0500
Received: from fed1rmmtai01.cox.net ([68.230.241.58]:8378 "EHLO
	fed1rmmtai01.cox.net") by vger.kernel.org with ESMTP
	id S1750706AbVKINFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 08:05:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109101932.UYGS776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 05:19:32 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11398>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> It does:
>>
>> 	struct commit *commit = pop_one_commit(list_p);
>> 	int still_interesting = !!interesting(*list_p);
>>
>> in that order: it looks whether there are any interesting commits left 
>> _after_ it has popped the top-of-stack.
>
> The problem is most of the time hidden,...

As you pointed out, still_interesting means "after we are done
with this commit, do we still have something interesting to be
processed?", and the later "extra < 0" check compensates for
this.  After I pop the last interesting commit, I still look at
its parents and push them back into the list.

It seems to be doing the right thing after all.  I hate to admit
it, but I have been having hard time figuring out how this thing
works X-<.  In the meantime, I've checked commits from linux-2.6
history that have more than one merge-base candidates.
"git-merge-base --all" and "git-show-branch --merge-base" give
the same answer to all of them [*1*].

I do not think "git-show-branch --merge-base" can be any more
efficient than "git-merge-base --all".  It does _more_ things
(probably unnecessary things as well).  Pasky's number could be
just an artifact of hot/cold cache difference.

[Footnote]

*1* Here are the commits I used from linux-2.6 repository that
have more than one commits:

    ba9b543d5bec0a7605952e2ba501fb8b0f3b6407
    84ffa747520edd4556b136bdfc9df9eb1673ce12
    da28c12089dfcfb8695b6b555cdb8e03dda2b690
    3190186362466658f01b2e354e639378ce07e1a9
    0c168775709faa74c1b87f1e61046e0c51ade7f3
    0e396ee43e445cb7c215a98da4e76d0ce354d9d7
    467ca22d3371f132ee225a5591a1ed0cd518cb3d
