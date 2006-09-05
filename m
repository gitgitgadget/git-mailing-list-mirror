From: Junio C Hamano <junkio@cox.net>
Subject: Re: send-pack: limit on negative references
Date: Tue, 05 Sep 2006 09:23:13 -0700
Message-ID: <7vwt8igu4u.fsf@assigned-by-dhcp.cox.net>
References: <44FD714F.9040003@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 18:23:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKdhN-0002qk-91
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 18:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWIEQWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIEQWo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 12:22:44 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:32908 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932167AbWIEQWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 12:22:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905162242.YLAZ21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 12:22:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JgNi1V00y1kojtg0000000
	Tue, 05 Sep 2006 12:22:43 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44FD714F.9040003@shadowen.org> (Andy Whitcroft's message of
	"Tue, 05 Sep 2006 13:45:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26478>

Andy Whitcroft <apw@shadowen.org> writes:

> I've been having trouble with git push apparently resending the entire
> commit trace for the branch each and every time I push; even with short
> branch names.  This seems to be related to the changes made to handle
> the case where the remote end has a large number of branches (>900).

I think the right fix is to do one or both of the following, and
lift that 900 cut-off entirely.

One is to teach rev-list to read the information it is taking
from the command line instead from its standard input.

Another is to teach pack-object the same trick on top of my
patch last night.  This has an added benefit that we save one
pipe+fork+exec there.

These are essentially suggestions from Linus made twice
separately in the past, so they must be on the right track ;-).

If nobody does, I would do it myself, but the list is welcome to
beat me to it.  Especially, the former (giving --stdin option to
rev-list) should be trivial.
