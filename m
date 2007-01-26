From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 22:50:18 -0800
Message-ID: <7vac062set.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
	<7v7iva4glo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701252202130.25027@woody.linux-foundation.org>
	<7vireu2uc6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701252218540.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKuq-0001bi-D2
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030805AbXAZGuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030806AbXAZGuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:50:25 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35871 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030805AbXAZGuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:50:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126065023.LAKR29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 01:50:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FipS1W0091kojtg0000000; Fri, 26 Jan 2007 01:49:26 -0500
In-Reply-To: <Pine.LNX.4.64.0701252218540.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 25 Jan 2007 22:24:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37807>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Tags automatically fall under that heading (which is why it makes sense to 
> pack them by default in the first place!) but so does any ref that was 
> already packed, and hadn't become unpacked since the last repack. By 
> definition, such a ref isn't "actively changing" even if it isn't a tag.
>
> No?

Yes.

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 464269f..b79b79d 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -34,11 +34,16 @@ OPTIONS
 
 \--all::
 
-The command by default packs all tags and leaves branch tips
+The command by default packs all tags and refs that are already
+packed, and leaves other refs
 alone.  This is because branches are expected to be actively
 developed and packing their tips does not help performance.
 This option causes branch tips to be packed as well.  Useful for
 a repository with many branches of historical interests.
+Once packing with `\--all` is done, further repacking with the
+default will keep the already packed refs (including branch
+heads) packed, while still actively developed branch heads will
+not be packed (because they become unpacked once modified).
 
 \--no-prune::
 
