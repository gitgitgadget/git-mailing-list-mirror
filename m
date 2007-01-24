From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 04:21:01 -0800
Message-ID: <7vps94fweq.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
	<Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 13:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9h7m-0005a5-7i
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 13:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAXMVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 07:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAXMVE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 07:21:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52851 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAXMVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 07:21:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124122101.TJYE18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Wed, 24 Jan 2007 07:21:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id F0L51W0021kojtg0000000; Wed, 24 Jan 2007 07:20:05 -0500
In-Reply-To: <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
	(Francis Moreau's message of "Wed, 24 Jan 2007 12:13:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37631>

"Francis Moreau" <francis.moro@gmail.com> writes:

> ... Givinig that I would use it to describe the HEAD of the kernel repo:
>
>        $ git describe --remote=<git-server> HEAD
>
> this would make the server parse all commits between HEAD and the
> closest tag which seems to me a lot cheaper than downloading the whole
> repo...

Do you mean you want to have the server describe the HEAD the
server side has (not the HEAD in your repository)?  Why?

I suspect the real motivation of your question lies elsewhere
and not in "describe".

Suppose we had such a service on the server side, and you asked
the server twice and got these (at different times, of course):

	v2.6.20-rc5-g419dd83
	v2.6.20-rc5-gde14569

What useful information can you get between the two?  

Nothing.

The commit object names are like random numbers and 419dd83 may
or may not be older than de14569.  The "hash" part of the
output is meaningless for you until you actually have the
history to poke at with "git log", "git diff" and friends.

Another request might give you this:

	v2.6.20-rc6

At least, between this one and the previous two, you have a
little bit of information that you can use: "Ah, another
development phase."

So I suspect what you are after is not about using describe
remotely or describing where the HEAD is; you want to know if
there is a new tag near the tip since the last time you checked.

If that is the case, "git-ls-remote --tags" is probably what you
want. 
