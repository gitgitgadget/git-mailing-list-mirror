From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Fix assorted white space damage
Date: Sat, 12 May 2007 18:45:12 -0700
Message-ID: <7vzm49ts2f.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705120409v629425aesc910927c26871323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 03:45:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn39L-0003yb-Il
	for gcvg-git@gmane.org; Sun, 13 May 2007 03:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbXEMBpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 21:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbXEMBpT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 21:45:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58366 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbXEMBpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 21:45:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513014519.TWOE6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 21:45:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yRlG1W00H1kojtg0000000; Sat, 12 May 2007 21:45:16 -0400
In-Reply-To: <e5bfff550705120409v629425aesc910927c26871323@mail.gmail.com>
	(Marco Costalba's message of "Sat, 12 May 2007 13:09:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47120>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Following there is a 3  patch series to remove stealth whitespace.
>
> I have used the new 'cleanfile' script by H. Peter Anvin, just merged
> in Linux tree.
>
> The script cleans up various classes of stealth whitespace.  In
> particular, it cleans up:
>
>  - Whitespace (spaces or tabs)before newline;
>  - DOS line endings (CR before LF);
>  - Space before tab (spaces are deleted or converted to tabs);
>  - Empty lines at end of file.

I haven't checked the script, but "git-apply --whitespace=strip"
can be used to do pretty much the same job with this sequence,
except the last one (do it with a copy of repository if you do
not want "git clean -x" to lose untracked):


	$ git checkout master
        $ rm -f .git/index
        $ git checkout HEAD -- t/
        $ git clean -x -d
	$ git diff -R --binary HEAD >P.diff
        $ git apply --index --whitespace=strip P.diff

Then you can check the results, and make a commit.

In the above I explicitly "saved" t/ because we have some test
vectors that need to have trailing whitespaces.
