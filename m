From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 23:03:55 -0800
Message-ID: <7vmzhbk1b8.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
	<7v64nzollt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311938130.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 08:04:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4C23-0000Yl-Vv
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 08:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWBAHD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 02:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWBAHD5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 02:03:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:26830 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030559AbWBAHD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 02:03:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201070116.VCCM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 02:01:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311938130.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 19:43:12 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15389>

Linus Torvalds <torvalds@osdl.org> writes:

> Your point that we discussed a similar flag for the "don't require a full 
> checkout" is a good one: we should try to make sure that it works for both 
> uses. Although maybe we decided for some reason that nobody cared about 
> the non-checked-out case?

We gave them a way to add --cacheinfo but did not do any more
than that, because they are independently coming up with some
hash (not necessarily be a proper git blob object name), they
did not have the huge blob data with the working tree anyway,
and the only thing they cared about was which paths changed and
they did not even want to see how the contents changed.
I.e. "diff-tree -r" was the only thing they cared about.

If we end up doing "assume unchanged", I should remember to do a
sensible thing for "diff-index" without --cached.  It should not
look at the working tree file for paths marked as such.  This
implies one optimization in "diff-index -p" and "diff-tree -p"
may need to be disabled.  They cheat and avoid expanding blob
objects when their cache entries are clean and required blobs
are in the working tree.  If "assume unchanged" path was
actually changed, such a diff would show up as a confusing
unexpected change.

Well, the user is asking for it, so that confusion is not _my_
problem, though ;-).
