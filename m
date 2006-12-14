X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 13:22:00 -0800
Message-ID: <7vmz5q18cn.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:22:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612140959.19209.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 09:59:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34402>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guy1p-0001Vp-32 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932925AbWLNVWF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbWLNVWF
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:22:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49563 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932925AbWLNVWE (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:22:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214212201.ZYGT25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 16:22:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ylNC1V00V1kojtg0000000; Thu, 14 Dec 2006
 16:22:12 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

>> >  Tell them if they
>> >  made a branch as well, which branch they are now on.
>>
>> I think you are talking about "checkout -b" not commit here;
>> this might be a borderline (branch creation is less often done
>> and it might warrant assuring feedback), but I think it still
>> falls into the "doing exactly what it was told to do" category.
>
> You're right, I was.  The reason I think feedback is useful is
> because of the two ways of making a new branch:
>
>  - git-branch XYZ
>    This makes a new branch but DOESN'T leave me on XYZ
>  - git-commit -b XYZ
>    This makes a new branch and switches to XYZ
>
> I can't tell you the number of times I get this wrong.  It's not because I 
> don't know if I stop to think, it's because I'm thinking about the project, 
> not the VCS.

This is interesting.  You said "commit -b", were pointed out
that you were talking about "checkout -b", and just after saying
"yup, that is right, I was", you again say "commit -b".

Maybe the users often need this sequence (I personally don't,
but others might):

	$ git checkout ;# or the previous day ended with a clean state
	$ edit edit hack
        $ git checkout -b XYZ ;# the changes are about different stuff
        $ git commit ;# commit the changes there
        $ git checkout master ;# or whatever branch you usually are on

and "git commit -b <newbranch>" might be a handy shortcut for
the last three commands.  I dunno.

And if we had such a variant of commit, then it is doing
something unusual, so I would not oppose (actually I would
probably favor) if the transcript went something like this:

	$ git commit -b XYZ -m "implement 'foo' subcommand" -a
	committed changes to newly created branch XYZ, back on 'master'.
	$ git show-branch master XYZ
        * [master] finishing touches to 'hello world'
         ! [XYZ] implement foo subcommand
        --
         + [XYZ] implement foo subcommand
        -- [master] finishing touches to 'hello world'
	$ exit

Earlier I said that the command should be silent if it did
exactly what it was told to do with some 'unless'es.

 * If the command fails, we should report (no question).

 * If the command succeeds the usual way, staying silent is
   preferable, at least to me.

 * If the command can have more than one mode of successful
   outcome, stating success in which way is not a useless
   verbosity.  E.g. 'git merge' should probably tell you if it
   did a usual three-way or a fast-forward (if the difference
   matters).  Especially reporting an unusual case a bit more
   verbosely than usual is a good thing.
