From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing vs. alternates
Date: Tue, 24 Oct 2006 10:33:34 -0700
Message-ID: <7vmz7lhb4h.fsf@assigned-by-dhcp.cox.net>
References: <20061024035335.GW20017@pasky.or.cz>
	<7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
	<20061024112028.GY20017@pasky.or.cz>
	<7vzmblhc3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 19:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcQ9k-00027q-Lv
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWJXRdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWJXRdg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:33:36 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16619 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161111AbWJXRdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 13:33:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024173335.GYNB12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Oct 2006 13:33:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eHZJ1V00X1kojtg0000000
	Tue, 24 Oct 2006 13:33:19 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vzmblhc3y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 24 Oct 2006 10:12:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29994>

Junio C Hamano <junkio@cox.net> writes:

>> Well, I would send haves for the alternate repository anyway,...
>
> While I agree it would be an optimization if it worked, there is
> one conceptual problem here though, coming from old warts.  It's
> not alternate "repository" but it is alternate object store.
> There is no guarantee that refs/ directory that is next to the
> objects/ alternate points at is related to that object store,
> for historical reasons (i.e. we have separate GIT_DIR and
> GIT_OBJECT_DIRECTORIES).

Having said that, I am not opposed to the idea of using refs/
next to objects/ your alternate points at.  Certainly I would
not have any objection (heck I would even volunteer to code it
myself if only to see how much we can save) if we did not have
GIT_OBJECT_DIRECTORY in the system (i.e. if we had a guarantee
from the beginning that objects/ directory that is next to refs/
*must* be related).  So I am Ok with this change, but I would
feel better if we add a few sentences to repository-layout.txt
that warns about the (technically new although it is very likely
that violating it would not have been useful at all) restriction.

I suspect we could do the same for fetching in principle,
e.g. when you track Linus's and a subsystem maintainer's trees
and these two repositories are linked with alternates at your
end.  Fetching into your copy of Linus's and then fetching into
your copy of subsystem would be optimized the same way if you
send refs/ from the alternates as HAVEs, right?
