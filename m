From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Wed, 26 Apr 2006 22:04:36 -0700
Message-ID: <7vejzjmwwr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
	<7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
	<Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 07:04:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYygF-000405-3S
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWD0FEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 01:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWD0FEk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 01:04:40 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49339 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964935AbWD0FEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 01:04:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060427050438.RGZS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 01:04:38 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
	(Nicolas Pitre's message of "Wed, 26 Apr 2006 23:05:43 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19223>

Nicolas Pitre <nico@cam.org> writes:

>> And actually I'm not sure how to solve that without walking the tree 
>> up to the top each time, which I want to avoid as much as possible.
>
> Well, that seems to be unavoidable.
>
> Reversing the window logic isn't that much of a good idea after all.
> ...

> Then there is the possibility of having a delta "branch" with maximum 
> depth meaning that the trunk for that branch may not be deltified. But 
> if a later objects to come does constitute a better delta base for the 
> object in the middle of that branch then the branch will be broken in 
> the middle to be transplanted onto the new base as explained previously.  
> Which means that the initial trunk no longer has a maximum depth and some
> objects that were skipped because of the depth limit could now have been
> tested, leading to suboptimal delta matching.

Good analysis, and I tend to agree with your conclusion.

BTW, Geert mentioned on the #git channel that about half the
filepair git-pack-objects asks diff_delta() to try have long
sequences of matching bytes at the beginning and at the end.  It
might be worthwhile if we can take an advantage of it, whichever
delta algorithm we would use.
