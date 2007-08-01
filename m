From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Wed, 01 Aug 2007 10:26:29 -0700
Message-ID: <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHxz-0006Ih-Dq
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbXHAR0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbXHAR0b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:26:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36270 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbXHAR0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 13:26:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801172629.SPEN14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 13:26:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WhSV1X00P1kojtg0000000; Wed, 01 Aug 2007 13:26:30 -0400
In-Reply-To: <vpqwswf8c1i.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed,
	01 Aug 2007 18:17:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54458>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> $ touch bar
> $ git diff
> diff --git a/bar b/bar         <--- here ---<
> $ git status
> # On branch master
> nothing to commit (working directory clean)
> $ git diff                     <--- status updated
>                                     the stat in the index.
>
> Is this intended,

Yes.  Very much so, intentionally, from very early days of git.
This serves as a reminder to the user that he started editing
but changed his mind to end up with the same contents as the
original, until the next "update-index --refresh" (which is
internally invoked from "status").

If the feature still makes sense in the modern world is a
different story, but I do find it useful.

Not the made-up "touch" example, but often in real life, I
explore a solution by first making changes to one part of the
system, realizing a better way is to change the caller of what I
initially thought should be changed, edit the file back and
modify the caller which is in another file.  The former file
will show that empty "header-only" diff as the reminder of what
I did.

After that, when I reach the point to run "git status", because
I have been reminded, I already know about these "tried but
discarded" changes, and I find the fact that the they are forgot
by that operation very convenient.
