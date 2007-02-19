From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/3] git-fetch: Split fetch and merge logic
Date: Mon, 19 Feb 2007 12:44:11 -0800
Message-ID: <7v649x7u90.fsf@assigned-by-dhcp.cox.net>
References: <874ppmplw7.fsf@gmail.com> <87vei2o75x.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFMu-0006RP-UL
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbXBSUoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Feb 2007 15:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbXBSUoN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:44:13 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43835 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633AbXBSUoN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 15:44:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219204411.LCCT22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 15:44:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RYkB1W00E1kojtg0000000; Mon, 19 Feb 2007 15:44:12 -0500
In-Reply-To: <87vei2o75x.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16
	Feb 2007 09:09:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40149>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> git-fetch fetches the branches from the remote and saves this
> information in .git/FETCH_FETCHED, and at the end it generates
> the file .git/FETCH_HEAD.
>
> There are two cases where the behaviour is changed:
>
> 1) branch.*.merge no longer must exactly match the remote part
>    of the branch fetched. Both are expanded in full (as refs/heads/..=
=2E)
>    and matched afterwards.

How hard would it be to fix this?  I see this as a regression.
If you are setting configuration, wouldn't you rather see the
behaviour consistent even when remote adds new refs?

> 2) When the remote is specified with $GIT_DIR/branches/... and there =
is
>    a branch.*.merge, the remote branch name must match to get them me=
rged.
>    Before the branch in $GIT_DIR/branches/... was always merged.

I do not think the current $GIT_DIR/branches/ support with
respect to choosing which remote branch to choose was done with
any deep thinking, other than to stay backward compatible, so I
would not put too much trust in what is in the documentation.
At the same time, I personally can be pursuaded to go either
way, exactly because I do not think the current behaviour has
strict reasoning behind it.

However, I wonder how this change would affect existing setups
people may have.

Merging this at this moment would be a pain even if there were
no downsides, as there are a few topics that want to touch
parse-remote and fetch (two already in 'pu', and git-bundle
series also wants to hook into git-fetch); these topics would
need to get adjusted if this clean-up goes in first.
