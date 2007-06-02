From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Sat, 02 Jun 2007 12:58:22 -0700
Message-ID: <7vy7j2p1r5.fsf@assigned-by-dhcp.cox.net>
References: <20070531222313.GA12204@steel.home>
	<7v4pls1qjv.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0706010035s5fc38dc6y6f985675cc3c069@mail.gmail.com>
	<20070601230924.GA6360@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:58:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuZk7-0003r1-GO
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 21:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXFBT6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbXFBT6X
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 15:58:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35259 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbXFBT6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 15:58:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602195824.BZVI22318.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 15:58:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6jyN1X0051kojtg0000000; Sat, 02 Jun 2007 15:58:22 -0400
In-Reply-To: <20070601230924.GA6360@steel.home> (Alex Riesen's message of
	"Sat, 2 Jun 2007 01:09:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48951>

Alex Riesen <raa.lkml@gmail.com> writes:

> by default. V=1 works as usual.

You obviously did not test that X-<.  V=1 does not work at all
for me.  This is what I get.

    ...
    install git '/home/junio/git-test/bin'
    :SETUP BUILTIN git-format-patch; rm -f '/home/junio/git-test/bin/git-format-patch' && ln '/home/junio/git-test/bin/git' '/home/junio/git-test/bin/git-format-patch'; ...
    ...
    /bin/sh: :SETUP: command not found
    /bin/sh: :SETUP: command not found
    /bin/sh: :SETUP: command not found
    /bin/sh: :SETUP: command not found
    ...

Two problems and a half.

 (0) You do not report the creation of target directory done
     with "install -d", so without $V there is no way to tell if
     things are installed in the expected location.

 (1) Obviously : and whatever action message needs to be
     separated so that it becomes a no-op command ':' followed
     by parameters;

 (2) Even with that ":SETUP: command not found" fixed, it now
     makes the command line twice as long as before for $V case,
     which makes it harder to diagnose a problem when Makefile
     goes wrong.

I think the way QUIET_CC and friends are done is quite sensible
and does not have this problem, especially (3).  With V=1 it
just becomes transparent, and that is what we would want.
