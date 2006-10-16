From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 21:45:44 -0700
Message-ID: <7v64ekyikn.fsf@assigned-by-dhcp.cox.net>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
	<7virim10rb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610151135110.17085@xanadu.home>
	<7vac3xzbze.fsf@assigned-by-dhcp.cox.net> <egtu1r$813$1@sea.gmane.org>
	<Pine.LNX.4.64.0610151433310.17085@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 06:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZKMP-0006LH-9D
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 06:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWJPEpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 00:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWJPEpq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 00:45:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38321 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030193AbWJPEpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 00:45:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061016044545.ZDJS16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Oct 2006 00:45:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aslo1V00c1kojtg0000000
	Mon, 16 Oct 2006 00:45:48 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28951>

Nicolas Pitre <nico@cam.org> writes:

> As for pack v4... My opinion is that nothing justifies it so far.  So if 
> I can convince Junio there shouldn't be any v4 just yet.

The only concern I have is the commit walkers (rsync has the
same problem as well but we honestly do not care).  They just
grab existing packs and try to use them.  I have been wondering
if it might be safer to mark the delta-base-offset encoded packs
v4 to make sure the clients would get "I know only v2 and v3 but
you fed me v4" message.

People who own public repositories and who care about commit
walkers need to refrain from using delta-base-offset when
repacking (which can be done via configuration mechanism
already).

If download goes over git native protocol, there is no such
worry -- they can pack using delta-base-offset and older clients
will be fed a pack with 20-byte base object name just fine, so my
worry is really only about commit walkers.
