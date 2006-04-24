From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-clone --reference problem?
Date: Mon, 24 Apr 2006 01:12:22 -0700
Message-ID: <7vmzeb8k9l.fsf@assigned-by-dhcp.cox.net>
References: <1145810080.16166.223.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0604231122490.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Apr 24 10:12:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXwBH-0006Ze-Og
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 10:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWDXIMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDXIMY
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 04:12:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20181 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751134AbWDXIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 04:12:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424081223.BSUO13862.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 04:12:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604231122490.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 23 Apr 2006 11:34:24 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19091>

Linus Torvalds <torvalds@osdl.org> writes:

> Maybe something like this could work.
>
> Untested, of course. It probably isn't even syntactically correct shell. 
> Whatever. You get the idea.
>
> (That while-loop could probably be simplified to just a 
>
>   cat ""$reference/objects/info/alternates" >> "$GIT_DIR/objects/info/alternates"
>
> because all alternates _should_ already be absolute paths, but hey, 
> whatever.

I was hoping that the solution would be to do the recursive
alternate resolution on the runtime side (IOW, prepare_alt_odb()
in sha1_file.c).  Then the repository you borrow from _could_
change its own alternates after you set up your repository to
borrow from it.

Currently, if the repository you borrowed from suddenly starts
borrowing from somewhere else and pruned itself by running
"repack -a -d -l", the borrower would be in trouble, even with
your patch.
