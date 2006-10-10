From: Junio C Hamano <junkio@cox.net>
Subject: Re: is git-unpack-objects now redundant for 'git-push' and friends?
Date: Tue, 10 Oct 2006 10:44:39 -0700
Message-ID: <7v7iz82hh4.fsf@assigned-by-dhcp.cox.net>
References: <452B9EE8.5020702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:45:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLem-0003jx-P0
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWJJRom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJJRol
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:44:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63151 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751044AbWJJRol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:44:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174440.WQUG2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:44:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yhkj1V00A1kojtg0000000
	Tue, 10 Oct 2006 13:44:43 -0400
To: Sam Vilain <sam@vilain.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28642>

Sam Vilain <sam@vilain.net> writes:

> When pushing or pulling to/from a repository, why unpack the objects?
> Why not just fsck and then throw the pack into $GIT_DIR/objects/pack?
>...
> I suspect that this was never changed, because there never used to be
> more than one packfile allowed, correct?

We've supported more than one packs at the same time from the
day we supported packs.

Primary reason that push never keeps the pack is that explosion
into loose objects hurts you only at the first round and later
pushes are supposed to be much smaller, so changing it to keep
the pack for the initial one has a very small value making it a
very low priority change.  Not keeping the pack on push makes it
possible to always use --thin for pushing if we wanted to.

On the fetch side you could use --keep option when you know the
fetch will be huge.
