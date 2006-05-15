From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 14:10:24 -0700
Message-ID: <7vlkt3gfjz.fsf@assigned-by-dhcp.cox.net>
References: <446778B8.7080201@inoi.fi>
	<7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi>
	<7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net>
	<20060515053133.GB28068@spearce.org>
	<7v1wuvvg0j.fsf@assigned-by-dhcp.cox.net>
	<877j4nvx2w.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 23:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfkKl-0004Da-Po
	for gcvg-git@gmane.org; Mon, 15 May 2006 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWEOVK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWEOVK2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 17:10:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27025 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965229AbWEOVK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 17:10:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515211026.KZBW25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 17:10:26 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <877j4nvx2w.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	15 May 2006 13:42:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20085>

Carl Worth <cworth@cworth.org> writes:

> In particular, when using checkout to change branches, unless I've
> specifically stated with "-m" that I want to carry my changes along, I
> would like git to stash my working tree "into" the branch I'm
> switching away from.
>
> Similarly, when switching to a branch, I'd like to have the working
> tree restored to what it was the last time I switched away from that
> branch.
>
> Does that seem unreasonable to anyone?

I would not call it unreasonable to want to have an easy access
to that mode of operation _as_ _well_, as an option.

If you were suggesting to make it the only way for future git to
work (I think you are not), then it sounds very unreasonable to
me.

The implementation behind the scene does not matter, but I think 
set of "stashes" that can be attached to each branch would work
well for what you would want.  OTOH, isn't it called stgit?

The reason why I want it to stay as an option is because I often
do a throw-away patch on top of whatever branch is checked out
in my working tree while reading the list traffic to compose a
response with an alternative patch.  Usually I follow that by a
"git reset" once the message is sent out, but when I like the
idea well enough, I do "checkout -b jc/that-topic master" to
switch to a new branch with the dirty state carried along, to
work on it further.  I do not want that workflow to require -m
flag, which means something different (-m means "I accept the
possibility of the three-way merge failing while doing this
switch that needs a merge").  Instead, I want "checkout -b" to
try carrying state forward and stop if it cannot without
file-level merging (i.e. the current behaviour).  Then I can
think if I want to do a stash with "git diff", or if I want to
do the temporary branch not based on "master" but the current
branch (which is guaranteed to work without -m) and deal with
the mess later.
