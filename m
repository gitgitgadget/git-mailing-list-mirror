X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Sun, 03 Dec 2006 22:32:34 -0800
Message-ID: <7v7ix8rx19.fsf@assigned-by-dhcp.cox.net>
References: <7v1wngv2rc.fsf@assigned-by-dhcp.cox.net>
	<505428.75434.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 06:32:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33165>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr7NZ-0004Gs-M7 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 07:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934343AbWLDGcg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 01:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934363AbWLDGcg
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 01:32:36 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:33977 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S934343AbWLDGcg
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 01:32:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204063235.HNOC97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 4 Dec
 2006 01:32:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uWY01V00Q1kojtg0000000; Mon, 04 Dec 2006
 01:32:01 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> Sometimes when I pull things from a bunch of places and do
> a resolve, I'm presented with the standard resolve format of
> a source file, "<<<< ==== >>>>" thingie, and all I'd really
> like to do is "accept ours".  I.e. something similar to what I've
> seen in other (commercial) SCMs, a la "scm resolve accept ours".
>
> This patch merely allows the user to say
>    git-checkout-index --stage=ours their_broken_file.c
> instead of
>    git-checkout-index --stage=2 their_broken_file.c
> and similarly for "theirs", etc.

That's _exactly_ my point.  It "merely allows to".

> If you think this breaks the ideology, ok.

It's not about the ideology.  It's in the part you quoted but
did not respond to (by the way, please don't quote the the bulk
of the message if you are not responding to it).

You stopped at only adding "ours" as synonym for "2" and did not
do anything else in the patch; it is a very sensible thing to
do, because "checkout-index" is a plumbing command that is about
checking out files from the index to the working tree.

But that means you HAVE TO stop at that because you are working
at the plumbing layer.  You said yourself that what you really
wanted to do was "scm resolve accept ours".  And from an end
user's point of view, "checkout --stage=ours" is NOT it.

A user who wants to see "accept ours" wants the scm to perform:

	git checkout-index --stage=2 paths...
        git update-index paths... ;# or Nico's "git add"

for him.  That is why I suggested to hoist the place you
implement this usability improvement up one level and make the
Porcelain level command:

	git checkout --ours paths...

to do the above two plumbing command sequence internally for the
end user.
