From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Sat, 04 Aug 2007 15:50:11 -0700
Message-ID: <7vvebuj4nw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHSRu-0007vB-Hb
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXHDWuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765007AbXHDWuO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:50:14 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60094 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765029AbXHDWuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 18:50:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804225013.FSUP11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 18:50:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XyqB1X00M1kojtg0000000; Sat, 04 Aug 2007 18:50:12 -0400
In-Reply-To: <Pine.LNX.4.64.0708042319470.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 4 Aug 2007 23:20:07 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54917>

Hmmph.  I was trying to come up with a better commit log message
for this change.

	Paths given from the command line of checkout-index name
	files relative to the cwd, whose implication is that it
	is relative to where you are in relation with the top of
	the working tree.  For doing that, you need to have the
	work tree to begin with.

Does this mean that any command that uses its prefix parameter
to cmd_xxx() needs NEED_WORK_TREE?

I wonder if it would help us to catch similar breakages if we
change git.c::run_command() so that we do not pass prefix (or
pass a bogus pointer ((const char *)1)) for commands that do not
ask for NEED_WORK_TREE.
