From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] rev list add option accepting revision constraints on standard input
Date: Tue, 05 Sep 2006 21:46:50 -0700
Message-ID: <7vk64ha9fp.fsf@assigned-by-dhcp.cox.net>
References: <44FDECD1.2090909@shadowen.org>
	<20060905215157.GA29172@shadowen.org>
	<7vpseaarrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 06:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKpJU-0007iq-R6
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 06:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWIFEqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 00:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWIFEqu
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 00:46:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16827 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750751AbWIFEqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 00:46:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906044649.CUOS18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 00:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jsmh1V00W1kojtg0000000
	Wed, 06 Sep 2006 00:46:42 -0400
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26500>

Junio C Hamano <junkio@cox.net> writes:

> Is calling setup_revisions() on the same revs like this many
> times safe?  I do not think so, especially what is after the
> primary "for()" loop in the function.
>
> I was sort-of expecting that you would instead replace that
> primary for() loop in setup_revisions() with some sort of
> callback...

I take half of the above back.  Even after setup_revisions()
returns, adding more revisions via add_pending_object() is
safe.  However, the postprocessing done in setup_revisions()
after its main loop, while I do not think they would crash when
called twice, would be very wasteful.

And ``callback'' interface is usually very cumbersome to use, so
we probably would want to avoid it unless absolutely necessary.

I've outlined an alternative implementation in two patches;
I'll be sending them out shortly.
