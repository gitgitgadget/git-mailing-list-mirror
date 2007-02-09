From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 09 Feb 2007 12:22:48 -0800
Message-ID: <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcGk-0003Tw-BX
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992793AbXBIUWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992802AbXBIUWu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:22:50 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54250 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992793AbXBIUWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:22:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209202250.UCLR21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 15:22:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MYNo1W00T1kojtg0000000; Fri, 09 Feb 2007 15:22:49 -0500
In-Reply-To: <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Feb 2007 11:56:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39195>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> "git status" doesn't "pretend" to write stuff. It really does. 
>
> You *can* just use "git-runstatus" instead. That's the command that 
> actually does all the heavy lifting. But you can see the difference by 
> doing this:
>
> 	touch Makefile
> 	git runstatus
>
> vs
>
> 	touch Makefile
> 	git status
>
> Notice how the "runstatus" one claims that Makefile is "modified:". That's 
> exactly because it doesn't do the index refresh.

Running refresh internally in runstatus without writing the
result out _might_ be an option, but that would largely be
a hack to only help qgit.

Other shapes of "git status", such as "git status <filename>"
and "git status -a", still need to perform the same index
manipulation as "git commit" with the same parameters before
calling git-runstatus, and at that point the extra "internal
refresh" in runstatus is an unwelcome extra cycle.
