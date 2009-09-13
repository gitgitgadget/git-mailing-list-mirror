From: Theodore Tso <tytso@mit.edu>
Subject: Re: Effectively tracing project contributions with git
Date: Sat, 12 Sep 2009 22:28:43 -0400
Message-ID: <20090913022843.GB26588@mit.edu>
References: <4AAB9459.3070809@webdrake.net> <20090912185940.GA21277@coredump.intra.peff.net> <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com> <4AAC3889.6030908@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 04:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmepo-0004e8-WC
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 04:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbZIMC2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 22:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbZIMC2w
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 22:28:52 -0400
Received: from THUNK.ORG ([69.25.196.29]:53295 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZIMC2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 22:28:52 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MmepY-0004De-Fu; Sat, 12 Sep 2009 22:28:44 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MmepX-0007h9-4B; Sat, 12 Sep 2009 22:28:43 -0400
Content-Disposition: inline
In-Reply-To: <4AAC3889.6030908@webdrake.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128323>

On Sun, Sep 13, 2009 at 02:10:49AM +0200, Joseph Wakeling wrote:
> 
> I don't see any solution that doesn't see me browsing diffs -- there's
> no metric that will solve the problem -- but if your stats work could
> help me get an output of the form 'here are all the diffs on file X by
> contributor Y in order of size, largest first' then I think it would
> help a LOT.

This will display all of the diffs on file (pathname) XXX by contributor YYY:

	git log -p --author=YYY XXX 

You might also find the diffstats useful:

	git log --stat --author=YYY XXX

Or if you want *only* the diffstats for the file in question, you might try:

	git log --stat --pretty=format: --author=YYY XXX | grep XXX

So the bottom line is git will allow you to extract quite a lot of
information.  You might need to do some perl- or shell- or python-
scripting to analyze or format the information, but the harder
question is determining exactly what question you want to ask.

Eliminating whitespace changes isn't hard (add the -b flag).  If you
want to eliminate variable renaming, that's harder since that requires
actually parsing the patch.  There are programs that will do that
(normally used by University professors to catch students cheating at
Programming 101 courses :-), but you'd need to do some shell (or perl
or python) scripting to splice them into the git invocations to
extract out the information.

Is there a particular reason why this is important to you?  Is it for
curiosity reasons; are you trying to build a case that you've
contacted all of the significant contributors for the purposes of
changing the license used on a file?  If it's the latter, what I'd
probably do is just simply collect everyone who has ever changed a
file (git log --format="%aN <%aE>" pathname/to/a/file | sort -u) and
try to get as many people as possible to agree to the license change.
For the ones who have _not_ agreed, or which you can not contact, you
can go back and just analyze their changes (git log --author=YYY) to
decide whether or not they are significant, and whether you need to
try extract hard to contact them, or in the worst case, find someone
to rewrite the parts of the file which they had modified in the past.

Or maybe you have some other reason for gathering said information.
Depending on what the high-level thing it is that you are trying to
do, there may be an easier or more elegant way to get the information
you are requesting.

						- Ted
