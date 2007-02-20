From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 16:35:07 -0800
Message-ID: <7vps854qf8.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIyS-0001gK-4H
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965742AbXBTAfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965741AbXBTAfM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:35:12 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51338 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965742AbXBTAfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:35:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220003507.RPPB22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 19:35:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rcb71W00N1kojtg0000000; Mon, 19 Feb 2007 19:35:08 -0500
In-Reply-To: <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 19 Feb 2007 16:11:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40176>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I agree that it is sensible, but it's sensible only within the context of 
> purely self-generated patches, where the patch itself was generated not 
> just with git, but with that exact project.

That makes sense, except that the patch could be made with any
other tools; it just has to follow the "patch is from the top of
the tree, with -p1" convention.

I think it might make sense to change (this might have to be
read "break", unfortunately) "git apply" for all three cases.

So the new rule, which would affect only when you run from a
subdirectory, would be that "diff -u a/foo b/foo" would be
parsed, 1 level (or -p <n> levels) of leading paths stripped,
and then prefix is added to form "new" and "old" filenames.

And I think Johannes is happy with that change as well.
