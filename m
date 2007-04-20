From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetch: Auto-following tags should check connectivity, not existence
Date: Fri, 20 Apr 2007 03:30:56 -0700
Message-ID: <7vvefr1gnz.fsf@assigned-by-dhcp.cox.net>
References: <4624F183.D4B6BBB1@eudaptics.com>
	<7v4pnb4kil.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeqPD-00020L-Bl
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 12:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767045AbXDTKbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 06:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767052AbXDTKbL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 06:31:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34769 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423046AbXDTKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 06:30:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420103057.XSND1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 06:30:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pNWw1W00G1kojtg0000000; Fri, 20 Apr 2007 06:30:56 -0400
In-Reply-To: <7v4pnb4kil.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 19 Apr 2007 23:39:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45080>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Sixt <J.Sixt@eudaptics.com> writes:
>
>> git-fetch's auto-following of tags fetches all tags for which it finds
>> objects in the local repository. I feel it were better if not object
>> existence, but connectivity to the existing refs was checked, like this:
> ...
> However, I think --max-count=1 defeats what you are trying to
> do.  Revision limiting will only look at commits, and if you
> have all commits that lead to the "$sha1" commit from some of
> the existing refs, but lack some blobs or trees that belong to
> some of the commits that are not the first commit that will be
> listed, their absense will not be noticed.

Sorry, but I have to take this back, after looking at your patch
once again.  In this case, all you are interested in is to see
if the commit ancestry is connected, and you do not mind if the
chain is somewhat incomplete in blobs and trees, as you will
re-fetch the chain in a safe manner in the later round.  In
other words, the code does not have to be as strict as my
quickfetch series, which tries to *omit* re-fetching
altogether.

So --max-count=1 is fine, although it may not be much of an
optimization in practice, it does not harm correctness in any
way, as my previous message suggested.
