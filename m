From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid rebuilding everything if user changes CFLAGS on the make  command line
Date: Wed, 07 Mar 2007 10:01:14 -0800
Message-ID: <7vd53lexw5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703062249540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EE854E.210EDAFF@eudaptics.com>
	<Pine.LNX.4.63.0703071319520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EEC122.EA43CB72@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP0Sn-0002iG-HA
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 19:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbXCGSB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbXCGSBy
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 13:01:54 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45375 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422956AbXCGSBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 13:01:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307180116.XYTC1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 13:01:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xu1F1W0051kojtg0000000; Wed, 07 Mar 2007 13:01:15 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41684>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> IMHO, the value of $(CFLAGS) (which the Makefile declares as "for the
> users to override from the command line") should never take part in this
> build-flags-change-autodetection.

This on the surface looks nicer than the other Johannes's
approach, but I have reservations.  The user can always say
"make CFLAGS=-DNO_SYNLINK_HEAD=NoThanks" from the command line
to affect the behaviour, and in such a case this approach
breaks.

As long as you declare CFLAGS is there for users to override
only the way the programs are compiled (e.g. optimization) and
it is forbidden to use CFLAGS to affect the way the programs are
to behave (iow, "use of -D<FEATURE> in CFLAGS is forbidden"), it
would be Ok, but in effect it is forcing people to modify
config.mak even for "try out this configuration just this time,
one-shot" compilation, which makes me somewhat unhappy.

IGNORE_GIT_CFLAGS looks much uglier, but is much nicer from
design standpoint.  At least the user declares "I know what I am
doing, and I assume full responsibility".  That might be less
confusing in the end.

Undecided.
