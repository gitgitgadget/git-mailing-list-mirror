From: Junio C Hamano <gitster@pobox.com>
Subject: git-log --follow?
Date: Thu, 12 Jul 2007 01:31:44 -0700
Message-ID: <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070704203541.GA13286@artemis.corp>
	<7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 10:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8u6c-0003Ec-Ru
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 10:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763456AbXGLIbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 04:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762280AbXGLIbs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 04:31:48 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64209 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763456AbXGLIbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 04:31:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712083144.KORL1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Jul 2007 04:31:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NYXk1X00E1kojtg0000000; Thu, 12 Jul 2007 04:31:45 -0400
In-Reply-To: <7vzm22vyin.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Jul 2007 01:04:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52258>

The message I am following up is a patch to unpack-trees.c,
whose basic code structure is Daniel's work, so I wanted to CC
him and the easiest way to look his address up was to run
git-log on it.

Not so.

The "blame -C unpack-trees.c" output consists of this
distribution of origin:

    464 read-tree.c
    337 unpack-trees.c
     74 builtin-read-tree.c
     11 tree.c
      8 tree.h

and most of the work by Daniel was done when the bulk of code
was still in read-tree.c.  Naturally the log output of
unpack-trees.c does not have a single commit by him.  "git log
-- unpack-trees.c" would not follow into read-tree.c, but I
thought "git log --follow -- unpack-trees.c" is supposed to; I
tried it for the first time, but it does not seem to work as
well as I hoped.

I think this is just a testament that "following renames" is not
as useful in a real project as people seem to believe, not a
real complaint.

When 16da134 created unpack-trees.c, it initially moved only
very small part of builtin-read-tree.c to it.  Later 076b0adc
made further code movements from builtin-read-tree.c to
unpack-trees.c.

An interesting thing is that builtin-read-tree.c immediately
before 16da134 is much similar to unpack-trees.c in 076b0adc
than unpack-trees.c in 16da134, exactly because of this stepwise
code movements.  I do not think people can argue that "human
user knows he is renaming the file so recording the human
intention would have helped git a lot better" in this case, as
the human user who made 16da134 did not even intend to do a
rename.
