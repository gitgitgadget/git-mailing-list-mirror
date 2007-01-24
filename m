From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 04:34:51 -0800
Message-ID: <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
	<Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
	<7vps94fweq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 13:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9hL8-0003cG-KO
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 13:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXAXMey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 07:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXAXMex
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 07:34:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53629 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbXAXMew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 07:34:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124123452.TOSE18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Wed, 24 Jan 2007 07:34:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id F0Zv1W00K1kojtg0000000; Wed, 24 Jan 2007 07:33:55 -0500
In-Reply-To: <7vps94fweq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 24 Jan 2007 04:21:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37632>

Junio C Hamano <junkio@cox.net> writes:

> Suppose we had such a service on the server side, and you asked
> the server twice and got these (at different times, of course):
>
> 	v2.6.20-rc5-g419dd83
> 	v2.6.20-rc5-gde14569
>
> What useful information can you get between the two?  
>
> Nothing.
>
> The commit object names are like random numbers and 419dd83 may
> or may not be older than de14569.  The "hash" part of the
> output is meaningless for you until you actually have the
> history to poke at with "git log", "git diff" and friends.

Side note.

Also the commit object names (hence "describe" output) do not
tell you how far they are from the tag used to describe them.

However, I suspect that we could do better with Shawn's new
fangled describe implementation that actually counts the
distance between what is described and the tag.  We could add
"number of commits since the tag" somewhere, to describe:

	v2.6.20-rc5-256-g419dd83
        v2.6.20-rc5-217-gde14569

to say that the first one has 256 commits accumulated since the
given tag "v2.6.20-rc5" and the second one has only 217
commits, to get the sense of how busy the development activity
is.

Is it useful?  That is something I am not sure.

Side note for side note.

This should be obvious to people who know git, but the above
does not mean we can remove gXXXX part from the describe output,
becauses there could be infinite number of commits that are 256
commits away from v2.6.20-rc5 tag.  v2.6.20-rc5-256 alone does
not uniquely identify the commit 419dd83.
