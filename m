From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Added use of xmalloc() on diff-delta.c
Date: Wed, 04 Apr 2007 12:22:40 -0700
Message-ID: <7vejn02bcv.fsf@assigned-by-dhcp.cox.net>
References: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Wed Apr 04 21:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZB4A-0007Ln-3S
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 21:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934089AbXDDTWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934087AbXDDTWm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 15:22:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55703 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934080AbXDDTWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 15:22:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404192241.QQMF24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 15:22:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id j7Ng1W00E1kojtg0000000; Wed, 04 Apr 2007 15:22:40 -0400
In-Reply-To: <11757126093105-git-send-email-ribas@c3sl.ufpr.br> (Bruno Ribas's
	message of "Wed, 4 Apr 2007 15:50:08 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43768>

These two functions, create_delta_index() and create_delta(),
are already nicely libified.  They allow the caller to deal with
oom condition.  The caller may die(), or it may decide to
continue its operation with reduced functionality without using
delta data.  A good example of this is found a few lines after
the lines the second patch touches.  When create_delta() cannot
find memory to work with, the entire function returns 0, saying
"sorry, cannot deltify these two", which would cause the object
stored without deltification.

These patches take that nice property away, making libification
more difficult, which is the downside.  Is there an upside?

If anything, I suspect that the part that calls die() you
touched in the second patch could return NULL.
