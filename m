From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 05 Jul 2007 22:12:27 -0700
Message-ID: <7v1wfmi090.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
	<81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
	<7vsl82dcj0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051811310.9789@racer.site>
	<7vfy42d6m0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707052018260.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 07:12:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6g7U-00060K-UN
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 07:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbXGFFM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 01:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXGFFM3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 01:12:29 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60674 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbXGFFM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 01:12:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706051226.YJRO1257.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Jul 2007 01:12:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L5CT1X00A1kojtg0000000; Fri, 06 Jul 2007 01:12:27 -0400
In-Reply-To: <Pine.LNX.4.64.0707052018260.9789@racer.site> (Johannes
	Schindelin's message of "Thu, 5 Jul 2007 20:22:43 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51722>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> .... I guess that many 
> distros do not update their templates as often as the core, because they 
> are much more likely to be modified distro-specifically.

Can you back that up?  Fedora and Debian seem to ship them unmodified.

> Further, there 
> are some platforms which are insane enough that you cannot trust the 
> executable bit, and therefore the templates are disabled by default.
>
> All this means that the given patch would not hardly make rerere as 
> widespread as I intended.

If you truly want to have rerere enabled by default, it might
make sense to:

 * Remove "if test -d "$GIT_DIR/rr-cache" tests we have in the
   existing users;

 * Implement a new test in builtin-rerere.c, as:

   - if rerere.enabled configuration does not exist, check
     $GIT_DIR/rr-cache as before;

   - if rerere.enabled configuration is true, do not bother
     checking $GIT_DIR/rr-cache, but just do it;

   - if rerere.enabled configuration is explicitly set to false,
     never use rerere.

 * Maybe later we might change the default value for
   rerere.enabled to "true", IOW, everybody except people who
   say "[rerere] enabled = false" in their configuration
   automatically gets rerere.

Doing it in git-init, either your patch or by installing a new
template, means existing old repository would never get the
updated behaviour unless the user runs "git init" there, which
is not a very intuitive thing to do to begin with.
