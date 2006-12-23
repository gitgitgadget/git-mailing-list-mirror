From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sat, 23 Dec 2006 01:37:03 -0800
Message-ID: <7vlkkzrm0w.fsf@assigned-by-dhcp.cox.net>
References: <20061223073317.GA9837@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 10:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy3Jh-0005Y4-Oc
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 10:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWLWJhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 04:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbWLWJhG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 04:37:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60235 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbWLWJhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223093704.JHZJ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 04:37:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 29cM1W0051kojtg0000000; Sat, 23 Dec 2006 04:36:21 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061223073317.GA9837@spearce.org> (Shawn O. Pearce's message of
	"Sat, 23 Dec 2006 02:33:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35307>

I have to say i am very much impressed (I've taken a look at
only the first half up to #11, though).  How much has this been
used in real projects?

A couple of comments:

[3/17]

I think losing "p->next = NULL" does not matter with the callers
we have right now, but somehow this part makes me feel uneasy.

[5/17]

I think it makes sense to exit(0) for the existing write_or_die
upon EPIPE because that indicates we are the upstream of the
pipe and the reading process has exit (i.e. user said 'q' to
less while we still have more to say).  

I suspect the symmetry would not hold for read_or_die; when we
are reading, EPIPE is not any different from any other errors
(except for EAGAIN or EINTR which we already take care of in
xread()) and the net effect is that we could not read what we
wanted to.
