From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sat, 07 Jul 2007 03:09:37 -0700
Message-ID: <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:09:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I77EU-0003LN-AH
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 12:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXGGKJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 06:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbXGGKJk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 06:09:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42916 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbXGGKJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 06:09:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707100938.GBJF1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 06:09:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id La9d1X00A1kojtg0000000; Sat, 07 Jul 2007 06:09:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51808>

"Marco Costalba" <mcostalba@gmail.com> writes:

> git-rev-list shows parents correctly, git-log no, in particulary there
> is parent 913419f that is shown 3 times instead of 1. Testing on git
> repository.
>
> $ git-log --parents --pretty=raw addafaf92e -n1 -- diff.h
> commit addafaf92eeb86033da91323d0d3ad7a496dae83
> 913419fcc648dd43d7f7afdd94fa25aee4f9798a 913419fcc648dd43d7f7a
> fdd94fa25aee4f9798a ea726d02e9677a66586d7ffebe97f112ab6dab33
> 913419fcc648dd43d7f7afdd94fa25aee4f9798a 46a6c262
> 0ba421397eec627b8eb18eb530e694fc
> tree e3be15f54f01e3aa1f8ec830ac87da5f85a23480
> parent 6b94f1e404afc552e5139c4357331843f5be61ad
> parent 93b74bca86f59b8df410b6fd4803b88ee0f304bf
> parent ea726d02e9677a66586d7ffebe97f112ab6dab33
> parent b33aba518456bee97bde1fef4fe17ab6bf401bbe
> parent 6b1ddbdd6e02719ae2be55dc141a176187e5027e
> author Junio C Hamano <junkio@cox.net> 1138436169 -0800
> committer Junio C Hamano <junkio@cox.net> 1138436169 -0800

Line wrapping in the middle of a single object name makes it
hard to read doesn't it?

The commit does have 5 parents, among which, three of them merge
branches that do not touch the named paths (in this case it
happens to be a single "diff.h") and parent simplification leads
to the same ancestor.

I recall we added an extra logic in rev-list side to squash the
parent commits that artificially becomes duplicate due to this
history simplification logic, which we might want to port to
git-log.  However, I have a slight suspicion that we earlier
decided not to do so on purpose with git-log and for a good
reason.  I do not have much energy left tonight to dig into this
right now, but mailing list log and commit log messages for
rev-list.c, builtin-log.c and builtin-rev-list.c might tell you
more.
