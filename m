From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bisect enhancements?
Date: Wed, 30 Nov 2005 14:43:09 -0800
Message-ID: <7v3bldoiyq.fsf@assigned-by-dhcp.cox.net>
References: <1133386585.30767.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:46:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhafS-0005yY-FW
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVK3WnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVK3WnL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:43:11 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17071 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751170AbVK3WnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:43:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130224155.YRZH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 17:41:55 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1133386585.30767.34.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 30 Nov 2005 15:36:26 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13027>

Jon Loeliger <jdl@freescale.com> writes:

>...
> Two or three "good builds" into things, it proposes a
> new build at a272e24cc8751d125f9582befed0213a2a2b270f.
> Which I build and don't quite boot.  It hangs after
> the IDE probe, and before the i2c probe.  Bummer.
>
> These are not bugs I was looking for.  Move along.

This is not about your "bump", but one thing that may worthwhile
to try is bisect enhancements Linus did a couple of days ago, to
let you limit the number of commits tried by specifying the area
you are interested in.

If may not help if only thing you know is that i2c probe is not
what you are looking for, but if you know what area is suspect,
say arch/powerpc and include/asm-powerpc (just taken randomly, I
do not even know if you work in that area), it lets you say:

	$ git bisect reset
	$ git bisect start arch/powerpc include/asm-powerpc
        $ git bisect good v2.6.13-rc3
        $ git bisect bad master

What is interesting is that this cuts down the commits to be
inspected to only the ones that touch the specified paths.  So
without the path specifier, you may need to bisect 5000 commits in
total, but with the commits limited to the ones that touch these
two example directories, you would need to bisect 247 commits,
which is only a fraction of the original.
