From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 00:47:14 -0700
Message-ID: <7vps77ngcd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	<Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	<7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.83.0703172053020.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 08:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSq6o-0001EX-Kt
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 08:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbXCRHrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 03:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbXCRHrR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 03:47:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50550 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbXCRHrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 03:47:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318074714.GTJA28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 03:47:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c7nF1W0011kojtg0000000; Sun, 18 Mar 2007 03:47:15 -0400
In-Reply-To: <alpine.LFD.0.83.0703172053020.18328@xanadu.home> (Nicolas
	Pitre's message of "Sat, 17 Mar 2007 21:13:57 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42480>

Nicolas Pitre <nico@cam.org> writes:

> A malloc() + memcpy() will always be faster than mmap() + malloc() + 
> inflate().  If the data is already there it is certainly better to copy 
> it straight away.

I do not know if there is mmap() cost involved, but you are
correct to point out that my aversion to malloc() cost was
unfounded.  We need to allocate anyway, and memcpy() should of
course be cheaper than inflate().

> With the patch below I can do 'git log drivers/scsi/ > /dev/null' about 
> 7% faster.  I bet it might be even more on those platforms with bad 
> mmap() support.

Wonderful.  I was going to nitpick but you even took care of the
convention of returning a buffer with one extra byte that
terminates the contents with NUL.  Perfect.
