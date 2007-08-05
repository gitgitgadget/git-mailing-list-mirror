From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug in git apply?
Date: Sat, 04 Aug 2007 22:11:19 -0700
Message-ID: <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 07:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYOj-0006Cn-Ny
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbXHEFLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbXHEFLV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:11:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34164 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246AbXHEFLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:11:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805051121.UZYA26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 01:11:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y5BK1X00N1kojtg0000000; Sun, 05 Aug 2007 01:11:20 -0400
In-Reply-To: <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 4 Aug 2007 21:48:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54948>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It should. I thought we did that, but maybe there's some bug there.
>
> See "remove_file()" in builtin-apply.c.
>
> But yeah, it seems that the file *rename* ends up not triggering that 
> logic! Very annoying.
>
> Does this fix it? Totally untested, but it _looks_ obvious enough..

That would regress the fix made in aea19457, I am afraid.  If
you are in a subdirectory and the rename patch moves away the
last file in your current directory, the shell session you ran
the git-apply from will end up in an unlinked directory.

Maybe that is a pilot error, and we can revert aea19457
altogether?
