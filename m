From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Tue, 27 Mar 2007 22:46:47 -0700
Message-ID: <7vk5x1ly2g.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
	<7vmz1zs0g5.fsf@assigned-by-dhcp.cox.net>
	<200703280544.47569.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 07:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWQzk-0002ya-S8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 07:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbXC1Fqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 01:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbXC1Fqt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 01:46:49 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42277 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbXC1Fqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 01:46:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328054647.DDTB1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Mar 2007 01:46:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id g5mn1W00f1kojtg0000000; Wed, 28 Mar 2007 01:46:48 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43354>

Christian Couder <chriscool@tuxfamily.org> writes:

> For example "git bisect run" could accept the following options:
>
> --not
> mark current revision as bad instead of good and as good instead of bad

Do you mean this is a useful option when the "run-script"
reports failure with 0 exit and success with non-zero exit?  In
other words, exit code has reversed meanings from the usual?

> --strict
> all exit code except 0 and 1 abort the bisect run process

This I can understand...

> --good <rev1>
> --bad <rev2>
> use rev1 as good and rev2 as bad

I am not sure what you mean by these two.

> --check or --test
> run the script once and then do nothing if the result is good

How would you use this?  Presumably this makes the command keep
running while the commit is bad, until you hit a good commit and
then stop.

I wonder why this is useful.

Stopping at a commit that happens to be good, without narrowing
the range all the way down is sometimes useful, as you can
usually guess which one of the remaining commits are likely to
be involved with the problem you are seeing, when the remaining
set is sufficiently narrow.  But how narrow the remaining set is
does not have much to do with your finding a good commit for the
first time.  If you start from a single bad commit at the tip of
10-year old project, you would probably try 5-year old commit,
which may well be good (or maybe it is too old to be relevant)
and then this option would make the cycle stop, and you have
5-year worth of history still left to be bisected.  I am not
sure what the assumed workflow would be after that point.
