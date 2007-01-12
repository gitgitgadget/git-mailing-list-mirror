From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restraining git pull/fetch to the current branch
Date: Thu, 11 Jan 2007 17:09:13 -0800
Message-ID: <7vejq1yrt2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 02:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Av5-0005C2-Ci
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 02:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXALBJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 20:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbXALBJP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 20:09:15 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34885 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbXALBJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 20:09:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112010914.QFCW20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 20:09:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id A18N1W00r1kojtg0000000; Thu, 11 Jan 2007 20:08:23 -0500
To: Julian Phillips <julian@quantumfyre.co.uk>
In-Reply-To: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Thu, 11 Jan 2007 21:47:53 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36650>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> While trying out git on a large repository (10000s of commits, 1000s
> of branches, ~2.5Gb when packed) at work I noticed that doing a pull
> was taking a long time (longer than I was prepared to wait anyway).

Are they all real branches?  In other words, does your project
have 1000s of active parallel development?

> So what I would like to know is: is there any way to make a pull/fetch
> with no options default to only fetching the current branch? (other
> than scripting "git pull/fetch origin $(git symbolic-ref HEAD)" that
> is)

Also, assuming the answer to the above question is yes, will you
have 1000s of branches on your end and will work on any one of
them?

The default configuration created by git-clone makes you track
all branches from the remote side by putting:

	remote.origin.fetch = +refs/heads/*:refs/remotes/origin/*

If you do not care all 1000s branches but only are interested in
selected few, you could change that configuration to suit your
needs better.

    remote.origin.fetch = +refs/heads/stable:refs/remotes/origin/stable
    remote.origin.fetch = +refs/heads/testing:refs/remotes/origin/testing
    remote.origin.fetch = +refs/heads/unstable:refs/remotes/origin/unstable


I suspect most of the time is being spent in the
append-fetch-head loop in fetch_main shell function in
git-fetch.sh The true fix would not be to limit the number of
branches updated, but to speed that part of the code up.
