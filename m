From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 16:07:35 -0700
Message-ID: <7vd5ecb688.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	<Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
	<8aa486160605161542u704ccf03w@mail.gmail.com>
	<Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
	<8aa486160605170641p2ab8704o@mail.gmail.com>
	<e4f9eo$b60$1@sea.gmane.org> <1147893786.16654.5.camel@dv>
	<20060517153903.6b896fdd.seanlkml@sympatico.ca>
	<1147895816.30618.6.camel@dv>
	<Pine.LNX.4.64.0605171325200.10823@g5.osdl.org>
	<e4g1f4$anv$1@sea.gmane.org>
	<Pine.LNX.4.64.0605171342370.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 01:07:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgV7L-0006Cn-6t
	for gcvg-git@gmane.org; Thu, 18 May 2006 01:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWEQXHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWEQXHh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 19:07:37 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65425 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751139AbWEQXHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 19:07:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517230736.RTXV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 19:07:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605171342370.10823@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 17 May 2006 13:53:09 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20249>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, with the new-and-improved builtin "git add", you could probably do 
> something like the appended (on top of my most recent patch).
>
> It says
>
> 	No added files - did you perhaps mean to do a 'git update-index'?
>
> whenever it finds that "git add" has ignored a file and not actually added 
> anything. That, btw, can happen either because it refused to see the file 
> in the first place (ie it was ignored), or because all the files listed 
> were already added.
>
> In both cases the warning may or may not be sensible.
>
> Anyway, I dunno. I don't have any strong opinions on this.

If you give a pattern that would match two files but one of them
were hidden by .gitignore, this approach would not help you
much.

Even if we wanted to say something like "if the user explicitly
tells us to add etc/mtab~ by spelling it out, we should ignore
*~ entry in .gitignore", the shell expansion bites us because it
is done before we get to what the user give us.  We cannot
distinguish that with the user typing etc/?tab* for example.

If somebody (Jakub, perhaps?) cares strong enough, we could show
by default "matched the pathspec but ignored by .gitignore"
paths with fprintf(stderr, "ignoring '%s'\n"), and have an
option -q to squelch it.

I do not have strong feeling on this, so I'll see if somebody
comes up with a better implementation.
