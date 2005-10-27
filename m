From: Junio C Hamano <junkio@cox.net>
Subject: Re: [TENTATIVE PATCH] Complain loudly, dying, when a ref is invalid
Date: Thu, 27 Oct 2005 12:01:37 -0700
Message-ID: <7vacgu3hta.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 21:04:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVD1O-0001bu-VH
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 21:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVJ0TBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVJ0TBj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 15:01:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53941 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751445AbVJ0TBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 15:01:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027190055.JJBC2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 15:00:55 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 27 Oct 2005 19:40:12 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10723>

The only case that I can think of that this patch may make a
difference in behaviour in a valid repository is the HEAD
pointer that points at nowhere (i.e. refs/heads/master)
immediately after git-init-db, so in that sense this change may
be safe for most purposes.

However, we might want to write a tool to iterate over what we
have under .git/refs/ and warn about them to help the user fix
broken branches/tags, and do_for_each_ref() dying like this
would not help that usage.

Not that the current loop is any better for that purpose.  We
silently ignore not just dangling ref and ref not storing
40-byte hex, but files starting with a period '.',  names longer
than 255 bytes, and unreadable ones, all of which we would
probably want to warn about in such a tool.

-jc
