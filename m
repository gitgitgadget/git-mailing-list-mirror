From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 12:15:17 -0800
Message-ID: <7vfyaaybhm.fsf@assigned-by-dhcp.cox.net>
References: <20070116162645.GA18894@informatik.uni-freiburg.de>
	<20070116173706.GB20898@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 21:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uiM-0005Vz-W8
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 21:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXAPUPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 15:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXAPUPY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 15:15:24 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48953 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbXAPUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 15:15:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116201518.SWAY16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jan 2007 15:15:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BwEQ1W00n1kojtg0000000; Tue, 16 Jan 2007 15:14:25 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070116173706.GB20898@mellanox.co.il> (Michael S. Tsirkin's
	message of "Tue, 16 Jan 2007 19:37:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36960>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> OK, I did a fetch and now I can see remote history by
>
> $git log FETCH_HEAD
>
> But, how to merge it?

You would do "git merge FETCH_HEAD" (note that this would not
work for octopus).

> $ git pull . FETCH_HEAD
> error: no such remote ref refs/heads/FETCH_HEAD
> Fetch failure: .

This is wrong twice.

 (1) "git pull" and "git fetch" by design are to fetch what are
     exposed, and the remote refnames you give are perfixed with
     refs/heads (or refs/tags if you say "git fetch tag v1.0.0")
     unless the refnames begin with refs/ already.  In other
     words, FETCH_HEAD is not something you can "pull".

 (2) Remember, "pull is fetch followed by merge." And the way
     fetch communicates with the calling "pull" so that it can
     drive "merge" is via FETCH_HEAD.  So whatever pull you
     would do, FETCH_HEAD is cleared first to store the result.

So by doing this (and not redoing the fetch) you broke your own
experiment sequence.  And that is why you got this:

> $git merge FETCH_HEAD
> FETCH_HEAD - not something we can merge

because at this point FETCH_HEAD is empty.
