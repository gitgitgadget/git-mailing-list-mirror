X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Sun, 26 Nov 2006 23:25:23 -0800
Message-ID: <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
	<7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
	<e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 07:25:46 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, catalin.marinas@gmail.com,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
	(Marco Costalba's message of "Mon, 27 Nov 2006 07:38:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32387>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goas0-0003CL-75 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 08:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757173AbWK0HZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 02:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757174AbWK0HZZ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 02:25:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1988 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1757173AbWK0HZY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 02:25:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127072524.LRVR20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 02:25:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rjRY1V00B1kojtg0000000; Mon, 27 Nov 2006
 02:25:32 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

"Marco Costalba" <mcostalba@gmail.com> writes:

> Could a possible '--all-branches' new option come to rescue?

I doubt it.  Next thing people would start talking about is what
to do with the remote tracking branches, and what we are talking
about is rev-list, one of the lower level of plumbing that would
be better left without knowing much about the Porcelain's use of
refs/ namespaces.

If you (as a Porcelain) want to get all refs under refs/heads/,
there are (unfortunately) two ways to get that list.  I would
suggest obtain the refs you want that way, pass them as command
line arguments to rev-list.

$ git for-each-ref --format='%(refname)' refs/heads
$ git show-ref --heads | sed -e 's/^[^ ]* //'

