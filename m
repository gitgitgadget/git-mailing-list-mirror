From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Split packs from git-repack should have descending timestamps
Date: Thu, 24 May 2007 20:18:25 -0700
Message-ID: <7vhcq1si9q.fsf@assigned-by-dhcp.cox.net>
References: <465612CE.4080605@gmail.com> <20070525004610.GP28023@spearce.org>
	<7vbqg9vhlf.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705241933x67fd4ed9h6d0e24341c19a9d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 05:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrQJx-0002vF-0E
	for gcvg-git@gmane.org; Fri, 25 May 2007 05:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbXEYDS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 23:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXEYDS1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 23:18:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37387 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbXEYDS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 23:18:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525031826.GRJP19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 23:18:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3FJR1X00E1kojtg0000000; Thu, 24 May 2007 23:18:25 -0400
In-Reply-To: <56b7f5510705241933x67fd4ed9h6d0e24341c19a9d4@mail.gmail.com>
	(Dana How's message of "Thu, 24 May 2007 19:33:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48341>

"Dana How" <danahow@gmail.com> writes:

> Also,  if there are rules on allowable bash constructs
> (POSIX only, no &, etc),  perhaps they should go in
> SubmittingPatches near the new C99 comments?

No bash arrays, no "function" noisewords, limiting <funky> in
${word<funky>word} constructs to POSIX (that means +,-,#,##,%,%%
but no regexps), prefer "test" over "[" (the last one is just for
readability).

But the reason I barfed on "&" is not about the syntax nor
portability.  I was afraid of somebody else manipulating things
long after the parent "git-repack" returns (but still the
stamper sleeping and waiting to restamp the next one) and gets
confused.  In this particular case, the restamping is only about
the performance so it is not _too_ bad, but in general I really
do not like leftover processes still doing something in the
background when the user thinks everything is done.

> I understand your point,  but for a "normal" yet extremely
> large repository this may not be the case.  The "object density"
> patch is designed so that the density component of the sort
> key is extremely weak -- I think the timestamp is very revealing,
> and should be followed in the absence of large variations
> in object density.

I still think "a pack that has ONLY megablobs and mark it with
.keep" is much simpler approach, and there is no question that
density would work extremely well with that kind of arrangement.
