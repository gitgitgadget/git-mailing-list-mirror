From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rebase --merge: fix for rebasing more than 7 commits.
Date: Thu, 22 Jun 2006 01:54:18 -0700
Message-ID: <7vpsh1tvt1.fsf@assigned-by-dhcp.cox.net>
References: <7vy7vptw8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 10:54:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtKxC-00043O-Lu
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 10:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWFVIyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWFVIyU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 04:54:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20356 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932453AbWFVIyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 04:54:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622085418.ZJJX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 04:54:18 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <7vy7vptw8p.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Jun 2006 01:44:54 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22312>

Junio C Hamano <junkio@cox.net> writes:

>  * I wanted to raise my confidence level in the new rebase --merge
>    code, so I did a little exercise which resulted in finding this
>    buglet.
>...
>    So the exercise went like this:
>...
>   With this fix, the above works beautifully.  I am reasonably
>   happy with this shiny new toy.  Good job, Eric! and thanks.

By the way, I do not quite understand the reasoning behind not
moving the head being rebased until the finalization phase.

Also I think --skip would be straightforward.  What you look at
in call_merge() is the current HEAD, the commit being rebased
and its direct parent (actually what you are interested in are
trees of these commits and not ancestry chains among them -- if
we can tell git-merge-recursive not to try its own "recursive"
merge base finding but just use what we give it as the base, I
could sleep better.  I think the current code could misbehave in
funnier ancestry graph if we allow it to pick merge base on its
own), so skipping is just a matter of, eh, skipping the commit.
