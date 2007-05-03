From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Wed, 02 May 2007 23:13:01 -0700
Message-ID: <7vejly305u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
	<7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704290152410.28708@iabervon.org>
	<7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705022330460.28708@iabervon.org>
	<7virba31wd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705030137520.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 03 08:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjUZF-00049I-Jm
	for gcvg-git@gmane.org; Thu, 03 May 2007 08:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030935AbXECGNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 02:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030933AbXECGNF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 02:13:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50613 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030938AbXECGND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 02:13:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503061302.RRRM1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 02:13:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uWD21W0021kojtg0000000; Thu, 03 May 2007 02:13:02 -0400
In-Reply-To: <Pine.LNX.4.64.0705030137520.28708@iabervon.org> (Daniel
	Barkalow's message of "Thu, 3 May 2007 01:45:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46068>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Indeed. Is there documentation on all the possibilities for refspecs 
> somewhere all together? I could only find it for particular programs, and 
> didn't see a no-colon option permitted anywhere.

Documentation/pull-fetch-param.txt which is included by various
manpages would be the best place to start.

    <refspec>::
            The canonical format of a <refspec> parameter is
            `+?<src>:<dst>`; that is, an optional plus `+`, followed
            by the source ref, followed by a colon `:`, followed by
            the destination ref.
    +
    The remote ref that matches <src>
    is fetched, and if <dst> is not empty string, the local
    ref that matches it is fast forwarded using <src>.
    Again, if the optional plus `+` is used, the local ref
    is updated even if it does not result in a fast forward
    update.

Hmph.  So <dst> could be empty, and in such a case there is no
tracking.  But this does not say missing colon is allowed (but
that was intentionally left out as we clarify it later).  Let's
read on.  After a few [Notes], we find this.

    Some short-cut notations are also supported.
    +
    * `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`; 
      it requests fetching everything up to the given tag.
    * A parameter <ref> without a colon is equivalent to
      <ref>: when pulling/fetching, so it merges <ref> into the current
      branch without storing the remote branch anywhere locally

Ahh, so a refspec that does not have a colon, and ends with a
colon (hence an empty <dst>) are equivalent, and does not result
in remote tracking.
