From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Fri, 10 Feb 2006 01:05:28 -0800
Message-ID: <7vmzgzy46f.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7UDk-0003fo-QS
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 10:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWBJJFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 04:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWBJJFc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 04:05:32 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:20101 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbWBJJFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 04:05:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210090355.LDMQ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 04:03:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081726390.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 17:30:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15869>

Linus Torvalds <torvalds@osdl.org> writes:

> Under that logic, "git status -v" would show all the diffs (not just 
> filenames) and "git commit -v .." would be the same as "git commit .." but 
> the "-v" flag would have been passed down to the "git status" call, so the 
> commit message file would be pre-populated with the diff.

Now that is done and sitting at the tip of "next".

> For small commits, it's actually nice to see the diff itself as you write 
> the commit message.

Yes, that is my experience, and even with fairly big one, it is
pleasant as long as your editor allows you to C-x 2 C-x o around
the file you are editing, like "em" ;-).

commit cf7bb589af739563c90dc32b4901bea73aaaa9d0
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri Feb 10 00:45:59 2006 -0800

    git-status -v
    
    This revamps the git-status command to take the same set of
    parameters as git commit.  It gives a preview of what is being
    committed with that command.  With -v flag, it shows the diff
    output between the HEAD commit and the index that would be
    committed if these flags were given to git-commit command.
    
    git-commit also acquires -v flag (it used to mean "verify" but
    that is the default anyway and there is --no-verify to turn it
    off, so not much is lost), which uses the updated git-status -v
    to seed the commit log buffer.  This is handy for writing a log
    message while reviewing the changes one last time.
    
    Now, git-commit and git-status internally share the same
    implementation.
    
    Unlike previous git-commit change, this uses a temporary index
    to prepare the index file that would become the real index file
    after a successful commit, and moves it to the real index file
    once the commit is actually made.  This makes it safer than the
    previous scheme, which stashed away the original index file and
    restored it after an aborted commit.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
