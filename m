From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 00:59:57 -0800
Message-ID: <7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	<20060119052914.GC8121@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:00:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzVeH-0000UA-Q8
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 10:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWASJAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 04:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbWASJAA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 04:00:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44437 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161285AbWASI77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 03:59:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119085852.WHJF20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 03:58:52 -0500
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060119052914.GC8121@trixie.casa.cgf.cx> (Christopher Faylor's
	message of "Thu, 19 Jan 2006 00:29:14 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14892>

Christopher Faylor <me@cgf.cx> writes:

> "They" probably would like to hear about any irregularities that are found.
> "They" probably don't like it when people treat an open source project as
> if it was some unresponsive proprietary enterprise which does not listen
> to or accept patches.

First of all, thanks for joining our discussion.  Being able to
hear from somebody from other project firsthand (not just listen
to somebody talking in his own changelogs and code comments, but
in actual e-mail exchange discussion) lets us put faces and
names to the entity "so far just one of the external projects to
us".

>>For reasons unknown, cygwin decided to use our sockaddr_storage.

I haven't looked at the proposed patch by Alex, so would not
comment on this part, but I'd appreciate your input.

>>For the other, probably unrelated, reasons, they decided to leave
>>declarations of DT_* macros in dirent.h without providing dirent->d_type.

I was wondering what the justification for keeping DT_* without
d_type myself.  What is the preferred resolution on this one
from your point of view?  I suspect removing d_type while
leaving DT_* was just a transient error and you would want to
remove DT_* as well, in which case the patch on this issue by
Alex would become unnecessary.

>>And on top of that, they removed dirent->d_ino (or probably replaced it
>>by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
>>referenced only in fsck-objects.c Anyway, to workaround this I put
>>
>>COMPAT_CFLAGS += -Dd_ino=__ino32
>>
>>It helps, but surely is not the solution.
>
> I don't see how it could help since __ino32 is not actually filled in
> with anything.  In fact, I'll rename the field to __invalid_ino32 to
> make that clear.

I think renaming __invalid_* makes sense.  I'll see how we would
work this around on the git side to make things more portable.
