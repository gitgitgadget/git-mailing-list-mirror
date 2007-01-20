From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Fri, 19 Jan 2007 16:35:13 -0800
Message-ID: <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AF5F83.6090207@fs.ei.tum.de>
	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84CX-0006u4-7t
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXATAfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbXATAfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:35:16 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36326 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbXATAfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:35:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120003514.RJYK15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:35:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCbX1W00m1kojtg0000000; Fri, 19 Jan 2007 19:35:32 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 00:54:49 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37231>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think this is sane but I hate to having to worry about
>> possible fallouts from giving --reverse in setup_revisions() to
>> make it available to everybody.  E.g. things like "what happens
>> when you say "git format-patch --reverse HEAD~3".
>
> It would
>
> 	1) traverse all commits, storing them in a commit_list,
> 	2) reverse the commits, and then
> 	3) continue as before.
>
> So I don't really see a problem (after all, you don't have to use it if 
> you don't want to).

Well, I understand what the code does, but what does the above
three steps MEAN to the end users?

In other words, if it does not make sense for format-patch to
take --reverse, maybe we should keep it as an internal option,
just like git-show is the only user of no-walk.  And give option
parsing for it for only selected commands (like rev-list) where
it makes sense.

I am sure you can come up with a reason why the above three
steps are useful for the end user, and it could turn out to be a
very valid reason.

But format-patch was just one example.  I will have to worry
about all the users of revision traversal machinery.

The end result might be "ok, we have spent quite a lot of time
and audited every users of revision machinery and for all of
them --reverse has some valid use cases." and that would be
wonderful.  But the thing is, I hate to having to worry about
that right now.
