From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 03 Feb 2007 12:51:53 -0800
Message-ID: <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
	<20070203181329.GA10192@179.242.249.10.in-addr.arpa>
	<7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
	<F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRrZ-0002hM-As
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbXBCUvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbXBCUvz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:51:55 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:47077 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbXBCUvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:51:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203205155.WKHZ1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 15:51:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K8ru1W0021kojtg0000000; Sat, 03 Feb 2007 15:51:54 -0500
In-Reply-To: <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> (Brian
	Gernhardt's message of "Sat, 3 Feb 2007 15:12:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38598>

Brian Gernhardt <benji@silverinsanity.com> writes:

> The only solution I can think of is to make dir.c:match_one() unicode-
> aware.  Which I'm working on to see if it will work, but don't know if
> you want to include that complication.

A filesystem that reports success on creat(path) and then does
not return that path to later readdir() from that directory is
broken from git's point of view.  At least that has been the
definition so far.

I am not sure offhand the implications of the change you propose
to make to match_one(), but it could also be the place to handle
case-challenged filesystems.

But even if you do that, I wonder what your plan would be to
handle something like "git add .".  read_directory_recursive()
asks readdir() for existing pathnames, and we expect that can be
used as parameter to add_file_to_index and then eventually we
can call creat() or symlink() with it, so it also needs to be
taught to behave consistently with respect to what your updated
match_one() does.
