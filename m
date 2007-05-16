From: Junio C Hamano <junkio@cox.net>
Subject: Re: pull/push inconsistencies
Date: Tue, 15 May 2007 18:22:29 -0700
Message-ID: <7v646th8a2.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	<7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
	<46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 03:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho8Du-0002Zn-Na
	for gcvg-git@gmane.org; Wed, 16 May 2007 03:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760401AbXEPBWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 21:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760321AbXEPBWb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 21:22:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34212 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760225AbXEPBWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 21:22:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516012229.WHBF24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 21:22:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zdNV1W00X1kojtg0000000; Tue, 15 May 2007 21:22:30 -0400
In-Reply-To: <46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 16 May 2007 13:11:02 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47403>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> There are 2 things that I see as wrong...
> - local .git/refs/remote/origin/foo and refs/heads/foo match - why is
> git-push talking about updating them?

Ooo...

Do you mean if you have refs/remotes/origin/foo locally, and
push into a repository that has refs/heads/foo (but not
refs/remotes/origin/foo), the push results in refs/heads/foo
getting updated?  If that is what is happening (without any
refspecs to instruct git-push to do so) that sounds quite buggy.
I need to look into the code for this one.

And I think earlier one I was confused that I thought you were
talking about pushing into refs/heads/branch (where branch is
checked out).  Sorry.

> - matching refs should ignore .git/refs/remote
>
> ... the 'matching refs' thing will
> ignore the local .git/refs/remotes directory. AFAICS it's the only
> sane thing to do.

I think you are probably right in that matching only heads and
perhaps tags is a sane thing to do (even tags/ is debatable, as
they are supposed to be immutable by convention).  As a matter
of fact I do not recall which part of refs/ namespace it looks
at, but it is a very old part of the system and I would not be
surprised if it silently assumed that there are only heads and
tags there (and not explicitly matching heads and tags only).
