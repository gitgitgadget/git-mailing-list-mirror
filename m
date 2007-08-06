From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug in git apply?
Date: Mon, 06 Aug 2007 01:29:46 -0700
Message-ID: <7vabt5dq11.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 10:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHxyL-0001uF-6y
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 10:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498AbXHFI3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 04:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758480AbXHFI3t
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 04:29:49 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38538 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbXHFI3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 04:29:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806082947.XUHG14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 04:29:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YYVm1X00P1kojtg0000000; Mon, 06 Aug 2007 04:29:47 -0400
In-Reply-To: <alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 5 Aug 2007 09:59:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55123>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, if we really wanted to get it right, we should do this as a 
> three-phase thing: (1) remove old files (2) create new files (3) for all 
> removals and renames, try to remove source directories that might have 
> become empty.
>
> That would fix it properly and for all cases.

Actually that will break the case of removing foo/bar, which is
the only file in directory foo, and creating a new file foo.  So
if we really want to do all the corner cases, we would need to
do something like:

 * scan the list of files that will remain (i.e., renamed-to,
   modifed-in-place and created-anew) to note which directories
   should remain in the result;

 * remove old files, and remove its empty parent directories
   that are not in the above list;

 * create new files.

But in the meantime for 1.5.3, I think your patch is better than
what we currently have.
