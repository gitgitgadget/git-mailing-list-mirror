From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 15:50:08 -0700
Message-ID: <7v64tsb9en.fsf@assigned-by-dhcp.cox.net>
References: <20050826184731.GA13629@c165.ib.student.liu.se>
	<Pine.LNX.4.63.0508261558550.23242@iabervon.org>
	<20050826213900.GA18880@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 00:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8n1e-0004Cm-Sx
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 00:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVHZWuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbVHZWuM
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 18:50:12 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4814 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751591AbVHZWuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 18:50:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826225010.LEAM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 18:50:10 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050826213900.GA18880@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Fri, 26 Aug 2005 23:39:00 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7827>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I find the Git architecture with respect to merging to be quite
> nice. A core which handles the simple cases _fast_ and let the more
> complicated cases be handled by someone else.

Exactly my feeling.  The three-way read-tree was made to do
"trivial" merges because the three-way merge operation is so
fundamental and more importantly because in what it does there
is no other plausible heuristics.  The cases that it leaves
stages unmerged in the index file are cases that a merge policy
might want to use heuristics to affect the outcome, and are left
for merge-cache to resolve.  And it is a good thing.

If the updated read-tree reads more than three trees at once and
makes decision internally which ones to choose, it would be very
desirable to see an implementation in which there is _no_
heuristics involved in the selection made by the built-in logic.

If there can be better selection made by more expensive logic,
and faster but less reliable heuristics by cheaper logic, it
would be very nice for the selection logic to call out a helper
"merge policy" program or dll module, just like the way
merge-cache calls merge-one-file-script, to make that decision.
