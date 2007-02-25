From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Sun, 25 Feb 2007 14:57:08 -0800
Message-ID: <7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 25 23:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSIv-0004ci-A2
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbXBYW5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbXBYW5L
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:57:11 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37659 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965182AbXBYW5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:57:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225225708.OFUA2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 17:57:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tyx81W00K1kojtg0000000; Sun, 25 Feb 2007 17:57:09 -0500
In-Reply-To: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 25 Feb 2007 23:36:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40592>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This allows you to say
>
> 	echo Hello World | git diff x -
>
> to compare the contents of file "x" with the line "Hello World".
> This automatically switches to --no-index mode.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Since the revision machinery checks for the presence of files,
> 	diff_populate_filespec() will only change behaviour when there
> 	is a file "-"... I have yet to think of an elegant fix for that.

Another thing is that at some point diff_populate_filespec()
needs to have a way to discard what was cached if memory
pressure gets tight, and we would want to keep this data read
from the standard input.

One solution would be to add a "const char *stdin_data" to diffopts
and read the data from stdin when you parse the options, and
have populate_filespec point at that with s->data (setting
should_free and should_munmap both to 0).
