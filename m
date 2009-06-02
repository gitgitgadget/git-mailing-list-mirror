From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Duplicating a branch
Date: Tue, 02 Jun 2009 08:36:13 -0700
Message-ID: <7voct6fy1e.fsf@alter.siamese.dyndns.org>
References: <BAF61FDE71D344FDB9F1415B5E2AFD75@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aaron Gray" <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBW2H-0003P7-Hi
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064AbZFBPgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757238AbZFBPgR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:36:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43496 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863AbZFBPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:36:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602153614.YINT2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 2 Jun 2009 11:36:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id z3cE1b0044aMwMQ043cEb9; Tue, 02 Jun 2009 11:36:14 -0400
X-Authority-Analysis: v=1.0 c=1 a=mK_AVkanAAAA:8 a=e5pJM0DCT7GrrfdluIgA:9
 a=_uLeuJEejKoq1XPHae4A:7 a=7I8jcMD0R1neiffkLkIlHt9yoMMA:4 a=9xyTavCNlvEA:10
X-CM-Score: 0.00
In-Reply-To: <BAF61FDE71D344FDB9F1415B5E2AFD75@HPLAPTOP> (Aaron Gray's message of "Tue\, 2 Jun 2009 16\:19\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120522>

"Aaron Gray" <aaronngray.lists@googlemail.com> writes:

> How do I go about duplicating a branch within a repository, so I can
> make test mods ?

Run

    $ git checkout -b experiment master

to make a new "experiment" branch that points at the same comit as
"master" (or whatever other branch), hack away (including committing which
would grow the history of "experiment" branch without touching "master").

After you are done, and if you want to discard it, simply:

    $ git checkout master
    $ git branch -D experiment

or if you want to keep all of it:

    $ git checkout master
    $ git merge experiment

*BUT* if your "experiment" was truly exploratory in the sense that your
history is full of "let's try this, commit to snapshot, test, oops, it did
not work, let's try that, commit to snapshot, test, ok, I made some
progress, let's continue" crufts, you would most likely want to clean-up
your history before the latter "checkout master and merge experiment into
it" steps with something like:

    $ git rebase -i master experiment

If you in advance know that what you are going to do is truly "throw-away
experiment", you do not even need to use an "experiment" branch.  You can
do your exploration while on a detached HEAD:

    $ git checkout master^0

and hack away, including making commits (but you will discard them in
the end), and then finally:

    $ git reset --hard ;# if you have local changes you do not want to
			  take back to master
    $ git checkout master



    
