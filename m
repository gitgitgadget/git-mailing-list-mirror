X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Fri, 15 Dec 2006 13:55:10 -0800
Message-ID: <7vbqm4omdd.fsf@assigned-by-dhcp.cox.net>
References: <200612141519.44294.andyparkins@gmail.com>
	<Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<458179B4.7020408@brefemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:55:32 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34560>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL1U-0006W9-Ih for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965204AbWLOVzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWLOVzP
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:15 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52676 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965191AbWLOVzM (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215511.FGOM16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vN1V0111kojtg0000000; Fri, 15 Dec 2006
 16:55:23 -0500
To: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Sender: git-owner@vger.kernel.org

Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com> writes:

> Johannes Schindelin wrote:
>> On Thu, 14 Dec 2006, Andy Parkins wrote:
>>
>>> "master" shouldn't get special treatment; making different log
>>> messages based on the name of the branch is bad form.  What if a
>>> user likes "my/master" or "my/head" as their master branch?
>>
>> I do not agree. There is usually a principal branch, where you
>> collect the topics, and you do want to treat that special. As for
>> the name: better have a convention here than configurability. You
>> would not want "git" to be called "guitar" for some users, just
>> because they happen to like that name more, either, right?
>
> because I like the pattern framework described in the book "Software
> Configuration Management Patterns", I like to use "mainline" instead
> of "master", for example.

Tough.  Like it or not, 'master' has been the name of the
default branch since very early days of git (May 30, 2005).

I think you guys are barking up the wrong tree.  I do not agree
it is wrong to treat the principal branch (or branches, such as
my 'master' and 'maint', or Jeff's 'ALL' and 'upstream') in a
different way from other branches.

Quite the opposite.  It is a wonderful thing for something like
fmt-merge-message.

The recommended workflow when you have topic branches is to cook
new things in the topics and merge them into principal branches,
and never merge the other way or across topics unless you
absolutely need to (i.e. the topic's evolution depends on
something new in your principal branches or another topic).  So
merging into your principal branch is a normal event and giving
short message makes tons of sense, while merging into a topic is
an abnormal situation that warrants "into this-topic" along with
an explanation why that unusual cross merge was needed.

What we could improve is to allow people to use different names
other than 'master' for their principal branches, to help use of
words like 'mainline' and 'upstream'.  We can have a new
configuration under "branch.*" namespace to mark branches that
tells fmt-merge-msg to drop "into branch" part from its output.

When you have more than one principal branches, it may be useful
be able to tell which principal branch was merged into with a
particular merge, and in such a situation, you may want your
config to tell fmt-merge-msg not to drop "into branch" for any
branch.

On this "master is not special" topic, I would accept the
'status' patch that always makes it to say "on this branch" for
all branches, but this is not because 'master' is not special.

Committing on principal branches and committing on topic
branches both happen as a normal event, and I think it is not
unusual to have more than one principal branches in an advanced
usage scenario.  It is very prudent thing to remind the user
what branch he is on, so that he can tell he is about to make a
commit on a wrong branch.

