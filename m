From: Junio C Hamano <junkio@cox.net>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 12:53:17 -0800
Message-ID: <7vd54f85du.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	<Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	<7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	<7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	<9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	<20070212051108.GB699@spearce.org>
	<9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com>
	<Pine.LNX.4.64.0702121013150.1757@xanadu.home>
	<20070212193507.GA18730@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGiAs-0003qM-GF
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbXBLUxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbXBLUxT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:53:19 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50620 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965364AbXBLUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:53:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212205319.EJDQ1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 15:53:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NktH1W00b1kojtg0000000; Mon, 12 Feb 2007 15:53:18 -0500
In-Reply-To: <20070212193507.GA18730@thunk.org> (Theodore Tso's message of
	"Mon, 12 Feb 2007 14:35:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39437>

Theodore Tso <tytso@mit.edu> writes:

> Even before we get Git 1.5.0 installed on master.kernel.org (and we
> should really ask hpa to do that), is there a reason we haven't done
> something like this across all of the kernel repo's on
> master.kernel.org?
>
> for i in <list of kernel git repo's on master.kernel.org>
> do
>    pushd $i
>    if [ ! -f objects/info/alternates ]; then
> 	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects \
> 	   > objects/info/alternates
> 	git repack -a -d -l
>    fi
>    popd
> done

Perhaps s/<list of kernel git repo's on master.kernel.org>/& minus a few/?

"Minus a few" are (obviously) Linus's repository and bkcvs
historical ones (I think there are two of them).

Other than that I do not think of a major problem.  Repacking
into one would inconvenience http clients but that is not a new
issue and would have happened when the owner of the individual
repository chose to do so anyway.

Older clients do not understand the more efficient packfile
format (delta-base-offset encoding) that can be used with recent
git.  The feature is not turned on by default and is controlled
by configuration repack.usedeltabaseoffset.  Whoever does the
"git repack" above should make sure he does not enable it with
his $HOME/.gitconfig.
