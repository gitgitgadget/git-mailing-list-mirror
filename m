From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/21] Return error messages when parsing fails.
Date: Sat, 09 Jun 2007 11:01:51 -0700
Message-ID: <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	<200706090210.36270.johan@herland.net>
	<200706090213.16031.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5GA-0001Z0-Eh
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbXFISBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXFISBy
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:01:54 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44545 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbXFISBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:01:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609180152.HQWE18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 14:01:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9W1r1X00m1kojtg0000000; Sat, 09 Jun 2007 14:01:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49589>

Johan Herland <johan@herland.net> writes:

> This patch brings the already similar tag.c:parse_tag_buffer() and
> mktag.c:verify_tag() a little bit closer to eachother.

While I would agree that it makes sense to have the same
definition of what is and is not a 100% well formatted tag
object for producer side and consumer side, I do not necessarily
think it is a good idea to make parse_tag_buffer() chattier on
errors.  mktag.c:verify_tag() can afford to be verbose in its
diagnosis, because it is used when the user is _creating_ the
tag, and it is generally a good idea to be strict when we
create.

On the other hand, parse_tag_buffer() is on the side of users
who use existing tag objects that were produced by somebody
else.  It is generally a good practice to be more lenient when
you are consuming.

Also, callers of parse_tag_buffer() know the function is silent
on errors (unless there is something seriously wrong with the
repository); they do their own error messages when they get an
error return.
