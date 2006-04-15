From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues: shallow clone
Date: Fri, 14 Apr 2006 19:11:59 -0700
Message-ID: <7vwtdrlh8w.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<87irpb7oma.wl%cworth@cworth.org>
	<7vr73zn0rb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 04:12:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUaGr-0006qV-24
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 04:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWDOCMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 22:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWDOCMF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 22:12:05 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52158 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751560AbWDOCME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 22:12:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415021204.OAHM2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 22:12:04 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <7vr73zn0rb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 14 Apr 2006 17:25:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18721>

Junio C Hamano <junkio@cox.net> writes:

> Maybe after the update to G happens (which means you now have C,
> F, G but not A B D E commits), the client side could enumerate
> commits on "rev-list ^C G" and cauterize the ones with missing
> parents (in this case, F does not have one of its parents).
> While doing this would help keeping the resulting commit
> ancestry sane, it does not solve the problem of missing blobs
> and trees.  See below.

Actually, it is more involved than the above.

The sender would give you A B D E as well, so we would not be
able to cauterise at F; instead you would do so at A, making
your shallow clone a bit deeper.  When you look at the objects
the parent gave you by running "rev-list ^C G", you would notice
that you do not have any of real parents of A, and add a new
graft.  While you are at it, you would hopefully notice that the
real parent of commit C is something you now have -- so you
remove the graft entry for C.

However, depending on what you care about more, having the
sender not to send the side branch and cauterising the result at
F _might_ be a better thing to do.  This is probably quite
involved and I offhand would not know how to efficiently
compute.
