X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Sun, 10 Dec 2006 13:27:43 -0800
Message-ID: <7vlklf4f1s.fsf@assigned-by-dhcp.cox.net>
References: <20061209232919.31863.58547.stgit@lathund.dewire.com>
	<7v3b7o8s5j.fsf@assigned-by-dhcp.cox.net>
	<200612101639.22397.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:28:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612101639.22397.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sun, 10 Dec 2006 16:39:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33930>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWD6-0004dE-Fp for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933059AbWLJV1p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbWLJV1p
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:27:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32880 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S933059AbWLJV1p (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:27:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210212744.GQOP4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 16:27:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id x9T61V00N1kojtg0000000; Sun, 10 Dec 2006
 16:27:07 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> Well, have you tried this?
>>
>> 	git diff-tree -p --binary fe142b3a | git apply --summary --numstat
> of course not. I didn't understand it. Why can't it tell me about removed
> binary files, so I could remove the git-diff-tree invocation to find out about 
> added/removed files?

Maybe I am missing something.  It tells you about added or
removed files (either binary or non-binary).

I'd prepare a pair of practice patch files.  "forward" has
creation, "reverse" has addition.

$ git diff-tree    -p --binary fe142b3a >forward.patch
$ git diff-tree -R -p --binary fe142b3a >reverse.patch


$ git apply --summary --numstat forward.patch
50      20      git-cvsexportcommit.perl
145     0       t/t9200-git-cvsexportcommit.sh
-       -       t/test9200a.png
-       -       t/test9200b.png
 create mode 100755 t/t9200-git-cvsexportcommit.sh
 create mode 100644 t/test9200a.png
 create mode 100644 t/test9200b.png

$ git apply --summary --numstat reverse.patch
20      50      git-cvsexportcommit.perl
0       145     t/t9200-git-cvsexportcommit.sh
-       -       t/test9200a.png
-       -       t/test9200b.png
 delete mode 100755 t/t9200-git-cvsexportcommit.sh
 delete mode 100644 t/test9200a.png
 delete mode 100644 t/test9200b.png

> This fuzz gives some, but not much slack. Reverting the option could be a 
> good idea.
>
> Update follows.

Ok.
