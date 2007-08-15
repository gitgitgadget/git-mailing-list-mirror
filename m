From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 18:31:58 -0700
Message-ID: <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
References: <1186984174.10249.7.camel@localhost>
	<200708131933.10125.m.kozlowski@tuxland.pl>
	<1187026955.2688.4.camel@laptopd505.fenrus.org>
	<1187037445.6628.98.camel@heimdal.trondhjem.org>
	<1187054366.2757.0.camel@laptopd505.fenrus.org>
	<46C10AA8.3090505@gmail.com>
	<20070814102033.604c8695@the-village.bc.nu>
	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 03:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL7kc-0002he-Tk
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 03:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbXHOBcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 21:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbXHOBcQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 21:32:16 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44458 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbXHOBcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 21:32:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815013215.LOGZ325.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 21:32:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c1Y91X0071kojtg0000000; Tue, 14 Aug 2007 21:32:10 -0400
In-Reply-To: <1187110824.32555.76.camel@localhost> (Joe Perches's message of
	"Tue, 14 Aug 2007 10:00:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55871>

Joe Perches <joe@perches.com> writes:

> On Tue, 2007-08-14 at 17:53 +0200, Rene Herman wrote:
>> It isn't about MODULE_FOO() tags, it is about tagging /source/ files 
>> to help with putting CCs on patch submissals.
>> If we want to link source file foo.c and the 
>> MAINTAINERS information, we have 3 options:
>> 1. MAINTAINERS --> foo.c
>> 2. foo.c --> MAINTAINERS
>> 3. foo.c <--> some 3rd file <--> MAINTAINERS
>
> I added git@vger.kernel.org and Junio Hamano
>
> Another possibility is improving git to allow
> some sort of "declaration of interest" in bits
> of projects.
>
> That would allow options like:
>
> o  git-format-patch to include CCs
> o  git-commit and git-branch to notify or
>      take some other action
>
> etc...

There are things git can help, and other things git does not
have any business with.

1. Finding out who the potentially interested parties are.

   Linus already gave a script to grep *-by: lines from commit
   messages.  I find this is probably be the best option, as it
   follows "yesterday's weather".  People who had dealt with the
   area are the ones who are likely to be interested.

   git records who did the work (author) and who did the
   integration to git-based patch flow (committer).  It does not
   structurally track intermediate people who touched the patch
   on e-mail, but Signed-off-by: and Acked-by: (and sometimes I
   see Cc: as well in the commit messages) are accepted social
   convention in the kernel community, and taking advantage of
   that is a good idea.


2. Making it easier to send your patches to these people.

   There are three possible places to add Signed-off-by: and
   friends in the commit messages you would mail out:

   - When you create your own commit, or commit a patch that
     came to you via e-mail.  The commit object in your tree
     will carry them --- you can send format-patch output as-is
     to Linus or Andrew and you are done.

   - When you run format-patch; your commit will not have extra
     Cc: or "interested parties" information, you will use the
     result of 1. and insert it near your own Signed-off-by: to
     the format-patch output.

   - When you send format-patch output, via git-send-email
     perhaps.

   To make the result useful for "yesterday's weather" approach,
   I think it would be the best to do the first.  After all,
   your commit may propagate via "git pull" not over e-mail, and
   no postprocessing approach would work in such a case.

   The second one is my least favorite.  format-patch output is
   designed to record author/committer (i.e. origin) and not to
   record recipient at all.  "Who's interested in this" does not
   simply belong there.

   On the other hand, git-send-email _is_ all about sending it
   out, and it needs to know who your patch should reach.  I
   think it makes sense to have one script that, given a set of
   paths that are affected, gives a list of potentially
   interested people (that is "Finding" part -- and I see there
   are 600+ patches to implement this on the list), and a new
   option to git-send-email to (1) inspect the patch to see what
   paths are affected, and (2) call that "Find" script to figure
   out whom to send it to, and probably asking for confirmation.
