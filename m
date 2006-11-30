X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-fetch -k is broken
Date: Thu, 30 Nov 2006 13:21:59 -0800
Message-ID: <7vd574iqa0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611301441440.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 21:22:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301441440.9647@xanadu.home> (Nicolas Pitre's
	message of "Thu, 30 Nov 2006 15:11:54 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32801>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GptM7-0006ld-Gq for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031493AbWK3VWE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031519AbWK3VWD
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:22:03 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52178 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1031506AbWK3VWB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:22:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130212200.CHEA7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 16:22:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id t9N81V00s1kojtg0000000; Thu, 30 Nov 2006
 16:22:09 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Actually, the .keep file is simply not removed as it should.
>
> But first it appears that commit f64d7fd2 added an && on line 431 of 
> git-fetch.sh and that cannot be right.  There is simply no condition for 
> not removing the lock file.  It must be removed regardless if the 
> previous command succeeded or not.  Junio?

True, but your "echo" patch breaks things even more -- when fast
forward check fails, it should cause the entire command should
report that with the exit status.

That suggests that we need to come up with a way to clean up
these .keep files some other way than just being one of the
command near the end.  As to the mysterious "echo e <empty>"
I will not have chance to look at it myself until later today
(I'm at work now and it is not my git day today).
