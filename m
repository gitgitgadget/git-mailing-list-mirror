From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-symbolic-ref: fix error message when ref doesn't exist
Date: Mon, 19 Mar 2007 01:47:08 -0700
Message-ID: <7vslc1iprn.fsf@assigned-by-dhcp.cox.net>
References: <20070318020645.2444.75365.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 19 09:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTDWL-0003s7-Jg
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 09:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965827AbXCSIrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965839AbXCSIrL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 04:47:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46490 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965827AbXCSIrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 04:47:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319084709.HRYV24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 04:47:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cYn81W00Y1kojtg0000000; Mon, 19 Mar 2007 04:47:09 -0400
In-Reply-To: <20070318020645.2444.75365.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Sun, 18 Mar 2007 01:53:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42599>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> When calling resolve_ref from check_symref set reading to 1, since we
> do want to know if the given ref doesn't exist.  This means that
> "git symbolic-ref foo" will now print "fatal: No such ref: foo" as
> expected.

Hmmmm.  That would break:

	$ rm -fr a; mkdir a; cd a
	$ git init-db
        $ git symbolic-ref HEAD
        refs/heads/master

wouldn't it?  We do want it not to fail and tell us that the
commit we are going to create will be on refs/heads/master
(i.e. "the master branch").

And  the command errors out as expected when given a
non-existent symbolic ref:

	$ git symbolic-ref no-such; echo $?
	fatal: ref no-such is not a symbolic ref
	128
