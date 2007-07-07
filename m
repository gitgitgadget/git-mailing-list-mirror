From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] interpolate '\n' as newline
Date: Fri, 06 Jul 2007 19:13:46 -0700
Message-ID: <7vy7htc65h.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062100360.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 04:13:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6zo2-00021h-G2
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 04:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXGGCNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 22:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbXGGCNs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 22:13:48 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57159 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbXGGCNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 22:13:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707021346.KRIR1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Jul 2007 22:13:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LSDl1X00E1kojtg0000000; Fri, 06 Jul 2007 22:13:46 -0400
In-Reply-To: <Pine.LNX.4.64.0707062100360.4093@racer.site> (Johannes
	Schindelin's message of "Fri, 6 Jul 2007 21:02:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51799>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> All places which call interpolate() get this interpolation for free.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
> 	In the back of my head, I remembered that a few people
> 	were interested in this.
>
> 	Judging by the diffstat, it really escapes me why these people
> 	did not implement it.
>
> 	However, there is a chance that this change is not liked by
> 	all places that call interpolate(). merge-recursive can live
> 	with it, I guess.

I actually think merge-recursive has much bigger chance of
getting broken than git-daemon, but only _if_ people are already
using custom merge programs this becomes an issue.  It is much
more common to see two letter sequence '\n' as a string literal
in a script than in a pathname.

>       But daemon interpolates the path... However,
> 	it seems only the command line of daemon can change the string,
> 	so this change should be safe.

The command line needs to say --interpolated-path="...\n..."
and expect that '\n' would come out as two characters backslash
and en in the _pathname_ to get broken, and it is very unlikely
that anybody is insane enough to have such a path.
