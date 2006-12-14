X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 02:21:24 -0800
Message-ID: <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 10:21:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612140959.19209.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 09:59:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34300>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuniV-0005Hp-GX for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751849AbWLNKV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWLNKV0
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:21:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54603 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751849AbWLNKVZ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 05:21:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214102125.DUAW20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 05:21:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yaLm1V0011kojtg0000000; Thu, 14 Dec 2006
 05:20:46 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> $ git commit
> Revision XXXXXXXXXXXXXXXXXX successfully added.
>
> I'd actually argue that git-commit is a particular problem because it's too 
> fast.  You quit editing your commit message and bang, you're back at the 
> command line.  Then you run git-log to make sure it really was committed.

You keep repeating that you want to know the object name of the
newly created commit.  I would very strongly agree with you that
it would be a fatal UI bug of git-commit if that information
were vital for the end user after making each commit.

But you never communicate with your own git repository using the
SHA-1 object names when talking about commits you made recently
(you would have the SHA-1 output from your updated version of
'git commit' command on the screen or in your scrollbuffer for
them -- you would need to refer to commits older than what your
scrollbuffer has in different way anyway).  Git gives branch~<n>
notation, and commands like "git log --pretty=short" and friends
would show them which you can easily cut&paste.  When people
talk about object names on the mailing list, they do so by
asking "git log" and friends to find them out -- it is pretty
much "on demand" type of thing and I do not think continually
mentioning SHA-1 object names buys us anything.

In other words, the following transcript would be possible but
not realistic:

	$ git commit
        Revision deadbeef0000 created.
        : now what did I do?
        $ git show deadbeef0000
        : oops, that is wrong
        $ git reset --hard deadbeef0000^

So I do not think "git commit" is a valid example.  I also agree
with Shawn that "git add" that says 6781 files were added is
pointless.

>> However, perhaps you could make lack of "[user] expert = true"
>> in ~/.gitconfig to trigger more verbose messages that say "yes
>> sir I did what I was told to do".
>
> I've always thought that programs that needed an expert/beginner split were 
> badly designed.

There probably is a truth in that.  Let's not add verbosity
unnecessarily.

I agree with you that making some commands with progress
indication less chatty would be a good clean-up.
