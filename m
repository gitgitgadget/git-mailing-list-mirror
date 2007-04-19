From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Thu, 19 Apr 2007 01:08:28 -0700
Message-ID: <7v1wig9477.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	<7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
	<7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
	<7vk5w9fnjx.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
	<20070419075229.GA27208@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeRhd-0008V6-B4
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993168AbXDSIJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993194AbXDSIIy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:08:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64113 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993193AbXDSII3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:08:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419080828.XNGH1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Apr 2007 04:08:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ow8U1W00L1kojtg0000000; Thu, 19 Apr 2007 04:08:28 -0400
In-Reply-To: <20070419075229.GA27208@admingilde.org> (Martin Waitz's message
	of "Thu, 19 Apr 2007 09:52:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44989>

Martin Waitz <tali@admingilde.org> writes:

> or different attributes for other file types:
>
> [attr] *@ merge=ours		# for symlinks
> [attr] */ merge=submodule	# for dirlinks
We already have much more general mechanism to model this on for
merges.  Look at how git-merge-one-file is invoked.  It gets the
mode bits which tells what kind of object the path is, for all
three (i.e. ancestor, ours, and theirs).

So a single, perhaps not so low-level, merge driver can take the
same set of attributes merge-one-file makes use of, not just the
current set of %O/%A/%B temporary files, and make intelligent
decision to override what is hardcoded in merge-recursive if it
wants to.

We do not need to pollute the gitattribute mechanism for this
application; it can and should stay about path*name*s.
