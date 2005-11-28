From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 17:07:07 -0800
Message-ID: <7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
	<7vr792fnta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
	<20051127182244.GK22159@pasky.or.cz>
	<Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 28 02:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgXUD-0006zO-FM
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 02:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVK1BHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 20:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVK1BHL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 20:07:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50162 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbVK1BHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 20:07:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128010638.UXMJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 20:06:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511271049090.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 11:00:09 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12842>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 27 Nov 2005, Petr Baudis wrote:
>> Ugh. That's really weird. Wouldn't a better approach be to fix
>> git-ls-files to behave more sanely? (That is, listing the entry for
>> drivers/char instead of drivers?)

It behaves sanely, just not in the way you are expecting.

> Well, it's not actually confusing if you see a path spec for
> what it is: it's not a filename, it's a _pattern_.

Well, that is confusing, although it may be sane.

> So you should always do
>
> 	git-ls-tree -r pattern
>
> (and yes, we could even hardcode "-r", because git-ls-tree without it 
> really is a pretty strange thing).

If you mean "in the presense of pathspec, default to -r", I
*might* agree, but I am not convinced yet.

Without pathspec, ls-tree is a pretty-printing version of
"git-cat-file tree", and that is how the command is used by the
git browsers like gitweb.  I have never looked at qgit source,
but I'd be surprised if it did not depend on the single-level
behaviour of ls-tree for that purpose.

It *is* "/bin/ls" after all, and you _would_ get annoyed if your
/bin/ls always recursed if you gave an argument.  Imagine going
to the kernel source and try "/bin/ls arch" with your version of
/bin/ls that always recurses, when you only wanted to get the
list of architectures you are supporting ;-).

> The _real_ strangeness in "git-ls-tree" is that it shows the tree nodes at 
> all, which no other git tool does when it recurses. 

Very true.  I do not think even git browsers need that but I may
be mistaken.

Having said all of the above, I do understand why we would
_also_ want the behaviour parallel to ls-files, not /bin/ls
behaviour.  Maybe we should have both?  Either rename the
current ls-tree to browse-tree, and make the one that parallels
ls-files the new ls-tree?
