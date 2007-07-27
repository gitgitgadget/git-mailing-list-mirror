From: Junio C Hamano <gitster@pobox.com>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 20:43:57 -0700
Message-ID: <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
	<alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
	<200707260115.13234.robin.rosenberg.lists@dewire.com>
	<alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
	<81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
	<alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 05:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEGkR-0005X1-3T
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 05:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbXG0Dn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 23:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbXG0Dn7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 23:43:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60165 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759512AbXG0Dn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 23:43:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727034358.UBUA1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 23:43:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UTjw1X00a1kojtg0000000; Thu, 26 Jul 2007 23:43:57 -0400
In-Reply-To: <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 26 Jul 2007 09:13:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53877>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I'm not saying that's great programming, but the "git_pread()" that git 
> will use in the absense of a real pread() is actually even *less* of a 
> POSIX pread, since it doesn't even try to save/restore the old position 
> (it knows that git doesn't care).

If you mean the offset associated with fd, we actually do.

The original HP-UX error is confusing, as we ask pread() to
transfer 428 bytes and it returns 0 (not returning -1 with
EINTR).  Return value of zero is understandable, if the starting
position is at or after the EOF, but the offset is 123601 and
56k objects packed from git.git repository should be longer than
that, so that also sounds implausible.
