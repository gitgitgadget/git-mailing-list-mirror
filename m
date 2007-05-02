From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-blame not tracking copies
Date: Wed, 02 May 2007 16:42:41 -0700
Message-ID: <7v8xc64wsu.fsf@assigned-by-dhcp.cox.net>
References: <200705022033.25885.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 01:43:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjOTJ-0003hY-Oo
	for gcvg-git@gmane.org; Thu, 03 May 2007 01:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767252AbXEBXmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 19:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767253AbXEBXmo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 19:42:44 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58635 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767252AbXEBXmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 19:42:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070502234241.LGQY1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 2 May 2007 19:42:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uPih1W00a1kojtg0000000; Wed, 02 May 2007 19:42:42 -0400
In-Reply-To: <200705022033.25885.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 2 May 2007 20:33:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46053>

Andy Parkins <andyparkins@gmail.com> writes:

> All git-blame commands are "git-blame -C1 -C1"

I am sick and not functioning well today, so will not be able to
review what is happening with your example deeply, but here are
some comments to get you started digging.

There is a built-in sanity valve in git-blame that refuses to
pass down the blame via -M/-C for really trivial hunks.  Without
such safety, all the empty lines in the latest revision would be
attributed to a random empty line in a random file in the root
commit ;-).

By default, the sanity valve is set to refuse a hunk that has 20
or 40 alnum characters.  These values seem to be appropriate for
real life projects, but obviously the real-world case would be
very different from a made-up "each commit changes one-line"
test case and it would be understandable that the command would
behave differently.

Also with real-life projects, probably depending on the coding
style and merge patterns, I would not be surprised if there are
rooms to tweak the heuristics.
