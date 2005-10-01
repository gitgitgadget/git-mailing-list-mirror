From: Wolfgang Denk <wd@denx.de>
Subject: Re: Destructive side-effect of "cg-status"
Date: Sat, 01 Oct 2005 21:42:16 +0200
Message-ID: <20051001194216.EE3E5353D8E@atlas.denx.de>
References: <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 21:43:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELnFy-0003na-4g
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 21:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJATmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVJATmr
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 15:42:47 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:47251 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750833AbVJATmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 15:42:46 -0400
Received: from fwd33.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1ELnFg-0003MN-03; Sat, 01 Oct 2005 21:42:32 +0200
Received: from denx.de (STR+omZU8eeoAujDKTARV4766Rxm+BV8QN4h911Mo+FVcL7hjPkJ8E@[84.150.83.140]) by fwd33.sul.t-online.de
	with esmtp id 1ELnFY-1mivyK0; Sat, 1 Oct 2005 21:42:24 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 0E9AB42BFC; Sat,  1 Oct 2005 21:42:22 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id EE3E5353D8E;
	Sat,  1 Oct 2005 21:42:16 +0200 (MEST)
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: Your message of "Sat, 01 Oct 2005 09:41:41 PDT."
             <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> 
X-ID: STR+omZU8eeoAujDKTARV4766Rxm+BV8QN4h911Mo+FVcL7hjPkJ8E@t-dialin.net
X-TOI-MSGID: 50daee4f-a31e-4ef9-9ac7-650e18e298a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9602>

In message <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
Linus Torvalds wrote:
> 
> Also, arguably we should try to avoid writing the index file when not 
> necessary, although the fact is, that cg-status (and "git status") _do_ 
> need to actually keep it up-to-date in order to do the right thing. Also 
> true of some other programs that might otherwise appear to be read-only 
> (ie I've considered doing the same thing for "git diff").

But shouldn't it be possible to run such  commands  as  "status"  and
"diff" in a repository for which I have only read permissions? Or how
can  I find out about the status of another user's repository without
actually modifying it?

Also, error reporting is IMHO  not  sufficient  and  misleading.  For
example:

	$ git status 2>&1 | less
	error: open failed
	#
	# Updated but not checked in:
	#   (will commit)
	#
	#       deleted:  CHANGELOG
	#       deleted:  COPYING
	#       deleted:  CREDITS
	#       deleted:  MAINTAINERS
	#       deleted:  MAKEALL
	#       deleted:  Makefile
	#       deleted:  README
	...
	[all files in the repository flagged as "deleted" !]
	#
	error: open failed
	read_cache: Permission denied

The "error: open failed" should at leats include the  file  name  and
the  errno/strerror  message.  Same  for  the "read_cache: Permission
denied" - of course, if you knot the git internals you will know what
this means, but the average user has no idea that he should check the
permissions of .git/index.

Finally, a thick fat warning should be  added  to  the  documentation
that  these  commands  actually (may) modify the repository. This was
totally unexpected for me.

Thanks.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In an infinite universe all things are possible, including the possi-
bility that the universe does not exist.
                        - Terry Pratchett, _The Dark Side of the Sun_
