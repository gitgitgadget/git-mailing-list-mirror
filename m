From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port updated to GIT 1.5.0
Date: Thu, 15 Feb 2007 09:43:11 -0800
Message-ID: <7vire3co5s.fsf@assigned-by-dhcp.cox.net>
References: <45D44FD5.72299A3A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 18:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHkdY-0002Am-M6
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 18:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbXBORnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbXBORnN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 12:43:13 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56013 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030358AbXBORnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 12:43:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215174312.DTND21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 15 Feb 2007 12:43:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PtjA1W00o1kojtg0000000; Thu, 15 Feb 2007 12:43:11 -0500
In-Reply-To: <45D44FD5.72299A3A@eudaptics.com> (Johannes Sixt's message of
	"Thu, 15 Feb 2007 13:19:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39840>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> .... The general idea is to extend the meaning of
> `core.filemode = false` to check out symbolic links as plain files. Any
> hints about where the source code needs changes are welcome.

grep for "if (S_ISLNK(mode))", see if it talks about the mode we
put (either in tree object or index) and if so they are the
places you want them to pretend that you got a regular file.

For example, builtin-apply.c::try_create_file() is one.  This
writes out "git apply" result (so "am" and "rebase" are affected
with this).  entry.c::write_entry() is another.  This writes
things out of the index and used by "checkout-index" and
"read-tree -u".
