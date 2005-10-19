From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone, tag objects and cg-push/git-push don't play nice
Date: Wed, 19 Oct 2005 00:16:37 -0700
Message-ID: <7vzmp6dlii.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 09:17:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES8Bm-0003JO-Io
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 09:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbVJSHQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 03:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbVJSHQj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 03:16:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50415 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751560AbVJSHQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 03:16:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019071612.VNOU776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 03:16:12 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 19 Oct 2005 19:38:16 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10268>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>  + git-push is trying to walk all the refs it knows about when it does
> the "what do I have that the repo doesn't" part, and it breaks on
> those incomplete tag fetches.

That is expected.

> Removing  .git/refs/tags/* didn't help. If I actually rm all the
> problematic tag objects from the object repository, I can then push
> correctly. Lucky it wasn't packed.
>
> I am going to write a quick'n'dirty script to fix our repos when this
> happens, and I'll try my hand at a patch to cg-fetch. Can git-push be
> taught to be smarter in these cases?

Although I do not follow Cogito development closely, I seem to
recall that it fetched tags without making them complete at some
point in the past; I hope it is now fixed but I am not sure.

I cannot think offhand of a way how git-push could help to cope
with a repository broken that way.  However, we could probably
have a tool that tangles from each ref, find incomplete ones and
remove them from .git/refs.  After running that maybe pull from
a know good copy would fix the broken repository.

I do not understand why removing .git/refs/tags/* did not help,
and that is the biggest thing that disturbs me in this whole
problem report.  We (meaning git-* transfer, not cg-* transfer
whose correctness I cannot vouch for) _should_ be relying only
on refs not object existence.  Maybe there are some other files
under .git/refs/ directory that had copies of them?
