From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 14:53:29 -0700
Message-ID: <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8Uf-00025M-L5
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWJLVxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWJLVxb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:53:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15300 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751142AbWJLVxa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 17:53:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012215330.QDF12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 17:53:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZZtJ1V00Z1kojtg0000000
	Thu, 12 Oct 2006 17:53:19 -0400
To: Alexei Podtelezhnikov <apodtele@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28804>

apodtele <apodtele@gmail.com> writes:

> Instead of conditionally scaling the stat graph for large changes,
> always scale it asymptotically: small changes shall appear without any
> distortions.
>
> Signed-off-by: Alexei Podtelezhnikov

Missing e-mail address on S-o-b line.  If your mail From: line
does not say who you are, please add an extra From: line in the
body, like this:

	From: Alexei Podtelezhnikov <apodtele@gmail.com>
        Subject: [PATCH 1/2] diff --stat: ...

        Instead of ...

	Signed-off-by: Alexei Podtelezhnikov <apodtele@gmail.com>


I am not sure if any non-linear scaling is worth pursuing.
Suppose your change set has three files modified:

	A	adds 20 lines, deletes 10 lines
        B	adds 10 lines, deletes 20 lines
        C	adds 30 lines, deletes 30 lines

When drawing into a specified width that leaves 20-column for
the graph part, what would we see?  What would we see if the
graph part is 21-column wide?  59-column wide?  80-column wide?

For obvious reasons, the total length of A and B exceeds half of
C, which looks quite misleading.

         A | ++++++++++++--------
         B | ++++++++------------
         C | +++++++++++++++---------------

We could align things in the middle, like this, though:

         A |    ++++++++++++--------
         B |        ++++++++------------
         C | +++++++++++++++---------------
