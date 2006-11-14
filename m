X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 14:36:19 -0800
Message-ID: <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:37:41 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
	Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87bqn9u43s.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	14 Nov 2006 13:10:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31387>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6tk-00088I-IV for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966313AbWKNWgV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966416AbWKNWgV
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:36:21 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3315 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S966313AbWKNWgU
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:36:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114223620.RCYU296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:36:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mmcR1V00t1kojtg0000000; Tue, 14 Nov 2006
 17:36:26 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> On Tue, 14 Nov 2006 15:52:47 -0500 (EST), Nicolas Pitre wrote:
>> Even if I have a clear preference for GIT's _technology_, I still think
>> that the HG user interface is more convivial.  I even been thinking
>> about writing something like an hg-like frontend to GIT from time to
>> time just so that GIT could then be better compared to (and actually
>> just used like) HG.
>
> I've actually been tempted to do the same myself. I really think that
> the technology is a more important criterion than the UI so the
> imagined hg-on-git interface would be an attempt to get people to look
> past the interface differences and look at the technology when
> deciding.
>...
>> I still think that the GIT user interface sucks in many ways.  The
>...

I've actually been tempted to do that too, and my earlier "if I
were to redo git from scratch" message was the beginning of it
to summarize my preference about some of the issues raised in
this thread.

Commenting on the messages in this thread:

 - "resolve / resolved" are both confusing, when you are talking
   about "mark-resolved" operation.

 - "pull/push/fetch" have undesired confusion depending on where
   people learned the term.  I'd perhaps vote for replacing
   fetch with download and push with upload.

 - I think it would be sensible to make remote tracking branches
   less visible.  For example:

	git diff origin

   where origin is the shorthand for your upstream (e.g. you
   have .git/remotes/origin that records the URL and the branch
   you are tracking) should be easier to understand than

   	git diff remotes/origin/HEAD

   The latter is an implementation detail.  I could imagine we
   might even want to allow

	git diff origin#next

   to name the branch of the remote repository.  The notion of
   "where the tips of remote repository's branches are" is
   probably be updated by "git download" (in other words, the
   above "git diff" does not automatically initiate network
   transfer).

 - "git merge" to merge another branch into the current would
   make sense.  "git pull . remotes/origin/next" is showing too
   much implementation detail.  It should just be:

	git merge origin#next

And I agree with Pasky that fixing UI is hard unless you are
willing to get rid of historical warts.  Syntax of the command
line arguments the current set of Porcelain-ish takes are
sometimes just horrible.  It may not be a bad idea to start
building the fixed UI from scratch, using different prefix than
"git" (say "gu" that stands for "git UI" or "gh" that stands for
"git for humans").

Of course, it could even be "cg" ;-).

