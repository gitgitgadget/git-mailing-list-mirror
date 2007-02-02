From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Flag and skip over packfiles known to be invalid.
Date: Fri, 02 Feb 2007 00:34:17 -0800
Message-ID: <7virelhsae.fsf@assigned-by-dhcp.cox.net>
References: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org>
	<20070202080010.GB21094@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCtsE-000211-Pn
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423198AbXBBIeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423200AbXBBIeT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:34:19 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:48958 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423198AbXBBIeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:34:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202083419.WXZH1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 03:34:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JYaH1W00r1kojtg0000000; Fri, 02 Feb 2007 03:34:18 -0500
In-Reply-To: <20070202080010.GB21094@spearce.org> (Shawn O. Pearce's message
	of "Fri, 2 Feb 2007 03:00:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38475>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If we've already looked at a packfile and determined it isn't
> valid/usable as a pack, we shouldn't try to use it again in
> the future either.  This avoids multiple error messages from
> the same packfile.

I haven't looked your patch very closely, but two successive
"git-repack -a -d" would produce the packfile under the same
name, but with different parameters (--window or --depth), the
old .idx and new .pack may not match.

Can this be possible (time flows from top to bottom):

	git-repack -a -d		somebody else

	produces a new .pack/.idx

        mv new .pack to objects/pack

					mmap .idx (old)
					finds .pack does not match

	mv new .idx to objects/pack
	
Is this something we care about?
