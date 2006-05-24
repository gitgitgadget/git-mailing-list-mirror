From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending line
Date: Tue, 23 May 2006 18:09:52 -0700
Message-ID: <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
	<7vd5e4z2je.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 03:10:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fihsq-00044e-GO
	for gcvg-git@gmane.org; Wed, 24 May 2006 03:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWEXBJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 21:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEXBJy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 21:09:54 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52688 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932198AbWEXBJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 21:09:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524010953.WGGB27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 21:09:53 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20654>

Junio C Hamano <junkio@cox.net> writes:

> To git-apply, this patch:
>
>         diff --git a/file b/file
>         --- a/file
>         +++ b/file
>         @@ -1,2 +1,3 @@
>          a
>          b
>         +c
>
> currently means "I want to append a line c immediately after the
> lines that have a and then b".
>...
> I do not think this is necessarily a bug.  You _could_ make the
> EOF a special case (i.e. you _could_ interpret the patch that it
> also says, with "@@ -1,2", that "the result of this patch _must_
> end with this line I just added"), and if you are going to do
> that, you would also need a symmetric special case for the
> beginning of the file, but I do not think it is the right thing
> to do in general.

Come to think of it, the above argument is bogus.  We _would_
want to make EOF just like any other context lines.

The issue is if we can reliably tell if there is such an EOF
context by looking at the diff.  Not having the same number of
lines that starts with ' ' in the hunk is not really a nice way
of doing so (you could make a unified diff that does not have
trailing context at all), and I do not offhand think of a good
way to do so.
