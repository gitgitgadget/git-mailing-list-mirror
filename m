From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] show-branch --reflog: show the reflog message at the top.
Date: Fri, 19 Jan 2007 17:32:35 -0800
Message-ID: <7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H855z-0004ZQ-NS
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXATBch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXATBch
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:32:37 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36138 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965040AbXATBcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:32:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120013236.UKBW25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 20:32:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DDYt1W00U1kojtg0000000; Fri, 19 Jan 2007 20:32:53 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 02:19:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37245>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about failing if there are _uninteresting_ commits? So,
>
> 	git log --walk-reflogs next master
>
> still works?

That feels like a good way to deal with it.  I think people may
also appreciate timestamps on Reflog headers you add to the
output.

That change makes

	$ git log --walk-reflogs master..next
        fatal: No reflogs found for 'master..next'

a non issue, for one thing.

Unfortunately,

	$ git log --walk-reflogs ^master next 

is not something I can read and make heads or tails of it.  So
I'll try something smaller:

	$ git log --walk-reflogs ^master jc/show-reflog

shows only three commits (the same as without --walk-reflogs),
although I have tons of rewinds and rebases.  There is something
broken, or perhaps the semantics of --walk-reflogs does not
match what humans would expect when interacting with revision
limiting.  This would also become an non-issue if we do not
allow negative ones.
