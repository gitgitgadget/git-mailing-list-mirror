X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] shortlog: fix segfault on empty authorname
Date: Sat, 09 Dec 2006 22:01:21 -0800
Message-ID: <7vejr85lxq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
	<20061209040421.GA29113@coredump.intra.peff.net>
	<Pine.LNX.4.63.0612100019270.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061210034524.GA11819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 06:01:34 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061210034524.GA11819@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 9 Dec 2006 22:45:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33868>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtHkg-0001Ly-Sn for gcvg-git@gmane.org; Sun, 10 Dec
 2006 07:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759243AbWLJGBX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 01:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759292AbWLJGBX
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 01:01:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44157 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759243AbWLJGBX (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 01:01:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210060122.OYGD22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sun, 10
 Dec 2006 01:01:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wu1Y1V00i1kojtg0000000; Sun, 10 Dec 2006
 01:01:33 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It doesn't look like there are ever extra spaces to get soaked up in the
> kernel or git repositories, but if there is a reason to expect
>   Full Name    <user@domain>
> then we should probably replace my fix with yours.

As far as I know, commit-tree removes the extra space if exists,
so your fix would be fine in practice.

People could write crappy replacements of plumbing, and we may
end up with names with trailing whitespaces, but with your fix
at least that would not make us crash, and it may even be
considered a feature -- it would serve as a coalmine canary to
detect such a broken alternative program that creates bogus
commit objects.

We might want to tighten fsck-objects to warn about them,
though.  But that is probably rather low priority.
