From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 19:23:21 -0800
Message-ID: <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 04:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCSXr-0003yr-0U
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbXBADXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbXBADXY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:23:24 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53651 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161126AbXBADXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:23:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070201032322.CZBV16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 22:23:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J3PN1W00W1kojtg0000000; Wed, 31 Jan 2007 22:23:22 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38323>

Jeff King <peff@peff.net> writes:

> I think part of the "scariness" of the message is that git-checkout does
> not _usually_ produce output. I wonder if, when switching HEAD, it
> usually printed "Now on branch <foo>", and for detached printed some
> special variant, it would seem more natural.

That sounds sensible.  Another thing I found slightly annoying
about branch switching in git-checkout is that we list the paths
with local changes only when the tip of the old branch and the
new branch are different.  Very often I start hacking while on
'master' and later find the change forms a concrete "theme", and
then say "git checkout -b that-theme" to switch a branch; in
such a case I do want the list of locally modified paths.

For example:

	: gitster project/master; edit foo.c
        : gitster project/master; git checkout -b theme
	M	foo.c
	Switched to a new branch "theme"
	: gitster project/theme; edit bar.c
        : gitster project/theme; git checkout master
	M	bar.c
        M	foo.c
        Switched to branch "master"
	: gitster project/master; git checkout master^
	M	bar.c
        M	foo.c
	Detached your HEAD -- you are not on any branch.
        If you want to create a new branch from this checkout, you may do so
        (now or later) by using -b with the checkout command again. Example:
          git checkout -b <new_branch_name>
	: gitster project; 

would feel very natural and much less scary.

Note.  I run with PS1=': \h \W$(__git_ps1 "/%s"); '.
