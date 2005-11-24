From: Junio C Hamano <junkio@cox.net>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 13:02:45 -0800
Message-ID: <7vveyhpxmy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
	<Pine.LNX.4.64.0511241037400.13959@g5.osdl.org>
	<7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511241154340.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Ed Tomlinson <tomlins@cam.org>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 22:04:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfOFI-00068L-EJ
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 22:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbVKXVCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 16:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVKXVCs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 16:02:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40416 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932655AbVKXVCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 16:02:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124210132.MMVL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 16:01:32 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511241154340.13959@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 24 Nov 2005 11:57:20 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12715>

Linus Torvalds <torvalds@osdl.org> writes:

> Since git-pack-objects has to generate the pack _anyway_, it might as well 
> save it away when it does - so that if you have lots of people doing 
> clones or pulling, you'd only need to run it once for a particular set of 
> objects, and you'd not have to do any extra (or unnecessary) maintenance.

Caching itself is relatively easy (just implement an equivalent
of tee inside pack-objects ourselves).  More problematic is
pruning.  We could do it from cron based on atime _if_ the
filesystem is not mounted noatime but without arranging a
reasonably way for automated pruning this would become a disk
hog and extra maintenance burden, which is why I did not
implement the dynamic caching part in the initial round.

Since git-daemon would be the primary user of pack-cache/, this
implies a repository writable by git-daemon user on public
machine (not master), which is an extra thing to note.
