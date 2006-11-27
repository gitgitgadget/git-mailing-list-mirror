X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Hyphens and hiding core commands
Date: Mon, 27 Nov 2006 15:59:17 -0800
Message-ID: <7vodqse90q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 23:59:35 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87bqmswm1e.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	27 Nov 2006 14:40:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32464>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoqNm-00067e-3N for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758627AbWK0X7U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758628AbWK0X7T
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:59:19 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48347 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1758627AbWK0X7T
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:59:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127235918.TFYC27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 18:59:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rzym1V00n1kojtg0000000; Mon, 27 Nov 2006
 18:58:47 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> There's another rule-of-thumb I would like to propose that's a bit
> harder to state, but I think is just as important (if not more):
>
> 	For introductory documentation it should never make sense to
> 	introduce a command with specific command-line options before
> 	the same command without options.

I tend to disagree.  "This is the easiest way to use, even for
beginners" and "this way should be the default for all levels of
users" are quite different.

> As examples, both "commit -a" and "cat-file -p" fail that test and
> both appear in the git tutorial here:
>
> 	http://www.kernel.org/pub/software/scm/git/docs/tutorial.html
>
> My proposals to fix those two are:

Creating a "git cat" and promote that in the Tutorial makes a
lot of sense, but then that can easily be done with aliases ;-).
cat-file is plumbing.  We did not even have '-p' and you needed
to _know_ the type of stuff you are feeding and we had '-t' to
help you do so.  '-p' was done as a quick hack because showing
the representation of any object in semi human readable way was
not all that important but occasionally people found it useful,
and it just was an easy thing to do inside cat-file.  Nobody
bothered to do a real Porcelain called "git cat" for that
purpose, so far, but that is probably what should have been.  On
the other hand, if "cat-file -p" needs to be used often, I think
there is something ELSE that is wrong.

I do not think defaulting to "commit -a" is a fix; rather, it
feels exactly what Linus was talking about when he said about
"second system syndrome".

I would not mind if you created "commit-easy" (just like curl
library has curl_x_easy), but the current way the command works
is more useful once you grok the index.  Being able to work in a
slightly dirty tree and commit only the necessary things, and
being able to do so even for a merge commit, is damn convenient.

Because there is a learning curve involved, an easier way to use
git without worrying about the index was added in the form of
'-a' for beginners.  People who use index regularly should not
be forced to spend extra keystrokes for the rest of their lives
only because you want to lose '-a' from the tutorial document.
The tool should be designed for regular users, not for the first
few pages of the tutorial.
