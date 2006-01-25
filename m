From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files in subdirectories ignore higher-up .gitignore
Date: Tue, 24 Jan 2006 18:08:24 -0800
Message-ID: <7vhd7t3vqf.fsf@assigned-by-dhcp.cox.net>
References: <1138125570.24415.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 25 03:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a5G-0001vH-GT
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAYCI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWAYCI0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:08:26 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47078 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWAYCI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:08:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020725.CBHJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:07:25 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15110>

Pavel Roskin <proski@gnu.org> writes:

> This can be demonstrated in git's own repository:
>
> $ touch t/test.o
> $ git-ls-files --others --exclude-per-directory=.gitignore
> $ cd t
> $ git-ls-files --others --exclude-per-directory=.gitignore
> test.o
> $
>
> Before I attempt to fix it, I'd like to make sure it's a bug, not a
> feature.

I am not sure if that is a bug or a feature, but you are right.
We do not bother to go uplevel and look for .gitignore in the
current code.

It would probably be a welcome addition if your fix made these
two sequences work similarly modulo leading paths from the
command output.  I think it is natural to expect they are moral
equivalents:

	(Sequence 1)
	$ touch t/test.o t/garbage
        $ git-ls-files -o --exclude-per-directory=.gitignore t/

	(Sequence 2)
	$ touch t/test.o t/garbage
        $ cd t
        $ git-ls-files -o --exclude-per-directory=.gitignore
