X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 00:56:35 -0800
Message-ID: <7v4ptj7dfg.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
	<7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
	<200611010839.35436.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 08:56:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611010839.35436.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 1 Nov 2006 09:39:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30624>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBtv-0006Rx-H1 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423954AbWKAI4i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423955AbWKAI4i
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:56:38 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45015 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1423954AbWKAI4h
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:56:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101085636.EHBA22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Wed, 1
 Nov 2006 03:56:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id hLwF1V00P1kojtg0000000 Wed, 01 Nov 2006
 03:56:16 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

>> Then perhaps you can use "git checkout HEAD frotz", which is the
>> simplest?
>
> Doesn't that update the working directory as well as the
> index?

Yes, sorry, see my other mail.

> (imaginary) "git-update-index --reset" would not.

update-index is a plumbing that is about updating index (hence
its name) and should not care what the HEAD is, and it does not
even have to have _any_ head to do its work, so in that sense,
"update-index --reset" is conceptually a layering violation.

Another possibility is read-tree, which is another plumbing that
is about updating index from an existing tree (or three).  It
does not take paths limiter, so conceptually that is not too
bad.  We _could_ do so if we really wanted to.

But these two commands are meant to be used as building blocks,
so if there are more suitable UI commands at the Porcelain layer
to implement what we want to do without introducing more special
cases to these plumbing commands, I would rather not touch them.

