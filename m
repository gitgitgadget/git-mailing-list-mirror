From: Junio C Hamano <gitster@pobox.com>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 01 Aug 2007 00:27:10 -0700
Message-ID: <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net>
References: <20070801013450.GA16498@raptus.dandreoli.com>
	<alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org>
	<20070801063209.GA13511@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 09:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG8cC-0000pF-LF
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 09:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbXHAH1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 03:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbXHAH1N
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 03:27:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53197 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbXHAH1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 03:27:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801072709.LSUO1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 03:27:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WXTA1X0031kojtg0000000; Wed, 01 Aug 2007 03:27:10 -0400
In-Reply-To: <20070801063209.GA13511@raptus.dandreoli.com> (Domenico
	Andreoli's message of "Wed, 1 Aug 2007 08:32:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54413>

Domenico Andreoli <cavokz@gmail.com> writes:

> This fixed things and also warned about two heads referring to pruned
> commits, which may be those two commits I removed by hand (I hope).

Exactly.

All refs under .git/refs (the special case of this includes the
branch heads in .git/refs/heads) are your _promise_ to git that
everything that is reachable from them are supposed to be
available in your repository.  If you remove specific commits by
hand without adjusting the branch ref, you are breaking that
promise and git-fsck will notice it as a repository breakage.

If you do not need a branch and everything reachable only from
that branch, you can remove that branch (with "git branch -D"),
and run git-gc, which internally does the same reachability
analysis as git-fsck does and gets rid of objects that are no
longer necessary.
