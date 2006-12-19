X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enter interactive mode if no parameters are given to git-add
Date: Tue, 19 Dec 2006 10:00:44 -0800
Message-ID: <7vy7p3pxyr.fsf@assigned-by-dhcp.cox.net>
References: <200612191516.09606.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 18:00:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612191516.09606.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 19 Dec 2006 15:16:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34837>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwjGl-0001Pn-1m for gcvg-git@gmane.org; Tue, 19 Dec
 2006 19:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932865AbWLSSAr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWLSSAq
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 13:00:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62773 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932865AbWLSSAq (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 13:00:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219180044.TYKZ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 13:00:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0i0x1W0011kojtg0000000; Tue, 19 Dec 2006
 13:00:57 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> git-add with no parameters previously adds every modified file.  This
> patch instead makes git-add enter interactive mode.
> ...
> It seemed a bit nasty to add content without explicit instructions to do
> so.

Does anybody rely on the current behaviour?

It is nasty and I consider it a bug.  It appears that it has
been like that since the days when it was still a shell script.

While I think nobody should drive 'git add' from script, the
behaviour to add everything when there is no explicit parameter
(or fall back to interactive for that matter) has a problem if
you say "some command | xargs git-add --" (you need "xargs -r"
to fix it, which is GNU).

Let's first have a patch to exit with a warning message (but
status 0) without doing anything when there is no explicit
paths.

Again, does anybody rely on the current behaviour?

