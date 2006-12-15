X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 10:14:18 -0800
Message-ID: <7v3b7hxc05.fsf@assigned-by-dhcp.cox.net>
References: <200612151519.kBFFJSYn012227@laptop13.inf.utfsm.cl>
	<4582C233.1000706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 18:14:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4582C233.1000706@op5.se> (Andreas Ericsson's message of "Fri, 15
	Dec 2006 16:41:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34536>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvHZt-0001Tc-P6 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 19:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753119AbWLOSOV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbWLOSOV
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:14:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51103 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753119AbWLOSOU (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 13:14:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215181419.XCMT16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 13:14:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z6EX1V00U1kojtg0000000; Fri, 15 Dec 2006
 13:14:31 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

>>> The number in front is octal mode of a file or directory. "blob"
>>> is a file (or symbolic link), "tree" is a directory, all of this
>>> can be found in git(7).
>>
>> I don't want to come through as rude, but that you can find the explanation
>> somewhere (and as an old(ish) Unix/git hand you know (or should be able to
>> guess easily) what it means) doesn't help the _newbie_ confronted with this
>> gibberish one iota.
>
> I think it would help if we could write out things ls-style though and
> I'm all for axing the SHA1 (I don't even think the SHA1 of specific
> files of a tree can be *used* for anything), so the above would be
>
> -rw-r--r-- Makefile
>
> which most newbies should grok fairly quickly.

'ls-tree' is a plumbing and existing scripts (not limited to
what are in git.git) use it to extract object names from
arbitrary trees.  It's output format will NOT change.

The honest position to take on "svn list" question is "we do not
have a counterpart for that command".

Now, I happen to think "getting list of all paths in one
particular revision" is not a very useful operation from the end
user's point of view.  One possible use is to get such a list
from multiple revisions and compare them with "comm -3", but
that is obviously useless in the context of git.  You can do
that with "diff --name-status --diff-filter=AD" without doing
ls-tree yourself.

But if "ls $commit" is still interesting at end-user level,
probably we would need a Porcelain to let users do so.

Johannes recently made

	$ git show $commit^{tree}

to do the name-only variant.

If people actually do "ls-tree --name-only" (or ls-tree
--like-ls-l) often, we might want to be even easier:

	$ git show --ls $commit

or even:

	$ git ls $commit

or even:

	[alias] ls = ls-tree --name-only

