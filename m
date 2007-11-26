From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Sun, 25 Nov 2007 22:11:50 -0800
Message-ID: <7vejedh6xl.fsf@gitster.siamese.dyndns.org>
References: <200711252248.27904.jnareb@gmail.com>
	<20071125222314.GC21121@artemis.corp>
	<20071126012837.GA5402@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 07:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwXCe-0007Cp-4g
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 07:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbXKZGMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 01:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbXKZGMA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 01:12:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36382 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbXKZGL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 01:11:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F23942F0;
	Mon, 26 Nov 2007 01:12:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 56F0F97DAA;
	Mon, 26 Nov 2007 01:12:14 -0500 (EST)
In-Reply-To: <20071126012837.GA5402@dervierte> (Steven Walter's message of
	"Sun, 25 Nov 2007 20:28:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66046>

Steven Walter <stevenrwalter@gmail.com> writes:

> Heartily seconded.  I think checkout is the most egregrious of the
> three.  git-checkout can be used to:
>
>     * Switch branches
>     * Create a branch
>     * Change the state of all files to a particular commit
>     * Change the state of a particular file to that of the index
>     * Change the state of a particular file (and index) to a particular
>       commit

Come on.  The second one is just to give a short-hand side-effet for
commonly used operation and you do not have to use it nor learn it.

Also, you have written the last three in a more confusing way than it is
necessary.  They are all the same thing but with variations --- your way
of writing them is like enumerating "change the state of files whose
name starts with A", "change the state of files whose name starts with
B", etc. as if they are distinctly different and confusing operations.

Let's clear the confusion.  Although it is not bad like the above
"random 5 different operations", checkout does serve 2 quite different
purposes:

 (1) checkout a revision.

     This primarily affects the notion of where your HEAD is.  Is it
     pointing at a branch, or detached at a particular commit?  In
     either case, the objective from the user's point of view here is "I
     want to change on which commit and/or branch I'd build the next
     commit, if I were to issue git-commit command".

     "I started modifying but realized that I wanted to build not on top
     of master but a separate topic", is a typical use case, and this
     form will let you take your local changes with you exactly for this
     reason.

     Obviously when people say "I checkout this commit", they mean the
     state of the work tree and they mean the whole tree.  It is
     hopefully clear that is what you are doing from the fact that you
     do not give any pathspec to the command to trigger this mode of
     operation.

 (2) checkout selected paths out of a commit (or the index).

     "I screwed up.  I want to start over modifications to these files
     from the state of the previous commit (or the last state I
     staged)." is a typical use case for this mode.  For this reason,
     the named paths are updated in the work tree and the work tree and
     the index are made to match.

     Again, it hopefully is clear enough that you need to give some
     pathspec to it for the operation to make sense, if you understand
     the purpose of the command.  Like "." to mean the whole tree, "*.c"
     to mean all C files, or "directory/" to mean everything underneath
     it.

So yes, it does two quite different things, and that's mostly because
the verb "to check out" has overloaded meanings.

Hopefully it is clear which one you are using by thinking about the
reason WHY you are "checking out", and by looking at the way you form
the command line.
